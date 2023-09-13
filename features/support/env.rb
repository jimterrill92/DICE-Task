require 'selenium/webdriver'
require 'page-object'

driver = Selenium::WebDriver.for :chrome

Before do
	@driver = driver
    @driver.manage.timeouts.implicit_wait = 10
    @driver.manage.window.maximize
    @driver.manage.delete_all_cookies
    
    @dice_page = DicePage.new(@driver)
    @actions = Actions.new(@driver)
end