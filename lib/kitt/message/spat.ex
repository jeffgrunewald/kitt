defmodule Kitt.Message.SPAT do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant SignalPhaseandTiming message

  A `SPAT` defines the messages generated by the roadside
  infrastructure regarding current and pending signal status
  and expected timing of signal status changes.
  """

  @typedoc "Defines the structure of a SignalPhaseandTiming message and the data elements comprising its fields"
  @type t :: %__MODULE__{
          timeStamp: Kitt.Types.minute_of_year(),
          name: String.t(),
          intersections: [intersection_state()],
          regional: [Kitt.Types.regional_extension()]
        }

  @type intersection_state :: %{
          name: String.t(),
          id: Kitt.Types.intersection_reference_id(),
          revision: non_neg_integer(),
          status: bitstring(),
          moy: Kitt.Types.minute_of_year(),
          timeStamp: non_neg_integer(),
          enabledLanes: [non_neg_integer()],
          states: [movement_state()],
          maneuverAssistList: [connection_maneuver_assist()],
          regional: [Kitt.Types.regional_extension()]
        }

  @type movement_state :: %{
          movementName: String.t(),
          signalGroup: non_neg_integer(),
          "state-time-speed": [movement_event()],
          maneuverAssistList: [connection_maneuver_assist()],
          regional: [Kitt.Types.regional_extension()]
        }

  @type movement_event :: %{
          eventState:
            :unavailable
            | :dark
            | :"stop-Then-Proceed"
            | :"stop-And-Remain"
            | :"pre-Movement"
            | :"permissive-Movement-Allowed"
            | :"protected-Movement-Allowed"
            | :"permissive-clearance"
            | :"protected-clearance"
            | :"caution-Conflicting-Traffic",
          timing: time_change_details(),
          speeds: [advisory_speed()],
          regional: [Kitt.Types.regional_extension()]
        }

  @type time_change_details :: %{
          startTime: non_neg_integer(),
          minEndTime: non_neg_integer(),
          maxEndTime: non_neg_integer(),
          likelyTime: non_neg_integer(),
          confidence: non_neg_integer(),
          nextTime: non_neg_integer()
        }

  @type advisory_speed :: %{
          type:
            :none
            | :greenwave
            | :ecoDrive
            | :transit,
          speed: non_neg_integer(),
          confidence:
            :unavailable
            | :prec100ms
            | :prec10ms
            | :prec5ms
            | :prec1ms
            | :"prec0-1ms"
            | :"prec0-05ms"
            | :"prec0-01ms",
          distance: non_neg_integer(),
          class: non_neg_integer(),
          regional: [Kitt.Types.regional_extension()]
        }

  @type connection_maneuver_assist :: %{
          connectionID: non_neg_integer(),
          queueLength: non_neg_integer(),
          availableStorageLength: non_neg_integer(),
          waitOnStop: boolean(),
          pedBicycleDetect: boolean(),
          regional: [Kitt.Types.regional_extension()]
        }

  @enforce_keys [:intersections]
  defstruct [:intersections, :name, :regional, :timeStamp]

  @doc """
  Produces a `SPAT` message struct from an equivalent map or keyword input
  """
  @spec new(map()) :: t()
  def new(message), do: struct(__MODULE__, message)

  @doc """
  Returns the `SPAT` identifying integer
  """
  @spec type_id() :: non_neg_integer()
  def type_id(), do: :DSRC.signalPhaseAndTimingMessage()

  @doc """
  Returns the `SPAT` identifying atom recognized by the ASN1 spec
  """
  @spec type() :: atom()
  def type(), do: :SPAT
end
