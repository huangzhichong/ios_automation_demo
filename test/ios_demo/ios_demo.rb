def ios_demo

  it "FRAME001_demo of ios" do
    Common.logger_info"---->>>> load appium config"
    $appium_device_config ||= YAML.load_file("#{File.dirname(__FILE__)}/appium_custom_config.yml")

    WebDriver.restart_browser

    Common.logger_info"---->>>>click menu on home view"
    HomeView::MenuButton.new.wait_element_present
    HomeView::MenuButton.new.click

    Common.logger_info"---->>>>click login in option in the side menu"
    HomeView::LoginItemInSideMenu.new.wait_element_present
    HomeView::LoginItemInSideMenu.new.click

    Common.logger_info"---->>>>click create account on login view"
    CreateAccountView::CreateAccount.new.wait_element_present
    CreateAccountView::CreateAccount.new.click

    Common.logger_info"---->>>>input email and password"

    CreateAccountView::EmailInput.new.wait_element_present
    CreateAccountView::EmailInput.new.input "smarttest@test.com"
    CreateAccountView::PasswordInput.new.input "Test123!"
    CreateAccountView::PassowrdConfirmInput.new.input "Test123!"
    CreateAccountView::EmailPageNextButton.new.click
    Common.logger_info"---->>>> input first name / middle name/ last name"

    CreateAccountView::FirstNameInput.new.wait_element_present
    CreateAccountView::FirstNameInput.new.input "Smart"
    CreateAccountView::MiddleNameInput.new.input "M"
    CreateAccountView::LastNameInput.new.input "Huang"

    Common.logger_info"---->>>> select gender Male"
    CreateAccountView::MaleOption.new.click

    CreateAccountView::BirthdayInput.new.input "11/11/1980"
    CreateAccountView::PhoneNumberInput.new.input "8008700302"    
    CreateAccountView::UserInfoPageNextButton.new.click

    CreateAccountView::CountrySelectItem.new.wait_element_present
    CreateAccountView::CountrySelectItem.new.click
    GeneralKeyboard::GeneralSelectOption.new.wait_element_present
    GeneralKeyboard::GeneralSelectOption.new.element.send_keys "USA"
    GeneralKeyboard::DoneButton.new.click
    GeneralKeyboard::GeneralSelectOption.new.wait_element_disappear

    CreateAccountView::StateSelectItem.new.click

  end
end
