require 'rails_helper'

shared_examples_for :sign_in_user do
  let!(:user) { create :user }

  before { login(user) }
  after { logout(user) }
end
