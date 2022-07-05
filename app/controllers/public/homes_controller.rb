class Public::HomesController < ApplicationController

  def top
    @camps = Camp.all.order(created_at: :desc).limit(3)
  end
end
