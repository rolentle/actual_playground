require 'rails_helper'

RSpec.describe Api::V1::ShowsController, type: :controller do
  describe 'GET index' do
    before(:each) do
      @show_count = 2
      create_list(:show, @show_count)
      get :index
    end

    it 'is sucessful' do
      expect(response).to be_success
    end

    it 'returns shows' do
      body = JSON.parse(response.body)
      expect(body.length).to be @show_count
    end
  end

  describe 'GET show' do
    before(:each) do
      @show = create(:show)
      get :show, params: { id: @show.id }
    end

    it 'is sucessful' do
      expect(response).to be_success
    end

    it 'returns show' do
      body = JSON.parse(response.body)
      expect(body['id']).to eq @show.id
    end
  end
end
