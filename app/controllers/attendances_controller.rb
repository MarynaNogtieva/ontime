# frozen_string_literal: true
require 'byebug'

class AttendancesController < ApplicationController
  def index
    @attendances = Attendance.all
  end

  def show; end

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

  def attendance_params
    params.require(:attendance).permit(
      :first_name,
      :last_name,
      :checked_in_at,
      :checked_out_at,
      :user_id
    )
  end
end
