RSpec.configure do |config|
  config.include Aruba::Api

  config.before(:each, :aruba => true) do
    @aruba_timeout_seconds = 180
    FileUtils.rm_rf(current_dir)
    @__aruba_original_paths = (ENV['PATH'] || '').split(File::PATH_SEPARATOR)
    ENV['PATH'] = ([File.expand_path('bin')] + @__aruba_original_paths).join(File::PATH_SEPARATOR)
  end

  config.after(:each, :aruba => true) do
    ENV['PATH'] = @__aruba_original_paths.join(File::PATH_SEPARATOR)
    restore_env
  end

  # rspec-rails 3 will no longer automatically infer an example group's spec type
  # from the file location. You can explicitly opt-in to the feature using this
  # config option.
  # To explicitly tag specs without using automatic inference, set the `:type`
  # metadata manually:
  #
  #     describe ThingsController, :type => :controller do
  #       # Equivalent to being in spec/controllers
  #     end
  config.infer_spec_type_from_file_location!
end
