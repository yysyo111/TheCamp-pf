class Admin::CampCommentsController < ApplicationController
  before_action :authenticate_admin!

  def show
    # @camp = Camp.find(params[:id])
    @camp_comment = CampComment.find(params[:camp_id])
  end

  def destroy
    CampComment.find(params[:camp_id]).destroy
    redirect_to admin_camp_path(params[:id])
  end

end
