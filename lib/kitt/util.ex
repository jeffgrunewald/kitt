defmodule Kitt.Util do
  @moduledoc """
  Utility functions for interacting with data frames and elements
  for cleaner readability across modules.
  """

  def encode_id(id) do
    encoded_id = :binary.encode_unsigned(id)
    padding = (4 - byte_size(encoded_id)) * 8
    <<0::size(padding)>> <> encoded_id
  end

  def get_format(opts) do
    case Keyword.get(opts, :format) do
      hex when hex in [nil, :hex] -> :hex
      :binary -> :binary
      other -> {:error, "#{inspect(other)} is an unsupported format"}
    end
  end

  def to_binary(data) when is_binary(data), do: data
  def to_binary(data) when is_integer(data), do: <<data>>

  def to_map_recursive(%{__struct__: _type} = element) when is_map(element) do
    element |> Map.from_struct() |> reduce_element()
  end

  def to_map_recursive(element) when is_map(element) do
    reduce_element(element)
  end

  def to_map_recursive(element), do: element

  def reduce_element(element) do
    Enum.reduce(element, %{}, &put_non_nil_elements/2)
  end

  def put_non_nil_elements({_key, value}, acc) when value == nil, do: acc

  def put_non_nil_elements({key, value}, acc) do
    Map.put(acc, key, to_map_recursive(value))
  end
end
