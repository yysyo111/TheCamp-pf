class Public::CampItemCommentsController < ApplicationController

  def new
    @camp_item = CampItem.find(params[:camp_item_id])
    @camp_item_comment = CampItemComment.new
  end

  def create
    @camp_item = CampItem.find(params[:camp_item_id])
    @camp_item_comment = CampItemComment.new(camp_item_comment_params)
    @camp_item_comment.customer_id = current_customer.id
    # @comment = current_customer.camp_comments.new(camp_comment_params) #上の記述と同じ
    @camp_item_comment.camp_item_id = @camp_item.id
    @camp_item_comment.save
    # redirect_to request.referer
  end

  def destroy
    camp_item_comment = CampItemComment.find(params[:id])
    @camp_item = camp_item_comment.camp_item
    camp_item_comment.destroy
    @camp_item_comment = CampItemComment.new
    # CampItemComment.find(params[:id]).destroy
    # redirect_to request.referer
  end

  def camp_item_comment_params
    params.require(:camp_item_comment).permit(:comment)
  end

end