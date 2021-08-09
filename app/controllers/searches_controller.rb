class SearchesController < ApplicationController
  def search
    @range = params[:range]
    @word = params[:word]
    #以下の2つの項目を省略して、looksの括弧内に記入している。
    # search = params[:search]
    # word = params[:word]
    
    if @range == "User"
      @users = User.looks(params[:search],params[:word])
    else
      @books = Book.looks(params[:search],params[:word])
    end
  end
end
