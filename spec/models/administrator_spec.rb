require 'rails_helper'

RSpec.describe Administrator, type: :model do
  it_behaves_like "authenticateable"
end
