class Api::V1::ShowsController < ApplicationController
  def index
    shows = Show.by_avg_scores
    shows_response = shows.map { |show| ShowSerializer.new(show) }
    render json: shows_response.to_json
  end

  def show
    @show = Show.find(params[:id])
    show_response = ShowSerializer.new(@show, scope: current_user)
    render json: show_response.to_json
  end
end
