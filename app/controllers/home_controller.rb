class HomeController < ApplicationController

  require './app/services/card_validation_service'
  require './app/services/hand_judge_service'

  def check
    @msg = CardValidationService.new.execute(params[:cards])
    if @msg.present?
      render :'home/top'
      return
    end
    handJudgeService = HandJudgeService.new
    handJudgeService.execute(params[:cards])
    @hand = handJudgeService.hand
    render :'home/top'
  end

end
