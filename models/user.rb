# frozen_string_literal: true

require 'faker'

module Models
  class User
    include CommonHelpers
    attr_reader :username, :password, :firstname, :lastname, :phone_number, :address, :city, :zip, :state, :ssn
    attr_accessor :account_ids

    def initialize
      @firstname = Faker::Name.first_name
      @lastname = Faker::Name.last_name
      @address = Faker::Address.street_address
      @city = Faker::Address.city
      @state = Faker::Address.state
      @zip = Faker::Address.zip
      @phone_number = Faker::PhoneNumber.cell_phone_in_e164
      @ssn = Faker::IDNumber.ssn_valid
      @username = firstname + "_" + Faker::Alphanumeric.alphanumeric(number: 8)
      @password = 'password'
      @account_ids = []
    end
  end
end
