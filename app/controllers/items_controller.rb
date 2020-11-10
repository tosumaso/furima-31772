class ItemsController < ApplicationController
  before_action :move_to_signed_in, :only => [:new]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :action => :new
    end
  end

  private

  def move_to_signed_in
    redirect_to '/users/sign_in' unless user_signed_in?
  end

  def item_params
    params.require(:item).permit(:image, :price, :name, :item_detail, :category_id, :status_id, :delivery_charge_id, :delivery_source_id, :delivery_estimated_id).merge(:user_id => current_user.id)
  end
end
