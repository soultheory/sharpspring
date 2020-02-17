require 'rails_helper'

RSpec.describe User, type: :model do
  it_behaves_like "authenticateable"

  # Associations
  it { is_expected.to embed_many(:notes) }
end
