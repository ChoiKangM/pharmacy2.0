class HsearchesController < ApplicationController
  def result
    @hsearches = eval(params[:hbulletin]).where('created_at >= :years_ago', :years_ago => Time.now - 1.years).where("title like ?", "%#{params[:hsearch_text]}%").order(created_at: :DESC).page(params[:page]).per(12)
    @handouts = Handout.order(created_at: :DESC)
  end
end
