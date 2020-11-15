class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :correct_user!, only: [:index]
  before_action :item_sold, only: [:index]
  before_action :params_find_item_id, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save(current_user, params_find_item_id)
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def correct_user!
    redirect_to root_path if current_user.id == params_find_item_id.user_id
  end

  def item_sold
    redirect_to root_path if params_find_item_id.order.present?
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture, :city, :street_number, :building_number, :phone_number).merge(token: params[:token])
  end

  def params_find_item_id
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
