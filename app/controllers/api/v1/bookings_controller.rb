class Api::V1::BookingsController < ApplicationController
  before_action :authorized

  def index
    bookings = Booking.all
    render json: bookings
  end

  def create
    booking = Booking.new(booking_params)
    booking.user_id = current_user.id
    if booking.save
      render json: booking, status: :created
    else
      render json: { errors: booking.errors }, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:booking_item_id)
  end
end
