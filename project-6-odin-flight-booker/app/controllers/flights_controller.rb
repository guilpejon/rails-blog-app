class FlightsController < ApplicationController
  # GET /flights
  def index
    @airports = Airport.all
    @passenger_options = [1, 2, 3, 4]
    @flight_dates = Flight.select(:start_datetime).map { |f| f.start_datetime.to_date }.uniq.sort
    @selected_departure = params[:departure_airport_id]
    @selected_arrival = params[:arrival_airport_id]
    @selected_date = params[:flight_date]&.to_date
    @selected_passengers = params[:passenger_count]&.to_i
    @flights = Flight.search(
      params[:departure_airport_id],
      params[:arrival_airport_id],
      params[:passenger_count],
      params[:flight_date]
    )
  end
end
