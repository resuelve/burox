defmodule Burox.Parser do
  @moduledoc false

  import Burox.Parser.ResponseMap
  alias Burox.Response

  @success_sections [
    "INTL",  # Response header
    "PN",    # General info from client
    "PA",    # Client Addresses
    "PE",    # Work Addresses
    "TL",    # Credits or accounts
    "IQ",    # Queries of Buro de crédito
    "RS",    # Summary of Buro de Crédito
    "HI",    # HI Hawk Alert
    "HR",    # HR Hawk Alert
    "CR",    # Declarativa
    "SC",    # BC-Score
    "ES"     # End
  ]

  @error_sections [
    "ERRR",
    "ES"
  ]

  @doc """
  Process and parse the string response from Buro
  """
  @spec process_response(String.t) :: map
  def process_response(response) do

    # The response from buro is divided into segments
    response
    |> String.starts_with?("INTL")
    |> if  do
      response
      |> _process_response(@success_sections)
      |> Map.to_list()
      |> (&struct(Response, &1)).()
    else
      _process_response(response, @error_sections)
    end

  end

  # Process the response depending if it was succesful or failed.
  defp _process_response(response, sections) do
    Enum.reduce(sections, %{"tail" => response}, fn(tag, section_values) ->
        # Seek for sections and their values
        {values, tail} = match_section(section_values["tail"], tag, sections)

        # Read config to map section
        section_key = sections_map[tag]["key"]
        section_struct = sections_map[tag]["struct"]
        type = sections_map[tag]["type"]

        convert_to_list? = type == "list" and is_map(values)

        values = if convert_to_list? do
            if Enum.empty?(values), do: [] , else: [values]
          else
            values
          end

        Map.merge(section_values, %{section_key => values, "tail" => tail})
      end
    )
  end

  @doc """
  Retrieves a map with all section values
  """
  @spec match_section(String.t, String.t, list) :: tuple
  def match_section(string, section, sections_keys) do
    section_values = %{}

    cond do
      String.starts_with?(string, "INTL") ->
        {value_string, tail} = String.split_at(string, 49)
        {String.slice(value_string, 31, 15), tail}

      String.starts_with?(string, "ERRR") ->
        {value_string, tail} = String.split_at(string, 43)
        {String.slice(value_string, 31, 10), tail}

      String.starts_with?(string, section) ->
        _match_section(section, string, "", section_values, sections_keys)

      true ->
        # Skip section not found
        {%{}, string}
    end

  end

  # Retrieves values until the next section is found
  defp _match_section(_, "", _, values, _), do: {values, ""}
  defp _match_section(_, "", _, values, _), do: {values, ""}
  defp _match_section(section, tail, tag, values, sections) do

    # Read the values
    {value, tail} = tail
    |> String.split_at(2)
    |> elem(1)
    |> read_value()

    merge = fn section_map ->
      if is_nil(section_map) do
        Map.merge(values, %{tag => value})
      else
        tag_model = section_map
        |> Map.get("tags")
        |> Map.get(tag)

        Map.merge(values, %{tag_model["key"] => value})
      end
    end

    values = sections_map()
    |> Map.get(section)
    |> merge.()

    next_tag = String.slice(tail, 0, 2)

    # Check if we reach the end of section
    is_member = Enum.member?(sections, next_tag)
    is_same_section = section == next_tag

    cond do
      is_same_section ->
        {next_values, final_tail} =
          _match_section(section, tail, next_tag, values, sections)

        {[values] ++ next_values, final_tail}
      is_member ->
        {values, tail}
      true ->
        _match_section(section, tail, next_tag, values, sections)
    end

  end

  # Parse the length of a value and return the slice that contains it
  defp read_value(string) do
    # The length of the value is after the tag, 2 digits always
    {length, _} = string
    |> String.slice(0, 2)
    |> Integer.parse()

    # Value starts after the lenght info
    value_start = 0 + 2

    # Return the string not processed yet
    tail = string
    |> String.split_at(value_start + length)
    |> elem(1)

    {String.slice(string, value_start, length), tail}

  end

end
