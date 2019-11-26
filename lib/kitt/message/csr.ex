defmodule Kitt.Message.CSR do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant Common Safety Request message.
  """

  @type t :: %__MODULE__{
          timeStamp: Kitt.Types.minute_of_year(),
          msgCnt: non_neg_integer(),
          id: binary(),
          requests: [request_item()],
          regional: [Kitt.Types.regional_extension()]
        }

  @type request_item ::
          :reserved
          | :itemA
          | :itemB
          | :itemC
          | :itemD
          | :itemE
          | :itemF
          | :itemG
          | :itemI
          | :itemJ
          | :itemK
          | :itemL
          | :itemM
          | :itemN
          | :itemO
          | :itemP
          | :itemQ

  @enforce_keys [:requests]
  defstruct id: nil,
            msgCnt: nil,
            regional: nil,
            requests: nil,
            timeStamp: nil

  def new(message), do: struct(__MODULE__, message)

  def type_id(), do: :DSRC.travelerInformation()
end
