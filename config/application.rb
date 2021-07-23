require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module StopSweets
  class Application < Rails::Application
    config.load_defaults 6.1
    # lib/autoloads ディレクトリ配下のファイルを読み込む
    config.autoload_paths << Rails.root.join('lib/autoloads')

    config.i18n.default_locale = :ja
    config.time_zone = 'Asia/Tokyo'

    config.generators.system_tests = nil
  end
end
