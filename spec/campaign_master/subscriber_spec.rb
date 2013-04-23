require 'spec_helper'

describe CampaignMaster::Subscriber do
  describe ".new" do
    it "sets the value of the client property to the passed argument" do
      arg = "client_dummy"
      subscriber = CampaignMaster::Subscriber.new(arg)
      expect(subscriber.client).to eq arg
    end
  end

  describe ".import" do
    it "returns the Job ID if it's successfully called" do
      import_data = SubscriberSupport.get_import_data
      client = ClientSupport.get_good_client

      VCR.use_cassette('login_import_successful') do
        response = client.call(:Subscriber).import(import_data[:format], import_data[:subscribers], import_data[:delimiter])
        expect(response).to eq 123456
      end
    end

    it "raises an exception if an invalid response is received" do
      import_data = SubscriberSupport.get_import_data
      client = ClientSupport.get_good_client
      subscriber = client.call(:Subscriber)

      subscriber.stub("valid_response?").and_return(false)

      VCR.use_cassette('login_import_successful') do
        expect { subscriber.import(import_data[:format], import_data[:subscribers], import_data[:delimiter]) }.to raise_error
      end
    end
  end

  describe ".get_import_headers" do
    it "returns a hash containing the SOAP headers for the request" do
      client = ClientSupport.get_good_client
      subscriber = client.call(:Subscriber)

      VCR.use_cassette('login_successful') do
        expect(subscriber.send(:get_import_headers, ",")["ns2:JobDefinition"]["ns3:Filename"]).to eq "import.txt"
      end
    end

    it "take a delimeter parameter and includes this in the headers" do
      client = ClientSupport.get_good_client
      subscriber = client.call(:Subscriber)

      VCR.use_cassette('login_successful') do
        expect(subscriber.send(:get_import_headers, "^^")["ns2:JobDefinition"]["ns3:Delimiter"]).to eq "^^"
      end
    end

    it "returns the authentication information in the headers" do
      client = ClientSupport.get_good_client
      subscriber = client.call(:Subscriber)

      VCR.use_cassette('login_successful') do
        expect(subscriber.send(:get_import_headers, ",")["ns2:SecurityToken"]["ns3:Value"]).to eq "secrettoken"
      end
    end
  end
end
