defmodule Kitt.Message.SSM do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant SignalStatusMessage

  An `SSM` defines the message sent by DSRC-capable infrastructure
  to relay to vehicles the status of current signals and collection
  of pending or active pre-emption or requests
  """

  @typedoc "Defines the structure of a SignalStatusMessage and the data elements comprising its fields"
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

  @derive Jason.Encoder
  @enforce_keys [:second, :status]
  defstruct [:regional, :second, :sequenceNumber, :status, :timeStamp]

  @doc """
  Produces an `SSM` message struct from an equivalent map or keyword input
  """
  @spec new(map() | keyword()) :: t()
  def new(message), do: struct(__MODULE__, message)

  @doc """
  Returns the `SSM` identifying integer
  """
  @spec type_id() :: non_neg_integer()
  def type_id(), do: :DSRC.signalStatusMessage()

  @doc """
  Returns the `SSM` identifying atom recognized by the ASN1 spec
  """
  @spec type() :: atom()
  def type(), do: :SignalStatusMessage
end
