class CartController < ApplicationController
    before_action :initialize_cart

    def add
        #byebug
        @book = Book.find(params[:id])
        if request.xhr?
            @item = @cart.add(params[:id])
            flash.now[:cart_notice] = "Added #{@item.book.title}"
            respond_to do |format|
                format.js { render partial: 'cart/add_with_ajax' }
            end
        elsif
            request.post?
            @item = @cart.add(params[:id])
            flash[:cart_notice] = "Added #{@item.book.title}"
            redirect_to catalog_index_path
        else
            render
        end
    end
    def dell
        #byebug
        @book = Book.find(params[:id])
        if request.xhr?
            @item = @cart.dell(params[:id])
            flash.now[:cart_notice] = "Dell #{@item.book.title}"
            respond_to do |format|
                format.js { render partial: 'cart/add_with_ajax' }
            end
        elsif request.post?
            @item = @cart.dell(params[:id])
            flash[:cart_notice] = "Dell #{@item.book.title}"
            redirect_to session[:return_to] || {:controller => "catalog"}
        else
            render
        end
    end
    def clear
        #byebug
        if request.xhr?
            @cart.cart_items.destroy_all
            flash.now[:cart_notice] = "Cleared the cart"
            respond_to do |format|
                format.js { render partial: 'cart/add_with_ajax' }
            end
        elsif request.post?
            @cart.cart_items.destroy_all
            flash[:cart_notice] = "Cleared the cart"
            redirect_to session[:return_to] || {:controller => "catalog"}
        else
            render
        end
    end
end
=begin
        if request.xhr?
            @item = @cart.add(params[:id])
            flash.now[:cart_notice] = "Added #{@item.book.title}"
            #render :action => "add_with_ajax"
            render "cart/add_with_ajax"
        elsif request.post?
            @item = @cart.add(params[:id])
            flash[:cart_notice] = "Added #{@item.book.title}"
            redirect_to session[:return_to] || {:controller => "catalog"}
        else
            render
        end

=end
    #if request.post?
    #@item = @cart.add(params[:id])
    #flash[:cart_notice] = "Added #{@item.book.title}"
    #flash[:prueba] = "TESTING FLASH"
    #redirect_to catalog_index_path


#The filter makes the controller call the initialize_cart method before running an action. We
#could implement the initialize_cart method in both CartController and CatalogController, but
#since we don’t want to repeat ourselves, we put the definition to the ApplicationController (in
#app/controllers/application.rb), which is by default the parent class of all our controllers.