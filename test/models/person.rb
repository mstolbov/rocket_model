class Person
  include RocketModel

  attribute :name, :String
  attribute :role, :Symbol, default: :user
end
