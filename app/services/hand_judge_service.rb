class HandJudgeService
  attr_accessor :hand
  def execute(cards)
    card_list = cards.split(" ").sort_by{|card| card[1,2].to_i}
    suit_list = []
    number_list = []
    card_list.each do |card|
      suit_list.push card[0,1]
      number_list.push card[1,2]
    end
    count_uniq_number = number_list.count(number_list.uniq[0])
    min_max_diff_number = number_list[4].to_i - number_list[0].to_i

    if suit_list.uniq.size == 1 && min_max_diff_number == 4
      @hand = "ストレートフラッシュ"
      return
    end

    if suit_list.uniq.size == 1
      @hand = "フラッシュ"
      return
    end

    if number_list.uniq.size == 2 && (count_uniq_number == 1 || count_uniq_number == 4)
      @hand = "フォー・オブ・ア・カインド"
      return
    end

    if number_list.uniq.size == 2
      @hand = "フルハウス"
      return
    end

    if min_max_diff_number == 4 && number_list.uniq.size == 5
      @hand = "ストレート"
      return
    end

    if number_list.uniq.size == 4
      @hand = "ワンペア"
      return
    end

    @hand = "ハイカード"
  end
end