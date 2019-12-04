defmodule Kitt.Message.TIM do
  @moduledoc """
  Defines the structure and instantiation function
  for creating a J2735-compliant Traveler Information message

  A `TIM` defines a generic message type used to relay various advisory
  notifications to equipped devices, including but not limited to vehicles
  """

  @typedoc "Defines the structure of a TravelerInformation message and the data elements comprising its fields"
  @type t :: %__MODULE__{
          msgCnt: non_neg_integer(),
          timeStamp: Kitt.Types.minute_of_year(),
          packetID: binary(),
          urlB: String.t(),
          dataFrames: [traveler_data_frame()],
          regional: [Kitt.Types.regional_extension()]
        }

  @type traveler_data_frame :: %{
          sspTimRights: non_neg_integer(),
          frameType:
            :unknown
            | :advisory
            | :roadSignage
            | :commercialSignage,
          msdId: msg_id(),
          startYear: non_neg_integer(),
          startTime: non_neg_integer(),
          durationTime: non_neg_integer(),
          priority: non_neg_integer(),
          sspLocationRights: non_neg_integer(),
          regions: [geographical_path()],
          sspMsgRights1: non_neg_integer(),
          sspMsgRights2: non_neg_integer(),
          content: content(),
          url: String.t()
        }

  @type msg_id :: %{
          furtherInfoID: binary(),
          roadSignID: road_sign_id()
        }

  @type road_sign_id :: %{
          position: Kitt.Types.position_3d(),
          viewAngle: bitstring(),
          mutcdCode:
            :none
            | :regulatory
            | :warning
            | :maintenance
            | :motoristService
            | :guide
            | :rec,
          crc: binary()
        }

  @type geographical_path :: %{
          name: String.t(),
          id: Kitt.Types.road_segment_reference_id(),
          anchor: Kitt.Types.position_3d(),
          laneWidth: non_neg_integer(),
          directionality: direction_of_use(),
          closedPath: boolean(),
          direction: bitstring(),
          description: description(),
          regional: [Kitt.Types.regional_extension()]
        }

  @type direction_of_use ::
          :unavailable
          | :forward
          | :reverse
          | :both

  @type description ::
          {:path, Kitt.Types.offset_system()}
          | {:geometry, geometric_projection()}
          | {:oldRegion, valid_region()}
          | {:regional, [Kitt.Types.regional_extension()]}

  @type valid_region :: %{
          direction: bitstring(),
          extent: Kitt.Types.extent(),
          area: area()
        }

  @type area ::
          {:shapePointSet, shape_point_set()}
          | {:circle, circle()}
          | {:regionPointSet, region_point_set()}

  @type shape_point_set :: %{
          achor: Kitt.Types.position_3d(),
          laneWidth: non_neg_integer(),
          directionality: direction_of_use()
        }

  @type region_point_set :: %{
          anchor: Kitt.Types.position_3d(),
          scale: non_neg_integer(),
          nodeList: [region_offset()]
        }

  @type region_offset :: %{
          xOffset: integer(),
          yOffset: integer(),
          zOffset: integer()
        }

  @type geometric_projection :: %{
          direction: bitstring(),
          extent: Kitt.Types.extent(),
          laneWidth: non_neg_integer(),
          circle: circle(),
          regional: [Kitt.Types.regional_extension()]
        }

  @type circle :: %{
          center: Kitt.Types.position_3d(),
          radius: non_neg_integer(),
          units:
            :centimeter
            | :"cm2-5"
            | :decimeter
            | :meter
            | :kilometer
            | :foot
            | :yard
            | :mile
        }

  @type content :: %{
          advisory: [itis_item()],
          workZone: itis_item(),
          genericSign: itis_item(),
          speedLimit: itis_item(),
          exitService: itis_item()
        }

  @type itis_item :: %{
          itis: non_neg_integer(),
          text: String.t()
        }

  @derive Jason.Encoder
  @enforce_keys [:msgCnt, :dataFrames]
  defstruct [:dataFrames, :msgCnt, :packetID, :regional, :timeStamp, :urlB]

  @doc """
  Produces a `TIM` message struct from an equivalent map or keyword input
  """
  @spec new(map() | keyword()) :: t()
  def new(message), do: struct(__MODULE__, message)

  @doc """
  Returns the `TIM` identifying integer
  """
  @spec type_id() :: non_neg_integer()
  def type_id(), do: :DSRC.travelerInformation()

  @doc """
  Returns the `TIM` identifying atom recognized by the ASN1 spec
  """
  @spec type() :: atom()
  def type(), do: :TravelerInformation
end
