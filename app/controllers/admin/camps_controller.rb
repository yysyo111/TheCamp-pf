class Admin::CampsController < ApplicationController
  
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
    @camp.admin_id = current_admin.id

    @camp.save
    redirect_to admin_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def camp_params
    params.require(:camp).permit(:admin_id, :name, :address, :phone_number, :area, :latitude, :longitude, :parking)
  end
end
