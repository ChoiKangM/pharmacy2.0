class AlumnusfeesController < ApplicationController
  before_action :find_alumnusfee, only:[:show,:edit,:update,:destory]
  before_action :authenticate_user!
  def index
    @alumnusfees = Alumnusfee.all.reverse
  end

  def show
  end

  def new
    @alumnusfee = Alumnusfee.new
  end

  def create
    @alumnusfee = Alumnusfee.create(alumnusfee_params)
    if @alumnusfee.save
      flash['success'] = '게시글이 작성되었습니다.'
      redirect_to alumnusfee_path(@alumnusfee)
    else
      flash['danger'] = '글쓰기 실패. 다시 작성하세요'
      redirect_to new_alumnusfee_path
    end
  end

  def edit
  end

  def update
    if @alumnusfee.update(alumnusfee_params)
      flash['success'] = '게시글이 수정되었습니다.'
      redirect_to alumnusfee_path(@alumnusfee)
    else
      flash['danger'] = '수정 실패. 다시 시도하세요'
      redirect_to edit_alumnusfee_path(@alumnusfee)
    end
  end

  def destroy
    if @alumnusfee.destroy
      flash['success'] = '게시글이 삭제되었습니다.'
      redirect_to alumnusfees_path
    else
      flash['danger'] = '삭제 실패. 다시 시도하세요'
      redirect_to alumnusfee_path(@alumnusfee)
    end
  end
  private
  def find_alumnusfee
    @alumnusfee = Alumnusfee.find(params[:id])
  end
  def alumnusfee_params
    params.require(:alumnusfee).permit(:title, :content, :user_id, {accounts: []})
  end
end
