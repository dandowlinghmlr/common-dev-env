require_relative 'utilities'
require_relative 'commodities'
require 'yaml'

def provision_elasticsearch7(root_loc)
  # Load configuration.yml into a Hash
  config = YAML.load_file("#{root_loc}/dev-env-config/configuration.yml")
  started = false
  return unless config['applications']

  config['applications'].each_key do |appname|
    # To help enforce the accuracy of the app's dependency file, only search for init scripts
    # if the app specifically specifies elasticsearch in it's commodity list
    next unless File.exist?("#{root_loc}/apps/#{appname}/configuration.yml")
    next unless commodity_required?(root_loc, appname, 'elasticsearch7')

    # Run any script contained in the app
    if File.exist?("#{root_loc}/apps/#{appname}/fragments/elasticsearch7-fragment.sh")
      started = start_elasticsearch7(root_loc, appname, started)
    end
  end
end

def start_elasticsearch7(root_loc, appname, started)
  puts colorize_pink("Found an Elasticsearch7 fragment in #{appname}")
  if commodity_provisioned?(root_loc, appname, 'elasticsearch7')
    puts colorize_yellow("Elasticsearch7 has previously been provisioned for #{appname}, skipping")
  else
    unless started
      run_command("#{ENV['DC_CMD']} up -d elasticsearch7")
      # Better not run anything until elasticsearch is ready to accept connections...
      puts colorize_lightblue('Waiting for Elasticsearch 7 to finish initialising')

      loop do
        cmd_output = []
        run_command('curl --write-out "%{http_code}" --silent --output /dev/null http://localhost:9202', cmd_output)
        break if cmd_output.include? '200'

        puts colorize_yellow('Elasticsearch 7 is unavailable - sleeping')
        sleep(3)
      end

      puts colorize_green('Elasticsearch 7 is ready')
      started = true
    end
    run_command("sh #{root_loc}/apps/#{appname}/fragments/elasticsearch7-fragment.sh http://localhost:9202")
    # Update the .commodities.yml to indicate that elasticsearch7 has now been provisioned
    set_commodity_provision_status(root_loc, appname, 'elasticsearch7', true)
  end
  started
end
