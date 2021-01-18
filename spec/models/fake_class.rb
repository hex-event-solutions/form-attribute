# frozen_string_literal: true

class FakeClass

  extend FormAttribute

  attribute :one, String, default: 'one'
  attribute :two, Float, default: 1.2
  attribute :three, Integer

end
