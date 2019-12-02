defmodule Kitt.Message.PSM do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant PersonalSafetyMessage.

  A `PSM` defines the information exchanged between non-vehicle
  actors within a DSRC-capable environment and the vehicles
  and infrastructure of the environment
  """

  @typedoc "Defines the structure of a PersonalSafetyMessage and the data elements comprising its fields"
  @type t :: %__MODULE__{
          accelSet: Kitt.Types.acceleration_set_4_way(),
          accuracy: Kitt.Types.positional_accuracy(),
          activityType: bitstring(),
          activitySubType: bitstring(),
          assistType: bitstring(),
          attachment:
            :unavailable
            | :stroller
            | :bicycleTrailer
            | :cart
            | :wheelchair
            | :otherWalkAssistAttachments
            | :pet
            | {:asn1_enum, integer()},
          attachmentRadius: non_neg_integer(),
          basicType:
            :unavailable
            | :aPEDESTRIAN
            | :aPEDALCYCLIST
            | :aPUBLICSAFETYWORKER
            | :anANIMAL
            | {:asn1_enum, non_neg_integer()},
          clusterRadius: non_neg_integer(),
          clusterSize: :unavailable | :small | :medium | :large | {:asn1_enum, non_neg_integer()},
          crossRequest: boolean(),
          crossState: boolean(),
          eventResponderType:
            :unavailable
            | :towOperator
            | :fireAndEMSWorker
            | :aDOTWorker
            | :lawEnforcement
            | :hazmatResponder
            | :animalControlWorker
            | :otherPersonnel
            | {:asn1_enum, non_neg_integer()},
          heading: non_neg_integer(),
          id: binary(),
          msgCnt: non_neg_integer(),
          pathHistory: Kitt.Types.path_history(),
          pathPrediction: Kitt.Types.path_prediction(),
          position: Kitt.Types.position_3d(),
          propulsion:
            {:human,
             :unavailable | :otherTypes | :onFoot | :skateBoard | :pushOrKickScooter | :wheelchair}
            | {:animal, :unavailable | :otherTypes | :animalMounted | :animalDrawnCarriage}
            | {:motor,
               :unavailable
               | :otherTypes
               | :wheelChair
               | :bicycle
               | :scooter
               | :selfBalancingDevice},
          regional: [Kitt.Types.regional_extension()],
          secMark: non_neg_integer(),
          sizing: bitstring(),
          speed: non_neg_integer(),
          useState: bitstring()
        }

  @enforce_keys [:accuracy, :basicType, :heading, :id, :msgCnt, :position, :secMark, :speed]
  defstruct [
    :accelSet,
    :accuracy,
    :activityType,
    :activitySubType,
    :assistType,
    :attachment,
    :attachmentRadius,
    :basicType,
    :clusterRadius,
    :clusterSize,
    :crossRequest,
    :crossState,
    :eventResponderType,
    :heading,
    :id,
    :msgCnt,
    :pathHistory,
    :pathPrediction,
    :position,
    :propulsion,
    :regional,
    :secMark,
    :sizing,
    :speed,
    :useState,
    :useState
  ]

  @doc """
  Produces the `PSM` message struct from an equivalent map or keyword input
  """
  @spec new(map() | keyword()) :: t()
  def new(message), do: struct(__MODULE__, message)

  @doc """
  Returns the `PSM` identifying integer
  """
  @spec type_id() :: non_neg_integer()
  def type_id(), do: :DSRC.personalSafetyMessage()

  @doc """
  Returns the `PSM` identifying atom recognized by the ASN1 spec
  """
  @spec type() :: atom()
  def type(), do: :PersonalSafetyMessage
end
