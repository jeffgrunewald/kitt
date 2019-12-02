defmodule Kitt.Message.ICA do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant Intersection Collision Alert message

  An ICA defines the alert message type that is emitted to DSRC-capable
  vehicles entering the vicinity of an intersection in which a collision
  has occurred
  """

  alias Kitt.Message.BSM.CoreData

  @typedoc "Defines the structure of an IntersectionCollision message and the data elements comprising its fields"
  @type t :: %__MODULE__{
          msgCnt: non_neg_integer(),
          id: binary(),
          timeStamp: Kitt.Types.minute_of_year(),
          partOne: CoreData.t(),
          path: Kitt.Types.path_history(),
          pathPrediction: Kitt.Types.path_prediction(),
          intersectionID: Kitt.Types.intersection_reference_id(),
          laneNumber: approach_or_lane(),
          eventFlag: bitstring(),
          regional: [Kitt.Types.regional_extension()]
        }

  @type approach_or_lane ::
          {:approach, non_neg_integer()}
          | {:lane, non_neg_integer()}

  @enforce_keys [:msgCnt, :id, :intersectionID, :laneNumber, :eventFlags]
  defstruct [
    :eventFlag,
    :id,
    :intersectionID,
    :laneNumber,
    :msgCnt,
    :partOne,
    :path,
    :pathPrediction,
    :regional,
    :timeStamp
  ]

  @doc """
  Produces an `ICA` message struct from an equivalent map or keyword input
  """
  @spec new(map() | keyword()) :: t()
  def new(message) do
    {_, core_data_struct} =
      Map.get_and_update(message, :partOne, fn core_data ->
        case core_data do
          nil -> {nil, nil}
          core_data -> {core_data, CoreData.new(core_data)}
        end
      end)

    struct(__MODULE__, core_data_struct)
  end

  @doc """
  Returns the `ICA` identifying integer
  """
  @spec type_id() :: non_neg_integer()
  def type_id(), do: :DSRC.intersectionCollision()

  @doc """
  Returns the `ICA` identifying atom recognized by the ASN1 spec
  """
  @spec type() :: atom()
  def type(), do: :IntersectionCollision
end
