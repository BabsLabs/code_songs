desc "This task is called by the Heroku scheduler add-on"
task :update_micro_database => :environment do
  puts "Updating microservice database..."
  Faraday.post(ENV['MICRO_SERVICE_UPDATE_ENDPOINT'])
  puts "done."
end

task :seed_micro_database => :environment do
  puts "Updating microservice database..."
  Faraday.post(ENV['MICRO_SERVICE_SEED_ENDPOINT'])
  puts "done."
end