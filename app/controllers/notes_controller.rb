class NotesController < ApplicationController
  before_action :authenticate!

  def new
    @note = Note.new
  end

  def show
    redirect_to root_path
  end

  def create
    @note = current_user&.notes.create(sanitize_params(whitelisted_params))
    if @note.valid?
      flash[:notice] = t("messages.successful_save")
      response.set_header('X-Note-ID', @note.id)
      return redirect_to root_path
    end

    flash[:error] = t("messages.failed_save")
    redirect_to new_note_path(Note.new)
  end

  def edit
    @note = current_user&.notes.find(id: params[:id])
  end

  def update
    @note = current_user&.notes.find(params[:id])
    if @note&.update(sanitize_params(whitelisted_params))
      flash[:notice] = t("messages.successful_save")
      response.set_header('X-Note-ID', @note.id)
      return redirect_to root_path
    end

    flash[:error] = t("messages.failed_save")
    redirect_to edit_note_path(@note)
  end

  def destroy
    @note = current_user&.notes.find(id: params[:id])
    @note&.destroy
    response.set_header('X-Note-ID', @note.id)
    flash[:notice] = t("messages.successful_destroy")
    redirect_to root_path
  end

  private

  def whitelisted_params
    params.require(:note).permit(:title, :body)
  end
end
