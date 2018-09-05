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
  def full(name) when is_binary(name), do: name |> convert_string_to_name |> full
  def full(first, middle, last), do: full(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})
  def full(first, last), do: full(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def full(person = %NameOfPerson.PersonName{middle_name: ""}), do: String.trim("#{person.first_name} #{person.last_name}")
  def full(person = %NameOfPerson.PersonName{}), do: String.trim("#{person.first_name} #{person.middle_name} #{person.last_name}")

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
  def familiar(name) when is_binary(name), do: name |> convert_string_to_name |> familiar
  def familiar(first, last), do: familiar(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def familiar(first, middle, last), do: familiar(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})
  def familiar([first]), do: familiar(%NameOfPerson.PersonName{first_name: first})
  def familiar([first, last]), do: familiar(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def familiar([first, middle, last]), do: familiar(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def familiar(person = %NameOfPerson.PersonName{last_name: ""}), do: "#{String.trim(person.first_name)}"
  def familiar(person = %NameOfPerson.PersonName{}), do: "#{String.trim(person.first_name)} #{String.first(String.trim(person.last_name))}."


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
  def abbreviated(name) when is_binary(name), do: name |> convert_string_to_name() |> abbreviated()
  def abbreviated(first, last), do: abbreviated(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def abbreviated(first, middle, last), do: abbreviated(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})
  def abbreviated([first]), do: abbreviated(%NameOfPerson.PersonName{first_name: first})
  def abbreviated([first, last]), do: abbreviated(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def abbreviated([first, middle, last]), do: abbreviated(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def abbreviated(person = %NameOfPerson.PersonName{last_name: ""}), do: "#{String.trim(person.first_name)}"
  def abbreviated(person = %NameOfPerson.PersonName{}) do
    "#{String.first(String.trim(person.first_name))}. #{String.trim(person.last_name)}"
  end

  @doc """
  Returns last then first name for sorting.

  ## Examples

    iex> NameOfPerson.PersonName.sorted("Mitch", "Stanley")
    "Stanley, Mitch"
    iex> NameOfPerson.PersonName.sorted(%NameOfPerson.PersonName{first_name: "Mitch", last_name: "Stanley"})
    "Stanley, Mitch"
    iex> NameOfPerson.PersonName.sorted("Mitch")
    "Mitch"
    iex> NameOfPerson.PersonName.sorted("Mitch Stanley")
    "Stanley, Mitch"
    iex> NameOfPerson.PersonName.sorted("Mitch Blank Stanley")
    "Stanley, Mitch"
  """
  def sorted(name) when is_binary(name), do: name |> convert_string_to_name |> sorted
  def sorted(first, last), do: sorted(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def sorted(first, middle, last), do: sorted(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})
  def sorted([first]), do: sorted(%NameOfPerson.PersonName{first_name: first})
  def sorted([first, last]), do: sorted(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def sorted([first, middle, last]), do: sorted(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def sorted(person = %NameOfPerson.PersonName{last_name: ""}), do: "#{String.trim(person.first_name)}"
  def sorted(person = %NameOfPerson.PersonName{}), do: "#{String.trim(person.last_name)}, #{String.trim(person.first_name)}"


  @doc """
  Returns full name with the trailing 's or ' if name ends in s.

  ## Examples

    iex> NameOfPerson.PersonName.possessive("Mitch", "Stanley")
    "Mitch Stanley's"
    iex> NameOfPerson.PersonName.possessive("Ned", "Flanders")
    "Ned Flanders'"
    iex> NameOfPerson.PersonName.possessive(%NameOfPerson.PersonName{first_name: "Mitch", last_name: "Stanley"})
    "Mitch Stanley's"
    iex> NameOfPerson.PersonName.possessive(%NameOfPerson.PersonName{first_name: "Ned", last_name: "Flanders"})
    "Ned Flanders'"
    iex> NameOfPerson.PersonName.possessive("Mitch")
    "Mitch's"
    iex> NameOfPerson.PersonName.possessive("Mitch Stanley")
    "Mitch Stanley's"
    iex> NameOfPerson.PersonName.possessive("Mitch Blank Stanley")
    "Mitch Blank Stanley's"
  """
  def possessive(name) when is_binary(name), do: name |> convert_string_to_name |> possessive
  def possessive(first, last), do: possessive(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def possessive(first, middle, last), do: possessive(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})
  def possessive([first]), do: possessive(%NameOfPerson.PersonName{first_name: first})
  def possessive([first, last]), do: possessive(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def possessive([first, middle, last]), do: possessive(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def possessive(person = %NameOfPerson.PersonName{last_name: ""}), do: _possessive("#{String.trim(person.first_name)}")
  def possessive(person = %NameOfPerson.PersonName{middle_name: ""}), do: _possessive("#{String.trim(person.first_name)} #{String.trim(person.last_name)}")
  def possessive(person = %NameOfPerson.PersonName{}), do: _possessive("#{String.trim(person.first_name)} #{String.trim(person.middle_name)} #{String.trim(person.last_name)}")
  defp _possessive(person) when is_binary(person) do
    # reversed = person |> String.reverse |> List.first
    # IO.puts inspect(reversed)
    case person |> String.last do
      "s" -> "#{person}'"
      _ -> "#{person}'s"
    end
  end


  @doc """
  Generates a PersonName struct from a string.

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
    [last_name | middle_names ] = _fetch_other_names(tail)
    %NameOfPerson.PersonName{first_name: first_name, middle_name: middle_names,last_name: last_name }
  end
  defp _convert_string_to_name([first, last]), do: %NameOfPerson.PersonName{first_name: first, last_name: last}
  defp _convert_string_to_name([first]), do: %NameOfPerson.PersonName{first_name: first}

  defp _fetch_other_names(name) when is_list(name) do
    [last_name | middle_names ] = Enum.reverse(name)
    middle_names = Enum.reverse(middle_names) |> Enum.join(" ")
    [last_name | middle_names]
  end
end
