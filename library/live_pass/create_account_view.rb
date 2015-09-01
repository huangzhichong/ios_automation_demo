module CreateAccountView
  class CreateAccount < Button
    def initialize
      Button.new(:name, "Create Account")
    end
  end

  class EmailInput < TextInput
    def initialize
      TextInput.new(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[1]")
    end
  end

  class PasswordInput < TextInput
    def initialize
      TextInput.new(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIASecureTextField[1]")
    end
  end
  class PassowrdConfirmInput < TextInput
    def initialize
      TextInput.new(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIASecureTextField[2]")
    end
  end

  class EmailPageNextButton < Button
    def initialize
      Button.new(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIAButton[1]")
    end
  end

  class UserInfoPageNextButton < Button
    def initialize
      Button.new(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIAButton[2]")
    end
  end

  class FirstNameInput < TextInput
    def initialize
      TextInput.new(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[1]")
    end
  end
  class MiddleNameInput < TextInput
    def initialize
      TextInput.new(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[2]")
    end
  end
  class LastNameInput < TextInput
    def initialize
      TextInput.new(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[3]")
    end
  end

  class MaleOption < WebElement
    def initialize
      WebElement.new(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIAStaticText[10]")
    end
  end
  class FemaleOption < WebElement
    def initialize
      WebElement.new(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIAStaticText[9]")
    end
  end

  class BirthdayInput < TextInput
    def initialize
      TextInput.new(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[4]")
    end
  end

  class PhoneNumberInput < TextInput
    def initialize
      TextInput.new(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[5]")
    end
  end

  class CountrySelectItem < WebElement
    def initialize
      WebElement.new(:xpath,"//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIAElement[1]")
    end
  end

  class StateSelectItem < WebElement
    def initialize
      WebElement.new(:xpath,"//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIAElement[2]")
    end
  end
end
