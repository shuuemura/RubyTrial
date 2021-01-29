class HomeController < ApplicationController
  def check
    card_validation_service = CardValidationService.new(params[:cards_str])
    if card_validation_service.valid?
      @errors = card_validation_service.errors
      render :index
      return
    end
    handJudgeService = HandJudgeService.new(params[:cards_str])
    handJudgeService.judge
    @hand = handJudgeService.hand
    render :index
  end
end
