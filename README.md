# Name of Person

This is a port of Basecamp's Ruby library [Name of Person](https://github.com/basecamp/name_of_person) to Elixir. From their description:

>Presenting names for English-language applications where a basic model of first and last name(s) combined is sufficient. This approach is not meant to cover all possible naming cases, deal with other languages, or even titulations. Just the basics.

This library also accepts middle names and uses them where appropriate.

## Example usage

```elixir
alias NameOfPerson.PersonName
iex> PersonName.full("Ned Flanders")
"Ned Flanders"
iex> PersonName.familiar("Frodo", "Baggins")
"Frodo B."
iex> PersonName.abbreviated(%PersonName{first_name: "Kaladin", last_name: "Stormblessed"})
"K. Stormblessed"
iex> PersonName.possessive(["Dirk", "Gentley"])
"Dirk Gentley's"
```

## Available Arguments

Most functions accept from one to three string parameters, e.g. `full/1, full/2, full/3`. Additionally, you can pass a List of names or a `%NameOfPerson.PersonName{}` struct. The struct can take 3 arguments, `first_name`, `middle_name`, and `last_name`.

`full/1` will look for spaces and split the names up appropriately. `full/2` will assume the first parameter is the first name and the second parameter is the last name. `full/3` takes a first, middle, and last name. In some cases, e.g. initials, the middlename is checked for multiple names within itself.

## Available methods

* `full`
* `initials`
* `familiar`
* `abbreviated`
* `sorted`
* `mentionable`
* `possessive`

## Todo

* Functions for `first`, `last` and `middle` names.
* More testing

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `name_of_person` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:name_of_person, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/name_of_person](https://hexdocs.pm/name_of_person).

