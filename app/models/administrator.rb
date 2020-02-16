class Administrator
  include Mongoid::Document
  include Mongoid::Timestamps
  include Authenticateable

  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
end
