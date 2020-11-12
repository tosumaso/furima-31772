class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :correct_user!, only: [:edit]
  before_action :params_find, only: [:show, :edit, :update, :destroy]

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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render action: :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id
    @item.destroy
    redirect_to root_path
    end
  end

  private

  def params_find
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image, :price, :name, :item_detail, :category_id, :status_id, :delivery_charge_id, :delivery_source_id, :delivery_estimated_id).merge(user_id: current_user.id)
  end

  def correct_user!
    redirect_to root_path unless current_user.id == Item.find(params[:id]).user_id
  end
end
