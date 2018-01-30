class NoticesController < ApplicationController
  before_action :find_notice, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
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
    @notice = Notice.create(notice_params)
    redirect_to notices_path
  end
  def edit
  end
  def update
    @notice.update(notice_params) 
    redirect_to notices_path
  end
  def destroy
    @notice.destroy
    redirect_to notices_path
  end
  private
  def notice_params
    params.require(:notice).permit(:title,:content,:user_id)
  end
  def user_params
    params.require(:user).permit(:nickname, :email)
  end
  def find_notice
    @notice = Notice.find(params[:id])
  end
end
