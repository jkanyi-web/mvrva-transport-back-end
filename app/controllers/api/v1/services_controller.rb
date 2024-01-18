class Api::V1::ServicesController < ApplicationController
  def index
    render json: { services: Service.all }
  end
end
