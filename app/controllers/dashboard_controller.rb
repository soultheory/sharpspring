class DashboardController < ApplicationController
  before_action :authenticate!
  helper_method :notes

  private

  def notes
    @notes ||= current_user&.notes
  end
end
