class Order < ApplicationRecord
    has_many :order_items
    has_many :books, :through => :order_items

    attr_accessor :card_type, :card_number, :card_expiration_month, :card_expiration_year, :card_verification_value

    #validates_size_of :order_items, :minimum => 1
    validates :order_items, length: { minimum: 1 }
    #validates_length_of :ship_to_first_name, :in => 2..255
    validates :ship_to_first_name, length: { in: 2..255 }
    #validates_length_of :ship_to_last_name, :in => 2..255
    validates :ship_to_last_name, length: { in: 2..255 }
    #validates_length_of :ship_to_address, :in => 2..255
    validates :ship_to_address, length: { in: 2..255 }
    #validates_length_of :ship_to_city, :in => 2..255
    validates :ship_to_city, length: { in: 2..255 }
    #validates_length_of :ship_to_postal_code, :in => 2..255
    validates :ship_to_postal_code, length: { in: 2..255 }
    #validates_length_of :ship_to_country, :in => 2..255
    validates :ship_to_country, length: { in: 2..255 }
    #validates_length_of :phone_number, :in => 7..20
    validates :phone_number, length: { in: 7..20 }
    #validates_length_of :customer_ip, :in => 7..15
    validates :customer_ip, length: { in: 7..15 }
    #validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
    validates :email, format: { with: /\A\S+@.+\.\S+\z/ }
    #validates_inclusion_of :status, :in => %w(open processed closed failed)
    validates :status, inclusion: { in: %w(open processed closed failed), message: "%{value} is not valid" }
    #validates_inclusion_of :card_type, :in => ['Visa', 'MasterCard', 'Discover'],:on => :create
    validates :card_type, inclusion: { in: ['Visa', 'MasterCard', 'Discover'], message: "%{value} is not valid card type" }, on: :create
    #validates_length_of :card_number, :in => 13..19, :on => :create
    validates :card_number, length: { in: 13..19 }, on: :create
    #validates_inclusion_of :card_expiration_month, :in => %w(1 2 3 4 5 6 7 8 9 10 11 12), :on => :create
    validates :card_expiration_month, inclusion: { in: %w(1 2 3 4 5 6 7 8 9 10 11 12), message: "%{value} is not a valid month" }, on: :create
    #validates_inclusion_of :card_expiration_year, :in => %w(2006 2007 2008 2009 2010), :on => :create
    validates :card_expiration_year, inclusion: { in: %w(2022 2023 2024 2025 2026 2027 2028 2029 2030), message: "%{value} is not a valid year" }, on: :create
    #validates_length_of :card_verification_value, :in => 3..4, :on => :create
    validates :card_verification_value, length: { in: 3..4 }, on: :create

    def total
        order_items.inject(0) {|sum, n| n.price * n.amount + sum}
    end

    private
    def process
        result = true
        #
        # TODO Charge the customer by calling the payment gateway
        #
        self.status = 'processed'
        save!
        result
    end
end
