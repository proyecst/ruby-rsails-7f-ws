# app/services/bookings/create_reservation_service.rb
module Bookings
  class CreateReservationService
    def initialize(room_id:, customer_name:, date:)
      @room_id = room_id
      @customer_name = customer_name
      @date = date
    end

    def call
      # Iniciamos una transacción para asegurar atomicidad
      ActiveRecord::Base.transaction do
        # .lock("FOR UPDATE") bloquea la fila en la DB hasta que termine la transacción
        room = Room.lock.find(@room_id)

        if room.bookings_count < room.capacity
          booking = room.bookings.create!(
            customer_name: @customer_name,
            start_date: @date
          )
          # Incrementamos el contador manualmente para validación rápida
          room.increment!(:bookings_count)
          
          return { success: true, booking: booking }
        else
          return { success: false, error: "No hay disponibilidad disponible." }
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      { success: false, error: e.message }
    end
  end
end