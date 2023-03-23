class AttendancesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    attendance = Attendance.new(user: current_user, event: event)

    if attendance.save!
      flash[:success] = "You are now attending this event!"
    else
      flash[:error] = "Something went wrong. Please try again."
    end

    redirect_to event
  end

  def destroy
    event = Event.find(params[:event_id])
    attendance = Attendance.find_by(user: current_user, event: event)

    if attendance.destroy!
      flash[:success] = "You are no longer attending this event."
    else
      flash[:error] = "Something went wrong. Please try again."
    end

    redirect_to event
  end
end
