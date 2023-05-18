class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show]

  # GET /bookings
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  def show; end

  # GET /bookings/new
  def new
    @flight = Flight.find(params[:flight_id])
    @num_passengers = @flight.passenger_count
    @booking = @flight.bookings.build
    @num_passengers.times { @booking.passengers.build }
  end

  # POST /bookings
  def create
    @flight = Flight.find(params[:flight_id])
    @booking = @flight.bookings.new(booking_params)

    if @booking.save!
      @booking.update(num_passengers: @booking.passengers.count)
      @booking.passengers.each do |passenger|
        PassengerMailer.with(passenger:, booking: @booking, flight: @flight).ticket_confirmation_email.deliver_later
      end
      redirect_to @booking, notice: 'Booking was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: %i[name email])
  end
end
