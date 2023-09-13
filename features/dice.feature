@P1
Feature: Dice interview task
    Scenario: Create an event in promoter panel - MIO
        Given An existing event promoter is logged into MIO
        When They create an ON SALE event with 2 ticket types
        Then The event is successfully created

    Scenario: Purchase second ticket type as new fan user in Fan Web app
        Given A new fan is on the created event page
        When They purchase the second ticket type via the registration flow
        Then The ticket is successfully purchased