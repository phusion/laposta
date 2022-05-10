module Laposta
  class Client
    module Campaigns
      def campaigns(params = {})
        list("campaign", params)
      end

      # Parameters
      # Name         Type                Description
      # ------------------------------------------------------------
      # campaign_id  string (mandatory)  The ID of the campaign
      # ------------------------------------------------------------
      def get_campaign(campaign_id)
        get("campaign/#{campaign_id}")
      end

      # Allowed attributes:
      # Name                         Type               Description
      # ------------------------------------------------------------
      # type           string (mandatory)  Type of campaign (must be set to: regular)
      # name           string (mandatory)  A name for this campaign for internal use
      # subject        string (mandatory)  Subject line
      # from           object (mandatory)
      # from[name]     string (mandatory)  The name of the sender
      # from[email]    string (mandatory)  The email address of the sender (must be a sender address approved within the program)
      # reply_to       string              Email address for receiving replies
      # list_ids       array (mandatory)   Recipients, array of list_ids and segment_ids if needed
      # stats          object
      # stats[ga]      boolean             Link Google Analytics (true or false)
      # stats[mtrack]  boolean             Link Mtrack (true or false)
      # ------------------------------------------------------------
      def create_campaign!(params = {})
        cleaned = params.permit(:type,
                                :name,
                                :subject,
                                { from: [:name, :email] },
                                :reply_to,
                                :list_ids,
                                { stats: [:ga, :mtrack] })
        create("campaign", cleaned)
      end

      # Parameters
      # Name         Type                Description
      # ------------------------------------------------------------
      # campaign_id  string (mandatory)  The ID of the campaign that has to be modified
      # ------------------------------------------------------------
      #
      # Allowed attributes:
      # Name                         Type                Description
      # ------------------------------------------------------------
      # name           string (mandatory)  A name for this campaign for internal use
      # subject        string (mandatory)  Subject line
      # from           object (mandatory)
      # from[name]     string (mandatory)  The name of the sender
      # from[email]    string (mandatory)  The email address of the sender (must be a sender address approved within the program)
      # reply_to       string              Email address for receiving replies
      # list_ids       array (mandatory)   Recipients, array of list_ids and segment_ids if needed
      # stats          object
      # stats[ga]      boolean             Link Google Analytics (true or false)
      # stats[mtrack]  boolean             Link Mtrack (true or false)
      # ------------------------------------------------------------
      def update_campaign!(campaign_id, params = {})
        cleaned = params.permit(:name,
                                :subject,
                                { from: [:name, :email] },
                                :reply_to,
                                :list_ids,
                                { stats: [:ga, :mtrack] })
        update("campaign/#{campaign_id}", cleaned)
      end

      # Parameters
      # Name          Type                Description
      # ------------------------------------------------------------
      # campaign_id   string (mandatory)  The ID of the campaign to be deleted
      # ------------------------------------------------------------
      def delete_campaign!(campaign_id, params = {})
        delete("campaign/#{campaign_id}")
      end

      # Parameters
      # Name         Type                Description
      # ------------------------------------------------------------
      # campaign_id  string (mandatory)  The ID of the campaign
      # ------------------------------------------------------------
      def get_campaign_content(campaign_id)
        get("campaign/#{campaign_id}/content")
      end

      # Parameters
      # Name         Type                Description
      # ------------------------------------------------------------
      # campaign_id  string (mandatory)  The ID of the campaign
      # ------------------------------------------------------------
      #
      # Allowed attributes:
      # Name        Type     Description
      # ------------------------------------------------------------
      # html        string   The html for the campaign
      # import_url  string   The URL from which the html must be imported
      # inline_css  boolean  Potential inlining of css (true or false)
      # ------------------------------------------------------------
      def fill_campaign_content!(campaign_id, params = {})
        cleaned = params.permit(:html,
                                :import_url,
                                :inline_css)
        update("campaign/#{campaign_id}/content", cleaned)
      end

      # Parameters
      # Name         Type                Description
      # ------------------------------------------------------------
      # campaign_id  string (mandatory)  The ID of the campaign
      # ------------------------------------------------------------
      def send_campaign!(campaign_id)
        update("campaign/#{campaign_id}/action/send", {})
      end

      # Parameters
      # Name         Type                Description
      # ------------------------------------------------------------
      # campaign_id  string (mandatory)  The ID of the campaign
      # ------------------------------------------------------------
      #
      # Allowed attributes:
      # Name                Type               Description
      # ------------------------------------------------------------
      # delivery_requested  string(mandatory)  The time and date of sending (format YYYY-MM-DD HH:MM:SS)
      # ------------------------------------------------------------
      def schedule_campaign!(campaign_id, params = {})
        cleaned = params.permit(:delivery_requested)
        update("campaign/#{campaign_id}/action/schedule", cleaned)
      end

      # Parameters
      # Name         Type                Description
      # ------------------------------------------------------------
      # campaign_id  string (mandatory)  The ID of the campaign
      # ------------------------------------------------------------
      #
      # Allowed attributes:
      # Name   Type               Description
      # ------------------------------------------------------------
      # email  string(mandatory)  The email address to which the test should be sent.
      # ------------------------------------------------------------
      def test_campaign!(campaign_id, params = {})
        cleaned = params.permit(:email)
        update("campaign/#{campaign_id}/action/testmail", cleaned)
      end
    end
  end
end