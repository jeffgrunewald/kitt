defmodule Kitt.Util do
  @moduledoc """
  Utility functions for interacting with data frames and elements
  for cleaner readability across modules.
  """

  alias Kitt.Message.{BSM, CSR, EVA, ICA, MAP, PSM, RSA, SPAT, SRM, SSM, TIM}

  @doc """
  Converts an integer to its 4-byte binary representation
  for compatibility with common J2735 ID field spec.
  """
  @spec encode_id(non_neg_integer()) :: binary()
  def encode_id(id) do
    encoded_id = :binary.encode_unsigned(id)
    padding = (4 - byte_size(encoded_id)) * 8
    <<0::size(padding)>> <> encoded_id
  end

  @doc """
  """
  @spec type(atom() | non_neg_integer()) :: {module(), atom()}
  def type(type) when type in [:bsm, 20], do: {BSM, BSM.type()}
  def type(type) when type in [:csr, 21], do: {CSR, CSR.type()}
  def type(type) when type in [:eva, 22], do: {EVA, EVA.type()}
  def type(type) when type in [:ica, 23], do: {ICA, ICA.type()}
  def type(type) when type in [:map, 18], do: {MAP, MAP.type()}
  def type(type) when type in [:psm, 32], do: {PSM, PSM.type()}
  def type(type) when type in [:rsa, 27], do: {RSA, RSA.type()}
  def type(type) when type in [:spat, 19], do: {SPAT, SPAT.type()}
  def type(type) when type in [:srm, 29], do: {SRM, SRM.type()}
  def type(type) when type in [:ssm, 30], do: {SSM, SSM.type()}
  def type(type) when type in [:tim, 31], do: {TIM, TIM.type()}

  @doc """
  Parses a keyword list of options and returns the desired output
  format for an encode function or the expected input format for
  a decode function.

  Defaults to hexadecimal format via the `:hex` atom if the `:format`
  option is not supplied.

  Returns an `{:error, reason}` if an unsupported value is supplied
  for the `:format` option.
  """
  @spec get_format(keyword()) :: :hex | :binary | {:error, term()}
  def get_format(opts) do
    case Keyword.get(opts, :format) do
      hex when hex in [nil, :hex] -> :hex
      :binary -> :binary
      other -> {:error, "#{inspect(other)} is an unsupported format"}
    end
  end

  @doc """
  Ensures data is converted to binary format for compatibility with
  various fixed-size data element fields in the J2735 message set.
  """
  @spec to_binary(binary() | integer()) :: binary()
  def to_binary(data) when is_binary(data), do: data
  def to_binary(data) when is_integer(data), do: <<data>>

  @doc """
  Recursively converts a Kitt message struct to its equivalent Elixir
  map to allow it to be encoded to binary format. Reduces over the
  fields of the struct and converts it and any sub-fields defined as structs
  to a map.
  """
  @spec to_map_recursive(term()) :: term()
  def to_map_recursive(%{__struct__: _type} = element) when is_map(element) do
    element |> Map.from_struct() |> reduce_element()
  end

  def to_map_recursive(element) when is_map(element) do
    reduce_element(element)
  end

  def to_map_recursive(element), do: element

  defp reduce_element(element) do
    Enum.reduce(element, %{}, &put_non_nil_elements/2)
  end

  defp put_non_nil_elements({_key, value}, acc) when value == nil, do: acc

  defp put_non_nil_elements({key, value}, acc) do
    Map.put(acc, key, to_map_recursive(value))
  end
end
