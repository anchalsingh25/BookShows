class Api::V1::PaymentsController < ApplicationController
  before_action :authorized
  
  def index
    payments = Payment.all
    render json: payments
  end

  def create
    payment = Payment.new(payment_params)
    if payment.save
      render json: payment, status: :created
    else
      render json: { errors: payment.errors }, status: :unprocessable_entity
    end
  end

  def payment_params
    params.require(:payment).permit(:price, :event_id, :booking_id)
  end
end
