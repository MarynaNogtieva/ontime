# frozen_string_literal: true

FactoryBot.define do
  factory :attendance do
    sequence(:first_name) { |n| "FN #{n}" }
    sequence(:last_name) { |n| "LN #{n}" }
    user
  end
end
