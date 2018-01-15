class ShowsController < ApplicationController
  def index
    @shows = Show.by_avg_scores
  end

  def show
    @show = Show.find(params[:id])
    @rating = Rating.new
    @rating.show = @show
  end

  def update
  end

  def destroy
  end
end
