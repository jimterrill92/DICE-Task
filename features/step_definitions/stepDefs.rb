require 'test/unit/assertions'
require 'miniTest/autorun'
require_relative '../pages/page_objects.rb'
require_relative '../support/actions.rb'
include Test::Unit::Assertions

$eventName
$eventUrl

Given("An existing event promoter is logged into MIO") do
    # Go to event promoter dashboard
    @driver.navigate.to "http://mio-aqa-candidates.dc.dice.fm"

    # Type and submit login credentials
    @actions.typeText(@dice_page.emailField, 'client_admin_auto@dice.fm')
    @actions.typeText(@dice_page.passwordField, 'musicforever')
    @actions.clickElement(@dice_page.signInButton)
end

When('They create an ON SALE event with {int} ticket types') do |int|
    # Create unique event name
    $eventName = 'Test Event ' + Time.now.to_s
    
    # Enter event details  
    @actions.clickElement(@dice_page.createEventButton)
    @actions.typeText(@dice_page.eventNameField, $eventName)
    @actions.typeText(@dice_page.genreField, 'Rock')
    @actions.typeEnter(@dice_page.genreField)
    @actions.typeText(@dice_page.venueField, 'London') 
    @actions.typeEnter(@dice_page.venueField)

    # Select event dates
    @actions.clickElement(@dice_page.timelineButton)
    @actions.clickElement(@dice_page.announceDateField)
    @actions.clickElement(@dice_page.todayButton)
    @actions.clickElement(@dice_page.eventOnSaleField)
    @actions.clickElement(@dice_page.todayButton)
    @actions.clickElement(@dice_page.eventOffSaleField)
    @actions.clickElement(@dice_page.nextDayOption)
    @actions.clickElement(@dice_page.timePicker[20])
    @actions.clickElement(@dice_page.eventStartField)
    @actions.clickElement(@dice_page.nextDayOption)
    @actions.clickElement(@dice_page.timePicker[40])
    @actions.clickElement(@dice_page.eventEndField)
    @actions.clickElement(@dice_page.nextDayOption)
    @actions.clickElement(@dice_page.timePicker[60])
    @actions.clickElement(@dice_page.informationButton)

    # Upload image and type description
    @actions.typeText(@dice_page.imageUploader, File.expand_path('DICE.jpeg'))
    @actions.typeText(@dice_page.descriptionField, 'Test event 1234!$:')

    # Add ticket types
    @actions.clickElement(@dice_page.ticketsButton)
    @actions.clickElement(@dice_page.addTicketButton)
    @actions.typeText(@dice_page.ticketPriceField, '1000')
    @actions.clickElement(@dice_page.saveButton)
    @actions.validateElementText(@dice_page.firstTicketType, 'General Admission')

    # Add second ticket type if parameter = 2
    if int == 2
        @actions.clickElement(@dice_page.addATicketTypeButton)
        @actions.clickElement(@dice_page.vipButton)
        @actions.typeText(@dice_page.ticketPriceField, '2000')
        @actions.clickElement(@dice_page.saveButton)
        @actions.validateElementText(@dice_page.secondTicketType, 'VIP')
    end

    # Create event
    @actions.clickElement(@dice_page.saveAndContinueButton)
    @actions.clickElement(@dice_page.submitEventButton)
end

Then("The event is successfully created") do   
    # Validate that success message exists
    assert_equal(1, @dice_page.successMessage.length)
end

Given("A new fan is on the created event page") do
    # Navigate to fan site
    @driver.navigate.to('http://aqa-candidates.dc.dice.fm')

    # Accept all cookies to remove banner
    sleep 2
    @actions.clickElement(@dice_page.allowAllCookiesButton)
    @actions.clickElement(@dice_page.searchIcon)

    # Search for created event
    @actions.typeText(@dice_page.searchField, $eventName)

    # Retry search for event until its visible (as it seems to take around 20 seconds for the event to be searchable) 
    # TODO: Make this retry tidier, perhaps poll an API until there's no longer get a 404 for the event, or make environment more performant to mitigate the need for this wait
    count = 0
    while @driver.find_elements(:xpath, "//strong[contains(text(), '" + $eventName + "')]").empty? && count < 5
        sleep 10
        # Sometimes the search bar is closing during the retry, if this happens reopen the search bar
        if (@driver.find_elements(:xpath, "//input[@placeholder='Find an event']").empty?) 
            @actions.clickElement(@dice_page.searchIcon)
        end

        # Clear search bar and re-enter event name
        @dice_page.searchField.clear
        @actions.typeText(@dice_page.searchField, $eventName)
        count += 1
    end

    @actions.clickElement(@dice_page.searchResult)
    
    # Just need a slight pause here otherwise the browser gets the URL too quickly and ends up assigning 'http://aqa-candidates.dc.dice.fm' to eventUrl variable
    sleep 2
    $eventUrl = @driver.current_url
end

When("They purchase the second ticket type via the registration flow") do
    # Select ticket option
    @actions.clickElement(@dice_page.buyNowButton)
    @actions.clickElement(@dice_page.vipTicketOption)
    @actions.clickElement(@dice_page.checkoutButton)
    @actions.typeText(@dice_page.mobileNumberField, @actions.generateRandomMobileNumber)
    @actions.clickElement(@dice_page.continueButton)
    @actions.typeText(@dice_page.securityCodeField, '0000')

    # Register a new user
    @actions.typeText(@dice_page.firstNameField, 'Test')
    @actions.typeText(@dice_page.lastNameField, 'User')
    @actions.typeText(@dice_page.emailField, 'terrilltest+' + @actions.generateRandomMobileNumber.to_s + '@gmail.com')
    @actions.typeText(@dice_page.dobField, '19031992')
    @actions.clickElement(@dice_page.continueButton)

    # Enter and submit payment details
    @actions.clickElement(@dice_page.payWithCardButton)
    @driver.switch_to.frame @dice_page.paymentIframe
    @actions.typeText(@dice_page.cardNumberField, '4111111111111111')
    @actions.typeText(@dice_page.expiryDateField, '02' + (Time.now.year + 1).to_s[2..4])
    @actions.typeText(@dice_page.cvcField, '222')
    @driver.switch_to.default_content
    @actions.typeText(@dice_page.postcodeField, 'AA11AA')
    @actions.clickElement(@dice_page.purchaseTicketsButton)
    sleep 5
    # There seems to be an issue here, no payment confirmation screen is displaying.
end

Then("The ticket is successfully purchased") do
    # Validating ticket is purchased an alternative way, but ideally I was expecting to validate some sort of order confirmation page.
    @driver.navigate.to($eventUrl)

    # There seems to be a slight delay in the tickets being reflected, refresh page until tickets are visible
    count = 0
    while @driver.find_elements(:xpath, "//span[contains(text(), 'got tickets')]").empty? && count < 5
        sleep 3
        @driver.navigate.refresh
        count += 1
    end

    @actions.validateElementText(@dice_page.purchasedTicketText, '1 x VIP')
    @actions.clickElement(@dice_page.youveGotTicketsMessage)
    @dice_page.getTheAppMessage
end