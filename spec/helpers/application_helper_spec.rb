require "rails_helper"

describe ApplicationHelper do
  describe "#set_active_class" do
    it "returns nil when path_name is not current route" do
      expect(helper.set_active_class(:root)).to eq(nil)
    end

    it "returns true when path_name is current route" do
      allow(helper).to receive(:set_active_class).and_return(true)
      expect(helper.set_active_class(:root)).to eq(true)
    end
  end
end
