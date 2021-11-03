class SearchesController < ApplicationController
  def search
    @model = params[:model]
    @method = params[:method]
    if @model == "book"
      @books = Book.search(params[:search])
    else
      @users = User.search(params[:search])
    end
  end
end
