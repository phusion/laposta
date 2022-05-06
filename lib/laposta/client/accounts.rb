module Laposta
  class Client
    module Accounts
      def accounts(params = {})
        list("account", params)
      end

      # Parameters
      # Name        Type                Description
      # ------------------------------------------------------------
      # account_id  string (mandatory)  The ID of the account
      # ------------------------------------------------------------
      def get_account(account_id)
        get("account/#{account_id}")
      end

      # Allowed attributes:
      # Name           Type                Description
      # ------------------------------------------------------------
      # hostname       string              The hostname for this account, for in the url hostname.email-provider.com
      # company        object (mandatory)
      # company[name1] string (mandatory)  The name of the organization of this account
      # company[name2] string              Extra line for the name of the organization of this account
      # user           object (mandatory)
      # user[email]    string (mandatory)  Email address of the user associated with this account
      # user[sex]      string              The sex of the user associated with this account (male or female)
      # user[name1]    string              The first name of the user associated with this account
      # user[name2]    string              The last name of the user associated with this account
      # ------------------------------------------------------------
      def create_account!(params = {})
        cleaned = params.permit(:hostname,
                                { company: [:name1, :name2] },
                                { user: [:email, :sex, :name1, :name2] })
        create("account", cleaned)
      end
    end
  end
end