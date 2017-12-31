class Api::V1::RatingsController < ApplicationController
  before_action :authenticate_user!, :find_show
  def create
    @show.ratings.create(rating_params.merge!(user: current_user))
    redirect_to show_path(@show)
  end

  def update
    @rating = Rating.find(params[:id])
    redirect_to show_path(@show) if @rating.update!(rating_params)
  end

  def destroy
    @rating = Rating.find(params[:id])
    redirect_to show_path(@show) if @rating.destroy!
  end

  private

  def find_show
    @show = Show.find(params[:show_id])
  end

  def rating_params
    params.require(:rating).permit(:score, :review)
  end
end
