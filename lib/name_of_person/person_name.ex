defmodule NameOfPerson.PersonName do
  defstruct first_name: "", middle_name: "", last_name: ""
  @moduledoc """
  Documentation for NameOfPerson.PersonName.
  """

  @doc """
  Get the full name.

  ## Examples

      iex> NameOfPerson.PersonName.full("Mitch")
      "Mitch"
      iex> NameOfPerson.PersonName.full("Mitch", "Stanley")
      "Mitch Stanley"
      iex> NameOfPerson.PersonName.full("Mitch", "Blank", "Stanley")
      "Mitch Blank Stanley"
      iex> NameOfPerson.PersonName.full(%NameOfPerson.PersonName{first_name: "Mitch", middle_name: "Blank", last_name: "Stanley"})
      "Mitch Blank Stanley"
      iex> NameOfPerson.PersonName.full(%NameOfPerson.PersonName{first_name: "Mitch", last_name: "Stanley"})
      "Mitch Stanley"
      iex> NameOfPerson.PersonName.full(%NameOfPerson.PersonName{first_name: "Mitch"})
      "Mitch"

  """
  def full(first, middle, last), do: full(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})
  def full(first, last), do: full(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def full(person = %NameOfPerson.PersonName{middle_name: ""}), do: String.trim("#{person.first_name} #{person.last_name}")
  def full(person = %NameOfPerson.PersonName{}), do: String.trim("#{person.first_name} #{person.middle_name} #{person.last_name}")
  def full(name), do: full(%NameOfPerson.PersonName{first_name: name})

end
