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

  defdelegate encode(message, opts \\ []), to: Kitt.Encoder, as: :encode_frame
  defdelegate encode!(message, opts \\ []), to: Kitt.Encoder, as: :encode_frame!
  defdelegate decode(binary, opts \\ []), to: Kitt.Encoder, as: :decode_frame
  defdelegate decode!(binary, opts \\ []), to: Kitt.Encoder, as: :decode_frame!

  defmodule(DSRCEncodeError, do: defexception([:message]))
  defmodule(DSRCDecodeError, do: defexception([:message]))
end
