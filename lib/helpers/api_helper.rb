# frozen_string_literal: true

module APIHelper
  def parse_html
    Nokogiri::HTML(@response.body)
  end

  def parse_xml
    Nokogiri::XML(@response.body)
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
    match_data = script_content.match(%r{(\d+) \+ "/accounts"})

    match_data.nil? ? nil : match_data[1]
  end
end
