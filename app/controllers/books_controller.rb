class BooksController < ApplicationController
  
  def new
    @book = Book.new
  end

  # 投稿データの保存
  def create
    @book= Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
  else
    @books = Book.all
    @user = current_user   
    render :index
  end
  end


  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new 
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
    redirect_to books_path 
    end
  end
  
  
  def update
  @book = Book.find(params[:id])
   if @book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book)
   else
    render :edit
   end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end