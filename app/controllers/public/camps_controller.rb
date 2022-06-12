class Public::CampsController < ApplicationController

  def index
    @camps = Camp.all
  end

  def show
    @camp = Camp.find(params[:id])
    @camp_comment = CampComment.new
  end

end
