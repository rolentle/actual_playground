class Api::V1::ShowsController < ApplicationController
  def index
    shows = Show.by_avg_scores
    render json: shows
  end

  def show
    @show = Show.find(params[:id])
    render json: @show
  end
end
