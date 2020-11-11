class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :correct_user!, only: [:edit]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    else
      render action: :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :price, :name, :item_detail, :category_id, :status_id, :delivery_charge_id, :delivery_source_id, :delivery_estimated_id).merge(user_id: current_user.id)
  end

  def correct_user!
    redirect_to root_path unless current_user.id == Item.find(params[:id]).user_id
  end
end
