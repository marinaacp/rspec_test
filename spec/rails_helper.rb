# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# require 'capybara/rspec' # For capybara to use JS
# require 'selenium-webdriver'  # For capybara to use JS

# Add additional requires below this line. Rails is not loaded until this point!



# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#


# # For capybara to use JS
# Capybara.server = :puma, { Silent: true }
# Capybara.javascript_driver = :selenium_chrome # You can also use :selenium_firefox, :selenium_edge, etc.



Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }
# ------------ I HAD TO REMOVE THE COMMENT FROM THE LINE ABOVE TO BE ABLE TO MAKE THE REQUIRE REST-CLIENT BO MAKE IT WORK -------------






# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|

  # Setup for capybara test with devise
  # config.include Devise::Test::ControllersHelpers, :type => :controller
  config.include Warden::Test::Helpers

  # Time helper - native from rails to make the test travel in time back on forth on time passed simulation
  config.include ActiveSupport::Testing::TimeHelpers
  # Faker
  config.include FactoryBot::Syntax::Methods
  # FactoryBot --- Similar to fixtures
  config.include FactoryBot::Syntax::Methods
  # FactoryBot lint
  config.before(:suite) do #It will let you know if anything is missing before runing the tests
    # Ex: you create a mandatory fiels on the db and all the previous test break
    # Can affect perfore because runs before all suites. Is teste your factories
    FactoryBot.lint
  end
  # shoulda matchers
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
  # Devise
  config.include Devise::Test::ControllerHelpers, type: :controller
  # # Capybara with JS
  # config.before(:each, type: :system) do
  #   driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  # end


  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"
  # ---------- aqui em cima que está definido aonde ficam as fixtures ----------







  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/6-0/rspec-rails
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
