class BookCommentsController < ApplicationController
 
  def create
    @show_book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @show_book.id
    if @comment.save
      # redirect_to book_path(@show_book)
    else
      @user = current_user
      @book = Book.new
      render 'books/show'
    end
  end
  
  def destroy
    @comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    @show_book = @comment.book
    @comment.destroy
    # redirect_to book_path(params[:book_id])
  end
  
  private
    def book_comment_params
      params.require(:book_comment).permit(:comment)
    end
  
end
