class Api::V1::CartsController < ApplicationController
  before_action :authorized
  before_action :set_cart, only: %i[show update destroy]

  def index
    carts = current_user.carts
    render json: carts
  end

  def show
    render json: @cart
  end

  def create
    cart = current_user.carts.build(cart_params)
    if cart.save
      render json: cart, status: :created
    else
      render json: { errors: cart.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @cart.update(cart_params)
      render json: @cart
    else
      render json: { errors: @cart.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @cart.destroy
    render json: { message: 'Cart successfully deleted' }, status: :ok
  end

  private

  def cart_params
    params.require(:cart).permit(:event_id, :price_id, :quantity)
  end

  def set_cart
    @cart = current_user.carts.find_by(id: params[:id])
    render json: { error: 'Cart not found' }, status: :not_found unless @cart
  end
end
