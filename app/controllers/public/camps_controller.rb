class Public::CampsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @camps = Camp.all
  end

  def show
    @camp = Camp.find(params[:id])
    @camp_comment = CampComment.new
    @camp_comments = CampComment.where(camp_id: @camp.id)
    # @camp_avg = @camp.get_camp_review_avg
  end

  private

  def camp_comment_params
    params.require(:camp_comment).permit(:rate)
  end

end

