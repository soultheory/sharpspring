class NotesController < ApplicationController
  before_action :authenticate!

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(whitelisted_params)
    @note.user = current_user
    if @note.save
      flash[:notice] = t("messages.successful_save")
      return redirect_to new_session_path
    end

    flash[:error] = t("messages.failed_save")
    redirect_to new_registration_path(User.new)
  end

  def edit
    @note = current_user.notes.where(id: params[:id]).first
  end

  private

  def whitelisted_params
    params.require(:note).permit(:title, :body)
  end
end
