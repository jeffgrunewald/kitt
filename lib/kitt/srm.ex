defmodule Kitt.SRM do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant SignalRequestMessage
  """

  @type t :: %__MODULE__{
          timeStamp: Kitt.Types.minute_of_year(),
          second: non_neg_integer(),
          sequenceNumber: non_neg_integer(),
          requests: [signal_request_package],
          requestor: requestor_description(),
          regional: [Kitt.Types.regional_extension()]
        }

  @type signal_request_package :: %{
          request: signal_request(),
          minute: non_neg_integer(),
          second: non_neg_integer(),
          duration: non_neg_integer(),
          regional: [Kitt.Types.regional_extension()]
        }

  @type signal_request :: %{
          id: Kitt.Types.intersection_reference_id(),
          requestID: non_neg_integer(),
          requestType:
            :priorityRequestTypeReserved
            | :priorityRequest
            | :priorityRequestUpdate
            | :priorityCancellation,
          inBoundLane: Kitt.Types.intersection_access_point(),
          outBoundLane: Kitt.Types.intersection_access_point(),
          regional: [Kitt.Types.regional_extension()]
        }

  @type requestor_description :: %{
          id: Kitt.Types.vehicle_id(),
          type: Kitt.Types.requestor_type(),
          position: requestor_position_vector(),
          name: String.t(),
          routeName: String.t(),
          transitStatus: bitstring(),
          transitOccupancy:
            :occupancyUnknown
            | :occupancyEmpty
            | :occupancyVeryLow
            | :occupancyLow
            | :occupancyMed
            | :occupancyHigh
            | :occupancyNearlyFull
            | :occupancyFull,
          transitSchedule: integer(),
          regional: [Kitt.Types.regional_extension()]
        }

  @type requestor_position_vector :: %{
          position: Kitt.Types.position_3d(),
          heading: non_neg_integer(),
          speed: Kitt.Types.transmission_and_speed()
        }

  @enfore_keys [:requestor, :second]
  defstruct regional: nil,
            requestor: nil,
            requests: nil,
            second: nil,
            sequenceNumber: nil,
            timeStamp: nil

  def new(message), do: struct(__MODULE__, message)

  def type_id(), do: :DSRC.signalRequestMessage()
end
