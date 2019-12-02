defmodule Kitt.Message do
  @moduledoc """
  Encoding and decoding functions for specific
  message types defined by the J2735-standard.
  """

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

  def message_type(type), do: Map.get(@message_types, type)
  def message_id(id), do: Map.get(@message_ids, id)

  def encode_message(message, type, opts \\ []) do
    src_type = message_type(type)

    opts
    |> Util.get_format()
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
        raise Kitt.DSRCEncodeError, message: "Unable to encode message : #{inspect(reason)}"
    end
  end

  def decode_message(message, type, opts \\ []) do
    src_type = message_type(type)

    opts
    |> Util.get_format()
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
        raise Kitt.DSRCDecodeError, message: "Unable to decode message : #{inspect(reason)}"
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
