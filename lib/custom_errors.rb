module CustomErrors
    class UnauthorizedError < StandardError
        def initialize(message = "Unauthorized")
            super
            @message = message
        end
    end
end