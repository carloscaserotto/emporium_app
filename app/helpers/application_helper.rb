module ApplicationHelper

    def add_book_link(text, book)
        link_to text, "/cart/#{book.id}", remote: true, mehotd: :post
                             
        #link_to_remote text, {:url => {:controller => "cart",:action => "add", :id => book}},
        #                     {:title => "Add to Cart", :href => url_for( :controller => "cart",:action => "add", :id => book)}
    end
    
    def remove_book_link(text, book)
        link_to_remote text, {:url => {:controller => "cart", :action => "remove", :id => book}},
                             {:title => "Remove book", :href => url_for( :controller => "cart",
                              :action => "remove", :id => book)}
    end

    def clear_cart_link(text = "Clear Cart")
        link_to_remote text,{:url => { :controller => "cart",:action => "clear" }},
                            {:href => url_for(:controller => "cart", :action => "clear")}
    end
end
