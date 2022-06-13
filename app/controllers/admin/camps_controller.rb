class Admin::CampsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @camps = Camp.all
  end

  def show
    @camp = Camp.find(params[:id])
  end

  def new
    @camp = Camp.new
  end

  def create
    @camp = Camp.new(camp_params)
    @camp.admin_id = current_admin.id #ログイン中のユーザーの情報を取得

    @camp.save
    redirect_to admin_camps_path
  end

  def edit
    @camp = Camp.find(params[:id])
  end

  def update
    @camp = Camp.find(params[:id])
    if @camp.update(camp_params)
      redirect_to admin_camp_path(@camp.id)
    else
      render 'edit'
    end
  end

  def destroy
    @camp = Camp.find(params[:id])
    @camp.destroy
    redirect_to admin_camps_path(@camp)
  end

  private
  def camp_params
    params.require(:camp).permit(:admin_id, :name, :address, :phone_number, :area, :latitude, :longitude, :parking, :camp_image)
  end
end
