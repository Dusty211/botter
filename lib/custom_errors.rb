module CustomErrors
    class UnauthorizedError < StandardError
        def initialize(message = "Unauthorized")
            super
            @message = message
        end
    end

    class ForbiddenError < StandardError
        def initialize(message = "Forbidden")
            super
            @message = message
        end
    end
end