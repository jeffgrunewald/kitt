defmodule Kitt.Message.RSA do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant Road Side Alert message

  An `RSA` defines the basic message structure for notifying
  vehicles in entering the vicinity of an event within the
  roadway
  """

  @typedoc "Defines the structure of a RoadSideAlert message and the data elements comprising its fields"
  @type t :: %__MODULE__{
          msgCnt: non_neg_integer(),
          timeStamp: Kitt.Types.minute_of_year(),
          typeEvent: non_neg_integer(),
          description: [non_neg_integer()],
          priority: binary(),
          heading: bitstring(),
          extent: Kitt.Types.extent(),
          position: Kitt.Types.full_position_vector(),
          furtherInfoID: binary(),
          regional: [Kitt.Types.regional_extension()]
        }

  @derive Jason.Encoder
  @enforce_keys [:msgCnt, :typeEvent]
  defstruct [
    :description,
    :extent,
    :furtherInfoID,
    :heading,
    :msgCnt,
    :position,
    :priority,
    :regional,
    :timeStamp,
    :typeEvent
  ]

  @doc """
  Produces an `RSA` message struct from an equivalent map or keyword input
  """
  @spec new(map() | keyword()) :: t()
  def new(message), do: struct(__MODULE__, message)

  @doc """
  Returns the `RSA` identifying integer
  """
  @spec type_id() :: non_neg_integer()
  def type_id(), do: :DSRC.roadSideAlert()

  @doc """
  Returns the `RSA` identifying atom recognized by the ASN1 spec
  """
  @spec type() :: atom()
  def type(), do: :RoadSideAlert
end
