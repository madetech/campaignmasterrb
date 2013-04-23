require 'spec_helper'

describe CampaignMaster::Client do
  describe ".new" do
    it "accepts a username, password and client ID as constructor arguments" do
      client = ClientSupport.get_good_client

      expect(client.username).to eq 'derek'
      expect(client.password).to eq 'password'
      expect(client.id).to eq 123
    end
  end

  describe ".get_security_token" do
    it "will return the cached security token if it has not expired" do
      client = ClientSupport.get_good_client

      VCR.use_cassette('login_successful') do
        client.get_security_token()
      end

      expect(client.get_security_token()).to eq "secrettoken"
    end

    it "will fetch a new security token if it has expired" do
      client = ClientSupport.get_good_client

      VCR.use_cassette('login_successful') do
        expect(client.get_security_token()).to eq "secrettoken"
      end

      client.stub(:token_expired).and_return(true)

      VCR.use_cassette('login_successful_new_token') do
        expect(client.get_security_token()).to eq "newsecrettoken"
      end
    end

    it "will raise an exception if bad credentials are passed" do
      client = ClientSupport.get_bad_client

      VCR.use_cassette('login_unsuccessful') do
        expect { client.get_security_token() }.to raise_error
      end
    end
  end
end
