class Administrator
  include Mongoid::Document
  include Mongoid::Timestamps
  include Authenticateable
end
