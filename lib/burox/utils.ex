defmodule Burox.Utils do
  @moduledoc """
  Herramientas para convertir mapas a estructuras
  """

  defp to_map(list, options) when is_list(list) do
    list
    |> Enum.into(%{}, fn {key, val} -> {convert_key(key, options[:keys]), val} end)
  end

  defp to_map(%_module{} = struct, options) do
    struct
    |> Map.from_struct()
    |> convert_keys(options[:keys], options[:shallow] || false)
  end

  defp to_map(map, options) when is_map(map) do
    map |> convert_keys(options[:keys], options[:shallow] || false)
  end

  def to_struct(nil, _module) do
    nil
  end

  def to_struct(map, module) when is_atom(module) and is_map(map) do
    map = to_map(map, keys: :strings, shallow: true)
    struct = struct(module)

    Enum.reduce(Map.to_list(struct), struct, fn {k, _}, acc ->
      case Map.fetch(map, convert_key(k, :strings)) do
        {:ok, v} -> %{acc | k => v}
        :error -> acc
      end
    end)
  end

  defp convert_keys(map, keys_as, shallow?) do
    Enum.reduce(map, %{}, fn {k, v}, acc ->
      Map.put(
        acc,
        convert_key(k, keys_as),
        if shallow? do
          v
        else
          convert_val(v, keys_as)
        end
      )
    end)
  end

  defp convert_val(val, keys_as) when is_map(val) do
    to_map(val, keys: keys_as)
  end

  defp convert_val(val, _) do
    val
  end

  defp convert_key(k, :atoms) when is_atom(k) do
    k
  end

  defp convert_key(k, :atoms) when is_binary(k) do
    String.to_atom(k)
  end

  defp convert_key(k, :strings) when is_binary(k) do
    k
  end

  defp convert_key(k, :strings) when is_atom(k) do
    "#{k}"
  end

end
