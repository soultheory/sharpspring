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
end
