require "rails_helper"

RSpec.describe RegistrationsController, type: :controller do
  describe "#new" do
    it "shows registration page" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "#create" do
    it "returns to registration page when we don't have a successful authentication" do
      post :create
      expect(response).to redirect_to("/signup")
      expect(flash[:error]).to eq(I18n.t("messages.failed_registration"))
      expect(@response.headers['X-User-ID']).to eq(nil)
    end

    it "redirects to login page when we have a successful registration with an encrypted password" do
      email = "admin+#{SecureRandom.hex(4)}@app.com"
      post :create, params: {
        email: email,
        password: BCrypt::Password.create("password"),
        first_name: "Kadeem",
        last_name: "Pardue"
      }, format: :json
      expect(response).to redirect_to("/login")
      expect(flash[:notice]).to eq(I18n.t("messages.successful_registration"))
      expect(@response.headers['X-User-ID']).not_to eq(nil)

      user = User.find(@response.headers['X-User-ID'])
      expect(user.password).not_to eq("password")
      expect(user.password.start_with?("$")).to eq(true)
    end
  end
end
