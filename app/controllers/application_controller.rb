require 'jwt'

class ApplicationController < ActionController::API

    RSA_PRIVATE_KEY = OpenSSL::PKey::RSA.new(File.read(File.join(Rails.root, 'id_rsa')))
    RSA_PUBLIC_KEY = RSA_PRIVATE_KEY.public_key

    rescue_from 'ActiveRecord::RecordNotUnique' do |exception|
        render_error exception, 409
    end

    def get_token(user_id)
        now = Time.now.to_i
        payload = {
            iat: now,
            exp: now + 4 * 3600,
            aud: "Botter back-end",
            iss: "Botter back-end",
            user_id: user_id
        }
        JWT.encode payload, RSA_PRIVATE_KEY, 'RS512'
    end
    
    private

    def render_error(error, status_code)
        render json: {error: error.class, message: error.message}, status: status_code
    end
end
