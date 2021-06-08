class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @show_other_user = true
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "successfully create a book"
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    @hide_user_info = true
    redirect_to books_path unless current_user == @book.user
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully update a book"
      redirect_to book_path(@book.id)
    else
      @hide_user_info = true
      flash[:alert] = "update failed"
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if current_user == @book.user
      flash[:alert] = "successfully delete a book"
      @book.destroy
    end
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body).merge(user_id: current_user.id)
  end
end
