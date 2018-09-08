# frozen_string_literal: true
require 'byebug'

class AttendancesController < ApplicationController
  def index
    @attendances = Attendance.all
  end

  def create
    byebug
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      render :show
    else
      render :new
    end
  end

  def new
    @attendance = Attendance.new
  end

  def attendances_per_employee
    @user = User.find(params[:user_id])
    @user_attendances = @user.attendances
  end

  private

  def attendance_params
    params.require(:attendance).permit(
      :first_name,
      :last_name,
      :clock_in_at,
      :clock_out_at,
      :user_id
    )
  end
end
