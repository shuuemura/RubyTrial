class HandJudgeService
  attr_accessor :hand, :strength

  def initialize(cards_str)
    @cards_str = cards_str
    @results = []
  end

  def judge
    @cards = @cards_str.split(' ').sort_by { |card| card[1, 2].to_i }
    @suits = []
    @numbers = []
    @cards.each do |card|
      @suits.push card[0, 1]
      @numbers.push card[1, 2]
    end
    @count_uniq_number_0 = @numbers.count(@numbers.uniq[0])
    @count_uniq_number_1 = @numbers.count(@numbers.uniq[1])
    @diff_number = []
    @numbers.each_with_index do |number, i|
      diff = @numbers[i + 1].to_i - number.to_i
      @diff_number.push diff if [1, 9].include?(diff)
      break if i == 3
    end

    judge_straight_flash
    judge_four_of_a_kind
    judge_full_house
    judge_flash
    judge_straight
    judge_three_of_a_kind
    judge_two_pair
    judge_one_pair
    judge_high_card

    @hand = @results[0]['hand']
    @strength = @results[0]['strength']
  end

  private

  def judge_straight_flash
    result = { 'hand' => 'ストレートフラッシュ', 'strength' => 2_598_960 / 40 }
    @results.push result if @suits.uniq.size == 1 && @diff_number.size == 4
  end

  def judge_four_of_a_kind
    result = { 'hand' => 'フォー・オブ・ア・カインド', 'strength' => 2_598_960 / 624 }
    @results.push result if @numbers.uniq.size == 2 && (@count_uniq_number_0 == 1 || @count_uniq_number_0 == 4)
  end

  def judge_full_house
    result = { 'hand' => 'フルハウス', 'strength' => 2_598_960 / 3744 }
    @results.push result if @numbers.uniq.size == 2
  end

  def judge_flash
    result = { 'hand' => 'フラッシュ', 'strength' => 2_598_960 / 5108 }
    @results.push result if @suits.uniq.size == 1
  end

  def judge_straight
    result = { 'hand' => 'ストレート', 'strength' => 2_598_960 / 10_200 }
    @results.push result if @numbers.uniq.size == 5 && @diff_number.size == 4
  end

  def judge_three_of_a_kind
    result = { 'hand' => 'スリー・オブ・ア・カインド', 'strength' => 2_598_960 / 54_912 }
    @results.push result if @numbers.uniq.size == 3 && @count_uniq_number_0 * @count_uniq_number_1.odd?
  end

  def judge_two_pair
    result = { 'hand' => 'ツーペア', 'strength' => 2_598_960 / 123_552 }
    @results.push result if @numbers.uniq.size == 3
  end

  def judge_one_pair
    result = { 'hand' => 'ワンペア', 'strength' => 2_598_960 / 1_098_240 }
    @results.push result if @numbers.uniq.size == 4
  end

  def judge_high_card
    result = { 'hand' => 'ハイカード', 'strength' => 2_598_960 / 1_302_540 }
    @results.push result
  end
end
