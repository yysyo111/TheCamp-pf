class Public::CampItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    # @camp_items = CampItem.all
    @camp_items = params[:tag_id].present? ? Tag.find(params[:tag_id]).camp_items: CampItem.all
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
    @camp_item.save!
    redirect_to camp_items_path
  end

  def edit
    @camp_item = CampItem.find(params[:id])
  end

  def update
    @camp_item = CampItem.find(params[:id])
    if @camp_item.update(camp_item_params)
      redirect_to camp_item_path(@camp_item.id)
    else
      render 'edit'
    end
  end

  def destroy
    @camp_item = CampItem.find(params[:id])
    @camp_item.destroy
    redirect_to camp_items_path
  end

  private

  def camp_item_params
    params.require(:camp_item).permit(:name, :impression, :camp_item_image, :rate, tag_ids: [])
  end
end
