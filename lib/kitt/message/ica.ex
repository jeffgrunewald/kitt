defmodule Kitt.Message.ICA do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant Intersection Collision Alert message
  """

  alias Kitt.Message.BSM.CoreData

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
  defstruct eventFlag: nil,
            id: nil,
            intersectionID: nil,
            laneNumber: nil,
            msgCnt: nil,
            partOne: nil,
            path: nil,
            pathPrediction: nil,
            regional: nil,
            timeStamp: nil

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

  def type_id(), do: :DSRC.intersectionCollision()
end
