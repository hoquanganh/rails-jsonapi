require 'rails_helper'
require 'shared_contexts/controller_extensions'

describe Api::V1::ArticlesController, type: :request do
  include_context :sign_in_user

  describe 'GET /api/v1/articles' do
    context 'when user is authenticated' do
      it 'responds with ok status' do
        get api_v1_articles_path

        expect(response).to have_http_status :ok
      end
    end

    context 'list all articles' do
      let!(:articles) { create_list(:article, 3) }

      it 'returns a list of articles as JSON' do
        get api_v1_articles_path
        expect(json['data']).to be_a(Array)
        expect(json['data'].last(3).length).to eq(articles.count)

        json['data'].last(3).each_with_index do |article_data, index|
          article = articles[index]
          expect(article_data['id']).to eq(article.id.to_s)
          expect(article_data['type']).to eq('article')
          expect(article_data['attributes']['title']).to eq(article.title)
          expect(article_data['attributes']['body']).to eq(article.body)
        end
      end
    end

    context 'when user is not authenticated' do
      before { logout(user) }

      it 'returns http unauthorized' do
        get api_v1_articles_path

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /api/v1/articles' do
    let(:author) { create :author }

    before { post api_v1_articles_path, params: params }

    context 'given valid params' do
      let(:params) do
        {
          article: { title: 'Article title', body: 'Article body', author_id: author.id }
        }
      end

      it 'create new article' do
        last_article = Article.last
        expect(response).to have_http_status :created

        expect(json['data']).to have_type('article')
        expect(json['data']).to have_jsonapi_attributes(:title, :body)
        expect(json['data']).to have_attribute(:title).with_value('Article title')
        expect(json['data']).to have_attribute(:body).with_value('Article body')
        expect(json['data']).to have_relationship(:author).with_data({ id: last_article.author_id.to_s, type: 'author' })
      end
    end

    context 'given invalid params' do
      let(:params) do
        { article: { title: '', author_id: nil } }
      end

      it 'responds with unprocessable_entity status' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'GET /api/v1/articles/:id' do
    let!(:article) { create :article }

    it 'returns the article as JSON' do
      get api_v1_article_path(article.id)

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      expect(json['data']['id']).to eq(article.id.to_s)
      expect(json['data']['type']).to eq('article')
      expect(json['data']['attributes']['title']).to eq(article.title)
      expect(json['data']['attributes']['body']).to eq(article.body)
    end
  end

  describe 'PATCH /api/v1/articles/:id' do
    let!(:article) { create :article }
    let(:valid_params) { { title: 'Updated Title' } }
    let(:invalid_params) { { author_id: nil } }

    context 'with valid parameters' do
      it 'updates the article and returns the updated article as JSON' do
        patch api_v1_article_path(article.id), params: { article: valid_params }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        expect(json['data']['id']).to eq(article.id.to_s)
        expect(json['data']['type']).to eq('article')
        expect(json['data']['attributes']['title']).to eq(valid_params[:title])
      end
    end

    context 'with invalid parameters' do
      it 'returns an error response as JSON' do
        patch api_v1_article_path(article.id), params: { article: invalid_params }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        expect(json['status']).to be_falsey
        expect(json['error']).to be_present
      end
    end
  end

  describe 'DELETE /api/v1/articles/:id' do
    let!(:article) { create :article }

    it 'responds with :ok status and deletes the article' do
      expect {
        delete api_v1_article_path(article.id)
      }.to change(Article, :count).by(-1)

      expect(response).to have_http_status :ok
    end
  end
end
