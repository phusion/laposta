module Laposta
  class Client
    module Lists
      def lists(params = {})
        list("list", params)
      end

      # Parameters
      # Name     Type    Description
      # ------------------------------------------------------------
      # list_id  string  The list's ID
      # ------------------------------------------------------------
      def get_list(list_id)
        get("list/#{list_id}")
      end

      # Allowed attributes:
      # Name                            Type               Description
      # ------------------------------------------------------------
      # name                            string             A name for the list in question
      # remarks                         string (optional)  Potential remarks
      # subscribe_notification_email    string (optional)  Email address to which a notification will be sent upon a subscription
      # unsubscribe_notification_email  string (optional)  Email address to which a notification will be sent upon the cancelling of a subscription
      # ------------------------------------------------------------
      def create_list!(params = {})
        cleaned = params.permit(:name,
                                :remark,
                                :subscribe_notification_email,
                                :unsubscribe_notification_email)
        create("list", cleaned)
      end

      # Parameters
      # Name     Type    Description
      # -------------------------------
      # list_id  string  The ID of the list that has to be modified
      # -------------------------------
      #
      # Allowed attributes:
      # Name                            Type               Description
      # ------------------------------------------------------------
      # name                            string (optional)  A name for the list in question
      # remarks                         string (optional)  Potential remarks
      # subscribe_notification_email    string (optional)  Email address to which a notification will be sent upon a subscription
      # unsubscribe_notification_email  string (optional)  Email address to which a notification will be sent upon the cancelling of a subscription
      # ------------------------------------------------------------
      def update_list!(list_id, params = {})
        cleaned = params.permit(:name,
                                :remark,
                                :subscribe_notification_email,
                                :unsubscribe_notification_email)
        update("list/#{list_id}", cleaned)
      end

      # Name     Type    Description
      # ------------------------------------------------------------
      # list_id  string  The ID of the list
      # ------------------------------------------------------------
      def delete_list!(list_id)
        delete("list/#{list_id}")
      end

      # Name     Type    Description
      # ------------------------------------------------------------
      # list_id  string  The ID of the list
      # ------------------------------------------------------------
      def purge_list!(list_id)
        delete("list/#{list_id}/members")
      end
    end
  end
end