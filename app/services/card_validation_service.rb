module CardValidationService

  def execute(cards)

    if cards.blank? #トップページ、または空白でCheckしたときにmsgを出力しない
      return
    end

    card_list = cards.split(" ")
    if card_list.size != 5
      return "5つのカード指定文字を半角スペース区切りで入力してください。（例：「S1 H3 D9 C13 S11」）"
    end
    card_list.each.with_index do |card, i|
      unless card =~ /^[SDHC](1[0-3]|[1-9])$/
        return "#{i+1}番目のカードが違います（#{card}）。半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
    end
    if card_list.size != card_list.uniq.size
      return "カードが重複しています"
    end

  end
  module_function :execute
end