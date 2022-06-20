class Public::HomesController < ApplicationController

  def top
    @camps = Camp.all.page(params[:page]).per(3)
  end
end
