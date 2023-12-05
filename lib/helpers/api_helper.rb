# frozen_string_literal: true

module APIHelper

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
    api_client_get(path: CommonVars::OVERVIEW_API_HOST)
    extract_customer_id_from_html
  end

  def extract_customer_id_from_html
    script_content = parse_html.at_xpath("//script[contains(text(), 'services_proxy/bank/customers/')]").text
    match_data = script_content.match(/(\d+) \+ "\/accounts"/)

    match_data.nil? ? nil : match_data[1]
  end
end
