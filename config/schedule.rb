require File.expand_path(File.dirname(__FILE__) + '/environment')

# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development

# cronを実行する環境変数をセット
set :environment, rails_env

set :output, "#{Rails.root}/log/cron.log"

set :job_template, "bash -l -c ':job'"
job_type :rake, "export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

every '00 12 16 * *' do
  rake 'reset_eat_day_month:reset_eat_day'
end