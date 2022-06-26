class Public::CampsController < ApplicationController
  before_action :authenticate_customer!

  def index
    # 絞り込み表示
    if params[:area].present?
      @camps = Camp.where(area: params[:area]).page(params[:page]).per(6)
    # 評価の高い順(gem 'order_as_specified'というgem使用している)
    elsif params[:rate_count]
      avg_camp_comments = CampComment.group(:camp_id).average(:rate)
      avg_order_camp_ids = avg_camp_comments.sort {|a,b| b[1]<=>a[1]}.to_h.keys
      @camps = Camp.where(id: avg_order_camp_ids).order_as_specified(id: avg_order_camp_ids).page(params[:page]).per(6)
    # 評価の低い順(gem 'order_as_specified'というgem使用している)
    elsif params[:rate_asc_count]
      avg_camp_comments = CampComment.group(:camp_id).average(:rate)
      avg_order_camp_ids = avg_camp_comments.sort {|a,b| a[1]<=>b[1]}.to_h.keys
      @camps = Camp.where(id: avg_order_camp_ids).order_as_specified(id: avg_order_camp_ids).page(params[:page]).per(6)
    # 全てのキャンプ場
    else
      @camps = Camp.all.page(params[:page]).per(6)
    end
      @value = params[:area]
  end

  def show
    @camp = Camp.find(params[:id])
    @camp_comment = CampComment.new
    @camp_comments = CampComment.where(camp_id: @camp.id).page(params[:page]).per(3)
    # @camp_avg = @camp.get_camp_review_avg
  end

  private

  def camp_comment_params
    params.require(:camp_comment).permit(:rate)
  end

end

