# spec/services/create_reservation_service_spec.rb
require 'rails_helper'

RSpec.describe Bookings::CreateReservationService do
  it "maneja múltiples peticiones simultáneas sin exceder la capacidad" do
    room = Room.create!(name: "Suite 101", capacity: 1)
    threads = []
    
    # Simulamos 5 personas intentando reservar 1 sola habitación al mismo tiempo
    5.times do |i|
      threads << Thread.new do
        ActiveRecord::Base.connection_pool.with_connection do
          Bookings::CreateReservationService.new(
            room_id: room.id,
            customer_name: "Cliente #{i}",
            date: Date.today
          ).call
        end
      end
    end

    threads.each(&:join)

    expect(room.reload.bookings.count).to eq(1) # Solo 1 debió tener éxito
  end
end
