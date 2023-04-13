class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: 'Airport'
  belongs_to :arrival_airport, class_name: 'Airport'
  has_many :bookings

  validates_presence_of :start_datetime, :flight_duration

  def self.search(departure_airport_id, arrival_airport_id, passenger_count, flight_date)
    flights = Flight.all
    flights = flights.where(departure_airport_id:) if departure_airport_id.present?
    flights = flights.where(arrival_airport_id:) if arrival_airport_id.present?
    flights = flights.where('passenger_count >= ?', passenger_count) if passenger_count.present?
    if flight_date.present?
      flights = flights.where(
        start_datetime: Date.parse(flight_date).beginning_of_day..Date.parse(flight_date).end_of_day
      )
    end
    flights
  end
end
