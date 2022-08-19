class AuthorController < ApplicationController
  def index
    @authors = Author.all
    @page_title = 'Listing authors'
  end

  def show
    @author = Author.find(params[:id])
    session[:current_user_id] = @author.name
    @page_title = @author.name
  end

  
  def new
    @author = Author.new
    @page_title = 'Create new author'
  end
  def create
    #byebug
    @author = Author.new(params[:author].permit(:first_name, :last_name))
    if @author.save
      flash[:notice] = "Author #{@author.name} was successfully created."
      redirect_to @author
    else
      @page_title = "Create new author"
      flash[:alert] = "Author NOT successfully created."
      render 'new'
    end
  end

  def edit
    @author = Author.find(params[:id])
    @page_title = 'Edit author'
  end

  def update
    #byebug
    @author = Author.find(params[:id])
    if @author.update(params[:author].permit(:first_name, :last_name))
      flash[:notice] = "Author: #{@author.name} was successfully updated."
      redirect_to @author
    else
      @page_title = 'Edit author'
      render 'edit'
    end
  end

  def destroy
    @author = Author.find(params[:id])
    flash[:notice] = "Successfully deleted author: #{@author.name}"
    @author.destroy
    redirect_to  author_index_path
  end

  
end
