defmodule Kitt.Message.EVA do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant Emergency Vehicle Alert message
  """

  alias Kitt.Message.RSA

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

  @enforce_keys [:rsaMsg]
  defstruct basicType: nil,
            details: nil,
            id: nil,
            mass: nil,
            regional: nil,
            responderType: nil,
            responseEquip: nil,
            responseType: nil,
            rsaMsg: nil,
            timeStamp: nil,
            vehicleType: nil

  def new(message) do
    {_, rsa_struct} =
      Map.get_and_update!(message, :rsaMsg, fn rsa ->
        {rsa, RSA.new(rsa)}
      end)

    struct(__MODULE__, rsa_struct)
  end

  def type_id(), do: :DSRC.emergencyVehicleAlert()
end
