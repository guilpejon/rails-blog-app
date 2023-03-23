class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]

  def show
    @events = @user.attended_events.includes(:creator)
    @upcoming_events = @user.attended_events.upcoming
    @past_events = @user.attended_events.past
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
