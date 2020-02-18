class ApplicationController < ActionController::Base
  helper_method :user_signed_in?, :current_user

  protected

  def authenticate!
    redirect_to new_session_path unless user_signed_in?
  end

  def user_signed_in?
    session[:user_id].present?
  end

  def current_user
    return nil unless user_signed_in?
    @user ||= User.find(session[:user_id])
  end

  def sanitize_params(params)
    params.to_h.each { |k,v| params[k] = helpers.sanitize(v) }
    params
  end
end
