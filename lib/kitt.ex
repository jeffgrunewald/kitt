defmodule Kitt do
  @moduledoc """
  Provides encoding and decoding functionality
  for UPER-encoded DSRC message payloads defined
  by the J2735 standard defined by the Society for
  Automotive Engineers.

  Kitt uses Erlang's native ASN1 compiler to parse
  the raw binary of the DSRC messages and then converts
  them to Elixir structs for language-native enforcement
  of required message fields, interactions with message
  data frames/elements, and more flexible conversion to
  common interchange formats such as JSON, Protobuf, Avro, etc.
  """

  alias Kitt.Message.{BSM, CSR, EVA, ICA, MAP, PSM, RSA, SPAT, SRM, SSM, TIM}
  alias Kitt.{Message, Util}

  defmodule(DSRCEncodeError, do: defexception([:message]))

  defmodule(DSRCDecodeError, do: defexception([:message]))

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

  @doc """
  Takes a Kitt message struct and converts it to either a binary
  or hex version of the message data wrapped in a Message Frame structure
  tagged with the appropriate ID number.

  The default output format is hexadecimal. Optionally define the desired
  output by passing the keyword flag `format: :hex | :binary`.

  Returns the encoded message wrapped in an `:ok` tuple or an `{:error, reason}` tuple.
  """
  @spec encode(message(), format: :hex | :binary) :: {:ok, binary()} | {:error, term()}
  def encode(%type{} = message, opts \\ []) do
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
  The same as `Kitt.encode/2` but returns the encoded message binary directly
  without the `:ok` tuple wrapper or raises a `DSRCEncodeError` exception.
  """
  @spec encode!(message(), format: :binary | :hex) :: binary()
  def encode!(message, opts \\ []) do
    case encode(message, opts) do
      {:ok, result} ->
        result

      {:error, reason} ->
        raise DSRCEncodeError, message: "Unable to encode message : #{inspect(reason)}"
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
  @spec decode(binary(), format: :hex | :binary) :: {:ok, message()} | {:error, term()}
  def decode(message, opts \\ []) do
    {%{messageId: id, value: message_map}, ""} =
      opts
      |> Util.get_format()
      |> case do
        :hex -> Base.decode16!(message)
        :binary -> message
      end
      |> :DSRC.dec_MessageFrame()

    struct_type = Message.message_id(id)

    {:ok, struct_type.new(message_map)}
  rescue
    error -> {:error, error}
  end

  @doc """
  The same as `Kitt.decode/2` but returns the decoded message struct directly
  without the `:ok` tuple wrapper or raises a `DSRCDecodeError` exception.
  """
  @spec decode!(binary(), format: :hex | :binary) :: message()
  def decode!(message, opts \\ []) do
    case decode(message, opts) do
      {:ok, result} ->
        result

      {:error, reason} ->
        raise DSRCDecodeError, message: "Unable to decode message : #{inspect(reason)}"
    end
  end
end
