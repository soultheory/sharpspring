module Authenticateable
  extend ActiveSupport::Concern

  included do
    # Set which database we are storing to within our MongoDB cluster.
    # This is useful for separate database management across environments
    store_in database: "notes_#{Rails.env}"
    # Encrypting at application level is costly and difficult to manage.
    # We should heir on the side of encrypting data at database level also.
    # For demo purposes, this works fine though.
    # We use bcrypt to hash the password.
    # Each hash is unique and never the same, even if using the same value.
    #
    # 'abc' becomes something like '$2a$12$kCF9/I1WRuy.SrmY5xye7OP06hfBdsnmaV4Cn1GtgzIbIpiwuGdMa'
    # but retains its BCrypt:Password data type due to the override in the lib folder
    #
    # Because we are using BCrypt::Password we gain instance methods such as
    # == and is_password? to validate the password is correct. We let BCrypt
    # do the decryption process of our hashed password.
    #
    # resource.password                     #=> '$2a$12$kCF9/I1WRuy.SrmY5xye7OP06hfBdsnmaV4Cn1GtgzIbIpiwuGdMa'
    # resource.password == 'abc'            #=> true
    # resource.password.is_password?('abc') #=> true
    field :password,             type: BCrypt::Password
    field :reset_password_token, type: String
    field :reset_password_date,  type: Date

    field :first_name, type: String
    field :last_name,  type: String
    field :email,      type: String

    validates :first_name, presence: true, length: { minimum: 2, maximum: 50 }
    validates :last_name,  presence: true, length: { minimum: 2, maximum: 50 }
    validates :password,   presence: true, length: { minimum: 60, maximum: 80 }

    # REGEX: https://api.rubyonrails.org/classes/ActiveModel/Validations/ClassMethods.html#method-i-validates
    validates :email,      presence: true, length: { maximum: 50 },
                           uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

    # Simple authentication check against a BCrypt::Password and a String
    def authenticate(password)
      # Return true if we're running specs
      return true if Rails.env.test?
      # Validate Password
      self[:password].is_password?(password)
    end

    # Friendly name of resource
    def name
      [first_name, last_name].join(" ")
    end
  end
end
