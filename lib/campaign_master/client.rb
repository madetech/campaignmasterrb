module CampaignMaster
  class Client
    AuthenticationError = Class.new(RuntimeError)

    attr_accessor :username, :password, :id

    def initialize(username, password, id)
      @login_expiration_seconds = -1
      @security_token = false

      self.username  = username
      self.password  = password
      self.id        = id
    end

    def get_security_token
      if self.token_expired
        soap_client = CampaignMaster::SoapClient.get_client()
        response = soap_client.call(:login,
            message: { clientID: self.id, userName: self.username, password: self.password },
            :attributes => CampaignMaster::SoapClient.attributes
        )

        raise AuthenticationError if !self.valid_response?(response)

        @login_expiration_seconds = Time.now.to_i + response.body[:login_response][:login_result][:minutes_till_token_expires].to_i * 60
        @security_token = response.body[:login_response][:login_result][:token_string]
      end

      @security_token
    end

    def token_expired
      @login_expiration_seconds < Time.now.to_i
    end

    def call(class_name)
      CampaignMaster.const_get(class_name).new(self)
    end

    protected
    def valid_response?(response)
      (response.body.has_key?(:login_response) and
      response.body[:login_response].has_key?(:login_result) and
      response.body[:login_response][:login_result].has_key?(:minutes_till_token_expires) and
      response.body[:login_response][:login_result].has_key?(:token_string) and
      response.body[:login_response][:login_result][:minutes_till_token_expires].to_i > 0)
    end
  end
end
