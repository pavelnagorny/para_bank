# frozen_string_literal: true

module EndpointsHelper
  def self.included(context)
    context.let(:init_api_client) { Support::APIClient.new }
    context.let(:init_user) { Models::User.new }
  end
end

RSpec.configure { |conf| conf.include EndpointsHelper }
