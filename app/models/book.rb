class Book < ApplicationRecord
    has_and_belongs_to_many :authors
    belongs_to :publisher

    has_many :cart_items
    has_many :carts, through: :cart_items

    acts_as_ferret :fields => [:title, :author_names]

    has_one_attached :image, :dependent => :destroy

    validates :title, length: { in: 1..255 }
    validates :publisher, presence: true
    #validates :authors, presence: true
    validates :published_at,presence: true
    validates :page_count, numericality: { only_integer: true }
    validates :price, numericality: true
    validates :isbn, uniqueness: true, format: { with: /[0-9\-xX]{13}/ }
    
    def author_names
        self.authors.map do |a|
            a.name
        end.join(", ") rescue ""
    end

    def self.latest
        #find :all, :limit => 10, :order => "books.id desc",:include => [:authors, :publisher]
        all.includes(:authors, :publisher).limit(10).order(id: :desc)
    end
    
end
