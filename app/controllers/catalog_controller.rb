class CatalogController < ApplicationController
  before_action :initialize_cart


  def index
    @page_title = "Book List"
    scope =  Book.includes(:authors,:publisher).order("books.id desc")
    @books = scope.paginate(:page => params[:page], :per_page => 2)
  end

  def show
    @book = Book.find(params[:id]) rescue nil
    return render(:text => "Not found", :status => 404) unless @book
    @page_title = @book.title
  end

  def search
    #byebug
    #@page_title = "Search"
    @page_title = "Book List"
    if params[:commit] == "Search" || params[:query]
      @search_item = params[:query]
      #@books = Book.find_by_contents(params[:q].to_s.upcase)
      scope = Book.where("title like ?", "%#{params[:query].to_s.upcase}%")
      @books = scope.paginate(:page => params[:page], :per_page => 2)
      unless @books.size > 0
        flash.now[:notice] = "No books found matching your criteria"
      end
    end
  end

  def latest
    @page_title = "Latest Books"
     scope = Book.latest
     @books = scope.paginate(:page => params[:page], :per_page => 10)
  end
  def rss
    latest
    #render :layout => false
  end
end
