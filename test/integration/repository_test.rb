require 'test_helper'
require 'models/person'

module RocketModel
  class TestRepositiry < Repository
    def persist
      # do nothing
    end
  end
end

describe RocketModel::Repository do

  before do
    Person.repository = RocketModel::TestRepositiry
  end

  it "#all returns persons list" do
    persons = Person.all
    assert !persons.empty?
    assert_equal Person, persons.first.class
  end

  it "#find" do
    person = Person.find(1)
    assert !!person
    assert_equal 1, person.id
  end

  it "#find error" do
    assert_raises(RocketModel::RecordNotFound) { Person.find(2) }
  end

  it "#where"

  it "#create returns persisted object" do
    person = Person.create name: "Bill"
    assert_equal Person, person.class
    assert person.persisted?
  end

  it "#update"
  it "#delete"
  it "#persist"

end

