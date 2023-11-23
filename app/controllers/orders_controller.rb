class OrdersController < ApplicationController
before_action:authenticate_user!
before_action:move_to_index

 def index
  @item = Item.find(params[:item_id])
  @order_shipping_address = OrderShippingAddress.new
 end
   
  

  def create
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new(order_params)
      if @order_shipping_address.valid?
        Payjp.api_key = "sk_test_6d1c1fa00c7acaaf9ae87c49"
                         
        Payjp::Charge.create(
        amount: @item.item_price,  # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
       @order_shipping_address.save
        redirect_to root_path
      else 
        render :index, status: :unprocessable_entity
      end
  end

private

  def order_params
    params.require(:order_shipping_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id:current_user.id,item_id:@item.id, token: params[:token])
  end
  
  def move_to_index
    @item = Item.find(params[:item_id])
    if @item.present? && @item.order.present?
      redirect_to root_path
    end
  end
end

