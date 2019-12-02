defmodule Kitt.Message.BSM do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant BasicSafetyMessage

  A `BSM` defines the basic interchange of presence data
  between DSRC-capable vehicles and infrastructure
  """

  defmodule CoreData do
    @moduledoc """
    Defines the structure and instantiation function
    for creating a J2735-compliant BSMCoreData data element
    """

    @typedoc "Defines the structure of a BSMCoreData data element and the data elements comprising its fields"
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
    defstruct [
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

    @doc """
    Produces a `CoreData` message struct from an equivalent map or keyword input.
    """
    @spec new(map() | keyword()) :: CoreData.t()
    def new(core_data), do: struct(__MODULE__, core_data)
  end

  @typedoc "Defines the BasicSafetyMessage type and the data elements comprising its component fields"
  @type t :: %__MODULE__{
          coreData: CoreData.t(),
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
  defstruct [:coreData, :partII, :regional]

  @doc """
  Produces a `BSM` message struct from an equivalent map or keyword input.
  The `coreData` primary field is instantiated as a `CoreData` struct recursively
  """
  @spec new(map() | keyword()) :: t()
  def new(message) do
    {_, core_data_struct} =
      Map.get_and_update!(message, :coreData, fn core_data ->
        {core_data, CoreData.new(core_data)}
      end)

    struct(__MODULE__, core_data_struct)
  end

  @doc """
  Returns the `BSM` identifying integer
  """
  @spec type_id() :: non_neg_integer()
  def type_id(), do: :DSRC.basicSafetyMessage()

  @doc """
  Returns the `BSM` identifying atom recognized by the ASN1 spec
  """
  @spec type() :: atom()
  def type(), do: :BasicSafetyMessage
end
