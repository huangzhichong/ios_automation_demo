module ActivationPortalMedia
  class ElementActivationMediaContent < WebElement
    def initialize
      WebElement.new("xpath","//form[contains(@action, 'MediaPortal.aspx')]","ElementActivationMediaContent")
    end
  end
  
  class ButtonLookUp < Button
    def initialize
      Button.new("xpath","//input[contains(@name,'cmdLookup')]","ButtonLookUp")
    end
  end  
  
end