class UsersController < ApplicationController 
  before_action :authenticate_user!
  
  before_action :ensure_correct_user, only:[:edit]
  
   def ensure_correct_user
     user = User.find(params[:id])
     if user != current_user
      redirect_to user_path(current_user.id)
     end
   end
  
  
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index
   
    @users = User.all
    @book = Book.new
  end
  
  def edit
    @user = User.find(current_user.id)
    
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(current_user.id)
    else
      flash[:notice] = "error"
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
      render "books/index"
    end
  end
  
  #before_action :authenticate_user, {only: [:edit, :update]}
  
  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
      
    def book_params
      params.require(:book).permit(:title, :body)
      
    end  

end
