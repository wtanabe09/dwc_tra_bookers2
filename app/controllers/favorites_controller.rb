class FavoritesController < ApplicationController
  
  
  def create
    path = Rails.application.routes.recognize_path(request.referer)
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    if favorite.save
      if path[:controller] == "books" && path[:action] == "index"
        redirect_to books_path
      elsif path[:controller] == "books" && path[:action] == "show"
        redirect_to book_path(book)
      else
        user = User.find(book.user_id)
        redirect_to user_path(user)
      end
    end
  end
  
  def destroy
    path = Rails.application.routes.recognize_path(request.referer)
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    if favorite.destroy
      if path[:controller] == "books" && path[:action] == "index"
        redirect_to books_path
      elsif path[:controller] == "books" && path[:action] == "show"
        redirect_to book_path(book)
      else
        user = User.find(book.user_id)
        redirect_to user_path(user)
      end
    end
  end
end
