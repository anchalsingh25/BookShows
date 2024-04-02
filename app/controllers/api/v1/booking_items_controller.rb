class Api::V1::BookingItemsController < ApplicationController
  def index
    booking_items = BookingItem.all
    render json: booking_items
  end

  def create
    booking_item = BookingItem.new(booking_item_params)
    if booking_item.save
      render json: booking_item, status: :created
    else
      render json: { errors: booking_item.errors }, status: :unprocessable_entity
    end
  end

  private

  def booking_item_params
    params.require(:booking_item).permit(:event_id, :location_id, :quantity)
  end
end
