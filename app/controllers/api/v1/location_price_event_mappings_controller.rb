class Api::V1::LocationPriceEventMappingsController < ApplicationController
  before_action :authorized
  before_action :set_lpe, only: %i[update destroy]
  def index
    lpe = LocationPriceEventMapping.all
    render json: lpe
  end

  def create
    lpe = LocationPriceEventMapping.new(lpe_params)
    return unless current_user.admin?

    if lpe.save
      render json: lpe, status: :created
    else
      render json: { errors: lpe.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @lpe.update(lpe_params)
      render json: @lpe
    else
      render json: @lpe.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @lpe.destroy
    render json: { message: 'location price event mapping deleted' }, status: :ok
  end

  private

  def lpe_params
    params.require(:locationPriceEventMappings).permit(:event_id, :location_id, :price_id)
  end

  def set_lpe
    @lpe = LocationPriceEventMapping.find_by_id(params[:id])
    return render json: { error: 'mapping not found' }, status: :not_found if @lpe.nil?
  end
end
