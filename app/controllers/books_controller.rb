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
    @categories = Category.all.map { |category| [category.name, category.id] }
  end

  def create
    # @book = Book.new(book_params)
    @book = current_user.books.build(book_params)
    @book.category_id = params[:category_id]

    if @book.save
      redirect_to root_path
    else
      :new
    end
  end

  def edit
    @book = Book.find(params[:id])
    @categories = Category.all.map { |category| [category.name, category.id] }
  end

  def update
    @book = Book.find(params[:id])

    @book.category_id = params[:category_id]

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
    params.require(:book).permit(:title, :description, :author, :category_id)
  end
end
