module Authenticateable
  extend ActiveSupport::Concern

  included do
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
    field :password, type: BCrypt::Password
    field :reset_password_token, type: String
    field :reset_password_date, type: Date
  end
end
