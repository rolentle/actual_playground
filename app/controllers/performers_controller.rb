class PerformersController < ApplicationController
  def show
    @performer = Performer.find(params[:id])
  end
end
