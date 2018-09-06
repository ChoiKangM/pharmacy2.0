class CardsController < ApplicationController
  before_action :find_card, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!
  def index
    @cards = Card.order(created_at: :DESC).page(params[:page]).per(16)
  end

  def show
    @creply = Creply.new
    @creplies = @card.creplies
  end

  def new
    @card = Card.new
  end
  def create
    if @card = Card.create(card_params)
      flash['success'] = '게시글이 작성되었습니다.'
      redirect_to card_path(@card)
    else
      flash['danger'] = '글쓰기 실패. 다시 작성하세요'
      redirect_to new_card_path
    end
  end
  def edit
  end
  def update
    if @card.update(card_params)
      flash['success'] = '게시글이 수정되었습니다.'
      redirect_to card_path(@card)
    else
      flash['danger'] = '수정 실패. 다시 시도하세요'
      redirect_to edit_card_path(@card)
    end
  end
  def destroy
    if @card.destroy  
      flash['alert'] = '게시글이 삭제되었습니다.'
      redirect_to cards_path
    else
      flash['alert'] = '삭제 실패. 다시 시도하세요'
      redirect_to card_path(@card)
    end
  end
  private
  def card_params
    params.require(:card).permit(:title, :content, :user_id,{images: []})
  end
  def user_params
    params.require(:user).permit(:name, :email)
  end
  def find_card
    @card = Card.find(params[:id])
  end
end
