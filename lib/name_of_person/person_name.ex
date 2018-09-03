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
      iex> NameOfPerson.PersonName.full("Mitch Stanley")
      "Mitch Stanley"
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
  def full(name), do: full(convert_string_to_name(name))

  @doc """
  Returns first name and last initial, E.g. "Mitch S.".

  ## Examples

    iex> NameOfPerson.PersonName.familiar("Mitch", "Stanley")
    "Mitch S."
    iex> NameOfPerson.PersonName.familiar("Mitch Stanley")
    "Mitch S."
    iex> NameOfPerson.PersonName.familiar("Mitch")
    "Mitch"
    iex> NameOfPerson.PersonName.familiar("Mitch Blank Stanley")
    "Mitch S."
    iex> NameOfPerson.PersonName.familiar(%NameOfPerson.PersonName{first_name: "Mitch", last_name: "Stanley"})
    "Mitch S."
  """
  def familiar(first, last), do: familiar(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def familiar(first, middle, last), do: familiar(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})
  def familiar([first]), do: familiar(%NameOfPerson.PersonName{first_name: first})
  def familiar([first, last]), do: familiar(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def familiar([first, middle, last]), do: familiar(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def familiar(person = %NameOfPerson.PersonName{last_name: ""}), do: "#{String.trim(person.first_name)}"
  def familiar(person = %NameOfPerson.PersonName{}) do
    "#{String.trim(person.first_name)} #{String.first(String.trim(person.last_name))}."
  end
  def familiar(name) do
    name
    |> convert_string_to_name()
    |> familiar()
  end


  @doc """
  Returns first  initial and last name, E.g. "M. Stanley".

  ## Examples

    iex> NameOfPerson.PersonName.abbreviated("Mitch", "Stanley")
    "M. Stanley"
    iex> NameOfPerson.PersonName.abbreviated(%NameOfPerson.PersonName{first_name: "Mitch", last_name: "Stanley"})
    "M. Stanley"
    iex> NameOfPerson.PersonName.abbreviated("Mitch")
    "Mitch"
    iex> NameOfPerson.PersonName.abbreviated("Mitch Stanley")
    "M. Stanley"
    iex> NameOfPerson.PersonName.abbreviated("Mitch Blank Stanley")
    "M. Stanley"
  """
  def abbreviated(first, last), do: abbreviated(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def abbreviated(first, middle, last), do: abbreviated(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})
  def abbreviated([first]), do: abbreviated(%NameOfPerson.PersonName{first_name: first})
  def abbreviated([first, last]), do: abbreviated(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def abbreviated([first, middle, last]), do: abbreviated(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def abbreviated(person = %NameOfPerson.PersonName{last_name: ""}), do: "#{String.trim(person.first_name)}"
  def abbreviated(person = %NameOfPerson.PersonName{}) do
    "#{String.first(String.trim(person.first_name))}. #{String.trim(person.last_name)}"
  end
  def abbreviated(name) do
    name
    |> String.split(" ", trim: true)
    |> abbreviated()
  end


  @doc """
  Returns first  initial and last name, E.g. "M. Stanley".

  ## Examples

    iex> NameOfPerson.PersonName.convert_string_to_name("Mitch Quantum Firefox Stanley")
    %NameOfPerson.PersonName{first_name: "Mitch", middle_name: "Quantum Firefox", last_name: "Stanley"}
  """
  def convert_string_to_name(name) do
    name
    |> String.split(" ", trim: true)
    |> _convert_string_to_name()
  end
  defp _convert_string_to_name([first_name | tail] = name) when is_list(name) and length(name) > 2 do
    [last_name | middle_names ] = Enum.reverse(tail)
    middle_names = Enum.reverse(middle_names)
    %NameOfPerson.PersonName{first_name: first_name, middle_name: Enum.join(middle_names, " "),last_name: last_name }
  end
  defp _convert_string_to_name([first, last]), do: %NameOfPerson.PersonName{first_name: first, last_name: last}
  defp _convert_string_to_name([first]), do: %NameOfPerson.PersonName{first_name: first}
end
