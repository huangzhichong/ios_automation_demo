def ios_demo
  it "demo of rtp live pass" do
    Common.logger_info"---->>>> load appium config"
    $appium_device_config ||= YAML.load_file("#{File.dirname(__FILE__)}/appium_custom_config.yml")

    WebDriver.start_browser
    sleep 10
    Common.logger_info"---->>>>click menu on home view"
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIANavigationBar[1]/UIAButton[1]").click
    sleep 5

    Common.logger_info"---->>>>click login in option in the side menu"
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIATableView[1]/UIATableCell[2]/UIAStaticText[1]").click
    sleep 5

    Common.logger_info"---->>>>click create account on login view"
    $driver.find_element(:name, "Create Account").click
    sleep 30

    Common.logger_info"---->>>>input email and password"
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[1]").click
    sleep 3
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[1]").send_keys "smarttest@test.com"

    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIASecureTextField[1]").click
    sleep 5
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIASecureTextField[1]").send_keys "Test123!"
    sleep 5
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIASecureTextField[2]").click "smarttest@test.com"
    sleep 5
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIASecureTextField[2]").send_keys "Test123!"
  end
end
