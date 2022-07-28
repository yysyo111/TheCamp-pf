class Public::CampItemCommentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_user, only: [:destroy]

  def new
    # @camp_item = CampItem.find(params[:camp_item_id])
    # @camp_item_comment = CampItemComment.new
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

  private
  def camp_item_comment_params
    params.require(:camp_item_comment).permit(:comment)
  end

  def ensure_correct_user
    @camp_item_comment = CampItemComment.find(params[:id])
    unless @camp_item_comment.customer == current_customer
      redirect_to camp_items_path
    end
  end

end