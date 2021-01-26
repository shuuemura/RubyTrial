class HomeController < ApplicationController

  require './app/services/card_validation_service'
  require './app/services/hand_judge_service'

  def check
    @msg = CardValidationService.new(params[:cards]).valid?
    if @msg.present?
      render :'home/index'
      return
    end
    handJudgeService = HandJudgeService.new
    handJudgeService.execute(params[:cards])
    @hand = handJudgeService.hand
    render :'home/index'
  end

end
