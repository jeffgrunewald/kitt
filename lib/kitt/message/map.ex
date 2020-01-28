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
          maneuvers: maneuver(),
          nodeList: Kitt.Types.node_list_xy(),
          connectsTo: [connection()],
          overlays: [non_neg_integer()],
          regional: [Kitt.Types.regional_extension()]
        }

  @type maneuver ::
          :maneuverStraightAllowed
          | :maneuverLeftAllowed
          | :maneuverRightAllowed
          | :maneuverUTurnAllowed
          | :maneuverLeftTurnOnRedAllowed
          | :maneuverRightTurnOnRedAllowed
          | :maneuverLaneChangeAllowed
          | :maneuverNoStoppingAllowed
          | :yieldAllwaysRequired
          | :goWithHalt
          | :caution
          | :reserved1

  @type connection :: %{
          connectingLane: connecting_lane(),
          remoteIntersection: Kitt.Types.intersection_reference_id(),
          signalGroup: non_neg_integer(),
          userClass: non_neg_integer(),
          connectionID: non_neg_integer()
        }

  @type connecting_lane :: %{
          lane: non_neg_integer(),
          maneuver: maneuver()
        }

  @type lane_attributes :: %{
          directionalUse: directional_use(),
          sharedWith: shared_with(),
          laneType: lane_attribute_type(),
          regional: [Kitt.Types.regional_extension()]
        }

  @type directional_use ::
          :ingressPath
          | :egressPath

  @type shared_with ::
          :overlappingLaneDescriptionProvided
          | :multipleLanesTreatedAsOneLane
          | :otherNonMotorizedTrafficTypes
          | :individualMotorizedVehicleTraffic
          | :busVehicleTraffic
          | :taxiVehicleTraffic
          | :pedestriansTraffic
          | :cyclistVehicleTraffic
          | :trackedVehicleTraffic
          | :pedestrianTraffic

  @type lane_attribute_type ::
          {:vehicle, vehicle_lane_attribute()}
          | {:crosswalk, crosswalk_lane_attribute()}
          | {:bikeLane, bike_lane_attribute()}
          | {:sidewalk, sidewalk_lane_attribute()}
          | {:median, median_lane_attribute()}
          | {:striping, striping_lane_attribute()}
          | {:trackedVehicle, tracked_vehicle_attribute()}
          | {:parking, parking_lane_attribute()}

  @type vehicle_lane_attribute ::
          :isVehicleRevocableLane
          | :isVehicleFlyOverLane
          | :hovLaneUseOnly
          | :restrictedToBusUse
          | :restrictedToTaxiUse
          | :restrictedFromPublicUse
          | :hasIRbeaconCoverage
          | :permissionOnRequest

  @type crosswalk_lane_attribute ::
          :crosswalkRevocableLane
          | :bicyleUseAllowed
          | :isXwalkFlyOverLane
          | :fixedCycleTime
          | :biDirectionalCycleTimes
          | :hasPushToWalkButton
          | :audioSupport
          | :rfSignalRequestPresent
          | :unsignalizedSegmentsPresent

  @type bike_lane_attribute ::
          :bikeRevocableLane
          | :pedestrianUseAllowed
          | :isBikeFlyOverLane
          | :fixedCycleTime
          | :biDirectionalCycleTimes
          | :isolatedByBarrier
          | :unsignalizedSegmentsPresent

  @type sidewalk_lane_attribute ::
          :"sidewalk-RevocableLane"
          | :bicyleUseAllowed
          | :isSidewalkFlyOverLane
          | :walkBikes

  @type median_lane_attribute ::
          :"median-RevocableLane"
          | :median
          | :whiteLineHashing
          | :stripedLines
          | :doubleStripedLines
          | :trafficCones
          | :constructionBarrier
          | :trafficChannels
          | :lowCurbs
          | :highCurbs

  @type striping_lane_attribute ::
          :stripeToConnectingLanesRevocableLane
          | :stripeDrawOnLeft
          | :stripeDrawOnRight
          | :stripeToConnectingLanesLeft
          | :stripeToConnectingLanesRight
          | :stripeToConnectingLanesAhead

  @type tracked_vehicle_attribute ::
          :"spec-RevocableLane"
          | :"spec-commuterRailRoadTrack"
          | :"spec-lightRailRoadTrack"
          | :"spec-heavyRailRoadTrack"
          | :"spec-otherRailType"

  @type parking_lane_attribute ::
          :parkingRevocableLane
          | :parallelParkingInUse
          | :headInParkingInUse
          | :doNotParkZone
          | :parkingForBusUse
          | :parkingForTaxiUse
          | :noPublicParkingUse

  @derive Jason.Encoder
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
  @spec new(map() | keyword()) :: t()
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
