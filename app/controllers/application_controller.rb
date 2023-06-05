class ApplicationController < ActionController::API

    rescue_from 'ActiveRecord::RecordNotUnique' do |exception|
        render_error exception, 409
    end
    
    private

    def render_error(error, status_code)
        render json: {error: error.class, message: error.message}, status: status_code
    end
end
