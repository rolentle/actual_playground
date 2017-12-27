class ShowsController < ApplicationController
  def show
    @show = Show.includes(:ratings).find(params[:id])
  end

  def update
  end

  def destroy
    @show = Show.includes(:ratings).find(params[:id])
  end
end
