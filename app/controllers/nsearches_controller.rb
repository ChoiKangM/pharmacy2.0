class NsearchesController < ApplicationController
  def result
    @nsearches = eval(params[:nbulletin]).where('created_at >= :years_ago', :years_ago => Time.now - 1.years).where("title like ?", "%#{params[:nsearch_text]}%").order(created_at: :DESC).page(params[:page]).per(12)
    @notices = Notice.order(created_at: :DESC)
  end
end
