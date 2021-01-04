class HomeController < ApplicationController

  require './app/services/card_validation_service'
  require './app/services/hand_judge_service'
  include CardValidationService

  def top
    @msg = CardValidationService.execute(params[:cards])
    return unless @msg.blank?
    unless params[:cards].blank?
      handJudgeService = HandJudgeService.new
      handJudgeService.execute(params[:cards])
      @hand = handJudgeService.hand
    end
  end

end
