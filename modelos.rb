# db/migrate/20260320_create_rooms.rb
class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :capacity
      t.integer :bookings_count, default: 0 # Para tracking rápido
      t.timestamps
    end
  end
end

# db/migrate/20260320_create_bookings.rb
class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :room, null: false, foreign_key: true
      t.string :customer_name
      t.date :start_date
      t.timestamps
    end
  end
end