class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @game = Game.find(params[:id])

    render json: @game
  end

  def create
    @game = Game.new(params[:game])
    if @game.save
      render json: @game
    else
      render status: :conflict
    end
  end

end
