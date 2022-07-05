class Admin::CampsController < ApplicationController
  before_action :authenticate_admin!

  # def index
  #   @camps = Camp.all.page(params[:page]).per(3)
  # end

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
    else
      @camps = Camp.all.page(params[:page]).order(created_at: :desc).per(6)
    end
      @value = params[:area]
  end

  def show
    @camp = Camp.find(params[:id])
    @camp_comment = CampComment.new
    @camp_comments = @camp.camp_comments.page(params[:page]).per(3)
  end

  def new
    @camp = Camp.new
  end

  def create
    @camp = Camp.new(camp_params)
    @camp.admin_id = current_admin.id #ログイン中のユーザーの情報を取得

    if @camp.save
      redirect_to admin_camps_path, notice: "キャンプ場の登録に成功しました"
    else
      render :new
    end
  end

  def edit
    @camp = Camp.find(params[:id])
  end

  def update
    @camp = Camp.find(params[:id])
    if @camp.update(camp_params)
      redirect_to admin_camp_path(@camp.id), notice: "キャンプ場の更新に成功しました"
    else
      render 'edit'
    end
  end

  def destroy
    @camp = Camp.find(params[:id])
    @camp.destroy
    redirect_to admin_camps_path, notice: "キャンプ場の削除に成功しました"
  end

  private
  def camp_params
    params.require(:camp).permit(:admin_id, :name, :address, :phone_number, :area, :latitude, :longitude, :parking, :camp_image)
  end
end
