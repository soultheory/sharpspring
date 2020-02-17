require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "#new" do
    it "shows login page" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "#create" do
    it "returns to login page when we don't have a successful authentication" do
      post :create
      expect(response).to redirect_to('/login')
      expect(flash[:error]).to eq(I18n.t("messages.failed_login"))
    end

    it "redirects to dashboard when we have a successful authentication" do
      post :create, params: { email: 'kadeempardue@gmail.com', password: 'password123' }, format: :json
      expect(response).not_to redirect_to('/login')
      expect(response).to redirect_to('/')
      expect(flash[:notice]).to eq(I18n.t("messages.successful_login"))
    end
  end

  describe "#destroy" do
    it "destroys session and returns to login page" do
      @request.session['user_id'] = 'abcd'
      expect(@request.session).not_to eq(nil)
      get :destroy
      expect(response).to redirect_to('/')
      expect(flash[:notice]).to eq(I18n.t("messages.successful_logout"))
      expect(@request.session['user_id']).to eq(nil)
    end
  end
end
