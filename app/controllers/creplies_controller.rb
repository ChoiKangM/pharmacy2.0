class CrepliesController < ApplicationController
  before_action :find_creply, only: [:destroy]
  def create
    @creply = Creply.create(creply_params)
    if @creply.save
        flash['success'] = '댓글이 작성되었습니다.'
        redirect_to card_path(params[:card_id])
    else
        flash['danger'] = '댓글을 작성하세요'
        redirect_to :back
    end
  end
  def destroy
    if @creply.destroy
        flash['alert'] = '댓글이 삭제되었습니다.'
        redirect_to :back
    else
        flash['danger'] = '다시 시도하세요'
        redirect_to :back
    end
  end
  private
  def creply_params
    params.require(:creply).permit(:content, :user_id, :card_id)
  end
  def find_creply
    @creply = Creply.find(params[:id])
  end
end
