require 'rails_helper'

RSpec.describe 'Tags', type: :request do
  describe 'GET /search' do
    it 'returns http success' do
      get '/tags/search'
      expect(response).to have_http_status(:success)
    end
  end
end
