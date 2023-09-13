class DicePage
    include PageObject

# TODO: Ideally this page would be split into multiple smaller page files for better readability

# Login Locators
def emailField = @browser.find_element(:name, 'email')
def passwordField = @browser.find_element( :name, 'password')
def signInButton = @browser.find_element(:xpath, "//span[contains(text(),'Sign in')]")

#  Create event locators
def createEventButton = @browser.find_element(:xpath, "//a[@href='/events/new']")
def eventNameField = @browser.find_element(:xpath, "//input[@placeholder='Name of the event or headline artist']")
def genreField = @browser.find_element(:id, "genres")
def venueField = @browser.find_element(:id,"primaryVenue")
    
# Event Date Locators
def timelineButton = @browser.find_element(:xpath,"//li[@data-id='stepIndicator[timeline]']")
def announceDateField = @browser.find_element(:name, "announceDate")
def eventOnSaleField = @browser.find_element(:name,"onSaleDate")
def eventOffSaleField = @browser.find_element(:name, "offSaleDate")
def eventStartField = @browser.find_element(:name, "date")
def eventEndField = @browser.find_element(:name, "endDate")
def todayButton = @browser.find_element(:xpath, "//*[contains(text(), 'Today')]")
def nextDayOption = @browser.find_elements(:xpath, "//*[@aria-current='date']/following::div")[0]
def timePicker = @browser.find_elements(:class, "react-datepicker__time-list-item ")
    
def imageUploader = @browser.find_element(:xpath, "//*[@accept='image/jpeg']")
def boldIcon = @browser.find_element(:xpath, "//*[@title='Bold']")
def informationButton = @browser.find_element(:xpath, "//li[@data-id='stepIndicator[information]']")
def descriptionField = @browser.find_element(:xpath, "//*[@data-block='true']")
    
# Add ticket Locators
def ticketsButton = @browser.find_element(:xpath, "//li[@data-id='stepIndicator[tickets]']")
def addTicketButton = @browser.find_element(:xpath, "//span[contains(text(),'Add a ticket')]")
def addATicketTypeButton = @browser.find_element(:xpath, "//*[contains(text(),'Add a ticket type')]")
def ticketPriceField = @browser.find_element(:xpath, "//input[@placeholder='0.00']")
def saveButton =  @browser.find_element(:xpath, "//*[text() = 'Save']")
def firstTicketType = @browser.find_element(:xpath, "//*[@data-id='ticketType[0].name']")
def secondTicketType = @browser.find_element(:xpath, "//*[@data-id='ticketType[1].name']")   
def vipButton = @browser.find_element(:xpath, "//*[@data-id='iconButton[vip]']")
    
# Submit event locators
def saveAndContinueButton = @browser.find_element(:xpath, "//span[contains(text(), 'Save and continue')]")
def submitEventButton = @browser.find_element(:xpath, "//*[contains(text(), 'Submit')]")
def successMessage = @browser.find_elements(:xpath, "//*[contains(text(), 'your event’s been published.')]")
    
# Search for event locators
def acceptCookiesBanner = @browser.find_element(:xpath, "//*[@aria-describedby='ch2-dialog-description']")
def allowAllCookiesButton = acceptCookiesBanner.find_elements(:xpath, "//button[contains(text(), 'Allow all cookies')]")[0]
def searchIcon = @browser.find_elements(:xpath, "//button[@aria-label='Search']")[1]
def searchField = @browser.find_element(:xpath, "//input[@placeholder='Find an event']")
def searchResult = @browser.find_element(:xpath, "//strong[contains(text(), '" + $eventName + "')]")
    
# Purchase ticket locators
def buyNowButton = @browser.find_element(:xpath, "//span[contains(text(), 'Buy now')]")
def vipTicketOption = @browser.find_element(:xpath, "//span[contains(text(), 'VIP')]")
def checkoutButton = @browser.find_element(:xpath, "//span[contains(text(), 'Checkout')]")
def mobileNumberField = @browser.find_element(:xpath, "//*[@type='tel']") 
def continueButton = @browser.find_element(:xpath, "//span[contains(text(), 'Continue')]")
def securityCodeField = @browser.find_element(:xpath, "//*[@inputmode='numeric']") 
    
# Registration locators
def firstNameField = @browser.find_element(:xpath, "//*[@name='first_name']")
def lastNameField = @browser.find_element(:xpath, "//*[@name='last_name']")
def emailField = @browser.find_element(:xpath, "//*[@name='email']")
def dobField = @browser.find_element(:xpath, "//*[@name='dob']")
    
# Payment locators
def payWithCardButton = @browser.find_element(:xpath, "//h3[contains(text(), 'Pay with card')]")
def paymentIframe = @browser.find_element(:xpath, "//iframe[@title='Secure card payment input frame']")
def cardNumberField = @browser.find_element(:xpath, "//*[@autocomplete='cc-number']")
def expiryDateField = @browser.find_element(:xpath, "//*[@autocomplete='cc-exp']")
def cvcField = @browser.find_element(:xpath, "//*[@autocomplete='cc-csc']")
def postcodeField = @browser.find_element(:xpath, "//*[@placeholder='Postcode / Zipcode']")
def purchaseTicketsButton = @browser.find_element(:xpath, "//span[contains(text(), 'Purchase Tickets')]")
    
# Post order locators
def purchasedTicketText = @browser.find_element(:xpath, "//span[contains(text(), 'got tickets')]/following-sibling::*")
def youveGotTicketsMessage = @browser.find_element(:xpath, "//*[contains(text(), 'got tickets')]")
def getTheAppMessage = @browser.find_elements(:xpath, "//div[contains(text(), 'Get the app to use your ticket')]")

end