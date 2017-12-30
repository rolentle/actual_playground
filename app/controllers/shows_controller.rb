class ShowsController < ApplicationController
  def index
    @shows = Show.by_avg_scores
  end
  def show
    @show = Show.includes(:ratings).find(params[:id])
  end

  def update
  end

  def destroy
    @show = Show.includes(:ratings).find(params[:id])
  end
end
