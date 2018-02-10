class HandoutsController < ApplicationController
  before_action :find_handout, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  def index
    @handouts = Handout.order(created_at: :DESC).page(params[:page]).per(12)
  end

  def show
    @hreply = Hreply.new
    @hreplies = @handout.hreplies
  end

  def new
    @handout = Handout.new
  end
  def create
    if @handout = Handout.create(handout_params)
      flash['success'] = '게시글이 작성되었습니다.'
      redirect_to handout_path(@handout)
    else
      flash['danger'] = '글쓰기 실패. 다시 작성하세요'
      redirect_to new_handout_path
    end
  end
  def edit
  end
  def update
    if @handout.update(handout_params)
      flash['success'] = '게시글이 수정되었습니다.'
      redirect_to handout_path(params[:id])
    else
      flash['danger'] = '수정 실패. 다시 시도하세요'
      redirect_to edit_handout_path(params[:id])
    end
  end
  def destroy
    if @handout.destroy
      flash['alert'] = '게시글이 삭제되었습니다.'
      redirect_to handouts_path
    else
      flash['danger'] = '삭제 실패. 다시 시도하세요'
      redirect_to handout_path(@handout)
    end
  end
  private
  def handout_params
    params.require(:handout).permit(:title,:content,:user_id,:file)
  end
  def user_params
    params.require(:user).permit(:name, :email)
  end
  def find_handout
    @handout = Handout.find(params[:id])
  end
end
