module HomeView
  class MenuButton < Button
    def initialize
      Button.new(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIANavigationBar[1]/UIAButton[1]")
    end
  end
  
  class LoginItemInSideMenu < WebElement
    def initialize
      WebElement.new(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIATableView[1]/UIATableCell[2]/UIAStaticText[1]")
    end
  end  
  
end