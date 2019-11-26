defmodule Kitt.Message.SSM do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant SignalStatusMessage
  """

  @type t :: %__MODULE__{
          timeStamp: Kitt.Types.minute_of_year(),
          second: non_neg_integer(),
          sequenceNumber: non_neg_integer(),
          status: [signal_status()],
          regional: [Kitt.Types.regional_extension()]
        }

  @type signal_status :: %{
          sequenceNumber: non_neg_integer(),
          id: Kitt.Types.intersection_reference_id(),
          sigStatus: [signal_status_package()],
          regional: [Kitt.Types.regional_extension()]
        }

  @type signal_status_package :: %{
          requester: signal_requester_info(),
          inboundOn: Kitt.Types.intersection_access_point(),
          outboundOn: Kitt.Types.intersection_access_point(),
          minute: non_neg_integer(),
          second: non_neg_integer(),
          duration: non_neg_integer(),
          status: prioritization_response_status(),
          regional: [Kitt.Types.regional_extension()]
        }

  @type signal_requester_info :: %{
          id: Kitt.Types.vehicle_id(),
          request: non_neg_integer(),
          sequenceNumber: non_neg_integer(),
          role: Kitt.Types.basic_vehicle_role(),
          typeData: Kitt.Types.requestor_type()
        }

  @type prioritization_response_status ::
          :unknown
          | :requested
          | :processing
          | :watchOtherTraffic
          | :granted
          | :rejected
          | :maxPresence
          | :reserviceLocked

  @enforce_keys [:second, :status]
  defstruct regional: nil,
            second: nil,
            sequenceNumber: nil,
            status: nil,
            timeStamp: nil

  def new(message), do: struct(__MODULE__, message)

  def type_id(), do: :DSRC.signalStatusMessage()
end
