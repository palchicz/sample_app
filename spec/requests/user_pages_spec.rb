require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }


    describe "with invalid information" do
      it "should not create a user" do
        expect { invalid_signup }.not_to change(User, :count)
      end

      describe "after submission" do
        before { invalid_signup }

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
      it "should create a user" do
        expect { valid_signup }.to change(User, :count)
      end

      describe "after submission" do
        before { valid_signup }
        let(:user) { User.find_by(email: SignupHelper::VALID_EMAIL) }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_success_message('Welcome') }
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
