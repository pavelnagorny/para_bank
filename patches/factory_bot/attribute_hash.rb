# frozen_string_literal: true
# require 'factory_bot'

module FactoryBot
  class Decorator
    class AttributeHash < Decorator
      def alternative_attributes
        alt_attributes = attributes
        alternative_names = attributes[:alternative_name]
        alternative_names&.each do |old_key, new_key|
          alt_attributes[new_key] = alt_attributes.delete old_key if alt_attributes.key?(old_key)
        end
        alt_attributes.delete(:alternative_name)
        alt_attributes
      end
    end
  end
end
