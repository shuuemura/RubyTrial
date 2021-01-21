require 'rails_helper'
RSpec.describe "Cards", type: :request do
  context "正常なデータをRequestした時（もっとも役の強い手札がひとつ）" do
    let(:params){{"cards_list": ["H1 H13 H12 H11 H10","H9 C9 S9 H2 C2","C13 D12 C11 H8 H7"]}}
    it "カードと役、最も役の強いカードにはbest判定でtrueが返される" do
      post "/api/ver1/cards", params: params
      response_body = JSON.parse(response.body)

      expect(response).to be_success
      expect(response).to have_http_status "201"

      expect(response_body['result'][0]['cards']).to eq "H1 H13 H12 H11 H10"
      expect(response_body['result'][0]['hand']).to eq "ストレートフラッシュ"
      expect(response_body['result'][0]['best']).to eq true
      expect(response_body['result'][1]['cards']).to eq "H9 C9 S9 H2 C2"
      expect(response_body['result'][1]['hand']).to eq "フルハウス"
      expect(response_body['result'][1]['best']).to eq false
      expect(response_body['result'][2]['cards']).to eq "C13 D12 C11 H8 H7"
      expect(response_body['result'][2]['hand']).to eq "ハイカード"
      expect(response_body['result'][2]['best']).to eq false
    end
  end
  context "正常なデータをRequestした時（もっとも役の強い手札が複数）" do
    let(:params){{"cards_list": ["H1 H13 H12 H11 H10","H9 H8 H7 H6 H5","C13 D12 C11 H8 H7"]}}
    it "カードと役、最も役の強い強いカードにはbest判定でtrueが返される" do
      post "/api/ver1/cards", params: params
      response_body = JSON.parse(response.body)

      expect(response).to be_success
      expect(response).to have_http_status "201"

      expect(response_body['result'][0]['cards']).to eq "H1 H13 H12 H11 H10"
      expect(response_body['result'][0]['hand']).to eq "ストレートフラッシュ"
      expect(response_body['result'][0]['best']).to eq true
      expect(response_body['result'][1]['cards']).to eq "H9 H8 H7 H6 H5"
      expect(response_body['result'][1]['hand']).to eq "ストレートフラッシュ"
      expect(response_body['result'][1]['best']).to eq true
      expect(response_body['result'][2]['cards']).to eq "C13 D12 C11 H8 H7"
      expect(response_body['result'][2]['hand']).to eq "ハイカード"
      expect(response_body['result'][2]['best']).to eq false
    end
  end
  context "Validationに引っかかる異常なデータをRequestした時" do
    let(:params){{"cards_list": ["H1 H13 H12 H11 H10","H9 C9 C9 H2 C2","C13 D13 H13 H8 H7"]}}
    it "正常データはresultに、異常データはerrorに返される" do
      post "/api/ver1/cards", params: params
      response_body = JSON.parse(response.body)

      expect(response).to be_success
      expect(response).to have_http_status "201"

      expect(response_body['result'][0]['cards']).to eq "H1 H13 H12 H11 H10"
      expect(response_body['result'][0]['hand']).to eq "ストレートフラッシュ"
      expect(response_body['result'][0]['best']).to eq true
      expect(response_body['result'][1]['cards']).to eq "C13 D13 H13 H8 H7"
      expect(response_body['result'][1]['hand']).to eq "スリー・オブ・ア・カインド"
      expect(response_body['result'][1]['best']).to eq false
      expect(response_body['error'][0]['cards']).to eq "H9 C9 C9 H2 C2"
      expect(response_body['error'][0]['msg']).to eq "カードが重複しています"
    end
  end
end