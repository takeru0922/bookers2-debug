class BooksController < ApplicationController
    before_action :authenticate_user!, except: [:top,:about]
    before_action :authbook, {only:[:edit]}

    def top
    end

    def about
    end

    def show
        users = Book.find(params[:id])
        @user = users.user
        @book = Book.new
        @books = Book.find(params[:id])
    end

    def books
        @user = current_user
        @book = Book.new
        @books = Book.all#一覧表示するためにBookモデルの情報を全てくださいのall
    end

    def create
        @user = User.find(current_user.id)
        @book = current_user.books.new(books_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
        @books = Book.all
        if @book.save #入力されたデータをdbに保存する。
            redirect_to book_path(@book), notice: "successfully created book!"#保存された場合の移動先を指定。
        else
            render :books
        end
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(books_params)
            redirect_to book_path(@book), notice: "successfully updated book!"
        else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
            render :edit
        end
    end

    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path, notice: "successfully delete book!"
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