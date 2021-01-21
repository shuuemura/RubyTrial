require 'rails_helper'
describe 'エラー出力' do
  let(:cards){""} #初期値を設定しておき、subjectをエラー分岐前に実行できるようにする
  subject{CardValidationService.new.execute(cards)}
  context '空白Check' do
    let(:cards){blank?}
    it {is_expected.to eq "文字を入力してください"}
  end
  context '半角スペースで空けられた塊が4つ以下のとき' do
    let(:cards){"D1 D10 S9 C5"}
    it {is_expected.to eq "5つのカード指定文字を半角スペース区切りで入力してください。（例：「S1 H3 D9 C13 S11」）"}
  end
  context '半角スペースで空けられた塊が6つ以上のとき' do
    let(:cards){"D1 D10 S9 C5 C4 D6"}
    it {is_expected.to eq "5つのカード指定文字を半角スペース区切りで入力してください。（例：「S1 H3 D9 C13 S11」）"}
  end
  context 'スートが間違っているとき' do
    let(:cards){"D1 D10 S9 X4 D6"}
    it {is_expected.to eq "4番目のカードが違います（X4）。半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"}
  end
  context '数字が間違っているとき' do
    let(:cards){"D1 D20 S9 C4 D6"}
    it {is_expected.to eq "2番目のカードが違います（D20）。半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"}
  end
  context 'カードが重複しているとき' do
    let(:cards){"D1 D10 C4 C4 D6"}
    it {is_expected.to eq "カードが重複しています"}
  end
end