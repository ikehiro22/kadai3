class BooksController < ApplicationController
  before_action :authenticate_user!
  
  before_action :ensure_correct_user, only:[:edit]
  
   def ensure_correct_user
     @book = Book.find(params[:id])
     if @book.user != current_user
      redirect_to books_path
     end
   end
  
  def edit
      @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "error"
      render :edit
    end
    
  end

  def show
    @book = Book.new
    @booked = Book.find(params[:id])
    @user = User.find(@booked.user.id)
  end

  def index
    #@user = User.find(current_user.id)
    #@user = User.find(params[:id])
    @book = Book.new
    @books = Book.all
  end
  
  def create
    @user = User.new(user_params)
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "can't be blank error"
      redirect_to books_path
      
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  private
    def user_params
      params.permit(:name, :introduction, :profile_image)
      #require(:user).user
    end
      
    def book_params
      params.require(:book).permit(:title, :body)
      
    end  
end
