# frozen_string_literal: true

FactoryBot.define do
  factory :stats do
    counter { 0 }
    wins { 0 }
    loses { 0 }
    percentage { 0.0 }
  end
end
