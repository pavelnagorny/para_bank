# frozen_string_literal: true

module Pages
  class AccountsOverviewPage < SitePrism::Page
    elements :account_ids, :xpath, "//a[@class='ng-binding']"

    def return_all_accounts
      account_ids.map(&:text)
    end
  end
end
