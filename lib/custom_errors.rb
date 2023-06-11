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

    class BadRequestError < StandardError
        def initialize(message = "Bad request")
            super
            @message = message
        end
    end

    class GoneError < StandardError
        def initialize(message = "The target resource is no longer available")
            super
            @message = message
        end
    end
end