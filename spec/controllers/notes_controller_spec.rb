require "rails_helper"

RSpec.describe NotesController, type: :controller do
  before :each do
    # Remember, this test user must exist in test db
    @request.session["user_id"] = "5e49fe2cae98823cf3667eee"
    @note_id = "5e4ac220ae9882094a2a9820"
  end

  describe "#new" do
    it "redirect to login page when we don't have a session" do
      @request.session["user_id"] = nil
      get :new
      expect(response).to redirect_to("/login")
    end

    it "show the form when we have a session" do
      get :new
      expect(response).not_to redirect_to("/login")
      expect(response).to render_template("new")
    end
  end

  describe "#create" do
    it "redirect to login page when we don't have a session" do
      @request.session["user_id"] = nil
      get :create
      expect(response).to redirect_to("/login")
    end

    it "shows an error when note we do not have a title or body and we have a session" do
      post :create, params: { note: { title: nil, body: nil } }, format: :json
      expect(response).to redirect_to("/notes/new")
      expect(flash[:error]).to eq(I18n.t("messages.failed_save"))
      expect(@response.headers['X-Note-ID']).to eq(nil)

      post :create, params: { note: { title: "", body: "" } }, format: :json
      expect(response).to redirect_to("/notes/new")
      expect(flash[:error]).to eq(I18n.t("messages.failed_save"))
      expect(@response.headers['X-Note-ID']).to eq(nil)
    end

    it "creates a note when we provide a title and a body and have a session" do
      post :create, params: { note: { title: "Basic Note", body: "Some Body" } }, format: :json
      expect(response).to redirect_to("/")
      expect(flash[:notice]).to eq(I18n.t("messages.successful_save"))
      expect(@response.headers['X-Note-ID']).not_to eq(nil)
    end

    it "creates a note when we provide just a title and have a session" do
      post :create, params: { note: { title: "Basic Note" } }, format: :json
      expect(response).to redirect_to("/")
      expect(flash[:notice]).to eq(I18n.t("messages.successful_save"))
      expect(@response.headers['X-Note-ID']).not_to eq(nil)
    end

    it "creates a note when we provide just a body and have a session" do
      post :create, params: { note: { title: nil, body: "Some Body" } }, format: :json
      expect(response).to redirect_to("/")
      expect(flash[:notice]).to eq(I18n.t("messages.successful_save"))
      expect(@response.headers['X-Note-ID']).not_to eq(nil)
    end
  end

  describe "#edit" do
    it "redirect to login page when we don't have a session" do
      @request.session["user_id"] = nil
      get :edit, params: { id: @note_id }
      expect(response).to redirect_to("/login")
    end

    it "show the form when we have a session" do
      get :edit, params: { id: @note_id }
      expect(response).not_to redirect_to("/login")
      expect(response).to render_template("edit")
    end
  end

  describe "#update" do
    it "redirect to edit note page when updating an invalid note" do
      put :update, params: {
        id: @note_id,
        note: {
          title: nil,
          body: nil
        }
      }, format: :json
      expect(response).to redirect_to("/notes/#{@note_id}/edit")
      expect(@response.headers['X-Note-ID']).to eq(nil)

      current_user = User.find(@request.session["user_id"])
      @note = current_user.notes.find(@note_id)
      expect(@note&.body).not_to eq(nil)
    end

    it "redirect to dashboard page when updating an valid note" do
      put :update, params: {
        id: @note_id,
        note: {
          title: "Some Title",
          body: "Some Body"
        }
      }, format: :json
      expect(response).to redirect_to("/")
      expect(@response.headers['X-Note-ID']).to eq(BSON::ObjectId(@note_id))

      current_user = User.find(@request.session["user_id"])
      @note = current_user.notes.find(@note_id)
      expect(@note&.title).to eq("Some Title")
      expect(@note&.body).to eq("Some Body")

      put :update, params: {
        id: @note_id,
        note: {
          title: "Some Other Title",
          body: "Some Other Body"
        }
      }, format: :json
      expect(response).to redirect_to("/")
      expect(@response.headers['X-Note-ID']).to eq(BSON::ObjectId(@note_id))

      current_user = User.find(@request.session["user_id"])
      @note = current_user.notes.find(@note_id)
      expect(@note&.title).to eq("Some Other Title")
      expect(@note&.body).to eq("Some Other Body")

      put :update, params: {
        id: @note_id,
        note: {
          title: nil,
          body: "No Title But A Body"
        }
      }, format: :json
      expect(response).to redirect_to("/")
      expect(@response.headers['X-Note-ID']).to eq(BSON::ObjectId(@note_id))

      current_user = User.find(@request.session["user_id"])
      @note = current_user.notes.find(@note_id)
      expect(@note&.title).to eq("No Title But A Body")
      expect(@note&.body).to eq("No Title But A Body")
    end

    describe "#destroy" do
      it "redirect to login page when we don't have a session" do
        @request.session["user_id"] = nil
        delete :destroy, params: { id: 'abccbcbsca' }, format: :json
        expect(response).to redirect_to("/login")
      end

      it "destroys a note when have a session" do
        current_user = User.find(@request.session["user_id"])

        # Stubbing the destroy
        allow(current_user.notes).to receive(:find).with(@note_id).and_call_original
        allow_any_instance_of(Note).to receive(:destroy).and_return(true)

        delete :destroy, params: { id: @note_id }, format: :json
        expect(response).to redirect_to("/")
        expect(flash[:notice]).to eq(I18n.t("messages.successful_destroy"))
        expect(@response.headers['X-Note-ID']).to eq(BSON::ObjectId(@note_id))
      end
    end
  end
end
