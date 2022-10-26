class CheckoutController < ApplicationController
  before_action :initialize_cart

  wrap_parameters :order, include: [:card_type, :card_expiration_month, :card_expiration_year, :card_verification_value]

  def index
    @order = Order.new
    @page_title = "Checkout"
    if @cart.books.empty?
      flash[:notice] = "Your shopping cart is empty! Please add something to it before proceeding to checkout."
      redirect_to catalog_index_path
    end
  end

  def place_order
    #byebug
    @page_title = "Checkout"
    if @country
      @country = ISO3166::Country[params[:ship_to_country]]
      @country.translations[I18n.locale.to_s] || @country.common_name || @country.iso_short_name
    end
    @order = Order.new
    @order.email = params[:email]
    @order.phone_number = params[:phone_number]
    @order.ship_to_first_name = params[:ship_to_first_name]
    @order.ship_to_last_name = params[:ship_to_last_name]
    @order.ship_to_address = params[:ship_to_address]
    @order.ship_to_city = params[:ship_to_city]
    @order.ship_to_postal_code = params[:ship_to_postal_code]
    @order.ship_to_country = params[:ship_to_country]
    #@order.card_type = params[:card_type]
    #@order.card_number = params[:card_number]
    #@order.card_expiration_month = params[:card_expiration_month]
    #@order.card_expiration_year = params[:card_expiration_year]
    #@order.card_verification_value = params[:card_verification_value]
    @order.customer_ip = request.remote_ip
    @order.status = "open"
    populate_order
    @total_price = @cart.total
    if @order.save
      flash[:notice] = 'Your order has been submitted, please proceed to the payment.'
      session[:order_id] = @order.id
      # Empty the cart
      @cart.cart_items.destroy_all
      redirect_to checkout_payment_path
    else
      flash[:notice] = "Error while placing order. '#{@order.error_message}'"
      render :action => 'index'
    end
  end

  def payment
  end

  def thank_you
    #byebug
    @page_title = 'Thank You!'
    @status = params[:redirect_status]
    if @status = "succeeded"
      id = session[:order_id]
      order = Order.find(id)
      order.status = "closed"
      order.save
      flash[:notice] = 'Your order has been paid.'
    else
      flash[:notice] = "There was a problem with you payment."
    end
  end
   
  
  def secret
    #byebug
    @total_price = Order.last.total
    Stripe.api_key = Rails.application.credentials.stripe[:STRIPE_TEST_SECRET_KEY]
    @pi = Stripe::PaymentIntent.create({amount: @total_price, currency: 'usd', automatic_payment_methods: {enabled: true}})
    render json: @pi      
  end

  def confirm
    byebug
    @status = params[:redirect_status]
    if @status = "succeeded"
      if @order.save
        if @order.process
          @order_number = @order.id
          @total_price = @cart.total
          flash[:notice] = 'Your order has been submitted, and will be processed immediately.'
          session[:order_id] = @order.id
          # Empty the cart
          @cart.cart_items.destroy_all
          redirect_to checkout_thanks_path
        else
          flash[:notice] = "Error while placing order. '#{@order.error_message}'"
          render :action => 'index'
        end
      else
        render 'index'
      end
    end
    #@current_user = current_user.email
    @pi = params[:payment_intent_client_secret]
    @pi_client_secret = params[:payment_intent_client_secret]
    #if params[:redirect_status] == 'requires_payment_method'
    #    render 'http://localhost:3000/checkout'    
    #else 
    #    @status = params[:redirect_status]
    #end
  end

  private
  
  def order_params
    params.require(:order).permit(:order_items, :ship_to_first_name, :ship_to_last_name, :ship_to_address, 
                                  :ship_to_city, :ship_to_postal_code, :ship_to_country,
                                  :phone_number,:customer_ip,:email,:status,:card_number, :card_type, 
                                  :card_expiration_month, :card_expiration_year, :card_verification_value)
  end

  def populate_order
    @cart.cart_items.each do |cart_item|
      order_item = OrderItem.new(book_id: "#{cart_item.book_id}",price: "#{cart_item.price}",amount: "#{cart_item.amount}")
      @order.order_items << order_item
    end
  end
  
end


