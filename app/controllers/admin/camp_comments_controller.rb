class Admin::CampCommentsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @camp_comment = CampComment.find(params[:camp_id])
  end

  def destroy
    CampComment.find(params[:camp_id]).destroy
    redirect_to admin_camp_path(params[:id]), notice: "口コミの削除に成功しました"
  end

end
