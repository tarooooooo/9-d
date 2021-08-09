class BookCommentsController < ApplicationController
  def create
    @book_comment = current_user.book_comments.new(comment_params)
      if @book_comment.save
      else
        redirect_back(fallback_location: root_path)
      end
  end

  def destroy
    @book_comment = BookComment.find_by(id: params[:id],book_id: params[:book_id],user_id: current_user.id)
    if @book_comment.user == current_user
      @book_comment.destroy
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.require(:book_comment).permit(:comment_content,:book_id)
  end
end
