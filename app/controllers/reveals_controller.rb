class RevealsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @game = Game.find(params[:game_id])
    @game.reveal(params[:row], params[:col])
    if @game.save
      render json: @game, status: :ok
    else
      render json: @game, status: :conflict
    end
  end

end
