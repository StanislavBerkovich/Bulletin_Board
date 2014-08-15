namespace :auto_actions do
  task :start => :environment do
    system( 'whenever --update-crontab board' )
  end
end
