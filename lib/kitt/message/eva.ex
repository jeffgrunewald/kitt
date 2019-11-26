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
          responseType: response_type(),
          details: emergency_details(),
          mass: vehicle_mass(),
          basicType: vehicle_type(),
          vehicleType: itis_vehicle_group_affected(),
          responseEquip: itis_incident_response_equipment(),
          responderType: itis_responder_group_affected(),
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
