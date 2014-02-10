class OrdersController < ApplicationController
  def index
    if current_user
      @orders = current_user.orders
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
