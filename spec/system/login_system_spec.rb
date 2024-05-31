require "rails_helper"

RSpec.describe "LoginSystem", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }

  specify "ログインできること" do
    login_with_email_and_password user.email, "password"
    expect(page).to have_selector("div", text: I18n.t("devise.sessions.signed_in"))
  end

  specify "メールアドレスまたはパスワードが間違っていると表示されること" do
    login_with_email_and_password "missing@example.org", "password"
    expect(page).to have_selector("div", text: I18n.t("devise.failure.invalid", authentication_keys: "メールアドレス"))
  end

  private

  def login_with_email_and_password(email, password)
    visit new_user_session_path

    fill_in "user[email]", with: email
    fill_in "user[password]", with: password
    find('input[name="commit"]').click
  end
end
