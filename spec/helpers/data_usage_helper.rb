# frozen_string_literal: true

module DataUsageHelper
  def self.included(context)
    context.let(:storage) { @storage }
    context.let(:user) { storage.user }
    context.let(:api_client) { storage.api_client }
    context.let(:prepared_data?) { storage.prepared_data? }

    context.before(:all) do
      @storage = Helpers::StorageHelper
    end

    context.after(:all) do
      @storage.prepared_data = false
    end
  end
end

RSpec.configure { |conf| conf.include DataUsageHelper }
