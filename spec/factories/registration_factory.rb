# frozen_string_literal: true

FactoryBot.define do
  factory :new_user_registration_payload, class: Hash do
    transient do
      user { nil }
    end

    alternative_name do
      {
        first_name: 'customer.firstName',
        last_name: 'customer.lastName',
        street: 'customer.address.street',
        city: 'customer.address.city',
        state: 'customer.address.state',
        zip_code: 'customer.address.zipCode',
        phone_number: 'customer.phoneNumber',
        ssn: 'customer.ssn',
        username: 'customer.username',
        password: 'customer.password'
      }
    end

    first_name { user.firstname }
    last_name { user.lastname }
    street { user.address }
    city { user.city }
    state { user.state }
    zip_code { user.zip }
    phone_number { user.phone_number }
    ssn { user.ssn }
    username { user.username }
    password { user.password }
    repeatedPassword { password }

    initialize_with { alternative_attributes }
  end
end
