class CardValidationService
  attr_reader :errors

  def initialize(cards_str)
    @cards_str = cards_str
    @errors = []
  end

  def valid?
    blank_check # 文字入力チェック
    if @errors.empty?
      @cards = @cards_str.split(' ')
      card_count_check # カードの枚数チェック
      card_standard_check # カードの規格チェック
      card_overlap_check # カードの重複チェック
    end
    @errors.present?
  end

  private

  def blank_check
    @errors << '文字を入力してください' if @cards_str.blank?
  end

  def card_count_check
    @errors << '5つのカード指定文字を半角スペース区切りで入力してください。（例：「S1 H3 D9 C13 S11」）' if @cards.size != 5
  end

  def card_standard_check
    nonstandard_card_list = []
    nonstandard_card_index_list = []
    @cards.each.with_index(1) do |card, i|
      unless card =~ /^[SDHC](1[0-3]|[1-9])$/
        nonstandard_card_list.push card
        nonstandard_card_index_list.push i
      end
    end
    if nonstandard_card_list.any?
      @errors << "#{nonstandard_card_index_list.join(', ')}番目のカードが違います（#{nonstandard_card_list.join(', ')}）。半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
    end
  end

  def card_overlap_check
    @errors << 'カードが重複しています' if @cards.size != @cards.uniq.size
  end
end
