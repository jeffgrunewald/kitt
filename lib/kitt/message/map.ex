defmodule Kitt.Message.MAP do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant MapData message

  A MapData message defines the geometry of a roadway
  intersection including the lanes, ingress/egress vectors
  and other defined rules for traversing the intersection.
  """

  @typedoc "Defines the MapData message and the data elements comprising its fields"
  @type t :: %__MODULE__{
          timeStamp: Kitt.Types.minute_of_year(),
          msgIssueRevision: non_neg_integer(),
          layerType:
            :none
            | :mixedContent
            | :generalMapData
            | :intersectionData
            | :curveData
            | :roadwaySectionData
            | :parkingAreaData
            | :sharedLaneData,
          layerID: non_neg_integer(),
          intersections: [intersection_geometry()],
          roadSegments: [road_segment()],
          dataParameters: data_parameters(),
          restrictionList: [restriction_class_assignment()],
          regional: [Kitt.Types.regional_extension()]
        }

  @type restriction_class_assignment :: %{
          id: non_neg_integer(),
          users: [restriction_user_type()]
        }

  @type restriction_user_type ::
          {:basicType, restriction_applies_to()}
          | {:regional, [Kitt.Types.regional_extension()]}

  @type restriction_applies_to ::
          :none
          | :equippedTransit
          | :equippedTaxis
          | :equippedOther
          | :emissionCompliant
          | :equippedBicycle
          | :weightCompliant
          | :heightCompliant
          | :pedestrians
          | :slowMovingPersons
          | :wheelchairUsers
          | :visualDisabilities
          | :audioDisabilities
          | :otherUnknownDisabilities

  @type data_parameters :: %{
          processMethod: String.t(),
          processAgency: String.t(),
          lastCheckedDate: String.t(),
          geoidUsed: String.t()
        }

  @type road_segment :: %{
          name: String.t(),
          id: Kitt.Types.road_segment_reference_id(),
          refPoint: Kitt.Types.position_3d(),
          laneWidth: non_neg_integer(),
          speedLimits: [Kitt.Types.regulatory_speed_limit()],
          roadLaneSet: [generic_lane()],
          regional: [Kitt.Types.regional_extension()]
        }

  @type intersection_geometry :: %{
          name: String.t(),
          id: Kitt.Types.intersection_reference_id(),
          revision: non_neg_integer(),
          refPoint: Kitt.Types.position_3d(),
          laneWidth: non_neg_integer(),
          speedLimits: [Kitt.Types.regulatory_speed_limit()],
          laneSet: [generic_lane()],
          preemptPriorityData: [signal_control_zone()],
          regional: [Kitt.Types.regional_extension()]
        }

  @type signal_control_zone :: %{
          zone: Kitt.Types.regional_extension()
        }

  @type generic_lane :: %{
          laneID: non_neg_integer(),
          name: String.t(),
          ingressApproach: non_neg_integer(),
          egressApproach: non_neg_integer(),
          laneAttributes: lane_attributes(),
          maneuvers: bitstring(),
          nodeList: Kitt.Types.node_list_xy(),
          connectsTo: [connection()],
          overlays: [non_neg_integer()],
          regional: [Kitt.Types.regional_extension()]
        }

  @type connection :: %{
          connectingLane: connecting_lane(),
          remoteIntersection: Kitt.Types.intersection_reference_id(),
          signalGroup: non_neg_integer(),
          userClass: non_neg_integer(),
          connectionID: non_neg_integer()
        }

  @type connecting_lane :: %{
          lane: non_neg_integer(),
          maneuver: bitstring()
        }

  @type lane_attributes :: %{
          directionalUse: bitstring(),
          sharedWith: bitstring(),
          laneType: lane_attribute_type(),
          regional: [Kitt.Types.regional_extension()]
        }

  @type lane_attribute_type ::
          {:vehicle, bitstring()}
          | {:crosswalk, bitstring()}
          | {:bikeLane, bitstring()}
          | {:sidewalk, bitstring()}
          | {:median, bitstring()}
          | {:striping, bitstring()}
          | {:trackedVehicle, bitstring()}
          | {:parking, bitstring()}

  @enforce_keys [:msgIssueRevision]
  defstruct [
    :dataParameters,
    :intersections,
    :layerID,
    :layerType,
    :msgIssueRevision,
    :regional,
    :restrictionList,
    :roadSegments,
    :timeStamp
  ]

  @doc """
  Produces a `MAP` message struct from an equivalent map or keyword input
  """
  @spec new(map()) :: t()
  def new(message), do: struct(__MODULE__, message)

  @doc """
  Returns the `MAP` identifying integer
  """
  @spec type_id() :: non_neg_integer()
  def type_id(), do: :DSRC.mapData()

  @doc """
  Returns the `MAP` identifying atom recognized by the ASN1 spec
  """
  @spec type() :: atom()
  def type(), do: :MapData
end
