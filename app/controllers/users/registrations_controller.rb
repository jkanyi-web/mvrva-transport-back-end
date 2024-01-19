# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  protected

  def after_sign_up_path_for(resource)
    "/"
  end

  def after_update_path_for(resource)
    "/"
  end

  def respond_with(resource, options = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: "Signed up sucessfully.", data: resource}
      }, status: :ok
    else
      render json: {
        status: {message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end
end
