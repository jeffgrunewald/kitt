defmodule Kitt do
  @moduledoc """
  Provides encoding and decoding functionality
  for UPER-encoded DSRC message payloads defined
  by the J2735 standard defined by the Society for
  Automotive Engineers.

  Kitt uses Erlang's native ASN1 compiler to parse
  the raw binary of the DSRC messages and then converts
  them to Elixir structs for language-native enforcement
  of required message fields, interactions with message
  data frames/elements, and more flexible conversion to
  common interchange formats such as JSON, Protobuf, Avro, etc.
  """

  @doc """
  Encodes a message struct wrapped in a message frame, tagged with
  the message type identifying integer as the second byte of the message.

  Defaults the format of the encoded message to a hexadecimal string. Optionally
  specify the desired output format with the option `format: :hex | :binary`.

  Returns the encoded message as `{:ok, encoded_message}` or `{:error, reason}`

  ## Example

      iex> Kitt.encode(%Kitt.Message.BSM{
      ...>       coreData: %Kitt.Message.BSM.CoreData{
      ...>         accelSet: %{lat: 2001, long: 2001, vert: -127, yaw: 0},
      ...>         accuracy: %{orientation: 65535, semiMajor: 255, semiMinor: 255},
      ...>         angle: 127,
      ...>         brakes: %{
      ...>           abs: :unavailable,
      ...>           auxBrakes: :unavailable,
      ...>           brakeBoost: :unavailable,
      ...>           scs: :unavailable,
      ...>           traction: :unavailable,
      ...>           wheelBrakes: [:unavailable]
      ...>         },
      ...>         elev: 1260,
      ...>         heading: 4800,
      ...>         id: <<0, 0, 2, 89>>,
      ...>         lat: 374_230_638,
      ...>         long: -1_221_420_467,
      ...>         msgCnt: 1,
      ...>         secMark: 43476,
      ...>         size: %{length: 1200, width: 300},
      ...>         speed: 486,
      ...>         transmission: :unavailable
      ...>       },
      ...>       partII: nil,
      ...>       regional: nil
      ...>     })
      {:ok,
       "00142500400000966A7525F99BB7113E36260A767FFFFFFFF0F312C0FDFA1FA1007FFF8000962580"}
  """
  defdelegate encode(message, opts \\ []), to: Kitt.Encoder, as: :encode_frame

  @doc """
  The same as `encode/2` but returns the encoded message directly,
  else raises a `DSRCEncodeError`

  ## Example
      iex> Kitt.encode!(%Kitt.Message.BSM{
      ...>       coreData: %Kitt.Message.BSM.CoreData{
      ...>         accelSet: %{lat: 2001, long: 2001, vert: -127, yaw: 0},
      ...>         accuracy: %{orientation: 65535, semiMajor: 255, semiMinor: 255},
      ...>         angle: 127,
      ...>         brakes: %{
      ...>           abs: :unavailable,
      ...>           auxBrakes: :unavailable,
      ...>           brakeBoost: :unavailable,
      ...>           scs: :unavailable,
      ...>           traction: :unavailable,
      ...>           wheelBrakes: [:unavailable]
      ...>         },
      ...>         elev: 1260,
      ...>         heading: 4800,
      ...>         id: <<0, 0, 2, 89>>,
      ...>         lat: 374_230_638,
      ...>         long: -1_221_420_467,
      ...>         msgCnt: 1,
      ...>         secMark: 43476,
      ...>         size: %{length: 1200, width: 300},
      ...>         speed: 486,
      ...>         transmission: :unavailable
      ...>       },
      ...>       partII: nil,
      ...>       regional: nil
      ...>     }, format: :binary)
      <<0, 20, 37, 0, 64, 0, 0, 150, 106, 117, 37, 249, 155, 183, 17, 62, 54, 38, 10,
      118, 127, 255, 255, 255, 240, 243, 18, 192, 253, 250, 31, 161, 0, 127, 255,
      128, 0, 150, 37, 128>>
  """
  defdelegate encode!(message, opts \\ []), to: Kitt.Encoder, as: :encode_frame!

  @doc """
  Decodes a message wrapped in a message frame, tagged with the message type
  identifying integer as the second byte of the message, to a Kitt Elixir
  struct representing the messaage content.

  Defaults the expected input format of the message to a hexadecimal string.
  Optionally specify the input format with the option `format: :hex | :binary`.

  Returns the decoded message as `{:ok, %Struct{}}` or `{:error, reason}`

  ## Example
      iex> Kitt.decode(<<0, 29, 45, 115, 204, 33, 222, 6, 2, 3, 148, 0, 0, 15, 172, 20, 128, 128, 60,
      ...> 243, 8, 136, 219, 128, 250, 12, 0, 0, 0, 18, 200, 72, 25, 169, 126, 102, 237,
      ...> 196, 79, 141, 137, 130, 157, 132, 176, 56, 121, 128>>, format: :binary)
      {:ok,
       %Kitt.Message.SRM{
         regional: nil,
         requestor: %{
           id: {:entityID, <<0, 0, 2, 89>>},
           position: %{
             heading: 4800,
             position: %{elevation: 1260, lat: 374230638, long: -1221420467},
             speed: %{speed: 486, transmisson: :unavailable}
           },
           type: %{hpmsType: :bus, role: :transit}
         },
         requests: [
           %{
             duration: 2000,
             minute: 497732,
             request: %{
               id: %{id: 1003, region: 0},
               inBoundLane: {:lane, 8},
               outBoundLane: {:lane, 30},
               requestID: 5,
               requestType: :priorityRequest
             },
             second: 18140
           }
         ],
         second: 48140,
         sequenceNumber: 2,
         timeStamp: 497731
       }}
  """
  defdelegate decode(binary, opts \\ []), to: Kitt.Encoder, as: :decode_frame

  @doc """
  The same as `decode/2` but returns the encoded message directly,
  else raises a `DSRCDecodeError`

  ## Example
      iex> Kitt.decode!("001D2D73CC21DE0602039400000FAC1480803CF30888DB80FA0C00000012C84819A97E66EDC44F8D89829D84B0387980")
      %Kitt.Message.SRM{
        regional: nil,
        requestor: %{
          id: {:entityID, <<0, 0, 2, 89>>},
          position: %{
            heading: 4800,
            position: %{elevation: 1260, lat: 374230638, long: -1221420467},
            speed: %{speed: 486, transmisson: :unavailable}
          },
          type: %{hpmsType: :bus, role: :transit}
        },
        requests: [
          %{
            duration: 2000,
            minute: 497732,
            request: %{
              id: %{id: 1003, region: 0},
              inBoundLane: {:lane, 8},
              outBoundLane: {:lane, 30},
              requestID: 5,
              requestType: :priorityRequest
            },
            second: 18140
          }
        ],
        second: 48140,
        sequenceNumber: 2,
        timeStamp: 497731
      }
  """
  defdelegate decode!(binary, opts \\ []), to: Kitt.Encoder, as: :decode_frame!

  defmodule(DSRCEncodeError, do: defexception([:message]))
  defmodule(DSRCDecodeError, do: defexception([:message]))
end
