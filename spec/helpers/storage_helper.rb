# frozen_string_literal: true

module Helpers
  class StorageHelper
    class << self
      attr_accessor :user, :prepared_data, :api_client, :users

      def prepared_data?
        @prepared_data ||= false
      end

      def add_user(user)
        @users ||= []
        @users << user
      end
    end
  end
end
