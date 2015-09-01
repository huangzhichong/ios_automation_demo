def ios_demo_original
xit "demo of rtp live pass" do
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
    sleep 15

    Common.logger_info"---->>>>input email and password"

    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[1]").click
    sleep 5
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[1]").send_keys "smarttest@test.com"
    sleep 5

    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIASecureTextField[1]").click
    sleep 5
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIASecureTextField[1]").send_keys "Test123!"
    sleep 5


    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIASecureTextField[2]").click
    sleep 5
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIASecureTextField[2]").send_keys "Test123!"
    sleep 5

    Common.logger_info"---->>>>click create account button"
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIAButton[1]").click
    sleep 5

    Common.logger_info"---->>>> input first name / middle name/ last name"
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[1]").click
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[1]").send_keys "Smart"

    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[2]").click
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[2]").send_keys "M"

    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[3]").click
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[3]").send_keys "Huang"

    Common.logger_info"---->>>> select gender"
    # Male
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIAStaticText[10]").click
    # Female
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIAStaticText[10]").click

    Common.logger_info"---->>>> input Birthday"
    #Birthday
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[4]").click
    sleep 5
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[4]").send_keys "11/11/1985"

    Common.logger_info"---->>>> input phone number"
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[5]").click
    sleep 5
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[5]").send_keys "8008700380"
    sleep 5

    Common.logger_info"---->>>> click next"
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIAButton[2]").click

    sleep 10
    Common.logger_info"---->>>> select country"
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIAElement[1]").click
    sleep 5
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[3]/UIAPicker[1]/UIAPickerWheel[1]").send_keys "USA"
    $driver.find_element(:name, "Done").click
    sleep 5
    Common.logger_info"---->>>> select state"
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIAElement[2]").click
    sleep 5
    $driver.find_element(:xpath, "//UIAApplication[1]/UIAWindow[3]/UIAPicker[1]/UIAPickerWheel[1]").send_keys "CA"
    $driver.find_element(:name, "Done").click

end
  end