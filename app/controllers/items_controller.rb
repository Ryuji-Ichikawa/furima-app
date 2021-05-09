class ItemsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @items = Item.order('created_at DESC')
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :info, :price, :category_id, :status_id, :shipping_fee_id, :prefecture_id,
                                 :scheduled_delivery_id).merge(user_id: current_user.id)
  end
end
