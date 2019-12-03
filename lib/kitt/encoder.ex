defmodule Kitt.Encoder do
  @moduledoc """
  Encoding and decoding functions for specific
  message types and frame defined by the J2735-standard.

  Calls the lower-level `:DSRC` functions generated by the ASN1
  definition files and converts the resulting maps to Elixir structs
  as well as the reverse order for conversion from maps and structs
  to hexadecimal or binary encoded messages
  """

  alias Kitt.Message.{BSM, CSR, EVA, ICA, MAP, PSM, RSA, SPAT, SRM, SSM, TIM}
  alias Kitt.Util

  @typedoc "A struct-encoded instance of a J2735 standard message"
  @type message() ::
          BSM.t()
          | CSR.t()
          | EVA.t()
          | ICA.t()
          | MAP.t()
          | PSM.t()
          | RSA.t()
          | SPAT.t()
          | SRM.t()
          | SSM.t()
          | TIM.t()

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
  Takes a Kitt message struct and converts it to either a binary
  or hex version of the message data wrapped in a Message Frame structure
  tagged with the appropriate ID number.

  The default output format is hexadecimal. Optionally define the desired
  output by passing the keyword flag `format: :hex | :binary`.

  Returns the encoded message wrapped in an `:ok` tuple or an `{:error, reason}` tuple.
  """
  @spec encode_frame(message(), format: :hex | :binary) :: {:ok, binary()} | {:error, term()}
  def encode_frame(%type{} = message, opts \\ []) do
    type_id = type.type_id()

    [head, middle | tail] =
      %{
        messageId: type_id,
        value: Util.to_map_recursive(message)
      }
      |> :DSRC.enc_MessageFrame()

    frame = Util.to_binary(head) <> Util.to_binary(middle) <> Util.to_binary(tail)

    opts
    |> Util.get_format()
    |> case do
      :hex -> Base.encode16(frame)
      :binary -> {:ok, frame}
    end
  rescue
    MatchError -> {:error, "Unable to encode message : #{inspect(message)}"}
  end

  @doc """
  The same as `Kitt.encode_frame/2` but returns the encoded message binary directly
  without the `:ok` tuple wrapper or raises a `DSRCEncodeError` exception.
  """
  @spec encode_frame!(message(), format: :binary | :hex) :: binary()
  def encode_frame!(message, opts \\ []) do
    case encode_frame(message, opts) do
      {:ok, result} ->
        result

      {:error, reason} ->
        raise Kitt.DSRCEncodeError, message: "Unable to encode message : #{inspect(reason)}"
    end
  end

  @doc """
  Takes an encoded DSRC Message Frame and decodes it to a Kitt struct of
  the encoded type.

  Data elements contained within the struct as sub-values with a defined
  Kitt struct type are recursively instantiated as well.

  The default input format is a hexadecimal string encoding unless specified
  by passing the optional keyword argument `format: :hex | :binary`

  Returns the struct wrapped in an `:ok` tuple or an `{:error, reason}` tuple.
  """
  @spec decode_frame(binary(), format: :hex | :binary) :: {:ok, message()} | {:error, term()}
  def decode_frame(message, opts \\ []) do
    {%{messageId: id, value: message_map}, ""} =
      opts
      |> Util.get_format()
      |> case do
        :hex -> Base.decode16!(message)
        :binary -> message
      end
      |> :DSRC.dec_MessageFrame()

    struct_type = Map.get(@message_ids, id)

    {:ok, struct_type.new(message_map)}
  rescue
    error -> {:error, error}
  end

  @doc """
  The same as `Kitt.decode_frame/2` but returns the decoded message struct directly
  without the `:ok` tuple wrapper or raises a `DSRCDecodeError` exception.
  """
  @spec decode_frame!(binary(), format: :hex | :binary) :: message()
  def decode_frame!(message, opts \\ []) do
    case decode_frame(message, opts) do
      {:ok, result} ->
        result

      {:error, reason} ->
        raise Kitt.DSRCDecodeError, message: "Unable to decode message : #{inspect(reason)}"
    end
  end

  @doc """
  Takes a Kitt message struct and encodes it to a binary representation
  of the message.

  By default the message is encoded to a hexadecimal representation but
  the optional keyword argument `format: :hex | :binary` can explicitly
  define the desired output format.

  Resulting binary is wrapped in an `:ok` tuple, else an `{:error, reason}`
  is returned.
  """
  @spec encode_struct(message(), format: :hex | :binary) ::
          {:ok, binary()} | {:error, term()}
  def encode_struct(%struct{} = message, opts \\ []) do
    type = struct.type()

    convert_message_by_format(message, type, opts, &encode_type/3)
  end

  @doc """
  Same as `encode_struct/2` but returns the encoded message binary directly
  or else raises a DSRCEncodeError exception.
  """
  @spec encode_struct!(message(), format: :hex | :binary) :: binary()
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
  @spec encode_message(message() | map(), atom(), format: :hex | :binary) ::
          {:ok, binary()} | {:error, term()}
  def encode_message(message, type, opts \\ []) do
    src_type = Map.get(@message_types, type)

    convert_message_by_format(message, src_type, opts, &encode_type/3)
  end

  @doc """
  Same as `encode_message/3` but returns the encoded message binary directly
  or else raises a DSRCEncodeError exception.
  """
  @spec encode_message!(message(), atom(), format: :hex | :binary) :: binary()
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
          {:ok, message()} | {:error, term()}
  def decode_message(message, type, opts \\ []) do
    src_type = Map.get(@message_types, type)

    convert_message_by_format(message, src_type, opts, &decode_type/3)
  end

  @doc """
  Same as `decode_message/3` but returns the decoded struct directly or else raises
  a DSRCDecodeError exception.
  """
  @spec decode_message!(binary(), atom(), format: :hex | :binary) :: message()
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