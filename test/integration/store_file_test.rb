require 'test_helper'

describe RocketModel::Store::File do

  subject do
    RocketModel::Store::File.new path: "test/fixtures/test.pstore"
  end

  it "#all loads data from file" do
    assert !subject.all(table: "people").empty?
  end

  it "#create addes id to data" do
    data = subject.create({"name" => "Bill"}, table: "people")
    assert_equal({"id" => 2, "name" => "Bill"}, data)
  end

  it "#read" do
    data = subject.read({"id" => 1}, table: "people")
    assert_equal([{"id" => 1, "name" => "Jimm"}], data)
  end

  it "#update" do
    data = subject.update(1, {"name" => "Bill"}, table: "people")
    assert_equal({"id" => 1, "name" => "Bill"}, data)

    data = subject.read({"id" => 1}, table: "people")
    assert_equal([{"id" => 1, "name" => "Bill"}], data)
  end

  it "#persist" do
    subject.update(1, {"name" => "Bill"}, table: "people")
    subject.persist

    store = subject.class.new path: "test/fixtures/test.pstore"
    data = store.read({"id" => 1}, table: "people")
    assert_equal([{"id" => 1, "name" => "Bill"}], data)

    # restore data
    subject.update(1, {"name" => "Jimm"}, table: "people")
    subject.persist
  end

  it "#delete" do
    data = subject.delete(1, table: "people")
    data = subject.read({"id" => 1}, table: "people")
    assert_equal([], data)
  end

end
