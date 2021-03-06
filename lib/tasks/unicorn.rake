namespace :uc do

  def unicorn_config_path
    File.expand_path('../../../config/unicorn.rb', __FILE__)
  end

  def unicorn_pid
    File.read(File.expand_path("../../../tmp/pids/unicorn.pid", __FILE__)).chomp.to_i
  end

  desc 'Start unicorn master & workers'
  task :start do
    exec("bundle exec unicorn_rails -E #{ENV['RAILS_ENV'] || 'development'} -c #{unicorn_config_path} -D")
  end

  desc 'Stop unicorn master & workers'
  task :stop do
    exec("kill #{unicorn_pid}")
  end

  desc 'Restart unicorn workers'
  task :restart do
    exec("kill -USR2 #{unicorn_pid}")
  end

  desc 'Return the PID for the current unicorn master'
  task :pid do
    puts unicorn_pid
  end
end
