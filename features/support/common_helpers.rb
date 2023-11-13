# frozen_string_literal: true

module CommonHelpers
  def to_hash
    instance_variables.each_with_object({}) do |var, hash|
      key = var.to_s.delete('@').to_sym
      value = instance_variable_get(var).to_s
      hash[key] = value
    end
  end

  def save_to_file(user)
    FileUtils.mkdir_p('./reports/temp') unless File.exist?('./temp')
    File.open('./reports/temp/registered_user.yml', 'a') do |file|
      YAML.dump(user, file)
    end
    LOGGER.info "User was saved to /reports/temp"
  end

  def read_from_file(filename: './reports/temp/registered_user.yml')
    YAML.load_file(filename)
  end

  def clean_up_data(path_to_folder, file_types)
    file_types.each do |file_type|
      Dir.glob(File.join(path_to_folder, '**', "*.{#{file_type}}")).each do |file|
        File.delete(file) if File.file?(file)
      end
    end
    LOGGER.info "Cleaning up test data from previous run"
  end

  def generate_user_data
    user = Models::User.new
    save_to_file(user.to_hash)
    LOGGER.info "Generate user data: #{user}"
    user
  end
end
