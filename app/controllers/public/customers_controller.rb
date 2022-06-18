class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :show]
  before_action :ensure_guest_user, only: [:edit, :show]

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id), notice: "会員の更新に成功しました"
    else
      render "edit"
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :introduction, :profile_image)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer.id == current_customer.id
      redirect_to customers_path
    end
  end

  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.email == "guest@example.com"
      redirect_to customers_path, notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
