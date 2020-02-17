class SessionsController < ApplicationController
  helper_method :user

  def new
    redirect_to controller: :dashboard, action: :index if user_signed_in?
  end

  def create
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = t("messages.successful_login")
      return redirect_to root_path
    end
    flash[:error] = t("errors.failed_login")
    redirect_to new_session_path
  end

  def destroy
    reset_session
    flash[:notice] = t("messages.successful_logout")
    redirect_to root_path
  end

  private

  def user
    @user ||= User.find_by(email: params[:email])
  end
end
