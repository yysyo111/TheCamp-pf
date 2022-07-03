class Public::CampItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def index
    # @camp_items = CampItem.all
    @camp_items = params[:tag_id].present? ? Tag.find(params[:tag_id]).camp_items.page(params[:page]).per(6): CampItem.all.page(params[:page]).per(6)
    # キャンプアイテムのページネーション追加
  end

  def show
    @camp_item = CampItem.find(params[:id])
    @camp_item_comment = CampItemComment.new
  end

  def new
    @camp_item = CampItem.new
  end

  def create
    @camp_item = CampItem.new(camp_item_params)
    @camp_item.customer_id = current_customer.id
    if @camp_item.save
      vision_tags = Vision.get_image_data(@camp_item.camp_item_image)
      vision_tags.each do |tag|
      @camp_item.vision_tags.create(name: tag)
      end
      redirect_to camp_items_path, notice: "アイテムの投稿に成功しました"
    else
      render :new
    end
  end

  def edit
    @camp_item = CampItem.find(params[:id])
  end

  def update
    @camp_item = CampItem.find(params[:id])
    if @camp_item.update(camp_item_params)
      redirect_to camp_item_path(@camp_item.id), notice: "アイテムの更新に成功しました"
    else
      render 'edit'
    end
  end

  def destroy
    @camp_item = CampItem.find(params[:id])
    @camp_item.destroy
    redirect_to camp_items_path, notice: "アイテムの削除に成功しました"
  end

  private

  def camp_item_params
    params.require(:camp_item).permit(:name, :impression, :camp_item_image, :rate, tag_ids: [])
  end

  def ensure_correct_customer
    @camp_item = CampItem.find(params[:id])
    unless @camp_item.customer == current_customer
      redirect_to camp_items_path
    end
  end
end
