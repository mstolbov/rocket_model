require 'test_helper'

describe RocketModel::Store::File do

  subject do
    RocketModel::Store::File.new path: "test/fixtures/test.pstore"
  end

  it "#all loads data from file" do
    assert !subject.all(table: "people").empty?
  end

  it "#create addes id to data" do
    data = subject.create({"name" => "Jimm"}, table: "people")
    assert_equal({"id" => 2, "name" => "Jimm"}, data)
  end

  it "#read"
  it "#update"
  it "#delete"
  it "#persist"

end
