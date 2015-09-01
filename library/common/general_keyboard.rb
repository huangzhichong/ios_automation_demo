module GeneralKeyboard
  class GeneralSelectOption < WebElement
    def initialize
      WebElement.new(:xpath, "//UIAApplication[1]/UIAWindow[3]/UIAPicker[1]/UIAPickerWheel[1]")
    end
  end

  class DoneButton < Button
    def initialize
      Button.new(:name, "Done")
    end
  end
end
