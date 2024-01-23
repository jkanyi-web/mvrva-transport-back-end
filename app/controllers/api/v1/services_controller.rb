class Api::V1::ServicesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create destroy]
  # user authorization
  # service/
  def index
    render json: { services: Service.all }
  end

  # user authorization
  # service/:id
  def show
    render json: { service: Service.find_by_id(params[:id]) }
  end

  # POST /service
  # admin authorization
  def create
    @service = current_user.services.new(service_params)
    if @service.save
      render json: { service: @service }
    else
      render json: { error: 'Service was not created.' }
    end
  end

  # admin authorization
  def destroy
    @service = current_user.services.find_by_id(params[:id])
    if @service.destroy
      render json: { data: 'Service was removed successfully', status: 'success' }, status: :ok
    else
      render json: { error: 'Service was not deleted.' }
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :image, :min_cost)
  end
end
