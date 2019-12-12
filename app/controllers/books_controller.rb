# typed: false
class BooksController < ApplicationController
  # before_action

  def index
    @books = Book.all.order("created_at DESC")
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    # @book = Book.new
    @book = current_user.books.build
  end

  def create
    # @book = Book.new(book_params)
    @book = current_user.books.build(book_params)

    if @book.save
      redirect_to root_path
    else
      :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to root_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :author)
  end
end
