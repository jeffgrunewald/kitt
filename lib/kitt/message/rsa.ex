defmodule Kitt.Message.RSA do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant Road Side Alert message
  """

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

  @enforce_keys [:msgCnt, :typeEvent]
  defstruct description: nil,
            extent: nil,
            furtherInfoID: nil,
            heading: nil,
            msgCnt: nil,
            position: nil,
            priority: nil,
            regional: nil,
            timeStamp: nil,
            typeEvent: nil

  def new(message), do: struct(__MODULE__, message)

  def type_id(), do: :DSRC.roadSideAlert()
end
