class HsearchesController < ApplicationController
  def result
    @hsearches = eval(params[:bulletin]).where('created_at >= :years_ago', :years_ago => Time.now - 1.years).where("title like ?", "%#{params[:search_text]}%").order(created_at: :DESC).page(params[:page]).per(12)
    @handouts = Handout.order(created_at: :DESC)
  end
end
