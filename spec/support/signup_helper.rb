include ApplicationHelper

module SignupHelper

    VALID_NAME = "Example User"
    VALID_EMAIL = "user@example.com"
    VALID_PASSWORD = "foobar"

    @submit = "Create my Account"

    def valid_signup
        fill_in "Name",     with: VALID_NAME
        fill_in "Email",    with: VALID_EMAIL
        fill_in "Password", with: VALID_PASSWORD
        fill_in "Password confirmation", with: VALID_PASSWORD
        click_button @submit
    end

    def invalid_signup
        click_button @submit 
    end

end

