class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    
    private
    def initialize_cart
        #byebug
        if session[:cart_id]
            @cart = Cart.find(session[:cart_id])
        else
            @cart = Cart.create
            session[:cart_id] = @cart.id
        end
    end
end
