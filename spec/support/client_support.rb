class ClientSupport
  class << self
    def get_good_client
      CampaignMaster::Client.new('derek', 'password', 123)
    end

    def get_bad_client
      CampaignMaster::Client.new('derek', 'badsecret', 123)
    end
  end
end
