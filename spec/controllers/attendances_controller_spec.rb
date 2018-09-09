# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttendancesController, type: :controller do
  let(:user) { create(:user) }
  let(:attendance) { create(:attendance, user: user) }

  describe 'GET#index' do
    sign_in_user
    let(:attendance_list) { create_list(:attendance, 3, user: user) }

    before { get :index }

    it 'shows the clockin/clockout list of all users' do
      expect(assigns(:attendances)).to match_array(attendance_list)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'POST#create' do
    sign_in_user

    before do
      @acceptance_params = {
        first_name: 'Bob',
        last_name: 'Tomson',
        user_id: user.id,
        clock_in_at: Time.now.utc,
        clock_out_at: Time.now.utc
      }
    end

    it 'saves new attendance reccord to DB' do
      expect do
        post :create,
             params: {
              attendance: @acceptance_params
             }
      end.to change(Attendance, :count).by(1)
    end
  end

  describe 'GET#new' do
    sign_in_user
    before { get :new }

    it 'assigns a new attendance' do
      expect(assigns(:attendance)).to be_a_new(Attendance)
    end
  end

  describe 'GET#attendances_per_employee' do
    sign_in_user
    let(:attendance_list) { create_list(:attendance, 3, user: user) }
    before { get :attendances_per_employee, params: { user_id: user } }

    it 'assigns the requested attendance' do
      expect(assigns(:user_attendances)).to eq attendance_list
    end

    it 'renders show view' do
      expect(response).to render_template :attendances_per_employee
    end
  end

  describe 'GET #edit' do
    sign_in_user
    before { get :edit, params: { id: attendance.id } }

    it 'assigns the requested attendance to @attendance' do
      expect(assigns(:attendance)).to eq attendance
    end

    it 'render new edit' do
      expect(response).to render_template :edit
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    before { attendance }

    it 'deletes question' do
      expect { delete :destroy, params: { id: attendance, format: :js } }.to change(Attendance, :count).by(-1)
    end
  end
end

