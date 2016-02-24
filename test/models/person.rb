class Person < RocketModel::Base

  attribute :name, :String
  attribute :role, :Symbol, default: :user
end
