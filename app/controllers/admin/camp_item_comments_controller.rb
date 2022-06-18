class Admin::CampItemCommentsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @camp_item_comment = CampItemComment.find(params[:camp_item_id])
  end

  def destroy
    CampItemComment.find(params[:camp_item_id]).destroy
    redirect_to admin_camp_item_path(params[:id]), notice: "口コミの削除に成功しました"
  end
end
