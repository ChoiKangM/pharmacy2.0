class NoticesController < ApplicationController
  before_action :find_notice, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!
  def index
    @notices = Notice.order(created_at: :DESC).page(params[:page]).per(12)
  end

  def show
    @nreply = Nreply.new
    @nreplies = @notice.nreplies
  end

  def new
    @notice = Notice.new
  end
  def create
    if @notice = Notice.create(notice_params)
      flash['success'] = '게시글이 작성되었습니다.'
      redirect_to notice_path(@notice)
    else
      flash['danger'] = '글쓰기 실패. 다시 작성하세요'
      redirect_to new_notice_path
    end
  end
  def edit
  end
  def update
    if @notice.update(notice_params)
      flash['success'] = '게시글이 수정되었습니다.'
      redirect_to notice_path(params[:id])
    else
      flash['danger'] = '수정 실패. 다시 시도하세요'
      redirect_to edit_notice_path(params[:id])
    end
  end
  def destroy
    if @notice.destroy
      flash['alert'] = '게시글이 삭제되었습니다.'
      redirect_to notices_path
    else
      flash['danger'] = '삭제 실패. 다시 시도하세요'
      redirect_to notice_path(@notice)
    end
  end
  private
  def notice_params
    params.require(:notice).permit(:title,:content,:user_id)
  end
  def user_params
    params.require(:user).permit(:name, :email)
  end
  def find_notice
    @notice = Notice.find(params[:id])
  end
end
