defmodule NameOfPersonTest do
  use ExUnit.Case
  doctest NameOfPerson
  doctest NameOfPerson.PersonName


  test "first name" do
    assert NameOfPerson.PersonName.first(%NameOfPerson.PersonName{first_name: "John", middle_name: "Blank", last_name: "Smith"}) == "John"
    assert NameOfPerson.PersonName.first(%NameOfPerson.PersonName{first_name: "John", last_name: "Smith"}) == "John"
    assert NameOfPerson.PersonName.first(%NameOfPerson.PersonName{first_name: "John"}) == "John"
  end
  test "full name" do
    assert NameOfPerson.PersonName.full("john") == "john"
    assert NameOfPerson.PersonName.full("John") == "John"
    assert NameOfPerson.PersonName.full("john smith") == "john smith"
    assert NameOfPerson.PersonName.full("john", "smith") == "john smith"
    assert NameOfPerson.PersonName.full("john", "blank", "smith") == "john blank smith"
    assert NameOfPerson.PersonName.full(%NameOfPerson.PersonName{first_name: "John", middle_name: "Blank", last_name: "Smith"}) == "John Blank Smith"
    assert NameOfPerson.PersonName.full(%NameOfPerson.PersonName{first_name: "John", last_name: "Smith"}) == "John Smith"
    assert NameOfPerson.PersonName.full(%NameOfPerson.PersonName{first_name: "John"}) == "John"
    assert NameOfPerson.PersonName.full(["john"]) == "john"
    assert NameOfPerson.PersonName.full(["john", "smith"]) == "john smith"
    assert NameOfPerson.PersonName.full(["john", "blank", "smith"]) == "john blank smith"
  end

  test "familiar name" do
    assert NameOfPerson.PersonName.familiar(%NameOfPerson.PersonName{first_name: "John", last_name: "Smith"}) == "John S."
    assert NameOfPerson.PersonName.familiar(%NameOfPerson.PersonName{first_name: "John", middle_name: "Blank", last_name: "Smith"}) == "John S."
    assert NameOfPerson.PersonName.familiar(["John", "Blank", "Smith"]) == "John S."
    assert NameOfPerson.PersonName.familiar(["John",  "Smith"]) == "John S."
  end

  test "abbreviated name" do
    assert NameOfPerson.PersonName.abbreviated(%NameOfPerson.PersonName{first_name: "John", last_name: "Smith"}) == "J. Smith"
    assert NameOfPerson.PersonName.abbreviated(%NameOfPerson.PersonName{first_name: "John"}) == "John"
    assert NameOfPerson.PersonName.abbreviated(%NameOfPerson.PersonName{first_name: "John", middle_name: "Blank", last_name: "Smith"}) == "J. Smith"
    assert NameOfPerson.PersonName.abbreviated(["John"]) == "John"
    assert NameOfPerson.PersonName.abbreviated(["John", "Smith"]) == "J. Smith"
    assert NameOfPerson.PersonName.abbreviated(["John", "Blank", "Smith"]) == "J. Smith"
  end

  test "sorted name" do
    assert NameOfPerson.PersonName.sorted(%NameOfPerson.PersonName{first_name: "John", last_name: "Stanley"}) == "Stanley, John"
    assert NameOfPerson.PersonName.sorted(%NameOfPerson.PersonName{first_name: "John"}) == "John"
    assert NameOfPerson.PersonName.sorted(%NameOfPerson.PersonName{first_name: "John", middle_name: "Blank", last_name: "Smith"}) == "Smith, John"
    assert NameOfPerson.PersonName.sorted(["John", "Blank", "Smith"]) == "Smith, John"
    assert NameOfPerson.PersonName.sorted(["John", "Smith"]) == "Smith, John"
    assert NameOfPerson.PersonName.sorted(["John"]) == "John"
  end

  test "possessive name" do
    assert NameOfPerson.PersonName.possessive(%NameOfPerson.PersonName{first_name: "John", last_name: "Stanley"}) == "John Stanley's"
    assert NameOfPerson.PersonName.possessive(%NameOfPerson.PersonName{first_name: "John", middle_name: "Blank", last_name: "Smith"}) == "John Blank Smith's"
    assert NameOfPerson.PersonName.possessive(["John", "Blank", "Smith"]) == "John Blank Smith's"
    assert NameOfPerson.PersonName.possessive(["John", "Smith"]) == "John Smith's"
    assert NameOfPerson.PersonName.possessive(["John"]) == "John's"
  end

  test "possessive name ending with S" do
    assert NameOfPerson.PersonName.possessive(%NameOfPerson.PersonName{first_name: "Ned", last_name: "Flanders"}) == "Ned Flanders'"
    assert NameOfPerson.PersonName.possessive(%NameOfPerson.PersonName{first_name: "Luke", middle_name: "Thomas", last_name: "Jones"}) == "Luke Thomas Jones'"
    assert NameOfPerson.PersonName.possessive(["Ned", "Flanders"]) == "Ned Flanders'"
    assert NameOfPerson.PersonName.possessive(["Luke", "Thomas", "Jones"]) == "Luke Thomas Jones'"
    assert NameOfPerson.PersonName.possessive(["Alexis"]) == "Alexis'"
  end

  test "initials of name" do
    assert NameOfPerson.PersonName.initials(%NameOfPerson.PersonName{first_name: "John", last_name: "Smith"}) == "JS"
    assert NameOfPerson.PersonName.initials(%NameOfPerson.PersonName{first_name: "John", middle_name: "Blank", last_name: "Smith"}) == "JBS"
    assert NameOfPerson.PersonName.initials("John Quantum Firefox Smith") == "JQFS"
    assert NameOfPerson.PersonName.initials(["John", "Quantum Firefox", "Smith"]) == "JQFS"
    assert NameOfPerson.PersonName.initials(%NameOfPerson.PersonName{first_name: "John", middle_name: "Quantum Firefox", last_name: "Smith"}) == "JQFS"
  end

  test "last name" do
      assert NameOfPerson.PersonName.last(%NameOfPerson.PersonName{first_name: "John", middle_name: "Blank", last_name: "Smith"}) == {:ok, "Smith"}
      assert NameOfPerson.PersonName.last!(%NameOfPerson.PersonName{first_name: "John", last_name: "Smith"}) == "Smith"
      assert NameOfPerson.PersonName.last!(%NameOfPerson.PersonName{first_name: "John"}) == nil
  end

  test "return mentionable name" do
    assert NameOfPerson.PersonName.mentionable("John Quantum Firefox Smith") == "johns"
    assert NameOfPerson.PersonName.mentionable(["John", "Quantum Firefox", "Smith"]) == "johns"
    assert NameOfPerson.PersonName.mentionable(%NameOfPerson.PersonName{first_name: "John", middle_name: "Quantum Firefox", last_name: "Smith"}) == "johns"
    assert NameOfPerson.PersonName.mentionable(%NameOfPerson.PersonName{first_name: "John", last_name: "Smith"}) == "johns"
    assert NameOfPerson.PersonName.mentionable(%NameOfPerson.PersonName{first_name: "John", middle_name: "Blank", last_name: "Smith"}) == "johns"
  end
end
