# frozen_string_literal: true
require 'byebug'

class AttendancesController < ApplicationController
  before_action :load_user, only: %i[attendances_per_employee]
  before_action :load_attendance, only: %i[edit update]

  def index
    @attendances = Attendance.all
  end

  def create
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      redirect_to employee_attendances_path(user_id: @attendance.user.id)
    else
      render :new
    end
  end

  def new
    @attendance = Attendance.new
  end

  def edit; end

  def update
    byebug
    if @attendance.update(attendance_params)
      redirect_to attendances_path
    else
      render :edit
    end
  end

  def attendances_per_employee
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

  def load_attendance
    @attendance = Attendance.find(params[:id])
  end

  def load_user
    @user = User.find(params[:user_id])
  end
end
