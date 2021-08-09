class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.build(book_id: params[:book_id])
    favorite.save
    @books = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @user_books = Book.where(user_id:@book.user.id).includes(:favorited_users).sort{|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = Favorite.find_by(book_id: params[:book_id] ,user_id: current_user.id)
    favorite.destroy
    @books = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @user_books = Book.where(user_id:@book.user.id).includes(:favorited_users).sort{|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end
end