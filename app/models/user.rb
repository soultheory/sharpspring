class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Authenticateable

  embeds_many :notes, order: :created_at.desc
end
