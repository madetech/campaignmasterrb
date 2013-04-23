module Savon
  def self.extract_envelope_from_response_body(response_body)
    envelope_start = response_body.index("<s:Envelope")
    envelope_end = response_body.index("</s:Envelope>") + 12

    response_body[envelope_start..envelope_end]
  end

  class Response
    def to_xml
      Savon::extract_envelope_from_response_body(@http.body)
    end
  end

  class SOAPFault
    def to_hash
      nori.parse(Savon::extract_envelope_from_response_body(@http.body))[:envelope][:body]
    end
  end
end
