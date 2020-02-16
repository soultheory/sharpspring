# Named ext.rb instead of bcrypt/password.rb to avoid name clash in test environment.
module BCrypt
  class Password
    class << self
      # We want to define a custom field BCrypt::Password and store it in MongoDB.
      # That object contains all the hash data we need to check passwords.
      # This allows us to encrypt the password through BCrypt,
      # Store it as MongoDB friendly hash via mongoize and never know what the real value is.
      # Documentation: # https://docs.mongodb.com/mongoid/master/tutorials/mongoid-documents/index.html#custom-fields
      def mongoize(password)
        BCrypt::Password.create(password).mongoize
      end

      def demongoize(password)
        case password
        when String then self.new(password)
        when nil then nil
        else password
        end
      end

      def evolve(password)
        password.mongoize
      end
    end

    def mongoize
      self.to_s
    end
  end
end
