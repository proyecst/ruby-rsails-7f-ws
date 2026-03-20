# app/controllers/api/v1/bookings_controller.rb
class Api::V1::BookingsController < ApplicationController
  def create
    result = Bookings::CreateReservationService.new(
      room_id: params[:room_id],
      customer_name: params[:customer_name],
      date: params[:date]
    ).call

    if result[:success]
      render json: result[:booking], status: :created
    else
      render json: { error: result[:error] }, status: :unprocessable_entity
    end
  end
end