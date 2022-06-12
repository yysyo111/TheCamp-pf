class Public::CampCommentsController < ApplicationController

  def new
    @camp_comment = CampComment.new
  end

  def create
    @camp = Camp.find(params[:camp_id])
    # comment = CampComment.new(camp_comment_params)
    # comment.customer_id = current_customer.id
    @camp_comment = current_customer.camp_comments.new(camp_comment_params) #上の記述と同じ
    @camp_comment.camp_id = camp.id
    @camp_comment.save
    redirect_to camps_path(camp)
  end

  def camp_comment_params
    params.require(:camp_comment).permit(:comment, :title)
  end
end
