class CardsController < ApplicationController
  before_action :find_card, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
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
    @card = Card.create(card_params)
    redirect_to cards_path
  end
  def edit
  end
  def update
    @card.update(card_params)
    redirect_to card_path
  end
  def destroy
    @card.destroy  
    redirect_to cards_path
  end
  private
  def card_params
    params.require(:card).permit(:title, :content, :user_id, :image)
  end
  def user_params
    params.require(:user).permit(:nickname, :email)
  end
  def find_card
    @card = Card.find(params[:id])
  end
end
