class AboutController < ApplicationController
  
  def index
    @page_title = 'About Emporium'
    session[:first_time] ||= Time.now
  end
 
    
  

end
