module  WebDriver
  class << self

    $DOWNLOAD_PATH =File.absolute_path("#{File.dirname(__FILE__)}/../../output/downloads").gsub(File::SEPARATOR, File::ALT_SEPARATOR || File::SEPARATOR)

    def start_browser
      case $browser
      when "firefox"
        start_firefox
      when "chrome"
        start_chrome
      when "safari"
        send "start_safari_#{$OS.to_s}"
      when "ie", "ie_11","ie_10","ie_9","ie_8"
        start_ie
      when "iphone","iphone_plus","ipad","android"
        send "start_mobile_#{$OS.to_s}", *[$browser]
      end
    end

    def restart_browser
      $driver.quit unless $driver.nil?
      start_browser
    end

    :private
    def maxmize_window
      $driver.get "about:blank"
      begin
        max_width, max_height = $driver.execute_script("return [window.screen.availWidth, window.screen.availHeight];")
      rescue Exception => e
        Common.logger_info "WARNNING - fail to get screen width and height by JavaScript, set to 1440 * 900"
        max_width = "1440"
        max_height = "900"
      end
      $driver.manage.window.resize_to(max_width, max_height)
      $wait = Selenium::WebDriver::Wait.new(:timeout=>30)
    end

    def start_chrome
      Common.logger_info "Execute - Start Google Chrome"
      Dir.mkdir $DOWNLOAD_PATH unless Dir.exist?($DOWNLOAD_PATH)
      prefs = {
        :download => {
          :prompt_for_download => false,
          :default_directory => $DOWNLOAD_PATH
        },
      }
      prefs['profile.default_content_settings.multiple-automatic-downloads'] = 1
      switches = %w[--test-type --ignore-certificate-errors --disable-popup-blocking --disable-translate]
      $driver = Selenium::WebDriver.for :chrome, :prefs => prefs, :switches => switches
      maxmize_window
    end

    def start_firefox
      Common.logger_info "Execute - Start Firefox"
      profile = Selenium::WebDriver::Firefox::Profile.new
      Dir.mkdir $DOWNLOAD_PATH unless Dir.exist?($DOWNLOAD_PATH)
      profile['browser.download.dir'] = $DOWNLOAD_PATH
      profile['browser.download.folderList'] = 2
      profile['browser.helperApps.neverAsk.saveToDisk'] = "application/pdf,text/csv,application/zip"
      $driver = Selenium::WebDriver.for :firefox, :profile=>profile
      maxmize_window
    end

    def start_ie
      Common.logger_info "Execute - Start Internet Explorer"
      $driver = Selenium::WebDriver.for :ie
      maxmize_window
    end

    def start_safari_macosx
      Common.logger_info "Execute - Start Safari on Mac OSX"
      user_agent_string = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/600.6.3 (KHTML, like Gecko) Version/8.0.6 Safari/600.6.3"
      current_user_agent = `defaults read com.apple.Safari CustomUserAgent`
      unless current_user_agent.include? user_agent_string
        system %Q(defaults write com.apple.Safari CustomUserAgent '"#{user_agent_string}"')
      end
      $driver = Selenium::WebDriver.for :safari
      maxmize_window
    end

    def start_mobile_windows(device_type)
      Common.logger_info "Execute - Start Chrome to simulate mobile browser of #{device_type} on Windwos"
      devices_config = YAML.load_file("#{File.dirname(__FILE__)}/data/user_agent_devices.yml")
      width = devices_config[device][layout][:width]
      height = devices_config[device][layout][:height]
      user_agent_string = devices_config[device][:user_agent]
      # #simulate chrome
      Dir.mkdir $DOWNLOAD_PATH unless Dir.exist?($DOWNLOAD_PATH)
      prefs = {
        :download => {
          :prompt_for_download => false,
          :default_directory => $DOWNLOAD_PATH,
          :timeout => 60
        },
      }
      switches = %w[--test-type --ignore-certificate-errors --disable-popup-blocking --disable-translate]
      switches << "--user-agent=#{user_agent_string}"
      $driver = Selenium::WebDriver.for :chrome, :prefs => prefs,:switches => switches
      $driver.execute_script("window.open(#{$driver.current_url.to_json},'_blank','innerHeight=#{height},innerWidth=#{width}');")
      $driver.close
      $driver.switch_to.window $driver.window_handles.first
      $driver.manage.window.resize_to(width, height)
    end

    def start_mobile_macosx(device_type)
      Common.logger_info "Execute - Start Appium to test browser on mobile devices"
      $appium_device_config ||= YAML.load_file("#{File.dirname(__FILE__)}/data/appium_device_config.yml")
      if $appium_device_config.has_key? device_type
        capabilities = $appium_device_config[device_type]
        $driver = Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities, :url => "http://127.0.0.1:4723/wd/hub")
      else
        Common.logger_error "APPIUM CONFIG ERROR -- can't find #{device_type} in appium config file"
      end
    end

  end
end
