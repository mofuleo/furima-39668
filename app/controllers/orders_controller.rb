class OrdersController < ApplicationController

 def index
  @item = Item.find(params[:item_id])
  @order_shipping_address = OrderShippingAddress.new
 end
   
  

  def create
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new(order_params)
      if @order_shipping_address.valid?
       @order_shipping_address.save
        redirect_to root_path
      else 
        render :index, status: :unprocessable_entity
      end
  end

private

  def order_params
    params.require(:order_shipping_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id:current_user.id,item_id:@item.id)
  end
  
end

