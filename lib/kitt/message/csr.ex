defmodule Kitt.Message.CSR do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant Common Safety Request message.

  A CSR is a message defining the request for safety information
  from one DSRC-capable vehicle to another.
  """

  @typedoc "Defines the structure of a CommonSafetyRequest message and the data elements comprising its fields"
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
  defstruct [:id, :msgCnt, :regional, :requests, :timeStamp]

  @doc """
  Produces a `CSR` message struct from an equivalent map or keyword input
  """
  @spec new(map() | keyword()) :: t()
  def new(message), do: struct(__MODULE__, message)

  @doc """
  Returns the `CSR` identifying integer
  """
  @spec type_id() :: non_neg_integer()
  def type_id(), do: :DSRC.travelerInformation()

  @doc """
  Returns the `CSR` identifying atom recognized by the ASN1 spec
  """
  def type(), do: :CommonSafetyRequest
end
