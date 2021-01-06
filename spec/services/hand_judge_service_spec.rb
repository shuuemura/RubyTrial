require 'rails_helper'

describe '役判定' do
  let(:hand_judge_service) { HandJudgeService.new }

  context '同じスートで数字が連続する5枚のカードで構成' do
    before {hand_judge_service.execute("C7 C6 C5 C4 C3")}
    subject {hand_judge_service.hand}
    it {is_expected.to eq "ストレートフラッシュ"}
  end
  context '同じ数字のカードが4枚含まれる' do
    before {hand_judge_service.execute("C10 D10 H10 S10 D5")}
    subject {hand_judge_service.hand}
    it {is_expected.to eq "フォー・オブ・ア・カインド"}
  end
  context '同じ数字のカード3枚と、別の同じ数字のカード2枚で構成' do
    before {hand_judge_service.execute("S10 H10 D10 S4 D4")}
    subject {hand_judge_service.hand}
    it {is_expected.to eq "フルハウス"}
  end
  context '同じスートのカード5枚で構成' do
    before {hand_judge_service.execute("H1 H12 H10 H5 H3")}
    subject {hand_judge_service.hand}
    it {is_expected.to eq "フラッシュ"}
  end
  context '数字が連続した5枚のカードによって構成' do
    before {hand_judge_service.execute("S8 S7 H6 H5 S4")}
    subject {hand_judge_service.hand}
    it {is_expected.to eq "ストレート"}
  end
  context '同じ数字の札3枚と数字の違う2枚の札から構成' do
    before {hand_judge_service.execute("S12 C12 D12 S5 C3")}
    subject {hand_judge_service.hand}
    it {is_expected.to eq "スリー・オブ・ア・カインド"}
  end
  context '同じ数の2枚組を2組と他のカード1枚で構成' do
    before {hand_judge_service.execute("H13 D13 C2 D2 H11")}
    subject {hand_judge_service.hand}
    it {is_expected.to eq "ツーペア"}
  end
  context '同じ数字の2枚組とそれぞれ異なった数字の札3枚によって構成' do
    before {hand_judge_service.execute("C10 S10 S6 H4 H2")}
    subject {hand_judge_service.hand}
    it {is_expected.to eq "ワンペア"}
  end
  context '上述の役が1つも成⽴しない' do
    before {hand_judge_service.execute("D1 D10 S9 C5 C4")}
    subject {hand_judge_service.hand}
    it {is_expected.to eq "ハイカード"}
  end
end