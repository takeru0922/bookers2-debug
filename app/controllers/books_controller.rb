class BooksController < ApplicationController
    before_action :authenticate_user!, except: [:top,:about]
    before_action :authbook, {only:[:edit]}

    def top
    end

    def about
    end

    def books
        @user = current_user
        @book = Book.new
        @books = Book.all
    end

    def show
        users = Book.find(params[:id])
        @user = users.user
        @book = Book.new
        @books = Book.find(params[:id])
    end

    def edit
        @book = Book.find(params[:id])
    end

    def create
        @user = User.find(current_user.id)
        @book = current_user.books.new(books_params)
        @books = Book.all
        if @book.save
            flash[:message] = "You have creatad book successfully."
            redirect_to book_path(@book)
        else
            render :books
        end
    end

    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(books_params)
            flash[:message] = "You have updated book successfully."
            redirect_to book_path(@book)
        else
            render :edit
        end
    end

    private
        def books_params
            params.require(:book).permit(:user_id,:title,:body)
        end

        def authbook
            book = Book.find(params[:id])
            if book.user_id != current_user.id
                redirect_to books_path
            end
        end
end