require 'spec_helper'

describe "User Pages" do
    subject { page }

    describe "signup page" do
        before { visit signup_path }
        
        let(:submit) { "Create my Account" }
        
        describe "with invalid information" do
            it "should not create a user" do
                expect { click_button submit }.not_to change(User, :count)
            end
            
            describe "after submission" do
                before { click_button submit }

                it { should have_title('Sign up') }
                it { should have_content('error') }
                it { should have_content('Name can\'t be blank') }
                it { should have_content('Email can\'t be blank') }
                it { should have_content('Email is invalid') } 
                it { should have_content('Password can\'t be blank') }
                it { should have_content('Password is too short') }
            end
        end

        describe "with valid information" do
            let(:exampleEmail) { "user@example.com" }
            before do
                fill_in "Name",     with: "Example User"
                fill_in "Email",    with:  exampleEmail
                fill_in "Password", with: "foobar"
                fill_in "Password confirmation", with: "foobar"
            end
            
            it "should create a user" do
                expect { click_button submit }.to change(User, :count)
            end

            describe "after submission" do
                before { click_button submit }
                let(:user) { User.find_by(email: exampleEmail) }

                it { should have_title(user.name) }
                it { should have_selector('div.alert.alert-success', text: 'Welcome') }
            end
        end
        it { should have_content('Sign up') }
        it { should have_title(full_title('Sign up')) }
    end

    describe "profile page" do
        let(:user) { FactoryGirl.create(:user) }

        before { visit user_path(user) }

        it { should have_content(user.name) }
        it { should have_title(user.name) }
        it { should have_selector('img.gravatar') }
    end
end
