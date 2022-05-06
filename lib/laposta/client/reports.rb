module Laposta
  class Client
    module Reports
      def reports(params = {})
        list("report", params)
      end

      # Parameters
      # Name         Type                Description
      # ------------------------------------------------------------
      # campaign_id  string (mandatory)  The ID of a campaign
      # ------------------------------------------------------------
      def get_report(campaign_id)
        get("report/#{campaign_id}")
      end
    end
  end
end