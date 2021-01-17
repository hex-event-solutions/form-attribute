# frozen_string_literal: true

class FakeClass

  extend FormAttribute

  attribute :one, String, default: 'one'
  attribute :two, Boolean, default: false
  attribute :three, Integer

end
