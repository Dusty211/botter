class User < ApplicationRecord

    ONLY = [:id, :email, :username, :enabled, :created_ad, :updated_at]

    def safe_attributes
        self.as_json(:only => [*ONLY])
    end
end
