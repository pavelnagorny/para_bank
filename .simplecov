# frozen_string_literal: true

SimpleCov.start do
  add_filter 'reports/'
  add_filter 'drivers/'
  coverage_dir 'reports/coverage'
end
