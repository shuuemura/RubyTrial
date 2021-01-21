class CardValidationService

  def execute(cards)

    if cards.blank?
      return "文字を入力してください"
    end

    card_list = cards.split(" ")
    if card_list.size != 5
      return "5つのカード指定文字を半角スペース区切りで入力してください。（例：「S1 H3 D9 C13 S11」）"
    end
    nonstandard_card_list = []
    nonstandard_card_index_list = []
    card_list.each.with_index(1) do |card, i|
      unless card =~ /^[SDHC](1[0-3]|[1-9])$/
        nonstandard_card_list.push card
        nonstandard_card_index_list.push i
      end
    end
    if nonstandard_card_list.any?
      return "#{nonstandard_card_index_list.join(', ')}番目のカードが違います（#{nonstandard_card_list.join(', ')}）。半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
    end
    if card_list.size != card_list.uniq.size
      return "カードが重複しています"
    end

  end
end