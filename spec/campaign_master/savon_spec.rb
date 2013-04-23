require 'spec_helper'

describe Savon do
  describe ".extract_envelope_from_response_body" do
    it "extracts all the envelope from a crufty response body" do
      useful_response = "<s:Envelope><payload>value</payload></s:Envelope>"
      crufty_response = "some-cruft---#{useful_response}---more-cruft"

      expect(Savon.extract_envelope_from_response_body(crufty_response)).to eq useful_response
    end
  end
end
