module API
  module Ver1
    class Cards < Grape::API
      format :json

      params do
        requires :cards_list, type: Array, desc: 'Trump Cards.'
      end

      post '/ver1/cards' do
        result = []
        error = []
        strength = []
        params[:cards_list].each do |cards|
          card_validation_service = CardValidationService.new.execute(cards)
          hand_judge_service = HandJudgeService.new
          hand_judge_service.execute(cards)
          if card_validation_service.present?
            error_element = {
              "cards": cards,
              "msg": card_validation_service
            }
            error.push error_element
          else
            result_element = {
              "cards": cards,
              "hand": hand_judge_service.hand,
              "best": false
            }
            strength.push hand_judge_service.strength
            result.push result_element
          end
        end
        max_list = strength.each_index.select{|i|strength[i]==strength.max}
        max_list.each do |i|
          result[i][:best] = true
        end
        response = {
          "result": result,
          "error": error
        }
        response.delete(:result) if result.empty?
        response.delete(:error) if error.empty?
        return response
      end

    end
  end
end