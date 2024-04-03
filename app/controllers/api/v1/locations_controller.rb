class Api::V1::LocationsController < ApplicationController
  before_action :authorized, only: %i[create update]
  before_action :check_admin, only: %i[create update]
  before_action :set_location, only: %i[update destroy]

  def index
    locations = Location.all
    render json: locations
  end

  def create
    location = Location.new(location_params)
    if location.save
      render json: location, status: :created
    else
      render json: { errors: location.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @location.update(location_params)
      render json: @location
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @location.destroy
    render json: { message: 'location successfully deleted' }, status: :ok
  end

  private

  def location_params
    params.require(:location).permit(:city)
  end

  def set_location
    @location = Location.find_by_id(params[:id])
    return render json: { error: 'location not found' }, status: :not_found if @location.nil?
  end
end
