class Public::HomesController < ApplicationController

  def top
    # @camps = Camp.all.order(created_at: :desc).limit(3)
    # 人気キャンプ場の上位３件
    avg_camp_comments = CampComment.group(:camp_id).average(:rate)
    avg_order_camp_ids = avg_camp_comments.sort {|a,b| b[1]<=>a[1]}.to_h.keys
    @camps = Camp.where(id: avg_order_camp_ids).order_as_specified(id: avg_order_camp_ids).limit(3)
  end
end
