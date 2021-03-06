class HandJudgeService
  attr_accessor :hand, :strength
  def execute(cards)
    card_list = cards.split(" ").sort_by{|card| card[1,2].to_i}
    suit_list = []
    number_list = []
    card_list.each do |card|
      suit_list.push card[0,1]
      number_list.push card[1,2]
    end
    count_uniq_number_0 = number_list.count(number_list.uniq[0])
    count_uniq_number_1 = number_list.count(number_list.uniq[1])
    diff_number = []
    number_list.each_with_index do |number, i|
      diff = number_list[i+1].to_i - number.to_i
      if diff == 1 || diff == 9
        diff_number.push diff
      end
      break if i == 3
    end

    if suit_list.uniq.size == 1 && diff_number.size == 4
      @hand = "ストレートフラッシュ"
      @strength = 2598960 / 40
      return
    end
    if number_list.uniq.size == 2 && (count_uniq_number_0 == 1 || count_uniq_number_0 == 4)
      @hand = "フォー・オブ・ア・カインド"
      @strength = 2598960 / 624
      return
    end
    if number_list.uniq.size == 2
      @hand = "フルハウス"
      @strength = 2598960 / 3744
      return
    end
    if suit_list.uniq.size == 1
      @hand = "フラッシュ"
      @strength = 2598960 / 5108
      return
    end
    if number_list.uniq.size == 5 && diff_number.size == 4
      @hand = "ストレート"
      @strength = 2598960 / 10200
      return
    end
    if number_list.uniq.size == 3 && count_uniq_number_0 * count_uniq_number_1 % 2 == 1
      @hand = "スリー・オブ・ア・カインド"
      @strength = 2598960 / 54912
      return
    end
    if number_list.uniq.size == 3
      @hand = "ツーペア"
      @strength = 2598960 / 123552
      return
    end
    if number_list.uniq.size == 4
      @hand = "ワンペア"
      @strength = 2598960 / 1098240
      return
    end
    @hand = "ハイカード"
    @strength = 2598960 / 1302540
  end
end