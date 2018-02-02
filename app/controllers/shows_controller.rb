class ShowsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @shows = Show.by_avg_scores
  end

  def new
    @show = Show.new
  end

  def create
    creator = show_params[:creator_type].constantize.create!(show_params[:creator])
    create_show_params = show_params.merge(status: 1, submitter: current_user, creator: creator)
    @show = Show.create!(create_show_params)
    flash[:notice] = 'Thank you for submitting your show, we will notify you once it has been approved'
    redirect_to shows_path
  end

  def show
    @show = Show.find(params[:id])
    @rating = Rating.new
    @rating.show = @show
    if @show.pending?
      authenticate_user!
      redirect_to root_path unless (@show.submitter == current_user)
      flash[:notice] = 'Your show is still pending review'
    end
  end

  def edit
    @show = Show.find(params[:id])
    redirect_to root_path unless @show.pending? && (@show.submitter == current_user)
  end

  def update
  end

  def destroy
  end

  private

  def show_params
    params.require(:show).permit(:title, :twitter_username, :description, { creator: [:name] }, :creator_type)
  end
end
