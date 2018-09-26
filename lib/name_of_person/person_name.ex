defmodule NameOfPerson.PersonName do
  defstruct first_name: "", middle_name: nil, last_name: ""

  @moduledoc """
  Documentation for NameOfPerson.PersonName.
  """

  @doc """
  Get the first name.

  ## Examples

      iex> NameOfPerson.PersonName.first("John")
      "John"
      iex> NameOfPerson.PersonName.first("John Smith")
      "John"
      iex> NameOfPerson.PersonName.first("John", "Smith")
      "John"
      iex> NameOfPerson.PersonName.first("John", "Blank", "Smith")
      "John"

  """
  def first(first, middle, last),
    do: first(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})

  def first(first, last), do: first(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def first(name) when is_binary(name), do: name |> convert_string_to_name |> first

  def first(person = %NameOfPerson.PersonName{}),
    do: String.trim("#{String.trim(person.first_name)}")

  @doc """
  Get the full name.

  ## Examples

      iex> NameOfPerson.PersonName.full("John")
      "John"
      iex> NameOfPerson.PersonName.full("John Smith")
      "John Smith"
      iex> NameOfPerson.PersonName.full("John", "Smith")
      "John Smith"
      iex> NameOfPerson.PersonName.full("John", "Blank", "Smith")
      "John Blank Smith"
  """
  def full(first, middle, last),
    do: full(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})

  def full(first, last), do: full(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def full(name) when is_binary(name), do: name |> convert_string_to_name |> full
  def full([name]) when is_binary(name), do: name |> convert_string_to_name |> full

  def full([first_name, last_name]),
    do: full(%NameOfPerson.PersonName{first_name: first_name, last_name: last_name})

  def full([first_name, middle_name, last_name]),
    do:
      full(%NameOfPerson.PersonName{
        first_name: first_name,
        middle_name: middle_name,
        last_name: last_name
      })

  def full(person = %NameOfPerson.PersonName{middle_name: nil}),
    do: String.trim("#{person.first_name} #{person.last_name}")

  def full(person = %NameOfPerson.PersonName{}),
    do: String.trim("#{person.first_name} #{person.middle_name} #{person.last_name}")

  @doc """
  Returns first name and last initial, E.g. "John S.".

  ## Examples

      iex> NameOfPerson.PersonName.familiar("John", "Smith")
      "John S."
      iex> NameOfPerson.PersonName.familiar("John Smith")
      "John S."
      iex> NameOfPerson.PersonName.familiar("John")
      "John"
      iex> NameOfPerson.PersonName.familiar("John Blank Smith")
      "John S."

  """
  def familiar(first, last),
    do: familiar(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def familiar(first, middle, last),
    do:
      familiar(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})

  def familiar([first]), do: familiar(%NameOfPerson.PersonName{first_name: first})

  def familiar([first, last]),
    do: familiar(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def familiar([first, _middle, last]),
    do: familiar(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def familiar(name) when is_binary(name), do: name |> convert_string_to_name |> familiar

  def familiar(person = %NameOfPerson.PersonName{last_name: ""}),
    do: "#{String.trim(person.first_name)}"

  def familiar(person = %NameOfPerson.PersonName{}),
    do: "#{String.trim(person.first_name)} #{String.first(String.trim(person.last_name))}."

  @doc """
  Returns first  initial and last name, E.g. "M. Smith".

  ## Examples

      iex> NameOfPerson.PersonName.abbreviated("John", "Smith")
      "J. Smith"
      iex> NameOfPerson.PersonName.abbreviated("John")
      "John"
      iex> NameOfPerson.PersonName.abbreviated("John Smith")
      "J. Smith"
      iex> NameOfPerson.PersonName.abbreviated("John Blank Smith")
      "J. Smith"

  """
  def abbreviated(first, last),
    do: abbreviated(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def abbreviated(first, middle, last),
    do:
      abbreviated(%NameOfPerson.PersonName{
        first_name: first,
        middle_name: middle,
        last_name: last
      })

  def abbreviated([first]), do: abbreviated(%NameOfPerson.PersonName{first_name: first})

  def abbreviated([first, last]),
    do: abbreviated(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def abbreviated([first, _middle, last]),
    do: abbreviated(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def abbreviated(name) when is_binary(name),
    do: name |> convert_string_to_name() |> abbreviated()

  def abbreviated(person = %NameOfPerson.PersonName{last_name: ""}),
    do: "#{String.trim(person.first_name)}"

  def abbreviated(person = %NameOfPerson.PersonName{}) do
    "#{String.first(String.trim(person.first_name))}. #{String.trim(person.last_name)}"
  end

  @doc """
  Returns last then first name for sorting.

  ## Examples

      iex> NameOfPerson.PersonName.sorted("John", "Smith")
      "Smith, John"
      iex> NameOfPerson.PersonName.sorted("John")
      "John"
      iex> NameOfPerson.PersonName.sorted("John Smith")
      "Smith, John"
      iex> NameOfPerson.PersonName.sorted("John Blank Smith")
      "Smith, John"

  """
  def sorted(first, last),
    do: sorted(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def sorted(first, middle, last),
    do: sorted(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})

  def sorted([first]), do: sorted(%NameOfPerson.PersonName{first_name: first})

  def sorted([first, last]),
    do: sorted(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def sorted([first, _middle, last]),
    do: sorted(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def sorted(name) when is_binary(name), do: name |> convert_string_to_name |> sorted

  def sorted(person = %NameOfPerson.PersonName{last_name: ""}),
    do: "#{String.trim(person.first_name)}"

  def sorted(person = %NameOfPerson.PersonName{}),
    do: "#{String.trim(person.last_name)}, #{String.trim(person.first_name)}"

  @doc """
  Returns full name with the trailing 's or ' if name ends in s.

  ## Examples

      iex> NameOfPerson.PersonName.possessive("John", "Smith")
      "John Smith's"
      iex> NameOfPerson.PersonName.possessive(["Ned", "Flanders"])
      "Ned Flanders'"
      iex> NameOfPerson.PersonName.possessive("John")
      "John's"
      iex> NameOfPerson.PersonName.possessive("John Smith")
      "John Smith's"
      iex> NameOfPerson.PersonName.possessive("John Blank Smith")
      "John Blank Smith's"

  """
  def possessive(first, last),
    do: possessive(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def possessive(first, middle, last),
    do:
      possessive(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})

  def possessive([first]), do: possessive(%NameOfPerson.PersonName{first_name: first})

  def possessive([first, last]),
    do: possessive(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def possessive([first, middle, last]),
    do:
      possessive(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})

  def possessive(name) when is_binary(name), do: name |> convert_string_to_name |> possessive

  def possessive(person = %NameOfPerson.PersonName{last_name: ""}),
    do: _possessive("#{String.trim(person.first_name)}")

  def possessive(person = %NameOfPerson.PersonName{middle_name: nil}),
    do: _possessive("#{String.trim(person.first_name)} #{String.trim(person.last_name)}")

  def possessive(person = %NameOfPerson.PersonName{}),
    do:
      _possessive(
        "#{String.trim(person.first_name)} #{String.trim(person.middle_name)} #{
          String.trim(person.last_name)
        }"
      )

  defp _possessive(person) when is_binary(person) do
    # reversed = person |> String.reverse |> List.first
    # IO.puts inspect(reversed)
    case person |> String.last() do
      "s" -> "#{person}'"
      _ -> "#{person}'s"
    end
  end

  @doc """
  Checks if last name is available

  ## Examples

      iex> NameOfPerson.PersonName.has_last?("John", "Smith")
      true
      iex> NameOfPerson.PersonName.has_last?("John")
      false

  """
  def has_last?(first, middle, last),
    do:
      has_last?(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})

  def has_last?(first, last),
    do: has_last?(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def has_last?(name) when is_binary(name), do: name |> convert_string_to_name |> has_last?()

  def has_last?(%NameOfPerson.PersonName{last_name: ""}), do: false

  def has_last?(%NameOfPerson.PersonName{}), do: true

  @doc """
  Returns initials of full name

  ## Examples

      iex> NameOfPerson.PersonName.initials("John", "Smith")
      "JS"
      iex> NameOfPerson.PersonName.initials("John")
      "J"
      iex> NameOfPerson.PersonName.initials("John Smith")
      "JS"
      iex> NameOfPerson.PersonName.initials("John Smith")
      "JS"
      iex> NameOfPerson.PersonName.initials("John Blank Smith")
      "JBS"

  """
  def initials(first, last),
    do: initials(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def initials(first, middle, last),
    do:
      initials(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})

  def initials([first]), do: initials(%NameOfPerson.PersonName{first_name: first})

  def initials([first, last]),
    do: initials(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def initials([first, middle, last]),
    do:
      initials(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})

  def initials(name) when is_binary(name), do: name |> convert_string_to_name |> initials
  def initials(person = %NameOfPerson.PersonName{}), do: _initials(person)

  defp _initials(person = %NameOfPerson.PersonName{}) do
    case person do
      %NameOfPerson.PersonName{last_name: "", middle_name: nil} ->
        person.first_name
        |> _get_initial
        |> String.upcase()

      %NameOfPerson.PersonName{last_name: ""} ->
        (_get_initial(person.first_name) <> _get_initial(person.middle_name))
        |> String.upcase()

      %NameOfPerson.PersonName{middle_name: nil} ->
        (_get_initial(person.first_name) <> initials(person.last_name))
        |> String.upcase()

      _ ->
        (_get_initial(person.first_name) <>
           initials(person.middle_name) <> _get_initial(person.last_name))
        |> String.upcase()
    end
  end

  defp _get_initial(name), do: String.first(String.trim(name))

  @doc """
  Get the last name.

  ## Examples

      iex> NameOfPerson.PersonName.last("John Smith")
      {:ok, "Smith"}
      iex> NameOfPerson.PersonName.last("John", "Smith")
      {:ok, "Smith"}
      iex> NameOfPerson.PersonName.last("John")
      {:error, "No last name"}

  """
  def last(first, middle, last),
    do: last(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})

  def last(first, last), do: last(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def last(name) when is_binary(name), do: name |> convert_string_to_name |> last

  def last(%NameOfPerson.PersonName{last_name: ""}), do: {:error, "No last name"}

  def last(person = %NameOfPerson.PersonName{}),
    do: {:ok, String.trim("#{String.trim(person.last_name)}")}

  @doc """
  Get the last name or return nil.

  ## Examples
      iex> NameOfPerson.PersonName.last!("John Smith")
      "Smith"
      iex> NameOfPerson.PersonName.last!("John", "Smith")
      "Smith"
      iex> NameOfPerson.PersonName.last!("John")
      nil

  """
  def last!(first, middle, last),
    do: last!(%NameOfPerson.PersonName{first_name: first, middle_name: middle, last_name: last})

  def last!(first, last), do: last!(%NameOfPerson.PersonName{first_name: first, last_name: last})
  def last!(name) when is_binary(name), do: name |> convert_string_to_name |> last!

  def last!(%NameOfPerson.PersonName{last_name: ""}), do: nil

  def last!(person = %NameOfPerson.PersonName{}),
    do: String.trim("#{String.trim(person.last_name)}")

  @doc """
  Returns a mentionable version of their name.

  ## Examples

      iex> NameOfPerson.PersonName.mentionable("John", "Smith")
      "johns"
      iex> NameOfPerson.PersonName.mentionable("John")
      "john"
      iex> NameOfPerson.PersonName.mentionable("John Smith")
      "johns"
      iex> NameOfPerson.PersonName.mentionable("John Smith")
      "johns"
      iex> NameOfPerson.PersonName.mentionable("John Blank Smith")
      "johns"

  """
  def mentionable(first, last),
    do: mentionable(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def mentionable(first, middle, last),
    do:
      mentionable(%NameOfPerson.PersonName{
        first_name: first,
        middle_name: middle,
        last_name: last
      })

  def mentionable([first]), do: mentionable(%NameOfPerson.PersonName{first_name: first})

  def mentionable([first, last]),
    do: mentionable(%NameOfPerson.PersonName{first_name: first, last_name: last})

  def mentionable([first, middle, last]),
    do:
      mentionable(%NameOfPerson.PersonName{
        first_name: first,
        middle_name: middle,
        last_name: last
      })

  def mentionable(name) when is_binary(name), do: name |> convert_string_to_name |> mentionable
  def mentionable(person = %NameOfPerson.PersonName{}), do: _mentionable(person)

  defp _mentionable(person = %NameOfPerson.PersonName{}) do
    person
    |> familiar()
    |> String.trim_trailing(".")
    |> String.replace(" ", "")
    |> String.downcase()
  end

  @doc """
  Generates a PersonName struct from a string.

  ## Examples

      iex> NameOfPerson.PersonName.convert_string_to_name("John Quantum Firefox Smith")
      %NameOfPerson.PersonName{first_name: "John", middle_name: "Quantum Firefox", last_name: "Smith"}

  """
  def convert_string_to_name(name) do
    name
    |> String.split(" ", trim: true)
    |> _convert_string_to_name()
  end

  defp _convert_string_to_name([first_name | tail] = name)
       when is_list(name) and length(name) > 2 do
    [last_name | middle_names] = _fetch_other_names(tail)

    %NameOfPerson.PersonName{
      first_name: first_name,
      middle_name: middle_names,
      last_name: last_name
    }
  end

  defp _convert_string_to_name([first, last]),
    do: %NameOfPerson.PersonName{first_name: first, last_name: last}

  defp _convert_string_to_name([first]), do: %NameOfPerson.PersonName{first_name: first}

  defp _fetch_other_names(name) when is_list(name) do
    [last_name | middle_names] = Enum.reverse(name)
    middle_names = Enum.reverse(middle_names) |> Enum.join(" ")
    [last_name | middle_names]
  end
end
