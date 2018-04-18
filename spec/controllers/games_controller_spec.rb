require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  include ApiDoc::Games::Api

  describe 'GET #show' do
    include ApiDoc::Games::Index

    it 'returns a list of games', :dox do
      last = Game.create
      get :show, params: { id: last.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    include ApiDoc::Games::Create

    it 'returns a list of games', :dox do
      post :create
      expect(response).to have_http_status(:ok)
    end
  end
end
