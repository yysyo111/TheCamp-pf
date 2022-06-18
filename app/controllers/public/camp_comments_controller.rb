class Public::CampCommentsController < ApplicationController
  before_action :authenticate_customer!

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
    if @camp_comment.save
    redirect_to camp_path(@camp.id), notice: "レビューの投稿に成功しました"
    else
      render :new
    end
  end

  def destroy
    CampComment.find(params[:id]).destroy
    redirect_to camp_path(params[:camp_id]), notice: "レビューの削除に成功しました"
  end

  def camp_comment_params
    params.require(:camp_comment).permit(:comment, :title, :rate)
  end
end
