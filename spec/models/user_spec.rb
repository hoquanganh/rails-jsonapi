require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe "validations" do
    it { is_expected.to have_secure_password }

    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    it { is_expected.to allow_value("johndoe@example.com", "johjn@exa.co.in").for(:email) }

    it { is_expected.not_to allow_value("johndoeexample.com").for(:email) }

    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe "callbacks" do
    it "normalizes the email before validation" do
      user.update(email: '  HELLO@example.com ')

      expect(user.email).to eq("hello@example.com")
    end
  end
end
