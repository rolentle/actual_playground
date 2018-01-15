class RatingsController < ApplicationController
  before_action :authenticate_user!

  def new
    show = Show.where(id: params[:show_id]).first
    @rating = show.ratings.new
  end

  def create
    show = Show.where(id: params[:show_id]).first
    show.ratings.create(rating_params.merge!(user: current_user))
    redirect_to show_path(show)
  end

  def edit
    @rating = Rating.where(id: params[:id]).first
    if @rating.user != current_user
      redirect_to root_path
    end
  end

  def update
    @rating = Rating.where(id: params[:id]).first
    @rating.update(rating_params)
    redirect_to @rating.show
  end

  private

  def rating_params
    params.require(:rating).permit(:score, :review)
  end
end
