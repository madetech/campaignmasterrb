require 'base64'

module CampaignMaster
  class Subscriber
    ImportError = Class.new(RuntimeError)

    attr_accessor :client

    def initialize(client)
      self.client = client
    end

    def import(format, delimeter, subscribers)
      soap_client = CampaignMaster::SoapClient.get_client(self.get_import_headers(delimeter))

      response = soap_client.call(:submit_import_job,
              message_tag: "SubmitJobRequest",
              message: { FileToImport: Base64.encode64("#{format}\r\n#{subscribers}") },
              :attributes => CampaignMaster::SoapClient.attributes
      )

      raise ImportError if !self.valid_response?(response)

      response.body[:job_submission_result_message][:job_id].to_i
    end

    protected
    def get_import_headers(delimeter)
      {
        "ns2:SecurityToken" => { "ns3:Value" => self.client.get_security_token() },
        "ns2:JobDefinition" => {
          "ns3:Delimiter" => delimeter,
          "ns3:Filename" => "import.txt",
          "ns3:InsertSettings" => {
            "ns5:AllowImport" => true,
            "ns5:MakeActive" => true,
            "ns5:MakeVerified" => true
          },
          "ns3:PrimaryKey" => "EmailAddress",
          "ns3:UpdateSettings" => {
            "ns5:AllowImport" => true,
            "ns5:MakeActive" => true,
            "ns5:MakeVerified" => true
          },
          "ns3:UseFirstDuplicate" => 1
        }
      }
    end

    def valid_response?(response)
      (response.body.has_key?(:job_submission_result_message) and
      response.body[:job_submission_result_message].has_key?(:job_id) and
      response.body[:job_submission_result_message][:job_id].to_i > 0)
    end
  end
end
