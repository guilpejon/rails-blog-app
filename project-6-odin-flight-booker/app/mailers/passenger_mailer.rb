class PassengerMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def ticket_confirmation_email
    @passenger = params[:passenger]
    @flight = params[:flight]
    mail(to: @passenger.email, subject: 'Ticket Confirmation Email')
  end
end
