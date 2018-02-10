class Api::V1::RssFeedConvertersController < ApplicationController
  before_action :authenticate_user!
  def create
    render json: RssFeedConverter.execute(rss_feed_converter_params[:url]).episodes, each_serializer: RssFeedEpisodeSerializer
  end

  private
  def rss_feed_converter_params
    params.require(:rss_feed).permit(:url)
  end
end
