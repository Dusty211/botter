class User < ApplicationRecord

    validates :email, email: true

    ONLY = [:id, :email, :username, :enabled, :created_at, :updated_at]

    def safe_attributes
        self.as_json(:only => [*ONLY])
    end
end
