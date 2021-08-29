class UsersController < ApplicationController
  before_action :baria_user, only: [:edit]

  def show
    @categories = Category.all
    @user = User.find(params[:id])

  # 今日から６日前の投稿数、前日比計算
    @today_book_count          = @user.books.created_at_today.count
    @yesterday_book_count      = @user.books.created_at_yesterday.count
    @two_days_ago_book_count   = @user.books.created_at_two_days_ago.count
    @three_days_ago_book_count = @user.books.created_at_three_days_ago.count
    @four_days_ago_book_count  = @user.books.created_at_four_days_ago.count
    @five_days_ago_book_count  = @user.books.created_at_five_days_ago.count
    @six_days_ago_book_count   = @user.books.created_at_six_days_ago.count

    unless @yesterday_book_count == 0
      @day_before = (@today_book_count.to_f / @yesterday_book_count.to_f).round * 100
    end

    # 今週と先週の投稿数、前週比
    @week_book_count      = @user.books.created_at_week.count
    @last_week_book_count = @user.books.created_at_last_week.count

    unless @last_week_book_count == 0
      @week_before = (@week_book_count.to_f / @last_week_book_count.to_f).round * 100
    end

    @book = Book.new
    @user_books = Book.where(user_id:params[:id]).includes(:favorited_users).sort{|a,b| b.favorited_users.size <=> a.favorited_users.size}
    # @user_books = Book.includes(:favorited_users).sort{|a,b| b.favorited_users.size <=> a.favorited_users.size}
    #上記を追記すると、Book.allが呼び出されてしまう。なので、user.bookを呼び出してから、並び替えの記述をする。
    @current_entry = Entry.where(user_id: current_user.id)
    # Entryモデルからメッセージ相手のレコードを抽出
    @another_entry = Entry.where(user_id: @user.id)

    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          # ルームが存在する場合
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      # ルームが存在しない場合は新規作成
      unless @is_room
        @room  = Room.new
        @entry = Entry.new
      end
    end
  end

  def search
    @user = User.find(params[:user_id])
    @books = @user.books

    if params[:created_at] == ""
      @book_counts = "値を入力してください"
    else
      created_at = params[:created_at]
      @book_counts = @books.where(["created_at LIKE ?", "#{created_at}%"]).count
    end
  end

  def index
    @categories = Category.all
    @user  = current_user
    @book  = Book.new
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice:"You have updated user successfully."
    else
      render"edit"
    end
  end

  def follows
    user   = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user   = User.find(params[:id])
    @users = user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def baria_user
    unless User.find(params[:id]).id == current_user.id
    # if User.find(params[:id]).id != current_user.id
    redirect_to user_path(current_user)
    end
  end
end
