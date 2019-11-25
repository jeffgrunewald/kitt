defmodule Kitt.BSM do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant BasicSafetyMessage
  """

  @type t :: %__MODULE__{
          coreData: BSMCoreData.t(),
          partII: [partIIcontent()],
          regional: [map()]
        }

  @type partIIcontent :: %{
          "partII-Id": non_neg_integer(),
          "partII-Value": partIIextension()
        }

  @type vehicle_safety_extensions :: %{
          events: bitstring(),
          pathHistory: Kitt.Types.path_history(),
          pathPrediction: Kitt.Types.path_prediction(),
          lights: bitstring()
        }

  @type special_vehicle_extensions :: %{
          vehicleAlerts: Kitt.Types.emergency_details(),
          description: Kitt.Types.event_description(),
          trailers: Kitt.Types.trailer_data()
        }

  @type supplemental_vehicle_extensions :: %{
          classification: non_neg_integer(),
          classDetails: Kitt.Types.vehicle_classification(),
          vehicleData: Kitt.Types.vehicle_data(),
          weatherReport: Kitt.Types.weather_report(),
          weatherProbe: Kitt.Types.weather_probe(),
          obstacle: Kitt.Types.obstacle_detection(),
          status: Kitt.Types.disabled_vehicle(),
          speedProfile: Kitt.Types.speed_profile(),
          theRTCM: Kitt.Types.rtcm_package(),
          regional: [map()]
        }

  @type partIIextension ::
          vehicle_safety_extensions()
          | special_vehicle_extensions()
          | supplemental_vehicle_extensions()

  @enforce_keys [:coreData]
  defstruct coreData: nil,
            partII: nil,
            regional: nil

  defmodule BSMCoreData do
    @type t :: %__MODULE__{
            msgCnt: non_neg_integer(),
            id: binary(),
            secMark: non_neg_integer(),
            lat: integer(),
            long: integer(),
            elev: integer(),
            accuracy: Kitt.Types.positional_accuracy(),
            transmission: Kitt.Types.transmission_state(),
            speed: non_neg_integer(),
            heading: non_neg_integer(),
            angle: integer(),
            accelSet: Kitt.Types.acceleration_set_4_way(),
            brakes: Kitt.Types.brake_system_status(),
            size: Kitt.Types.vehicle_size()
          }

    @enforce_keys [
      :msgCnt,
      :id,
      :secMark,
      :lat,
      :long,
      :elev,
      :accuracy,
      :transmission,
      :speed,
      :heading,
      :angle,
      :accelSet,
      :brakes,
      :size
    ]
    defstruct msgCnt: nil,
              id: nil,
              secMark: nil,
              lat: nil,
              long: nil,
              elev: nil,
              accuracy: nil,
              transmission: nil,
              speed: nil,
              heading: nil,
              angle: nil,
              accelSet: nil,
              brakes: nil,
              size: nil
  end

  def new(message), do: struct(__MODULE__, message)

  def type_id(), do: :DSRC.basicSafetyMessage()
end
