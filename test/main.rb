require 'yaml'
require 'rspec'
require 'rspec/expectations'
require 'selenium-webdriver'
require 'rspec/autorun'
require 'optparse'
require 'json'
require 'gmail'

#set up the environment for automation tasks
#hash to hold all options
options = Hash.new
#handle options and arguments
optparse = OptionParser.new do|opts|
#set the banner
  opts.banner = "Usage: ruby main.rb -s <script_path> [options]"
  #define script path option
  options[:script_path] = nil
  opts.on('-s', '--script_path <string>',
  'Name of the market to target (required)', 'ex - "camps/bvt/workflow-1", "endurance/regression/workflow-1"') do|script_path|
    options[:script_path] = script_path
  end

  #define round option
  options[:round] = '1234'
  opts.on('-r', '--round <string>',
  'ID of the test round (optinal)', 'ex - "9999", "8888", "7777"',"Used by Marquee client only, set to 1234 by default ") do|round|
    options[:round] = round
  end
  #define browser option
  options[:browser] = 'firefox'
  opts.on('-b', '--browser <string>', ["ie", "firefox", "chrome","safari","ie_8","ie_9","ie_10","iphone","iphone_plus","ipad","android"],
  'Name of the test browser (optinal)', 'ex - "ie", "firefox", "chrome","iphone","iphone_plus","ipad","android"','set to firefox by default') do|browser|
    options[:browser] = browser
  end
  #define environment option
  options[:environment] = 'INT'
  opts.on('-e', '--environment <string>', ["PINT","INT","NEW","QA","REG", "STG", "PERF", "PROD"]
  
  'Name of the test environment (optinal)','ex -"INT", "STG", "NEW-INT", "NEW-QA", "NEW-STG"','set to INT by default') do|environment|
    options[:environment] = environment
  end
  
  opts.on('-p', '--param <string>','Parameter passed to the test') do|param|
    options[:param] = param
  end

  options[:debug] = false
  opts.on('-d','--debug','show the script result to console') do
    options[:debug] = true
  end

  #define help option
  opts.on_tail("-h", "--help", "Show options help") do
    puts opts
    exit
  end
end

begin
#parse the command line
  optparse.parse!
  #provide friendy output on missing switches
  mandatory = [:script_path]
  missing = mandatory.select{ |param| options[param].nil? }
  if not missing.empty?
    puts("MISSING OPTIONS: #{missing.join(', ')}")
    puts(optparse)
    exit(1)
  end
rescue OptionParser::InvalidOption, OptionParser::MissingArgument, OptionParser::InvalidArgument
  puts($!.to_s)
  puts(optparse)
  exit(1)
end

script_path = options[:script_path].gsub('\\\\','/').gsub('\\','/')
$plan_name=script_path.split('/').last
$round_id= options[:round]
$browser=options[:browser]
$env=options[:environment]

if options[:debug]
  ARGV.push '-fd'
  require 'pry'
  require 'pry-debugger'
else
  result_path = "#{$plan_name}_#{Time.now.strftime("%Y%m%d_%H%M%S")}"
  ARGV.push '-fh'
  ARGV.push '-o'
  ARGV.push "../output/test_results/#{result_path}.htm"
  puts "You can find test result in: ../output/test_results/#{result_path}.htm"
end

#init output folders
Dir.mkdir "#{File.dirname(__FILE__)}/../output" if not File.exist? "#{File.dirname(__FILE__)}/../output"
path = File.join(File.dirname(__FILE__),"..","output","screenshots")
Dir.mkdir path if not File.exist? path
path = File.join(File.dirname(__FILE__),"..","output","test_results")
Dir.mkdir path if not File.exist? path

#get the paramaters from config.yml for each test plan into $parameters
$parameters=YAML.load(File.open("#{File.dirname(__FILE__)}/#{script_path}/config.yml"))

#init the parameters used for marquee
$errormessage=""
$result="Passed"
$errormessage=""
$screenshot=""
$error_log=""
$script_comments=""
#load all the common functions
Dir[File.dirname(__FILE__) + '/../core_framework/*/*.rb'].each {|f| require f}

#load all the libraries under ../library
Dir.glob("#{File.dirname(__FILE__)}/../library/*/**/*.rb").each{|f| require f}

#initialize DB connection if database.yml exist in the data folder
$sqlserver_env_util = Utilities::DatabaseUtil.new $env if File.exist? "#{File.dirname(__FILE__)}/../data/database.yml"

#load all the libraries under ../workflow
Dir.glob("#{File.dirname(__FILE__)}/../workflow/*/**/*.rb").each{|f| require f}

if $browser.nil? || $env.nil?
  puts "ERROR------------- browser or env should not be nil."
  puts "browser: #{$browser}"
  puts "environment: #{$env}"
  exit 1
else
  puts "begin running with the configuration..."
  puts "browser: #{$browser}"
  puts "environment: #{$env}"
  puts "marquee round_id: #{$round_id}"
  puts "plan name: #{$plan_name}"
end


describe $plan_name  do
  before(:all){
    RSpec.configure {|c| c.fail_fast = true} if options[:debug]
    # Common.update_hosts_file
  }
  after(:all){
    $service = "#{$service}|#{$script_comments}" unless $script_comments.empty?
    MARQUEE::update_script_state $round_id,$plan_name,"End",$service    
    $driver.quit unless $driver.nil?
    # Common.restore_hosts_file
  }
  before(:each){$errormessage= ""}
  after(:each){
    example.result!
  }
  Dir[File.dirname(__FILE__) + "/#{script_path}/*.rb"].each {|file| require file}
  $parameters['actions'].split(',').each {|m| send m.strip.to_sym}
end
