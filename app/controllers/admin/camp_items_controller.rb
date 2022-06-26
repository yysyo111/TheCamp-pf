class Admin::CampItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # @camp_items = CampItem.all.page(params[:page]).per(3)
    @camp_items = params[:tag_id].present? ? Tag.find(params[:tag_id]).camp_items.page(params[:page]).per(6): CampItem.all.page(params[:page]).per(6)
  end

  def show
    @camp_item = CampItem.find(params[:id])
    @camp_item_comment = CampItemComment.new
  end

  def destroy
    @camp_item = CampItem.find(params[:id])
    @camp_item.destroy
    redirect_to admin_camp_items_path, notice: "キャンプアイテムの削除に成功しました"
  end
end
