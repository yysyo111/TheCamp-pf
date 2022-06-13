class Public::CampCommentsController < ApplicationController

  def new
    @camp = Camp.find(params[:camp_id])
    @camp_comment = CampComment.new
  end

  def create
    @camp = Camp.find(params[:camp_id])
    @camp_comment = CampComment.new(camp_comment_params)
    @camp_comment.customer_id = current_customer.id
    # @comment = current_customer.camp_comments.new(camp_comment_params) #上の記述と同じ
    @camp_comment.camp_id = @camp.id
    @camp_comment.save
    redirect_to camp_path(@camp.id)
  end

  def destroy
    CampComment.find(params[:id]).destroy
    redirect_to camp_path(params[:camp_id])
  end

  def camp_comment_params
    params.require(:camp_comment).permit(:comment, :title, :rate)
  end
end
