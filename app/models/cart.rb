class Cart < ApplicationRecord
    has_many :cart_items
    has_many :books, through: :cart_items

    def total
        cart_items.inject(0) {|sum, n| n.price * n.amount + sum}
    end

    def add(book_id)
       #items = cart_items.find_all_by_book_id(book_id)
       items = cart_items.all.where(" book_id = ?", book_id)
        book = Book.find(book_id)
        if items.size < 1
            ci = cart_items.create(book_id: book_id, amount: 1, price: book.price)
        else
            ci = items.first
            ci.update_attribute(:amount, ci.amount + 1)
        end
        ci
    end
    def dell(book_id)
        items = cart_items.all.where(" book_id = ?", book_id)
         #if items.first.amount != 0
         if items.first.amount > 0
            ci = items.first
            ci.update_attribute(:amount, ci.amount - 1)
         else
            items.first.id.destroy
         end
         ci
    end
end

#Note that we use the new has_many :through syntax
#With the syntax, we can access books belonging to a cart directly by using
#@cart_object.books, even though the two classes don’t have a direct relationship. Without
#using the new :through option, we would need to laboriously go through the CartItem class:
#@cart_object.cart_items.map {|ci| ci.book }.

#inject is a method for arrays and other enumerable objects that can be used to calculate
#sums, factorials, and so on of all the items in the container object. It takes one initial parameter
#(in our case, 0) and passes it as the first block parameter (in our case, sum) for the first iteration.
#Then it passes each item of cart_items to the block as n, one at a time, updating the sum all the
#time. After it has gone through all of the items, it returns the final value of sum.