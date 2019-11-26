defmodule Kitt.Message.PSM do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant PersonalSafetyMessage.
  """

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
  defstruct accelSet: nil,
            accuracy: nil,
            activityType: nil,
            activitySubType: nil,
            assistType: nil,
            attachment: nil,
            attachmentRadius: nil,
            basicType: nil,
            clusterRadius: nil,
            clusterSize: nil,
            crossRequest: nil,
            crossState: nil,
            eventResponderType: nil,
            heading: nil,
            id: nil,
            msgCnt: nil,
            pathHistory: nil,
            pathPrediction: nil,
            position: nil,
            propulsion: nil,
            regional: nil,
            secMark: nil,
            sizing: nil,
            speed: nil,
            useState: nil,
            useState: nil

  def new(message), do: struct(__MODULE__, message)

  def type_id(), do: :DSRC.personalSafetyMessage()
end
