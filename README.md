# kitt

### description
Kitt provides DSRC encoding and decoding functions for Erlang and
Elixir and converts decoded message maps to Elixir structs for additional
specification enforcement and operations.

Incoming messages are UPER-encoded binary payloads in either raw or hexadecimal
format. Elixir structs or basic maps producing the necessary fields for a
valid message are accepted for encoding.

### background
Messages, data frames, and their component data elements are based on the
2016-03 ASN1 definition of the J2735 DSRC message set standard developed by
the Society of Automative Engineers (SAE).

### caution
Kitt does __NOT__ currently provide any mechanism directly for encoding or
decoding regional extensions to the DSRC standard messages, frames, and
elememnts, instead instantiating those message components as the `:asn1_OPENTYPE`
followed by the raw binary of the regional extension element.

### up next
Future planned extensions for Kitt include additional serialization/deserialization
functionality to convert decoded messages to common interchange formats such as
JSON, Protobuf, and Avro, although __this functionality has not yet been fully implemented__.

### example decoding
```
iex(1)> Kitt.decode("0014251200000A252F24E6D03FEF9CCC88740D5F7FFFFFFFF098D5F0FDFA1FA1007FFF00004B1090")
{:ok,
 %Kitt.Message.BSM{
   coreData: %Kitt.Message.BSM.CoreData{
     accelSet: %{lat: 2001, long: 2001, vert: -127, yaw: 0},
     accuracy: %{orientation: 65535, semiMajor: 255, semiMinor: 255},
     angle: 127,
     brakes: %{
       abs: :unavailable,
       ...                      <========= Additional fields omitted for brevity
     },
     elev: 2750,
     heading: 22000,
     id: <<0, 0, 40, 148>>,
     lat: 402364127,
     long: -833667351,
     msgCnt: 72,
     secMark: 48275,
     size: %{length: 530, width: 150},
     speed: 305,
     transmission: :unavailable
   },
   partII: nil,
   regional: nil
 }}
```

### example encoding
```
iex(2)> %Kitt.Message.SPAT{
...(2)>   intersections: [
...(2)>     %{
...(2)>       id: %{id: 1005, region: 0},
...(2)>       moy: 322340,
...(2)>       revision: 1,
...(2)>       states: [
...(2)>         %{
...(2)>           signalGroup: 1,
...(2)>           "state-time-speed": [
...(2)>             %{
...(2)>               eventState: :"stop-And-Remain",
...(2)>               timing: %{maxEndTime: 12966, minEndTime: 12636, startTime: 12166}
...(2)>             }
...(2)>           ]
...(2)>         },
...(2)>         %{
...(2)>           signalGroup: 2,
...(2)>           "state-time-speed": [
...(2)>             %{
...(2)>               eventState: :"permissive-Movement-Allowed",
...(2)>               timing: %{maxEndTime: 12536, minEndTime: 12436, startTime: 12166}
...(2)>             }
...(2)>           ]
...(2)>         },
...(2)>         ...                   <=========== Additional signalGroups omitted for brevity
...(2)>       ],
...(2)>       status: [:trafficDependentOperation],
...(2)>       timeStamp: 16592
...(2)>     }
...(2)>   ],
...(2)>   name: nil,
...(2)>   regional: nil,
...(2)>   timeStamp: nil
...(2)> }
"00136F0018800001F68102004EB2440D009001043C17C318AE1953001022E0BE18C250C3E001010F05F0C6178624000A08782F8630303030006045C17C318041804004021E0BE18C2F0C48002810F05F0C63D067B801808782F8630BC312000E043C17C318AE1953008021E0BE18C2F0C480"
```
