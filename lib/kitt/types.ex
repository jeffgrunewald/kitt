defmodule Kitt.Types do
  @moduledoc """
  Collection of custom typespec definitions for
  abstracting the complexity of messages away from
  the structs that define them.
  """

  @type transmission_state ::
          :neutral
          | :park
          | :forwardGears
          | :reverseGears
          | :reserved1
          | :reserved2
          | :reserved3
          | :unavailable

  @type acceleration_set_4_way :: %{
          long: integer(),
          lat: integer(),
          vert: integer(),
          yaw: integer()
        }
  @type brake_system_status :: %{
          wheelBrakes: wheel_brake(),
          traction:
            :unavailable
            | :off
            | :on
            | :engaged,
          abs:
            :unavailable
            | :off
            | :on
            | :engaged,
          scs:
            :unavailable
            | :off
            | :on
            | :engaged,
          brakeBoost:
            :unavailable
            | :off
            | :on,
          auxBrakes:
            :unavailable
            | :off
            | :on
            | :reserved
        }

  @type wheel_brake ::
          :unavailable
          | quadrant()

  @type vehicle_size :: %{
          width: non_neg_integer(),
          length: non_neg_integer()
        }

  @type positional_accuracy :: %{
          semiMajor: non_neg_integer(),
          semiMinor: non_neg_integer(),
          orientation: non_neg_integer()
        }

  @type d_date_time :: %{
          year: non_neg_integer(),
          month: non_neg_integer(),
          day: non_neg_integer(),
          hour: non_neg_integer(),
          minute: non_neg_integer(),
          second: non_neg_integer(),
          offset: integer()
        }

  @type transmission_and_speed :: %{
          transmission:
            :neutral
            | :park
            | :forwardGears
            | :reverseGears
            | :reserved1
            | :reserved2
            | :reserved3
            | :unavailable,
          speed: non_neg_integer()
        }

  @type path_prediction :: %{
          radiusOfCurve: integer(),
          confidence: non_neg_integer()
        }

  @type position_3d :: %{
          lat: integer(),
          long: integer(),
          elevation: integer(),
          regional: [map()]
        }

  @type privileged_events :: %{
          sspRights: non_neg_integer(),
          event: privileged_event_flag()
        }

  @type privileged_event_flag ::
          :peUnavailable
          | :peEmergencyResponse
          | :peEmergencyLightsActive
          | :peEmergencySoundActive
          | :peNonEmergencyLightsActive
          | :peNonEmergencySoundActive

  @type emergency_details :: %{
          sspRights: non_neg_integer(),
          sirenUse:
            :unavailable
            | :notInUse
            | :inUse
            | :reserved,
          lightsUse:
            :unavailable
            | :notInUse
            | :inUse
            | :yellowCautionLights
            | :schoolBusLights
            | :arrowSignsActive
            | :slowMovingVehicle
            | :freqStops,
          multi:
            :unavailable
            | :singleVehicle
            | :multiVehicle
            | :reserved,
          events: privileged_events(),
          responseType: response_type()
        }

  @type response_type ::
          :notInUseOrNotEquipped
          | :emergency
          | :nonEmergency
          | :pursuit
          | :stationary
          | :slowMoving
          | :stopAndGoMovement

  @type event_description :: %{
          typeEvent: non_neg_integer(),
          description: [non_neg_integer()],
          priority: non_neg_integer(),
          heading: Kitt.Types.angle(),
          extent: extent(),
          regional: [map()]
        }

  @type event_flag ::
          :eventHazardLights
          | :eventStopLineViolation
          | :eventABSactivated
          | :eventTractionControlLoss
          | :eventStabilityControlactivated
          | :eventHazardousMaterials
          | :eventReserved1
          | :eventHardBraking
          | :eventLightsChanged
          | :eventWipersChanged
          | :eventFlatTire
          | :eventDisabledVehicle
          | :eventAirBagDeployment

  @type angle ::
          :"from000-0to022-5degrees"
          | :"from022-5to045-0degrees"
          | :"from045-0to067-5degrees"
          | :"from067-5to090-0degrees"
          | :"from090-0to112-5degrees"
          | :"from112-5to135-0degrees"
          | :"from135-0to157-5degrees"
          | :"from157-5to180-0degrees"
          | :"from180-0to202-5degrees"
          | :"from202-5to225-0degrees"
          | :"from225-0to247-5degrees"
          | :"from247-5to270-0degrees"
          | :"from270-0to292-5degrees"
          | :"from292-5to315-0degrees"
          | :"from315-0to337-5degrees"
          | :"from337-5to360-0degrees"

  @type regional_extension :: map()

  @type minute_of_year :: non_neg_integer()

  @type extent ::
          :useInstantlyOnly
          | :useFor3meters
          | :useFor10meters
          | :useFor50meters
          | :useFor100meters
          | :useFor500meters
          | :useFor1000meters
          | :useFor5000meters
          | :useFor10000meters
          | :useFor50000meters
          | :useFor100000meters
          | :useFor500000meters
          | :useFor1000000meters
          | :useFor5000000meters
          | :useFor10000000meters
          | :forever

  @type pivot_point_description :: %{
          pivotOffset: integer(),
          pivotAngle: non_neg_integer(),
          pivots: boolean()
        }

  @type node_xy_24b :: %{
          x: integer(),
          y: integer()
        }

  @type bumper_heights :: %{
          front: non_neg_integer(),
          rear: non_neg_integer()
        }

  @type trailer_unit_description :: %{
          isDolly: boolean(),
          width: non_neg_integer(),
          length: non_neg_integer(),
          height: non_neg_integer(),
          mass: non_neg_integer(),
          bumperHeights: bumper_heights(),
          centerOfGravity: non_neg_integer(),
          frontPivot: pivot_point_description(),
          rearPivot: pivot_point_description(),
          rearWheelOffset: integer(),
          positionOffset: node_xy_24b(),
          elevationOffset: integer(),
          crumbData: [trailer_history_point()]
        }

  @type trailer_data :: %{
          sspRights: non_neg_integer(),
          connection: pivot_point_description(),
          units: [trailer_unit_description()]
        }

  @type trailer_history_point :: %{
          pivotAngle: non_neg_integer(),
          timeOffset: non_neg_integer(),
          positionOffset: node_xy_24b(),
          elevationOffset: integer(),
          heading: non_neg_integer()
        }

  @type position_confidence_set :: %{
          pos:
            :unavailable
            | :a500m
            | :a200m
            | :a100m
            | :a50m
            | :a20m
            | :a10m
            | :a5m
            | :a2m
            | :a1m
            | :a50cm
            | :a20cm
            | :a10cm
            | :a5cm
            | :a2cm
            | :a1cm,
          elevation:
            :unavailable
            | :"elev-500-00"
            | :"elev-200-00"
            | :"elev-100-00"
            | :"elev-050-00"
            | :"elev-020-00"
            | :"elev-010-00"
            | :"elev-005-00"
            | :"elev-002-00"
            | :"elev-001-00"
            | :"elev-000-50"
            | :"elev-000-20"
            | :"elev-000-10"
            | :"elev-000-05"
            | :"elev-000-02"
            | :"elev-000-01"
        }

  @type speed_and_heading_and_throttle_confidence :: %{
          heading:
            :unavailable
            | :prec10deg
            | :prec05deg
            | :prec01deg
            | :"prec0-1deg"
            | :"prec0-05deg"
            | :"prec0-01deg"
            | :"prec0-0125deg",
          speed:
            :unavailable
            | :prec100ms
            | :prec10ms
            | :prec5ms
            | :prec1ms
            | :"prec0-1ms"
            | :"prec0-05ms"
            | :"prec0-01ms",
          throttle: :unavailable | :prec10percent | :prec1percent | :"prec0-5percent"
        }

  @type full_position_vector :: %{
          utcTime: d_date_time(),
          long: integer(),
          lat: integer(),
          elevation: integer(),
          heading: non_neg_integer(),
          speed: transmission_and_speed(),
          posAccuracy: positional_accuracy(),
          timeConfidence:
            :unavailable
            | :"time-100-000"
            | :"time-050-000"
            | :"time-020-000"
            | :"time-010-000"
            | :"time-002-000"
            | :"time-001-000"
            | :"time-000-500"
            | :"time-000-200"
            | :"time-000-100"
            | :"time-000-050"
            | :"time-000-020"
            | :"time-000-010"
            | :"time-000-005"
            | :"time-000-002"
            | :"time-000-001"
            | :"time-000-000-5"
            | :"time-000-000-2"
            | :"time-000-000-1"
            | :"time-000-000-05"
            | :"time-000-000-02"
            | :"time-000-000-01"
            | :"time-000-000-005"
            | :"time-000-000-002"
            | :"time-000-000-001"
            | :"time-000-000-000-5"
            | :"time-000-000-000-2"
            | :"time-000-000-000-1"
            | :"time-000-000-000-05"
            | :"time-000-000-000-02"
            | :"time-000-000-000-01"
            | :"time-000-000-000-005"
            | :"time-000-000-000-002"
            | :"time-000-000-000-001"
            | :"time-000-000-000-000-5"
            | :"time-000-000-000-000-2"
            | :"time-000-000-000-000-1"
            | :"time-000-000-000-000-05"
            | :"time-000-000-000-000-02"
            | :"time-000-000-000-000-01"
            | {:asn1_enum, non_neg_integer()},
          posConfidence: position_confidence_set(),
          speedConfidence: speed_and_heading_and_throttle_confidence()
        }

  @type path_history_point :: %{
          latOffset: integer(),
          lonOffset: integer(),
          elevationOffset: integer(),
          timeOffset: non_neg_integer(),
          speed: non_neg_integer(),
          osAccuracy: positional_accuracy(),
          heading: non_neg_integer()
        }

  @type path_history :: %{
          initialPosition: full_position_vector(),
          currGNSSstatus: status(),
          crumbData: [path_history_point()]
        }

  @type status ::
          :unavailable
          | :isHealthy
          | :isMonitored
          | :baseStationType
          | :aPDOPofUnder5
          | :inViewOfUnder5
          | :localCorrectionsPresent
          | :networkCorrectionsPresent

  @type antenna_offset_set :: %{
          antOffsetX: integer(),
          antOffsetY: integer(),
          antOffsetZ: integer()
        }

  @type rtcm_header :: %{
          status: status(),
          offsetSet: antenna_offset_set()
        }

  @type rtcm_package :: %{
          rtcmHeader: rtcm_header(),
          msgs: [non_neg_integer()]
        }

  @type speed_profile :: %{
          speedReports: [non_neg_integer()]
        }

  @type disabled_vehicle :: %{
          statusDetails: non_neg_integer(),
          locationDetails: generic_locations()
        }

  @type obstacle_detection :: %{
          obDist: non_neg_integer(),
          obDirect: non_neg_integer(),
          description: non_neg_integer(),
          locationDetails: generic_locations(),
          dateTime: d_date_time(),
          vertEvent: vert_event()
        }

  @type vert_event ::
          :notEquipped
          | quadrant()

  @type quadrant ::
          :leftFront
          | :leftRear
          | :rightFront
          | :rightRear

  @type wiper_status ::
          :unavailable
          | :off
          | :intermittent
          | :low
          | :high
          | :washerInUse
          | :automaticPresent

  @type wiper_set :: %{
          statusFront: wiper_status(),
          rateFront: non_neg_integer(),
          statusRear: wiper_status(),
          rateRear: non_neg_integer()
        }

  @type weather_probe :: %{
          airTemp: non_neg_integer(),
          airPressure: non_neg_integer(),
          rainRates: wiper_set()
        }

  @type weather_report :: %{
          isRaining:
            :precip
            | :noPrecip
            | :error,
          rainRate: non_neg_integer(),
          precipSituation:
            :other
            | :other
            | :unknown
            | :noPrecipitation
            | :unidentifiedSlight
            | :unidentifiedModerate
            | :unidentifiedHeavy
            | :snowSlight
            | :snowModerate
            | :snowHeavy
            | :rainSlight
            | :rainModerate
            | :rainHeavy
            | :frozenPrecipitationSlight
            | :frozenPrecipitationModerate
            | :frozenPrecipitationHeavy,
          solarRadiation: non_neg_integer(),
          friction: non_neg_integer(),
          roadFriction: non_neg_integer()
        }

  @type vehicle_data :: %{
          height: non_neg_integer(),
          bumpers: bumper_heights(),
          mass: non_neg_integer(),
          trailerWeight: non_neg_integer()
        }

  @type vehicle_type ::
          :none
          | :unknown
          | :special
          | :moto
          | :car
          | :carOther
          | :bus
          | :axleCnt2
          | :axleCnt3
          | :axleCnt4
          | :axleCnt4Trailer
          | :axleCnt5Trailer
          | :axleCnt6Trailer
          | :axleCnt5MultiTrailer
          | :axleCnt6MultiTrailer
          | :axleCnt7MultiTrailer

  @type vehicle_group_affected ::
          :"all-vehicles"
          | :bicycles
          | :motorcycles
          | :cars
          | :"light-vehicles"
          | :"cars-and-light-vehicles"
          | :"cars-with-trailers"
          | :"cars-with-recreational-trailers"
          | :"vehicles-with-trailers"
          | :"heavy-vehicles"
          | :trucks
          | :buses
          | :"articulated-buses"
          | :"school-buses"
          | :"vehicles-with-semi-trailers"
          | :"vehicles-with-double-trailers"
          | :"high-profile-vehicles"
          | :"wide-vehicles"
          | :"long-vehicles"
          | :"hazardous-loads"
          | :"exceptional-loads"
          | :"abnormal-loads"
          | :convoys
          | :"maintenance-vehicles"
          | :"delivery-vehicles"
          | :"vehicles-with-even-numbered-license-plates"
          | :"vehicles-with-odd-numbered-license-plates"
          | :"vehicles-with-parking-permits"
          | :"vehicles-with-catalytic-converters"
          | :"vehicles-without-catalytic-converters"
          | :"gas-powered-vehicles"
          | :"diesel-powered-vehicles"
          | :"lPG-vehicles"
          | :"military-convoys"
          | :"military-vehicles"

  @type incident_response_equipment ::
          :"ground-fire-suppression"
          | :"heavy-ground-equipment"
          | :aircraft
          | :"marine-equipment"
          | :"support-equipment"
          | :"medical-rescue-unit"
          | :other
          | :"ground-fire-suppression-other"
          | :engine
          | :"truck-or-aerial"
          | :quint
          | :"tanker-pumper-combination"
          | :"brush-truck"
          | :"aircraft-rescue-firefighting"
          | :"heavy-ground-equipment-other"
          | :"dozer-or-plow"
          | :tractor
          | :"tanker-or-tender"
          | :"aircraft-other"
          | :"aircraft-fixed-wing-tanker"
          | :helitanker
          | :helicopter
          | :"marine-equipment-other"
          | :"fire-boat-with-pump"
          | :"boat-no-pump"
          | :"support-apparatus-other"
          | :"breathing-apparatus-support"
          | :"light-and-air-unit"
          | :"medical-rescue-unit-other"
          | :"rescue-unit"
          | :"urban-search-rescue-unit"
          | :"high-angle-rescue"
          | :"crash-fire-rescue"
          | :"bLS-unit"
          | :"aLS-unit"
          | :"mobile-command-post"
          | :"chief-officer-car"
          | :"hAZMAT-unit"
          | :"type-i-hand-crew"
          | :"type-ii-hand-crew"
          | :"privately-owned-vehicle"
          | :"other-apparatus-resource"
          | :ambulance
          | :"bomb-squad-van"
          | :"combine-harvester"
          | :"construction-vehicle"
          | :"farm-tractor"
          | :"grass-cutting-machines"
          | :"hAZMAT-containment-tow"
          | :"heavy-tow"
          | :"light-tow"
          | :"flatbed-tow"
          | :"hedge-cutting-machines"
          | :"mobile-crane"
          | :"refuse-collection-vehicle"
          | :"resurfacing-vehicle"
          | :"road-sweeper"
          | :"roadside-litter-collection-crews"
          | :"salvage-vehicle"
          | :"sand-truck"
          | :snowplow
          | :"steam-roller"
          | :"swat-team-van"
          | :"track-laying-vehicle"
          | :"unknown-vehicle"
          | :"white-lining-vehicle"
          | :"dump-truck"
          | :"supervisor-vehicle"
          | :"snow-blower"
          | :"rotary-snow-blower"
          | :"road-grader"
          | :"steam-truck"

  @type responder_group_affected ::
          :"emergency-vehicle-units"
          | :"federal-law-enforcement-units"
          | :"state-police-units"
          | :"county-police-units"
          | :"local-police-units"
          | :"ambulance-units"
          | :"rescue-units"
          | :"fire-units"
          | :"hAZMAT-units"
          | :"light-tow-unit"
          | :"heavy-tow-unit"
          | :"freeway-service-patrols"
          | :"transportation-response-units"
          | :"private-contractor-response-units"

  @type basic_vehicle_role ::
          :basicVehicle
          | :publicTransport
          | :specialTransport
          | :dangerousGoods
          | :roadWork
          | :roadRescue
          | :emergency
          | :safetyCar
          | :"none-unknown"
          | :truck
          | :motorcycle
          | :roadSideSource
          | :police
          | :fire
          | :ambulance
          | :dot
          | :transit
          | :slowMoving
          | :stopNgo
          | :cyclist
          | :pedestrian
          | :nonMotorized
          | :military

  @type vehicle_classification :: %{
          keyType: non_neg_integer(),
          role: basic_vehicle_role(),
          iso3883: non_neg_integer(),
          hpmsType: vehicle_type(),
          vehicleType: vehicle_group_affected(),
          responseEquip: incident_response_equipment(),
          fuelType: non_neg_integer(),
          regional: [map()]
        }

  @type generic_locations() ::
          :"on-bridges"
          | :"in-tunnels"
          | :"entering-or-leaving-tunnels"
          | :"on-ramps"
          | :"in-road-construction-area"
          | :"around-a-curve"
          | :"on-curve"
          | :"on-tracks"
          | :"in-street"
          | :shoulder
          | :"on-minor-roads"
          | :"in-the-opposing-lanes"
          | :"adjacent-to-roadway"
          | :"across-tracks"
          | :"on-bend"
          | :intersection
          | :"entire-intersection"
          | :"in-the-median"
          | :"moved-to-side-of-road"
          | :"moved-to-shoulder"
          | :"on-the-roadway"
          | :dip
          | :"traffic-circle"
          | :crossover
          | :"cross-road"
          | :"side-road"
          | :to
          | :by
          | :through
          | :"area-of"
          | :under
          | :over
          | :from
          | :approaching
          | :"entering-at"
          | :"exiting-at"
          | :"in-shaded-areas"
          | :"in-low-lying-areas"
          | :"in-the-downtown-area"
          | :"in-the-inner-city-area"
          | :"in-parts"
          | :"in-some-places"
          | :"in-the-ditch"
          | :"in-the-valley"
          | :"on-hill-top"
          | :"near-the-foothills"
          | :"at-high-altitudes"
          | :"near-the-lake"
          | :"near-the-shore"
          | :"nearby-basin"
          | :"over-the-crest-of-a-hill"
          | :"other-than-on-the-roadway"
          | :"near-the-beach"
          | :"near-beach-access-point"
          | :"mountain-pass"
          | :"lower-level"
          | :"upper-level"
          | :airport
          | :concourse
          | :gate
          | :"baggage-claim"
          | :"customs-point"
          | :"reservation-center"
          | :station
          | :platform
          | :dock
          | :depot
          | :"ev-charging-point"
          | :"information-welcome-point"
          | :"at-rest-area"
          | :"at-service-area"
          | :"at-weigh-station"
          | :"roadside-park"
          | :"picnic-areas"
          | :"rest-area"
          | :"service-stations"
          | :toilets
          | :"bus-stop"
          | :"park-and-ride-lot"
          | :"on-the-right"
          | :"on-the-left"
          | :"in-the-center"
          | :"in-the-opposite-direction"
          | :"cross-traffic"
          | :"northbound-traffic"
          | :"eastbound-traffic"
          | :"southbound-traffic"
          | :"westbound-traffic"
          | :north
          | :south
          | :east
          | :west
          | :northwest
          | :northeast
          | :southwest
          | :southeast

  @type intersection_reference_id :: %{
          region: non_neg_integer(),
          id: non_neg_integer()
        }

  @type road_segment_reference_id :: %{
          region: non_neg_integer(),
          id: non_neg_integer()
        }

  @type vehicle_id ::
          {:entityID, non_neg_integer()}
          | {:stationID, non_neg_integer()}

  @type requestor_type :: %{
          role: basic_vehicle_role(),
          subrole:
            :requestSubRoleUnknown
            | :requestSubRole1
            | :requestSubRole2
            | :requestSubRole3
            | :requestSubRole4
            | :requestSubRole5
            | :requestSubRole6
            | :requestSubRole7
            | :requestSubRole8
            | :requestSubRole9
            | :requestSubRole10
            | :requestSubRole11
            | :requestSubRole12
            | :requestSubRole13
            | :requestSubRole14
            | :requestSubRoleReserved,
          request:
            :requestImportanceLevelUnknown
            | :requestImportanceLevel1
            | :requestImportanceLevel2
            | :requestImportanceLevel3
            | :requestImportanceLevel4
            | :requestImportanceLevel5
            | :requestImportanceLevel6
            | :requestImportanceLevel7
            | :requestImportanceLevel8
            | :requestImportanceLevel9
            | :requestImportanceLevel10
            | :requestImportanceLevel11
            | :requestImportanceLevel12
            | :requestImportanceLevel13
            | :requestImportanceLevel14
            | :requestImportanceReserved,
          iso3883: non_neg_integer(),
          hpmsType: vehicle_type(),
          regional: [map()]
        }

  @type intersection_access_point ::
          {:lane, non_neg_integer()}
          | {:approach, non_neg_integer()}
          | {:connection, non_neg_integer()}

  @type speed_limit_type ::
          :unknown
          | :maxSpeedInSchoolZone
          | :maxSpeedInSchoolZoneWhenChildrenArePresent
          | :maxSpeedInConstructionZone
          | :vehicleMinSpeed
          | :vehicleMaxSpeed
          | :vehicleNightMaxSpeed
          | :truckMinSpeed
          | :truckMaxSpeed
          | :truckNightMaxSpeed
          | :vehicleWithTrailersMinSpeed
          | :vehicleWithTrailersMaxSpeed
          | :vehicleWithTrailersNightMaxSpeed

  @type regulatory_speed_limit :: %{
          type: speed_limit_type(),
          speed: non_neg_integer()
        }

  @type offset_system :: %{
          scale: non_neg_integer(),
          offset: offset()
        }

  @type offset ::
          {:xy, node_list_xy()}
          | {:ll, node_list_ll()}

  @type node_list_ll :: {:nodes, [node_ll()]}

  @type node_ll :: %{
          delta: node_offset_point_ll(),
          attributes: node_attribute_set()
        }

  @type node_list_xy ::
          {:nodes, [node_xy()]}
          | {:computed, computed_lane()}

  @type computed_lane :: %{
          referenceLaneId: non_neg_integer(),
          offsetXaxis: driven_lane_offset(),
          offsetYaxis: driven_lane_offset(),
          rotateXY: non_neg_integer(),
          scaleXaxis: integer(),
          scaleYaxis: integer(),
          regional: [map()]
        }

  @type driven_lane_offset ::
          {:small, integer()}
          | {:large, integer()}

  @type node_xy :: %{
          delta: node_offset_point_xy(),
          attributes: node_attribute_set()
        }

  @type node_offset_point_ll ::
          {:"node-LL1"}
          | {:"node-LL2", node_ll_b()}
          | {:"node-LL3", node_ll_b()}
          | {:"node-LL4", node_ll_b()}
          | {:"node-LL5", node_ll_b()}
          | {:"node-LL6", node_ll_b()}
          | {:nodeLatLon, node_llmd_64b()}
          | {:regional, [map()]}

  @type node_offset_point_xy ::
          {:"node-XY1", node_xy_b()}
          | {:"node-XY2", node_xy_b()}
          | {:"node-XY3", node_xy_b()}
          | {:"node-XY4", node_xy_b()}
          | {:"node-XY5", node_xy_b()}
          | {:"node-XY6", node_xy_b()}
          | {:"node-LatLon", node_llmd_64b()}
          | {:regional, [map()]}

  @type node_attribute_set :: %{
          localNode: [node_attribute()],
          disabled: [segment_attribute()],
          enabled: [segment_attribute()],
          data: [lane_data_attribute()],
          dWidth: integer(),
          dElevation: integer(),
          regional: [map()]
        }

  @type node_attribute ::
          :reserved
          | :stopLine
          | :roundedCapStyleA
          | :roundedCapStyleB
          | :mergePoint
          | :divergePoint
          | :downstreamStopLine
          | :downstreamStartNode
          | :closedToTraffic
          | :safeIsland
          | :curbPresentAtStepOff
          | :hydrantPresent

  @type segment_attribute ::
          :reserved
          | :doNotBlock
          | :whiteLane
          | :mergingLaneLeft
          | :mergingLaneRight
          | :curbOnLeft
          | :curbOnRight
          | :loadingzoneOnLeft
          | :loadingzoneOnRight
          | :turnOutPointOnLeft
          | :turnOutPointOnRight
          | :adjacentParkingOnLeft
          | :adjacentParkingOnRight
          | :adjacentBikeLaneOnLeft
          | :adjacentBikeLaneOnRight
          | :sharedBikeLane
          | :bikeBoxInFront
          | :transitStopOnLeft
          | :transitStopOnRight
          | :transitStopInLane
          | :sharedWithTrackedVehicle
          | :safeIsland
          | :lowCurbsPresent
          | :rumbleStripPresent
          | :audibleSignalingPresent
          | :adaptiveTimingPresent
          | :rfSignalRequestPresent
          | :partialCurbIntrusion
          | :taperToLeft
          | :taperToRight
          | :taperToCenterLine
          | :parallelParking
          | :headInParking
          | :freeParking
          | :timeRestrictionsOnParking
          | :costToPark
          | :midBlockCurbPresent
          | :unEvenPavementPresent

  @type lane_data_attribute ::
          {:pathEndPointAngle, integer()}
          | {:laneCrownPointCenter, integer()}
          | {:laneCrownPointLeft, integer()}
          | {:laneCrownPointRight, integer()}
          | {:laneAngle, integer()}
          | {:speedLimits, [regulatory_speed_limit()]}
          | {:regional, [map()]}

  @type node_ll_b :: %{
          lon: integer(),
          lat: integer()
        }

  @type node_xy_b :: %{
          x: integer(),
          y: integer()
        }

  @type node_llmd_64b :: %{
          lon: integer(),
          lat: integer()
        }
end
