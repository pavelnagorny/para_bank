# frozen_string_literal: true
require_relative 'api_helpers'

module Support
  class APIClient
    class ItemNotSupported < StandardError; end
    include APIHelpers
    def initialize
      @http_conn = Excon.new(CommonVars::BASE_URL)
    end

    def get_api_token
      @response = @http_conn.get(path: CommonVars::INDEX_API_HOST)
      @token = @response.headers['Set-Cookie'].split(';').first
    end
    def api_client_auth(username, password)
      headers = CommonVars::API_HEADERS.merge('Cookie' => @token)
      @response = @http_conn.post(path: CommonVars::LOGIN_API_HOST,
                                  body: URI.encode_www_form(username: username, password: password),
                                  headers: headers)
      case @response.status
      when 302
        LOGGER.info "Request was successful: #{@response.status}"
      when 400..499
        LOGGER.error "Client error occurred: #{@response.status}"
      when 500..599
        LOGGER.error "Server error occurred: #{@response.status}"
      else
        LOGGER.error "Unexpected status code: #{@response.status}"
      end
      @response
    end

    def api_client_get(path:, **kwargs)
      headers = { 'Cookie' => @token }
      headers.merge!(**kwargs) if kwargs
      @response = @http_conn.get(path: path,
                                  headers: headers)

      case @response.status
      when 200..299
        LOGGER.info "Request was successful: #{@response.status}"
      when 400..499
        LOGGER.error "Client error occurred: #{@response.status}"
      when 500..599
        LOGGER.error "Server error occurred: #{@response.status}"
      else
        LOGGER.error "Unexpected status code: #{@response.status}"
      end
      @response
    end

    def api_client_post(path:, request_body:, **kwargs)
      headers = { 'Cookie' => @token }
      headers.merge!(**kwargs) if kwargs
      @response = @http_conn.post(path: path,
                                   body: request_body,
                                   headers: headers)
      case @response.status
      when 200..299
        LOGGER.info "Request was successful: #{@response.status}"
      when 400..499
        LOGGER.error "Client error occurred: #{@response.status}"
      when 500..599
        LOGGER.error "Server error occurred: #{@response.status}"
      else
        LOGGER.error "Unexpected status code: #{@response.status}"
      end
      @response
    end

    def get_reg_token
      @response = @http_conn.get(path: '/parabank/register.htm')
      @token = @response.headers['Set-Cookie'].split(';').first
    end
    def api_register_new_user(member)
      headers = CommonVars::API_HEADERS.merge(:Cookie => @token)
      request_body = new_user_payload(member)
      @response = @http_conn.post(path: CommonVars::REGISTER_API_HOST,
                                  body: request_body,
                                  headers: headers)
      case @response.status
      when 200
        LOGGER.info "Request was successful: #{@response.status}"
      when 400..499
        LOGGER.error "Client error occurred: #{@response.status}"
      when 500..599
        LOGGER.error "Server error occurred: #{@response.status}"
      else
        LOGGER.error "Unexpected status code: #{@response.status}"
      end
      @response
    end
  end
end
