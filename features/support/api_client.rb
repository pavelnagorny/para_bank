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

    def api_client_auth(user)
      headers = CommonVars::API_HEADERS.merge('Cookie' => @token)
      @response = @http_conn.post(path: CommonVars::LOGIN_API_HOST,
                                  body: URI.encode_www_form(username: user.username, password: user.password),
                                  headers: headers)
      case @response.status
      when 302
        new_location = @response.headers['Location']
        @response = @http_conn.get(path: new_location,
                                   headers: { 'Cookie' => @token })
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

    def api_client_get(path:, additional_headers: {})
      headers = { 'Cookie' => @token }
      headers.merge!(additional_headers) if additional_headers
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

    def api_client_post(path:, request_body:, additional_headers: {})
      headers = { 'Cookie' => @token }
      headers.merge!(additional_headers) if additional_headers
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

    def api_client_post_with_params(path:, params:, additional_headers: {})
      headers = { 'Cookie' => @token }
      headers.merge!(additional_headers) if additional_headers
      @response = @http_conn.post(path: path,
                                  query: params,
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

    def api_register_new_user(user)
      get_reg_token
      headers = CommonVars::API_HEADERS.merge(:Cookie => @token)
      request_body = new_user_payload(user)
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