class Public::CampsController < ApplicationController

  def index
    @camps = Camp.all
  end

  def show
    @camp = Camp.find(params[:id])
    @camp_comment = CampComment.new
    @camp_comments = CampComment.where(camp_id: @camp.id)
  end

  private

  def camp_comment_params
    params.require(:camp_comment).permit(:rate)
  end

end

