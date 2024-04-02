class Api::V1::PricesController < ApplicationController
  before_action :authorized
  before_action :set_price, only: %i[show update destroy]

  def index
    price = Price.all
    render json: price
  end

  def show
    render json: @price
  end

  def create
    if current_user.admin?
      price = Price.new(price_params)
      if price.save
        render json: price, status: :created
      else
        render json: price.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'only admin are allowed to create price' }, status: :forbidden
    end
  end

  def update
    if @price.update(price_params)
      render json: @price
    else
      render json: @price.error, status: :unprocessable_entity
    end
  end

  def destroy
    @price.destroy
    render json: { message: 'Price destroyed successfully !' }
    head :no_content
  end

  private

  def price_params
    params.require(:price).permit(:price)
  end

  def set_price
    @price = Price.find_by(id: params[:id])
    return render json: { error: 'price not found' }, status: :not_found if @price.nil?
  end
end
