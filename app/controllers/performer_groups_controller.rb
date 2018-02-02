class PerformerGroupsController < ApplicationController
  def show
    @performer_group = PerformerGroup.find(params[:id])
  end
end
