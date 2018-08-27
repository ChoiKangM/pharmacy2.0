class MakePublicsController < ApplicationController
  before_action :find_make_public, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @make_publics = MakePublic.all.reverse
  end
  def meeting
    @post_per_page = 12
    @meeting = MakePublic.order(id: :desc).where(:kind => '회의록').page(params[:page]).per(@post_per_page)
    @meeting_length = MakePublic.order(id: :desc).where(:kind => '회의록').length
    @page = params[:page].to_i
    
  end
  def account
    @post_per_page = 12
    @account = MakePublic.order(id: :desc).where(:kind => '회계자료').page(params[:page]).per(@post_per_page)
    @account_length = MakePublic.order(id: :desc).where(:kind => '회계자료').length
    @page = params[:page].to_i
  end
  def other
    @post_per_page = 12
    @other = MakePublic.order(id: :desc).where(:kind => '기타').page(params[:page]).per(@post_per_page)
    @other_length = MakePublic.order(id: :desc).where(:kind => '기타').length
    @page = params[:page].to_i
    
  end
  def rule
    @post_per_page = 12
    @rule = MakePublic.order(id: :desc).where(:kind => '운영규정').page(params[:page]).per(@post_per_page)
    @rule_length = MakePublic.order(id: :desc).where(:kind => '운영규정').length
    @page = params[:page].to_i
  end



  def show
  end

  def new
    @make_public = MakePublic.new
  end
  def create
    @make_public = MakePublic.new(make_public_params)
    if @make_public.save
      flash['success'] = '게시글이 작성되었습니다.'
      redirect_to make_public_path(@make_public)
    else
      flash['danger'] = '글쓰기 실패. 다시 작성하세요'
      redirect_to new_make_public_path
    end
  end
  def edit
  end
  def update
    if @make_public.update(make_public_params)
       flash['success'] = '게시글이 수정되었습니다.'
      redirect_to make_public_path(@make_public)
    else
      flash['danger'] = '수정 실패. 다시 시도하세요'
      redirect_to edit_make_public_path(@make_public)
    end
  end
  def destroy
    if @make_public.destroy  
      flash['alert'] = '게시글이 삭제되었습니다.'
      redirect_to make_publics_path
    else
      flash['alert'] = '삭제 실패. 다시 시도하세요'
      redirect_to make_public_path(@make_public)
    end
  end
  private
  def find_make_public
    @make_public = MakePublic.find(params[:id])
  end
  def make_public_params
    params.require(:make_public).permit(:title, :content,:user_id,:kind,{informations: []})
  end
end
