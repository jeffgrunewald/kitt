defmodule Kitt do
  @moduledoc """
  Provides encoding and decoding functionality
  for UPER-encoded DSRC message payloads defined
  by the J2735 standard.
  """

  alias Kitt.{BSM, SRM, MAP, SPAT, PSM, SSM, TIM}

  defmodule(DSRCEncodeError, do: defexception([:message]))

  defmodule(DSRCDecodeError, do: defexception([:message]))

  @type message() ::
          BSM.t()
          #         | SignalRequestMessage.t()
          #         | MAPMessage.t()
          #         | SPaTMessage.t()
          | PSM.t()
  # | SignalStatusMessage.t()
  #         | TravelerInformation.t()

  @types %{
    bsm: :BasicSafetyMessage,
    srm: :SignalRequestMessage,
    map: :MapData,
    spat: :SPAT,
    psm: :PersonalSafetyMessage,
    ssm: :SignalStatusMessage,
    tim: :TravelerInformation
  }

  @ids %{
    20 => BSM,
    29 => SRM,
    18 => MAP,
    19 => SPAT,
    32 => PSM,
    30 => SSM,
    31 => TIM
  }

  def encode_message(message, type, opts \\ []) do
    src_type = Map.get(@types, type.name)

    opts
    |> get_format()
    |> case do
      :hex -> encode_type(message, src_type, :hex)
      :binary -> encode_type(message, src_type, :binary)
      error -> error
    end
  end

  def encode_message!(message, type, opts \\ []) do
    case encode_message(message, type, opts) do
      {:ok, result} ->
        result

      {:error, reason} ->
        raise DSRCEncodeError, message: "Unable to encode message : #{inspect(reason)}"
    end
  end

  def decode_message(message, type, opts \\ []) do
    src_type = Map.get(@types, type.name)

    opts
    |> get_format()
    |> case do
      :hex -> decode_type(message, src_type, :hex)
      :binary -> decode_type(message, src_type, :binary)
      error -> error
    end
  end

  def decode_message!(message, type, opts \\ []) do
    case decode_message(message, type, opts) do
      {:ok, result} ->
        result

      {:error, reason} ->
        raise DSRCDecodeError, message: "Unable to decode message : #{inspect(reason)}"
    end
  end

  def encode(%type{} = message, opts \\ []) do
    type_id = type.type_id()

    [head, middle | tail] =
      %{
        messageId: type_id,
        value: Map.from_struct(message)
      }
      |> :DSRC.enc_MessageFrame()

    frame = to_binary(head) <> to_binary(middle) <> to_binary(tail)

    opts
    |> get_format()
    |> case do
      :hex -> Base.encode16(frame)
      :binary -> {:ok, frame}
    end
  rescue
    MatchError -> {:error, "Unable to encode message : #{inspect(message)}"}
  end

  def encode!(message, opts \\ []) do
    case encode(message, opts) do
      {:ok, result} ->
        result

      {:error, reason} ->
        raise DSRCEncodeError, message: "Unable to encode message : #{inspect(reason)}"
    end
  end

  def decode(message, opts \\ []) do
    {%{messageId: id, value: message_map}, ""} =
      opts
      |> get_format()
      |> case do
        :hex -> Base.decode16!(message)
        :binary -> message
      end
      |> :DSRC.dec_MessageFrame()

    struct_type = Map.get(@ids, id)

    {:ok, struct_type.new(message_map)}
  rescue
    error -> {:error, error}
  end

  def decode!(message, opts \\ []) do
    case decode(message, opts) do
      {:ok, result} ->
        result

      {:error, reason} ->
        raise DSRCDecodeError, message: "Unable to decode message : #{inspect(reason)}"
    end
  end

  def encode_id(id) do
    encoded_id = :binary.encode_unsigned(id)
    padding = (4 - byte_size(encoded_id)) * 8
    <<0::size(padding)>> <> encoded_id
  end

  defp encode_type(message, type, :binary), do: :DSRC.encode(type, message)

  defp encode_type(message, type, :hex) do
    type
    |> :DSRC.encode(message)
    |> Base.encode16()
  end

  defp decode_type(message, type, :hex) do
    bytes =
      message
      |> String.upcase()
      |> Base.decode16!()

    :DSRC.decode(type, bytes)
  end

  defp decode_type(message, type, :binary), do: :DSRC.decode(type, message)

  defp get_format(opts) do
    case Keyword.get(opts, :format) do
      hex when hex in [nil, :hex] -> :hex
      :binary -> :binary
      other -> {:error, "#{inspect(other)} is an unsupported format"}
    end
  end

  defp to_binary(data) when is_binary(data), do: data
  defp to_binary(data) when is_integer(data), do: <<data>>
end
