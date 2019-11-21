defmodule Kitt.PSM do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant PersonalSafetyMessage.
  """

  @type t :: %__MODULE__{
          accelSet: %{
            long: integer(),
            lat: integer(),
            vert: integer(),
            yaw: integer()
          },
          accuracy: %{
            semiMajor: non_neg_integer(),
            semiMinor: non_neg_integer(),
            orientation: non_neg_integer()
          },
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
          pathHistory: %{
            initialPosition: %{
              utcTime: %{
                year: non_neg_integer(),
                month: non_neg_integer(),
                day: non_neg_integer(),
                hour: non_neg_integer(),
                minute: non_neg_integer(),
                second: non_neg_integer(),
                offset: integer()
              },
              long: integer(),
              lat: integer(),
              elevation: integer(),
              heading: non_neg_integer(),
              speed: %{
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
              },
              posAccuracy: %{
                semiMajor: non_neg_integer(),
                semiMinor: non_neg_integer(),
                orientation: non_neg_integer()
              },
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
              posConfidence: %{
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
              },
              speedConfidence: %{
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
            },
            currGNSSstatus: binary(),
            crumbData: [
              %{
                latOffset: integer(),
                lonOffset: integer(),
                elevationOffset: integer(),
                timeOffset: non_neg_integer(),
                speed: non_neg_integer(),
                osAccuracy: %{
                  semiMajor: non_neg_integer(),
                  semiMinor: non_neg_integer(),
                  orientation: non_neg_integer()
                },
                heading: non_neg_integer()
              }
            ]
          },
          pathPrediction: %{
            radiusOfCurve: integer(),
            confidence: non_neg_integer()
          },
          position: %{
            lat: integer(),
            long: integer(),
            elevation: integer(),
            regional: [map()]
          },
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
          regional: [map()],
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
end
