require 'rails_helper'
RSpec.describe HomeController, type: :controller do
  describe "GET #top" do
    it '正常なレスポンスか？' do
      get :top
      expect(response).to be_success
    end
    it '200レスポンスが返ってきているか？' do
      get :top
      expect(response).to have_http_status "200"
    end
  end
  describe "POST #top" do
    context 'URLを開いたとき' do
      it 'POSTで正常なレスポンスか？' do
        post :top
        expect(response).to be_success
      end
      it 'POSTで200レスポンスが返ってきているか？' do
        post :top
        expect(response).to have_http_status "200"
      end
    end
    context '適切なカードでCheckした時' do
      let(:params){{cards: "D1 D10 S9 C5 C4"}}
      it 'POSTで正常なレスポンスか？' do
        post :top, params: params
        expect(response).to be_success
      end
      it 'POSTで200レスポンスが返ってきているか？' do
        post :top, params: params
        expect(response).to have_http_status "200"
      end
    end
    context '不適切なカードでCheckした時' do
      let(:params){{cards: "D1 D1 S9 C5 C4"}}
      it 'POSTで正常なレスポンスか？' do
        post :top, params: params
        expect(response).to be_success
      end
      it 'POSTで200レスポンスが返ってきているか？' do
        post :top, params: params
        expect(response).to have_http_status "200"
      end
    end
  end
end