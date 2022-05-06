module Laposta
  class Client
    module Webhooks
      # Parameters
      # Name      Type    Description
      # ------------------------------------------------------------
      # webhook_id  string  The ID of the webhookto be requested
      # ------------------------------------------------------------
      #
      # Allowed attributes:
      # Name     Type    Description
      # ------------------------------------------------------------
      # list_id  string  The ID of the list to which the webhook belongs
      # ------------------------------------------------------------
      def get_webhook(webhook_id, params = {})
        cleaned = params.permit(:list_id)
        get("webhook/#{webhook_id}", cleaned)
      end

      # Allowed attributes:
      # Name     Type    Description
      # ------------------------------------------------------------
      # list_id  string  The ID of the list to which the webhook belongs
      # ------------------------------------------------------------
      def get_webhooks_for_list(params = {})
        cleaned = params.permit(:list_id)
        list("webhook", cleaned)
      end

      # Allowed attributes:
      # Name     Type                Description
      # ------------------------------------------------------------
      # list_id  string (mandatory)   The ID of the list to which the webhook belongs
      # event    string (mandatory)   When will the webhook be requested? (subscribed, modified of deactivated)
      # url      string (mandatory)   The URL to be accessed
      # blocked  boolean (mandatory)  Is the accessing of the webhook (temporarily) blocked? (true or false)
      # ------------------------------------------------------------
      def create_webhook!(params = {})
        cleaned = params.permit(:list_id,
                                :event,
                                :url,
                                :blocked)
        create("webhook", cleaned)
      end


      # Parameters
      # Name      Type    Description
      # ------------------------------------------------------------
      # webhook_id  string  The ID of the webhook to be modified
      # ------------------------------------------------------------
      #
      # Allowed attributes:
      # Name        Type                Description
      # ------------------------------------------------------------
      # list_id     string (mandatory)  The ID of the list to which the webhook belongs
      # event       string              When will the webhook be requested? (subscribed, modified or deactivated)
      # url         string              The URL to be accessed
      # blocked     boolean             Is the accessing of the webhook (temporarily) blocked? (true or false)
      # ------------------------------------------------------------
      def update_webhook!(webhook_id, params = {})
        cleaned = params.permit(:list_id,
                                :event,
                                :url,
                                :blocked)
        update("webhook/#{webhook_id}", cleaned)
      end

      # Parameters
      # Name         Type    Description
      # ------------------------------------------------------------
      # webhook_id   string  The ID of the webhook to be deleted
      # ------------------------------------------------------------
      #
      # Allowed attributes:
      # Name     Type                Description
      # ------------------------------------------------------------
      # list_id  string (mandatory)  The ID of the list to which the webhook belongs
      # ------------------------------------------------------------
      def delete_webhook!(webhook_id, params = {})
        cleaned = params.permit(:list_id)
        delete("webhook/#{webhook_id}", cleaned)
      end
    end
  end
end