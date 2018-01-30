class HandoutsController < ApplicationController
  before_action :find_handout, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  
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
    @handout = Handout.create(handout_params)
    redirect_to handouts_path
  end
  def edit
  end
  def update
    @handout.update(handout_params)
    redirect_to handout_path
  end
  def destroy
    @handout.destroy
    redirect_to handouts_path
  end
  private
  def handout_params
    params.require(:handout).permit(:title,:content,:user_id,:file)
  end
  def user_params
    params.require(:user).permit(:nickname, :email)
  end
  def find_handout
    @handout = Handout.find(params[:id])
  end
end
