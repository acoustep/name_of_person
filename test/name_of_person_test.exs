defmodule NameOfPersonTest do
  use ExUnit.Case
  doctest NameOfPerson
  doctest NameOfPerson.PersonName

  test "full name" do
    assert NameOfPerson.PersonName.full("mitch") == "mitch"
    assert NameOfPerson.PersonName.full("mitch stanley") == "mitch stanley"
    assert NameOfPerson.PersonName.full("mitch", "stanley") == "mitch stanley"
    assert NameOfPerson.PersonName.full("mitch", "blank", "stanley") == "mitch blank stanley"
  end
end
