class ApplicationController < ActionController::Base
  
  #def set_current_user
   # @current_user=User.find_by(id :session[:user_id])
  #end
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  #before_action :set_current_user
  #@current_user=User.find_by(id: session[:user_id])
  #end
  
  #before_action :autheniticate_user, {only: [:edit, :update, :show, :index, :create, :destroy]}
  
  def after_sign_in_path_for(resource)
    user_path(resource)
  end
  
  #before_action :forbid_login_user, {only: [:top]}

  
  #def autheniticate_user
   # if @current_user.nil?
    #  flash[:notice] ="login sitekudasai"
     # redirect_to new_user_session_path
    #end
  #end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
