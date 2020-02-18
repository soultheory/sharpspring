class RegistrationsController < ApplicationController
  def create
    @user = User.new(sanitize_params(whitelisted_params))

    if @user.save
      flash[:notice] = t("messages.successful_registration")
      response.set_header('X-User-ID', @user.id)
      return redirect_to new_session_path
    end

    flash[:error] = t("messages.failed_registration")
    redirect_to new_registration_path(User.new)
  end

  private

  def whitelisted_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
