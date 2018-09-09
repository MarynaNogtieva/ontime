# frozen_string_literal: true

class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: %i[attendances_per_employee]
  before_action :load_attendance, only: %i[edit update destroy]

  respond_to :html
  respond_to :js, only: :destroy

  def index
    @attendances = Attendance.all
    respond_with(@attendances)
  end

  def create
    @attendance = Attendance.new(attendance_params)
    respond_with(@attendance.save, location: employee_attendances_path(user_id: @attendance.user.id) )
  end

  def new
    @attendance = Attendance.new
    respond_with @attendance
  end

  def edit; end

  def update
    @attendance.update(attendance_params)
    respond_with(@attendance, location: attendances_path )
  end

  def destroy
    @user = @attendance.user
    @attendance.destroy
    redirect_to employee_attendances_path(user_id: @user.id), format: 'js'
  end

  def attendances_per_employee
    @user_attendances = @user.attendances
    respond_with(@user_attendances)
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
