class Customers::SessionsController < Devise::SessionsController
  # ゲストログイン機能
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to camps_path, notice: 'guestuserでログインしました。'
  end
end
