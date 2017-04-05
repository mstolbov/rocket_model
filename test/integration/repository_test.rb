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

  it "#all returns Person list" do
    people = Person.all
    assert !people.empty?
    assert_equal Person, people.first.class
  end

  it "#find" do
    person = Person.find(1)
    assert !!person
    assert_equal 1, person.id
  end

  it "#find error" do
    assert_raises(RocketModel::RecordNotFound) { Person.find(100) }
  end

  it "#where" do
    people = Person.where(name: "Jimm")
    assert !people.empty?
    assert_equal "Jimm", people.first.name
  end

  it "#create returns persisted object" do
    person = Person.create name: "Bill"
    assert_equal Person, person.class
    assert person.persisted?
  end

  it "#create persist new object" do
    person = Person.new name: "July"
    person.save
    assert person.persisted?
  end

  it "#update" do
    person = Person.find(1)
    person.name = "Bill"
    person.save
    assert "Bill", Person.find(1).name

    person.update(name: "Jimm")
    assert "Jimm", Person.find(1).name
  end

  it "#delete" do
    person = Person.create(name: "Moe")
    person.delete

    assert_raises(RocketModel::RecordNotFound) {Person.find(person.id)}
  end

end

