require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe "#user_signed_in?" do
    it "returns false when we don't have a session" do
      # Using send because user_signed_in? is a protected method.
      # With great care comes great responsibility.
      expect(subject.send(:user_signed_in?)).to eq(false)
    end

    it "returns true when we have a session" do
      @request.session['user_id'] = 'abcd'
      expect(subject.send(:user_signed_in?)).to eq(true)
    end
  end

  describe "#current_user" do
    it "returns nil when we don't have a session" do
      expect(subject.send(:current_user)).to eq(nil)
    end

    it "returns user when we have a session" do
      @request.session['user_id'] = '5e49fe2cae98823cf3667eee'
      expect(subject.send(:current_user)).not_to eq(nil)
      expect(subject.send(:current_user).class).to eq(User)
    end
  end
end
