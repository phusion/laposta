module Laposta
  class Client
    module Subscribers
      # Allowed attributes:
      # Name     Type               Description
      # ------------------------------------------------------------
      # list_id  string             The ID of the list from which the subscribers are being requested
      # state    string (optional)  The status of the requested subscribers: active, unsubscribed or cleaned
      # ------------------------------------------------------------
      def get_subscribers_for_list(params = {})
        cleaned = params.permit(:list_id, :state)
        list("member", cleaned)
      end

      # Parameters
      # Name       Type    Description
      # ------------------------------------------------------------
      # member_id  string  The ID or the email address of the subscriber
      # ------------------------------------------------------------
      #
      # Allowed attributes:
      # Name     Type    Description
      # ------------------------------------------------------------
      # list_id  string  The ID of the list in which the subscriber appears
      # ------------------------------------------------------------
      def get_subscriber(member_id, params = {})
        cleaned = params.permit(:list_id, :state)
        get("member/#{member_id}", cleaned)
      end

      # Allowed attributes:
      # Name            Type               Description
      # ------------------------------------------------------------
      # list_id         string             The ID of the list to which the subscriber must be added
      # ip              string             The IP address from which the subscriber is registered
      # email           string             The email address of the subscriber to be added
      # source_url      string (optional)  The URL from which the subscriber is registered
      # custom_fields   array (optional)   The values of the additionally created fields
      # options         array (optional)   Additional instructions, with possibilities being:
      #                                    suppress_email_notification: true to prevent a notification email from being sent every time someone logs in via an API,
      #                                    suppress_email_welcome: true to prevent the welcome email from being sent when registering via the API, and
      #                                    ignore_doubleoptin: true to instantly activate subscribers on a double-optin list and ensure that no confirmation email is sent when signing up through the API.
      # ------------------------------------------------------------
      def create_subscriber!(params = {})
        cleaned = params.permit(:list_id,
                                :ip,
                                :email,
                                :source_url,
                                :custom_fields,
                                :options)
        create("member", cleaned)
      end

      # Parameters
      # Name        Type   Description
      # ------------------------------------------------------------
      # member_id  string  The subscriber's ID
      # ------------------------------------------------------------
      #
      # Allowed attributes:
      # Name            Type               Description
      # ------------------------------------------------------------
      # list_id         string             The ID of the list to which the subscriber must be modified
      # email           string (optional)  The email address of the subscriber that must be modified
      # state           string (optional)  The new status of the subscriber: active or unsubscribed
      # custom_fields   array (optional)   The values of the extra created fields
      # ------------------------------------------------------------
      def update_subscriber!(member_id, params = {})
        cleaned = params.permit(:list_id,
                                :email,
                                :state,
                                :custom_fields)
        update("member/#{member_id}", cleaned)
      end

      # Name        Type   Description
      # ------------------------------------------------------------
      # member_id  string  The subscriber's ID
      # ------------------------------------------------------------
      #
      # Allowed attributes:
      # Name     Type    Description
      # ------------------------------------------------------------
      # list_id  string  The ID of the list to which the subscriber must be modified
      # ------------------------------------------------------------
      def delete_subscriber!(member_id)
        delete("member/#{member_id}")
      end
    end
  end
end