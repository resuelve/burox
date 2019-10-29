defmodule Burox.Utils.Strip do
  @moduledoc """
  Módulo para limpiar caracteres inválidos de una cadena
  """

  def strip_utf(str) do
    _strip_utf(str, [])
  end

  defp _strip_utf(<<x :: utf8>> <> rest, acc) do
    _strip_utf rest, [x | acc]
  end

  defp _strip_utf(<<x>> <> rest, acc), do: _strip_utf(rest, ["x" | acc])

  defp _strip_utf("", acc) do
    acc
    |> :lists.reverse
    |> List.to_string
  end
end
