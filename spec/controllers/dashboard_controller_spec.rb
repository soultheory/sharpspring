require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe "#authenticate!" do
    it "redirect to login page when we don't have a session" do
      get :index
      expect(response).to redirect_to('/login')
    end

    it "show the dashboard when we have a session" do
      @request.session['user_id'] = 'abcd'
      get :index
      expect(response).not_to redirect_to('/login')
      expect(response).to render_template("index")
    end
  end
end
