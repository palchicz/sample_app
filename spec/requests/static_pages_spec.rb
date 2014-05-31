require 'spec_helper'

describe "Static pages" do
    subject { page }
   
    shared_examples_for "all static pages" do
        it { should have_selector('h1', text: heading) }
        it { should have_title (full_title(page_title)) }
    end

    describe "Home page" do
        before { visit root_path }
        let (:heading) { 'Sample App' }
        let (:page_title) { '' }

        it_should_behave_like "all static pages"
        it { should_not have_title (' | Home') }

        describe "for signed-in users" do
            let(:user) { FactoryGirl.create(:user) }
            before do
                FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
                FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
                sign_in user
                visit root_path
            end
            it "should render the user's feed" do
                user.feed.each do |item|
                    expect(page).to have_selector("li##{item.id}", text: item.content)
                end
            end
            describe "follower/following counts" do
                let(:other_user) { FactoryGirl.create(:user) }
                before do
                    other_user.follow!(user)
                    visit root_path
                end

                it { should have_link("0 following", href: following_user_path(user)) }
                it { should have_link("1 followers", href: followers_user_path(user)) }
            end
            it "should render microposts count" do
                expect(page).to have_selector("span", text:"2 microposts")
            end
        end
    end

    describe "Help Page" do
        before { visit help_path }
        let (:heading) { 'Help' }
        let (:page_title) { 'Help' }

        it_should_behave_like "all static pages"
    end

    describe "About Page" do
        before { visit about_path }
        let (:heading) { 'About' }
        let (:page_title) { 'About Us' }

        it_should_behave_like "all static pages"
    end

    describe "Contact Page" do
        before { visit contact_path }
        let (:heading) { 'Contact' }
        let (:page_title) { 'Contact' }

        it_should_behave_like "all static pages"
    end

    it "should have the right links on the layout" do
        visit root_path
        verifyLinkWithTitle('About', 'About Us')
        verifyLinkWithTitle('Help', 'Help')
        verifyLinkWithTitle('Contact', 'Contact')
        click_link "Home"
        verifyLinkWithTitle('Sign up now!', 'Sign up')
        verifyLinkWithTitle('sample app', '')
    end
end
