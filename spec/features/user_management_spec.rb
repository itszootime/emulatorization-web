feature "user management" do

  let(:user) { FactoryGirl.create(:user) }

  scenario "new user sign up" do
    visit root_url
    click_link "Get started"

    click_link "Sign up here"

    fill_in "First name", with: "Emily"
    fill_in "Last name", with: "Emulator"
    fill_in "E-mail address", with: "emily@emulator.com"
    fill_in "Password", with: "iloveemulators"
    fill_in "Password confirmation", with: "iloveemulators"

    click_button "Sign up"

    expect(page).to have_text "You have signed up successfully"
  end

  scenario "existing user sign in" do
    visit root_url
    click_link "Get started"

    fill_in "E-mail address", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign in"

    expect(page).to have_text "Signed in successfully"
  end
end