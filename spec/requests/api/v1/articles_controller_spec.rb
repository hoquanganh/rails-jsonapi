require 'rails_helper'
require 'shared_contexts/controller_extensions'

describe Api::V1::ArticlesController, type: :request do
  include_context :sign_in_user

  describe 'GET /api/v1/articles' do
    context "when user is authenticated" do
      it 'responds with ok status' do
        get api_v1_articles_path

        expect(response).to have_http_status :ok
      end
    end

    context "when user is not authenticated" do
      before { logout(user) }

      it "returns http unauthorized" do
        get api_v1_articles_path

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
