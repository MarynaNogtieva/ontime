# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttendancesController, type: :controller do
  let(:user) { create(:user) }
  let(:attendance) { create(:attendance, user: user) }

  describe 'GET#index' do
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
      byebug
      expect do
        post :create,
             params: {
              attendance: @acceptance_params
             }
      end.to change(Attendance, :count).by(1)
    end
  end

  describe 'GET#new' do
    before { get :new }

    it 'assigns a new attendance' do
      expect(assigns(:attendance)).to be_a_new(Attendance)
    end
  end

  # describe 'GET#show' do
  #   before { get :show, params: { id: attendance } }

  #   it 'assigns the requested attendance' do
  #     expect(assigns(:question)).to eq question
  #   end
  # end
end
