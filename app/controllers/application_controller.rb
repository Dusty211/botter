require 'jwt'

class ApplicationController < ActionController::API
    include CustomErrors

    before_action :authenticate

    RSA_PRIVATE_KEY = OpenSSL::PKey::RSA.new(File.read(File.join(Rails.root, 'id_rsa')))
    RSA_PUBLIC_KEY = RSA_PRIVATE_KEY.public_key

    rescue_from 'ActiveRecord::RecordNotUnique' do |exception|
        render_error exception, 409
    end

    rescue_from 'CustomErrors::ForbiddenError' do |exception|
        render_error exception, 403
    end

    rescue_from 'CustomErrors::BadRequestError' do |exception|
        render_error exception, 400
    end
    
    private

    def render_error(error, status_code)
        render json: {error: error.class, message: error.message}, status: status_code
    end

    def authenticate
        auth_headers = request.headers["Authorization"]
        if auth_headers.class == String && auth_headers.length > 0
            begin
                token = auth_headers[7..-1]
                decoded_token = JWT.decode token, RSA_PUBLIC_KEY, true, { algorithm: 'RS512' }
                @user_id = decoded_token[0]["user_id"]
                # Refresh token:
                update_headers_with_token @user_id
            rescue JWT::ExpiredSignature => e
                render_error(CustomErrors::UnauthorizedError.new(e.message), 401)
            rescue => e
                puts(e)
                render_error(CustomErrors::UnauthorizedError.new, 401)
            end
        else
            render_error(CustomErrors::UnauthorizedError.new, 401)
        end
    end

    def get_token(user_id)
        now = Time.now.to_i
        payload = {
            iat: now,
            exp: now + 24 * 3600,
            aud: "Botter back-end",
            iss: "Botter back-end",
            user_id: user_id
        }
        JWT.encode payload, RSA_PRIVATE_KEY, 'RS512'
    end

    def update_headers_with_token(user_id)
        response.headers["Authorization"] = "Bearer #{get_token user_id}"
    end
    
    def token_user_id
        @user_id
    end
end
