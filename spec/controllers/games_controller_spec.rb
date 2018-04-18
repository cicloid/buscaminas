require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  include ApiDoc::Games::Api

  describe 'GET #index' do
    include ApiDoc::Games::Index

    it 'returns a list of games', :dox do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
