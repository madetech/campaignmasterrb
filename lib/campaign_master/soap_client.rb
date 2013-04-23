module CampaignMaster
  class SoapClient
    def self.get_client(soap_header = nil)
      options = {
        wsdl: CampaignMaster.wsdl,
        ssl_verify_mode: :none,
        convert_request_keys_to: :none,
        env_namespace: :S,
        namespace_identifier: nil,
        namespaces: self::namespaces,
        log_level: :warn
      }

      options = options.merge({soap_header: soap_header}) if !soap_header.nil?

      Savon.client(options)
    end

    def self.namespaces
      {
        "xmlns:ns2"    => "http://campaignmaster.com.au",
        "xmlns:ns3"    => "http://schemas.datacontract.org/2004/07/ECM.BLL.WebServices.Client.API.DataContracts",
        "xmlns:ns4"    => "http://schemas.microsoft.com/2003/10/Serialization/",
        "xmlns:ns5"    => "http://schemas.datacontract.org/2004/07/ECM.Model",
        "xmlns:ns1381" => "http://campaignmaster.com.au"
      }
    end

    def self.attributes
      {
        "xmlns" => "http://campaignmaster.com.au"
      }
    end
  end
end
