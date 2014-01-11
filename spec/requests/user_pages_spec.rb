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
            
            describe "after submissiom" do
                before { click_button submit }
                it { should have_title('Sign up') }
                it { should have_content('error') }
                it { should have_content('Email is invalid') } 
                it { should have_content('Password is too short') }
            end
        end

        describe "with valid information" do
            before do
                fill_in "Name",     with: "Example User"
                fill_in "Email",    with: "user@example.com"
                fill_in "Password", with: "foobar"
                fill_in "Password confirmation", with: "foobar"
            end
            
            it "should create a user" do
                expect { click_button submit }.to change(User, :count)
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
    end
end
