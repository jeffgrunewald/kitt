defmodule Kitt.Message do
  @moduledoc """
  Encoding and decoding functions for specific
  message types defined by the J2735-standard.
  """

  alias Kitt.Message.{BSM, CSR, EVA, ICA, MAP, PSM, RSA, SPAT, SRM, SSM, TIM}
  alias Kitt.Util

  @message_types %{
    bsm: :BasicSafetyMessage,
    csr: :CommonSafetyRequest,
    eva: :EmergencyVehicleAlert,
    ica: :IntersectionCollision,
    map: :MapData,
    psm: :PersonalSafetyMessage,
    rsa: :RoadSideAlert,
    spat: :SPAT,
    srm: :SignalRequestMessage,
    ssm: :SignalStatusMessage,
    tim: :TravelerInformation
  }

  @message_ids %{
    18 => MAP,
    19 => SPAT,
    20 => BSM,
    21 => CSR,
    22 => EVA,
    23 => ICA,
    27 => RSA,
    29 => SRM,
    30 => SSM,
    31 => TIM,
    32 => PSM
  }

  @doc """
  Takes an atom representing the common short-hand abbreviation
  for a J2735 message type and returns the full type atom representation
  recognized by the Erlang ASN1 compiler.
  """
  @spec message_type(atom()) :: atom()
  def message_type(type), do: Map.get(@message_types, type)

  @doc """
  Takes an integer representing the official ID of a J2735 message type
  and returns the Kitt Module that defines the struct encoding of the
  message.
  """
  @spec message_id(non_neg_integer()) :: module()
  def message_id(id), do: Map.get(@message_ids, id)

  @doc """
  Takes a Kitt message struct and encodes it to a binary representation
  of the message.

  By default the message is encoded to a hexadecimal representation but
  the optional keyword argument `format: :hex | :binary` can explicitly
  define the desired output format.

  Resulting binary is wrapped in an `:ok` tuple, else an `{:error, reason}`
  is returned.
  """
  @spec encode_struct(Kitt.message(), format: :hex | :binary) ::
          {:ok, binary()} | {:error, term()}
  def encode_struct(%struct{} = message, opts \\ []) do
    type = struct.type()

    convert_message_by_format(message, type, opts, &encode_type/3)
  end

  @doc """
  Same as `encode_struct/2` but returns the encoded message binary directly
  or else raises a DSRCEncodeError exception.
  """
  @spec encode_struct!(Kitt.message(), format: :hex | :binary) :: binary()
  def encode_struct!(message, opts \\ []) do
    case encode_struct(message, opts) do
      {:ok, result} ->
        result

      {:error, reason} ->
        raise Kitt.DSRCEncodeError, message: "Unable to encode message : #{inspect(reason)}"
    end
  end

  @doc """
  Takes a Kitt message struct _or_ comparable message data as a basic Elixir map
  as well as an explicit message type atom and encodes the message to a binary
  representation of the message.

  By default the message is encoded to a hexadecimal representation but the optional
  keyword argument `format: :hex | :binary` can explicitly define the desired output
  format.

  Resulting binary is wrapped in an `:ok` tuple, else an `{:error, reason}` is
  returned.
  """
  @spec encode_message(Kitt.message() | map(), atom(), format: :hex | :binary) ::
          {:ok, binary()} | {:error, term()}
  def encode_message(message, type, opts \\ []) do
    src_type = message_type(type)

    convert_message_by_format(message, src_type, opts, &encode_type/3)
  end

  @doc """
  Same as `encode_message/3` but returns the encoded message binary directly
  or else raises a DSRCEncodeError exception.
  """
  @spec encode_message!(Kitt.message(), atom(), format: :hex | :binary) :: binary()
  def encode_message!(message, type, opts \\ []) do
    case encode_message(message, type, opts) do
      {:ok, result} ->
        result

      {:error, reason} ->
        raise Kitt.DSRCEncodeError, message: "Unable to encode message : #{inspect(reason)}"
    end
  end

  @doc """
  Takes a binary encoded J2735 message and an explicit message type atom and decodes
  the message to a Kitt struct. Any sub-fields of the struct that are defined by Kitt
  as a struct are recursively instantiated.

  By default the binary message is assumed to be in a hexadecimal string but the input
  format can be explicitly supplied via the keyword argument `format: :hex | :binary`.

  Returns the resulting message struct wrapped in an `:ok` tuple, else returns `{:error, reason}`.
  """
  @spec decode_message(binary(), atom(), format: :hex | :binary) ::
          {:ok, Kitt.message()} | {:error, term()}
  def decode_message(message, type, opts \\ []) do
    src_type = message_type(type)

    convert_message_by_format(message, src_type, opts, &decode_type/3)
  end

  @doc """
  Same as `decode_message/3` but returns the decoded struct directly or else raises
  a DSRCDecodeError exception.
  """
  @spec decode_message!(binary(), atom(), format: :hex | :binary) :: Kitt.message()
  def decode_message!(message, type, opts \\ []) do
    case decode_message(message, type, opts) do
      {:ok, result} ->
        result

      {:error, reason} ->
        raise Kitt.DSRCDecodeError, message: "Unable to decode message : #{inspect(reason)}"
    end
  end

  defp convert_message_by_format(message, type, opts, func) do
    opts
    |> Util.get_format()
    |> case do
      :hex -> func.(message, type, :hex)
      :binary -> func.(message, type, :binary)
      error -> error
    end
  end

  defp encode_type(message, type, :binary), do: :DSRC.encode(type, Util.to_map_recursive(message))

  defp encode_type(message, type, :hex) do
    {:ok, binary_message} = :DSRC.encode(type, Util.to_map_recursive(message))
    {:ok, Base.encode16(binary_message)}
  end

  defp decode_type(message, type, :hex) do
    bytes =
      message
      |> String.upcase()
      |> Base.decode16!()

    :DSRC.decode(type, bytes)
  end

  defp decode_type(message, type, :binary), do: :DSRC.decode(type, message)
end
