defmodule Kitt do
  @moduledoc """
  Provides encoding and decoding functionality
  for UPER-encoded DSRC message payloads defined
  by the J2735 standard.
  """

  defmodule(DSRCEncodeError, do: defexception([:message]))

  defmodule(DSRCDecodeError, do: defexception([:message]))

  # @type message() ::
  #         BasicSafetyMessage.t()
  #         | SignalRequestMessage.t()
  #         | MAPMessage.t()
  #         | SPaTMessage.t()
  #         | PersonalSafetyMessage.t()

  @types %{
    bsm: :BasicSafetyMessage,
    srm: :SignalRequestMessage,
    map: :MapData,
    spat: :SPAT,
    psm: :PersonalSafetyMessage
  }

  def encode(message, type, opts \\ []) do
    src_type = Map.get(@types, type)

    opts
    |> get_format()
    |> case do
      :hex -> encode_type(message, src_type, :hex)
      :bytes -> encode_type(message, src_type, :bytes)
      error -> error
    end
  end

  def encode!(message, type, opts \\ []) do
    case encode(message, type, opts) do
      {:ok, result} -> result
      {:error, reason} -> raise DSRCEncodeError, message: "Unable to encode message : #{reason}"
    end
  end

  def decode(message, type, opts \\ []) do
    src_type = Map.get(@types, type)

    opts
    |> get_format()
    |> case do
      :hex -> decode_type(message, src_type, :hex)
      :bytes -> decode_type(message, src_type, :bytes)
      error -> error
    end
  end

  def decode!(message, type, opts \\ []) do
    case decode(message, type, opts) do
      {:ok, result} -> result
      {:error, reason} -> raise DSRCDecodeError, message: "Unable to decode message : #{reason}"
    end
  end

  def encode_id(id) do
    encoded_id = :binary.encode_unsigned(id)
    padding = (4 - byte_size(encoded_id)) * 8
    <<0::size(padding)>> <> encoded_id
  end

  defp encode_type(message, type, :bytes), do: :DSRC.encode(type, message)

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

  defp decode_type(message, type, :bytes), do: :DSRC.decode(type, message)

  defp get_format(opts) do
    case Keyword.get(opts, :format) do
      hex when hex in [nil, :hex] -> :hex
      :bytes -> :bytes
      other -> {:error, "#{other} is an unsupported format"}
    end
  end
end
