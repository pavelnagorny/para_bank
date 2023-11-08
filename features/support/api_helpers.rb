# frozen_string_literal: true

module Support
  module APIHelpers

    def parse_html
      Nokogiri::HTML(@response.body)
    end

    def parse_xml
      Nokogiri::XML(@response.body)
    end

    def new_user_payload(member)
      URI.encode_www_form({
                            'customer.firstName': member.firstname,
                            'customer.lastName': member.lastname,
                            'customer.address.street': member.address,
                            'customer.address.city': member.city,
                            'customer.address.state': member.state,
                            'customer.address.zipCode': member.zip,
                            'customer.phoneNumber': member.phone_number,
                            'customer.ssn': member.ssn,
                            'customer.username': member.username,
                            'customer.password': member.password,
                            'repeatedPassword': member.password
                          }
      )
    end



    def response_body
      JSON.parse(@response.body)
    end

    def response_status
      @response.status.to_s
    end

    def retrieve_customer_id
      self.api_client_get(path: CommonVars::OVERVIEW_API_HOST)
      @customer_id = self.parse_html.at_xpath("//script[contains(text(), 'services_proxy/bank/customers/')]")
                           .text.scan(/(\d+) \+ "\/accounts"/)[0][0]
    end
  end
end
