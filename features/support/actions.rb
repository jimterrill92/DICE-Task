class Actions
    include PageObject

def clickElement (locator)
    scroll_to_element(locator)
    locator.click()
end

def typeText (locator, text)
    scroll_to_element(locator)
    locator.send_keys(text)
end

def typeEnter (locator)
    scroll_to_element(locator)
    sleep 1
    locator.send_keys(:enter)
end

def scroll_to_element(element, locator=nil)
    script_string = "var viewPortHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0);" +
        "var elementTop = arguments[0].getBoundingClientRect().top;" +
        "window.scrollBy(0, elementTop-(viewPortHeight/2));"
    element = element.nil? ? find(locator) : element
    @browser.execute_script(script_string, element)
  end

def validateElementText(locator, expectedText)
    scroll_to_element(locator)
    assert_equal(expectedText, locator.text(), 'Expected element text to be: ' + expectedText + ', actual text was: ' + locator.text())
end

def generateRandomMobileNumber = rand 999999999

end