defmodule Kitt.Message.EVA do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant Emergency Vehicle Alert message

  An EVA defines the alert message type emitted by emergency
  vehicles to other DSRC-capable vehicles entering the vicinity
  of the incident
  """

  alias Kitt.Message.RSA

  @typedoc "Defines the structure of a EmergencyVehicleAlert message and the data elements comprising its component fields"
  @type t :: %__MODULE__{
          timeStamp: Kitt.Types.minute_of_year(),
          id: binary(),
          rsaMsg: RSA.t(),
          responseType: Kitt.Types.response_type(),
          details: Kitt.Types.emergency_details(),
          mass: non_neg_integer(),
          basicType: Kitt.Types.vehicle_type(),
          vehicleType: Kitt.Types.vehicle_group_affected(),
          responseEquip: Kitt.Types.incident_response_equipment(),
          responderType: Kitt.Types.responder_group_affected(),
          regional: [Kitt.Types.regional_extension()]
        }

  @derive Jason.Encoder
  @enforce_keys [:rsaMsg]
  defstruct [
    :basicType,
    :details,
    :id,
    :mass,
    :regional,
    :responderType,
    :responseEquip,
    :responseType,
    :rsaMsg,
    :timeStamp,
    :vehicleType
  ]

  @doc """
  Produces an `EVA` message struct from an equivalent map or keyword input
  """
  @spec new(map() | keyword()) :: t()
  def new(message) do
    {_, rsa_struct} =
      Map.get_and_update!(message, :rsaMsg, fn rsa ->
        {rsa, RSA.new(rsa)}
      end)

    struct(__MODULE__, rsa_struct)
  end

  @doc """
  Returns the `EVA` identifying integer
  """
  @spec type_id() :: non_neg_integer()
  def type_id(), do: :DSRC.emergencyVehicleAlert()

  @doc """
  Returns the `EVA` identifying atom recognized by the ASN1 spec
  """
  @spec type() :: atom()
  def type(), do: :EmergencyVehicleAlert
end
