class OrdersController < ApplicationController

 def index
  @item = Item.find(params[:item_id])
 end

  def new
    @order_dhipping_address = OrderShippingAddress.new
  end

  def create
    @order_dhipping_address = OrderShippingAddress.new(order_params)
      if @order_dhipping_address.valid?
        redirect_to root_path
      else 
        render :new,status:unprocessable_entity
    end
  end

private

  def order_params
    params.require(:order_dhipping_address).permit(:postal_code, :prefecture_id, :city,:addresses, :building, :phone_number).merge(user_id:current_user_id)
  end
end

