module Laposta
  class Error < StandardError
    def self.from_response(response)
      error_class = case response.status

        when 301 then LoginDoesNotExistError        # This login does not exist
        when 302 then InvalidPasswordError          # The password entered is incorrect
        when 303 then UserNotAllowedToLoginError    # This user is not (or no longer) allowed to log in
        when 304 then AccountNotAllowedToLoginError # This account is not (or no longer) allowed to log in
        when 305 then AccountNotVerifiedError       # This account has not been verified
        when 400 then BadRequestError               # Incomplete input
        when 401 then UnauthorizedError             # No valid API key was provided
        when 402 then RequestFailedError            # Input was in order, but request was not processed
        when 404 then NotFoundError                 # The requested object does not exist/could not be located
        when 429 then TooManyRequestsError          # The maximum number of requests was reached within the given unit of time
        when 500 then ServerError                   # Error detected on Laposta's side
        else self
        end
      error_class.new(response)
    end

    def initialize(response)
      @response = response
      super("Response: #{response.inspect}\nBody: #{response.body}")
    end
  end

  # Login errors
  class LoginDoesNotExistError < Error; end
  class InvalidPasswordError < Error; end
  class UserNotAllowedToLoginError < Error; end
  class AccountNotAllowedToLoginError < Error; end
  class AccountNotVerifiedError < Error; end
  # Generic errors
  class BadRequestError < Error; end
  class NotFoundError < Error; end
  class RequestFailedError < Error; end
  class UnauthorizedError < Error; end
  class TooManyRequestsError < Error; end
  class ServerError < Error; end
end
