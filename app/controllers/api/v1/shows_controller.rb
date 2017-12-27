class Api::V1::ShowsController < ApplicationController
  def show
    @show = Show.find(params[:id])
    show_response = ShowSerializer.new(@show, scope: current_user)
    render json: show_response.to_json
  end
end
