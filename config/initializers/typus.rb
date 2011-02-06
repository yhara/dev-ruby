Typus.setup do |config|

  # Application name.
  config.admin_title = "dev-ruby"
  # config.admin_sub_title = ""

  # When mailer_sender is set, password recover is enabled. This email
  # address will be used in Admin::Mailer.
  # config.mailer_sender = "admin@example.com"

  # Define file attachment settings.
  # config.file_preview = :typus_preview
  # config.file_thumbnail = :typus_thumbnail

  # Authentication: +:none+, +:http_basic+
  # Run `rails g typus:migration` if you need an advanced authentication system.
  config.authentication = :http_basic

  # Define username and password for +:http_basic+ authentication
  config.username = ENV["ADMIN_USER"]
  config.password = ENV["ADMIN_PASS"] or raise "Admin pass not set!"

  # Define available languages on the admin interface.
  # config.available_locales = [:en]

end
