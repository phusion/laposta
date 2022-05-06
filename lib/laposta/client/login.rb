module Laposta
  class Client
    module Login
      # Allowed attributes:
      # Name      Type    Description
      # ------------------------------------------------------------
      # login     string  The login
      # password  string  The password
      # ------------------------------------------------------------
      def login(params = {})
        cleaned = params.permit(:login, :password)
        get("login", cleaned)
      end
    end
  end
end