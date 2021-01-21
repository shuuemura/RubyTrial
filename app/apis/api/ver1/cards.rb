module API
  module Ver1
    class Cards < Grape::API
      format :json

      params do
        requires :cards_list, type: Array, desc: 'Trump Cards.'
      end

      post '/ver1/cards' do
        results = []
        errors = []
        strengths = []
        params[:cards_list].each do |cards|
          validation_msg = CardValidationService.new.execute(cards)
          hand_judge_service = HandJudgeService.new
          hand_judge_service.execute(cards)
          if validation_msg.present?
            error = {
              "cards": cards,
              "msg": validation_msg
            }
            errors.push error
          else
            result = {
              "cards": cards,
              "hand": hand_judge_service.hand,
              "best": false
            }
            strengths.push hand_judge_service.strength
            results.push result
          end
        end
        strongest_indexes = strengths.each_index.select{|i|strengths[i]==strengths.max}
        strongest_indexes.each do |i|
          results[i][:best] = true
        end
        response = {}
        response[:result] = results if results.any?
        response[:error] = errors if errors.any?
        return response
      end

    end
  end
end