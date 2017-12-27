class Api::V1::RatingsController < ApplicationController
  before_action :authenticate_user!
  def create
    @show = Show.find(params[:show_id])
    @show.ratings.create(rating_params.merge!(user: current_user))
    redirect_to show_path(@show)
  end

  def update
    @show = Show.find(params[:show_id])
    @rating = Rating.find(params[:id])
    if @rating.update!(rating_params)
      redirect_to show_path(@show)
    end
  end

  def destroy
    @show = Show.find(params[:show_id])
    @rating = Rating.find(params[:id])
    if @rating.destroy!
      redirect_to show_path(@show)
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:score, :review)
  end
end
