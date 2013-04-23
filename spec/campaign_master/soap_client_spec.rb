require 'spec_helper'

describe CampaignMaster::SoapClient do
  describe ".get_client" do
    it "returns an instance of Savon::Client" do
      CampaignMaster::SoapClient.get_client.should be_a(Savon::Client)
    end

    it "includes the soap_header in the headers if the argument is passed" do
      soap_header = {"test" => "example"}

      soap_client = CampaignMaster::SoapClient.get_client(soap_header)
      expect(soap_client.globals[:soap_header]).to be soap_header
    end

    it "omits the soap_header from the headers if no argument is passed" do
      soap_client = CampaignMaster::SoapClient.get_client()
      expect(soap_client.globals[:soap_header]).to be_nil
    end
  end

  describe ".namespaces" do
    it "returns a hash containing the necessary namespaces for a SOAP request" do
      expect(CampaignMaster::SoapClient.namespaces["xmlns:ns2"]).to eq "http://campaignmaster.com.au"
      expect(CampaignMaster::SoapClient.namespaces["xmlns:ns3"]).to eq "http://schemas.datacontract.org/2004/07/ECM.BLL.WebServices.Client.API.DataContracts"
      expect(CampaignMaster::SoapClient.namespaces["xmlns:ns4"]).to eq "http://schemas.microsoft.com/2003/10/Serialization/"
      expect(CampaignMaster::SoapClient.namespaces["xmlns:ns5"]).to eq "http://schemas.datacontract.org/2004/07/ECM.Model"
      expect(CampaignMaster::SoapClient.namespaces["xmlns:ns1381"]).to eq "http://campaignmaster.com.au"
    end
  end

  describe ".attributes" do
    it "returns the attributes necessary to make a SOAP request" do
      expect(CampaignMaster::SoapClient.attributes["xmlns"]).to eq "http://campaignmaster.com.au"
    end
  end
end
