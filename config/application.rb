require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AdminDemo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
 
	 	config.generators.system_tests = nil

	 	# Attach specific database if provided
	 	if ENV['RAILS_DATABASE_ENV'].present?
 		  self.paths["config/database"] = "config/database/#{ENV["RAILS_DATABASE_ENV"]}.yml" 
	 	end

	 	config.time_zone = 'Asia/Manila'
	 	config.action_cable.disable_request_forgery_protection = true

	 	# ENV configurables
	 	config.settings = YAML.load(ERB.new(File.read("#{Rails.root}/config/configurable.yml")).result).deep_symbolize_keys

	 	# ENV Carrierwave
	 	config.carrierwave = YAML.load(ERB.new(File.read("#{Rails.root}/config/carrierwave.yml")).result).deep_symbolize_keys
	 	Rails.autoloaders.main.ignore(Rails.root.join('lib/protocol/encrypted_connection.rb'))



    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
