# frozen_string_literal: true

desc 'This task triggers execution of all tests'
task :all_tests_execution do
  %w[create_report_folder run_web_tests run_rspec_tests run_allure_report].each do |task_name|
    sh "rake #{task_name}"
  end
end

desc 'This task will create report folder'
task :create_report_folder do
  FileUtils.mkdir_p 'reports'
  FileUtils.mkdir_p 'reports/allure-results'
end

desc 'This task triggers execution of cucumber tests'
task :web_tests_execution do
  %w[create_report_folder run_web_tests run_allure_report].each do |task_name|
    sh "rake #{task_name}"
  end
end

desc 'Rake task for running cucumber web tests'
task :run_web_tests do
  sh 'bundle exec cucumber features/tests/web'
end

desc 'Rake task for running cucumber web tests in parallel'
task :run_web_tests_parallel do
  sh 'bundle exec parallel_cucumber -o features/test/web/ -o "-r features --format AllureCucumber::Formatter --out reports/allure-results"'
end

desc 'Rake task for running RSpec '
task :run_rspec_tests do
  sh 'bundle exec cucumber features/tests/android/'
end

desc 'Open allure report '
task :run_allure_report do
  sh 'allure serve reports/allure-results -h localhost'
end
