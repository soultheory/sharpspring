class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Authenticateable
end
