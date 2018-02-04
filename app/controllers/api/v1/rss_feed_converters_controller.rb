class Api::V1::RssFeedConvertersController < ApplicationController
  before_action :authenticate_user!
  def create
    render json: Array.new(26) { { title: Faker::Book.unique.title } }
  end

  private
  def rss_feed_converter_params
    params.require(:rss_feed).permit(:url)
  end
end
