defmodule Kitt.UtilTest do
  use ExUnit.Case

  alias Kitt.Util

  test "encodes an ID field" do
    assert Util.encode_id(1234) == <<0, 0, 4, 210>>
  end

  test "decodes an ID field" do
    assert Util.decode_id(<<0, 0, 4, 210>>) == 1234
  end

  test "converts type identifiers" do
    assert Util.type(:bsm) == {Kitt.Message.BSM, :BasicSafetyMessage}
    assert Util.type(18) == {Kitt.Message.MAP, :MapData}
    assert Util.type(:spat) == {Kitt.Message.SPAT, :SPAT}
    assert Util.type(31) == {Kitt.Message.TIM, :TravelerInformation}
    assert Util.type(:psm) == {Kitt.Message.PSM, :PersonalSafetyMessage}
  end

  test "returns the expected format" do
    assert Util.get_format(format: :binary) == :binary
    assert Util.get_format(format: :hex) == :hex
    assert Util.get_format(other: :unrelated) == :hex
  end

  test "ensures binary format" do
    assert Util.to_binary(<<0, 1, 2, 3>>) == <<0, 1, 2, 3>>
    assert Util.to_binary(1) == <<1>>
  end

  test "converts structs and sub-structs to maps" do
    result = struct(TestOuterStruct) |> Util.to_map_recursive()

    assert result == %{
             id: 123,
             name: "Test Struct",
             sub_struct: %{
               description: "An inner struct",
               properties: %{
                 key1: "value1",
                 key2: "value2"
               },
               type: :foo
             }
           }
  end
end

defmodule TestInnerStruct do
  defstruct type: :foo,
            description: "An inner struct",
            properties: %{
              key1: "value1",
              key2: "value2"
            }
end

defmodule TestOuterStruct do
  defstruct id: 123,
            name: "Test Struct",
            sub_struct: struct(TestInnerStruct)
end
