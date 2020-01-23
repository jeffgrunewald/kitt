defmodule Kitt.EncoderTest do
  use ExUnit.Case

  describe "handles frames" do
    test "decodes the message frame from a hex string" do
      input = TestHelper.bsm_frame_hex()

      result =
        {:ok,
         %Kitt.Message.BSM{
           coreData: %Kitt.Message.BSM.CoreData{
             accelSet: %{lat: 2001, long: 2001, vert: -127, yaw: 0},
             accuracy: %{orientation: 65_535, semiMajor: 255, semiMinor: 255},
             angle: 127,
             brakes: %{
               abs: :unavailable,
               auxBrakes: :unavailable,
               brakeBoost: :unavailable,
               scs: :unavailable,
               traction: :unavailable,
               wheelBrakes: []
             },
             elev: 2750,
             heading: 22_000,
             id: 10388,
             lat: 402_364_127,
             long: -833_667_351,
             msgCnt: 72,
             secMark: 48_275,
             size: %{length: 530, width: 150},
             speed: 305,
             transmission: :unavailable
           },
           partII: nil,
           regional: nil
         }}

      assert result == Kitt.Encoder.decode_frame(input)
    end

    test "encodes the message struct to a hex string wrapped in a frame" do
      input = TestHelper.bsm()

      result = "00142500400000966A7525F99BB7113E36260A767FFFFFFFF0F312C0FDFA1FA1007FFF8000962580"

      assert {:ok, result} == Kitt.Encoder.encode_frame(input)
      assert <<0, 20>> <> _payload = Base.decode16!(result)
    end
  end

  describe "handles structs" do
    test "encodes structs without specifying a type" do
      input = TestHelper.bsm()

      result = "00400000966A7525F99BB7113E36260A767FFFFFFFF0F312C0FDFA1FA1007FFF8000962580"

      assert {:ok, result} == Kitt.Encoder.encode_struct(input)

      assert {:ok, input} == Kitt.Encoder.decode_message(result, :bsm)
    end
  end

  describe "handles messages" do
    test "encodes messages to hex strings" do
      input = TestHelper.bsm()

      result = "00400000966A7525F99BB7113E36260A767FFFFFFFF0F312C0FDFA1FA1007FFF8000962580"

      assert {:ok, result} == Kitt.Encoder.encode_message(input, :bsm)
    end

    test "encodes messages to binary" do
      input = TestHelper.bsm()

      result =
        <<0, 64, 0, 0, 150, 106, 117, 37, 249, 155, 183, 17, 62, 54, 38, 10, 118, 127, 255, 255,
          255, 240, 243, 18, 192, 253, 250, 31, 161, 0, 127, 255, 128, 0, 150, 37, 128>>

      assert {:ok, result} == Kitt.Encoder.encode_message(input, :bsm, format: :binary)
    end

    test "decodes a hex string to a message" do
      input1 = TestHelper.bsm_message_hex()
      input2 = TestHelper.map_message_hex()

      result1 = %Kitt.Message.BSM{
        coreData: %Kitt.Message.BSM.CoreData{
          accelSet: %{lat: -2000, long: 32, vert: -126, yaw: -255},
          accuracy: %{orientation: 43_520, semiMajor: 180, semiMinor: 161},
          angle: -126,
          brakes: %{
            abs: :unavailable,
            auxBrakes: :unavailable,
            brakeBoost: :unavailable,
            scs: :off,
            traction: :unavailable,
            wheelBrakes: []
          },
          elev: 4097,
          heading: 4352,
          id: 0,
          lat: -899_999_984,
          long: -1_790_956_031,
          msgCnt: 0,
          secMark: 0,
          size: %{length: 62, width: 0},
          speed: 256,
          transmission: :neutral
        },
        partII: nil,
        regional: nil
      }

      result2 = %Kitt.Message.MAP{
        dataParameters: nil,
        intersections: [
          %{
            id: %{id: 1016, region: 0},
            laneSet: [
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 9, maneuver: [:maneuverLeftAllowed]},
                    signalGroup: 4
                  },
                  %{
                    connectingLane: %{lane: 12, maneuver: [:maneuverStraightAllowed]},
                    signalGroup: 4
                  },
                  %{
                    connectingLane: %{lane: 17, maneuver: [:maneuverRightAllowed]},
                    signalGroup: 4
                  }
                ],
                ingressApproach: 1,
                laneAttributes: %{
                  directionalUse: [:ingressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 1,
                maneuvers: [
                  :maneuverStraightAllowed,
                  :maneuverLeftAllowed,
                  :maneuverRightAllowed,
                  :maneuverRightTurnOnRedAllowed
                ],
                nodeList:
                  {:nodes,
                   [
                     %{delta: {:"node-XY4", %{x: 992, y: 2052}}},
                     %{delta: {:"node-XY5", %{x: 3498, y: 3842}}},
                     %{delta: {:"node-XY5", %{x: 4424, y: 5015}}}
                   ]}
              },
              %{
                egressApproach: 2,
                laneAttributes: %{
                  directionalUse: [:egressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 2,
                maneuvers: [:maneuverStraightAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{delta: {:"node-XY4", %{x: 1226, y: 1704}}},
                     %{delta: {:"node-XY5", %{x: 3450, y: 3950}}},
                     %{delta: {:"node-XY5", %{x: 4478, y: 5054}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 2, maneuver: [:maneuverRightAllowed]},
                    signalGroup: 6
                  },
                  %{
                    connectingLane: %{lane: 17, maneuver: [:maneuverStraightAllowed]},
                    signalGroup: 6
                  }
                ],
                ingressApproach: 3,
                laneAttributes: %{
                  directionalUse: [:ingressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 3,
                maneuvers: [
                  :maneuverStraightAllowed,
                  :maneuverRightAllowed,
                  :maneuverRightTurnOnRedAllowed
                ],
                nodeList:
                  {:nodes,
                   [
                     %{
                       attributes: %{
                         dWidth: 60,
                         data: [speedLimits: [%{speed: 782, type: :vehicleMaxSpeed}]]
                       },
                       delta: {:"node-XY3", %{x: 1389, y: 134}}
                     },
                     %{delta: {:"node-XY4", %{x: 2286, y: -3360}}},
                     %{delta: {:"node-XY4", %{x: 1359, y: -2045}}},
                     %{delta: {:"node-XY4", %{x: 2097, y: -2718}}},
                     %{delta: {:"node-XY4", %{x: 1413, y: -1748}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 18, maneuver: [:maneuverStraightAllowed]},
                    signalGroup: 6
                  }
                ],
                ingressApproach: 3,
                laneAttributes: %{
                  directionalUse: [:ingressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 4,
                maneuvers: [:maneuverStraightAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{delta: {:"node-XY3", %{x: 1201, y: -230}}},
                     %{delta: {:"node-XY5", %{x: 2278, y: -3420}}},
                     %{delta: {:"node-XY4", %{x: 1270, y: -1833}}},
                     %{delta: {:"node-XY4", %{x: 2024, y: -2720}}},
                     %{delta: {:"node-XY4", %{x: 1418, y: -1768}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 19, maneuver: [:maneuverStraightAllowed]},
                    signalGroup: 6
                  },
                  %{connectingLane: %{lane: 6, maneuver: [:maneuverStraightAllowed]}}
                ],
                ingressApproach: 3,
                laneAttributes: %{
                  directionalUse: [:ingressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 5,
                maneuvers: [:maneuverStraightAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{delta: {:"node-XY3", %{x: 1007, y: -602}}},
                     %{delta: {:"node-XY4", %{x: 2103, y: -3183}}},
                     %{delta: {:"node-XY3", %{x: 1087, y: -1593}}},
                     %{delta: {:"node-XY4", %{x: 2304, y: -3028}}},
                     %{delta: {:"node-XY4", %{x: 1397, y: -1777}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 9, maneuver: [:maneuverUTurnAllowed]},
                    signalGroup: 1
                  },
                  %{
                    connectingLane: %{lane: 12, maneuver: [:maneuverLeftAllowed]},
                    signalGroup: 1
                  }
                ],
                ingressApproach: 3,
                laneAttributes: %{
                  directionalUse: [:ingressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 6,
                maneuvers: [:maneuverLeftAllowed, :maneuverUTurnAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{
                       attributes: %{dWidth: -30},
                       delta: {:"node-XY3", %{x: 802, y: -962}}
                     },
                     %{delta: {:"node-XY4", %{x: 1457, y: -2238}}},
                     %{delta: {:"node-XY3", %{x: 1049, y: -1585}}},
                     %{delta: {:"node-XY3", %{x: 889, y: -593}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 17, maneuver: [:maneuverStraightAllowed]},
                    remoteIntersection: %{id: 1017, region: 0}
                  }
                ],
                egressApproach: 4,
                laneAttributes: %{
                  directionalUse: [:egressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 7,
                maneuvers: [:maneuverStraightAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{
                       attributes: %{dWidth: 30},
                       delta: {:"node-XY4", %{x: 29, y: -2129}}
                     },
                     %{delta: {:"node-XY5", %{x: 2745, y: -4117}}},
                     %{delta: {:"node-XY4", %{x: 2364, y: -3166}}},
                     %{delta: {:"node-XY4", %{x: 1544, y: -1829}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 18, maneuver: [:maneuverStraightAllowed]},
                    remoteIntersection: %{id: 1017, region: 0}
                  }
                ],
                egressApproach: 4,
                laneAttributes: %{
                  directionalUse: [:egressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 8,
                maneuvers: [:maneuverStraightAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{delta: {:"node-XY3", %{x: 311, y: -1861}}},
                     %{delta: {:"node-XY5", %{x: 2669, y: -4007}}},
                     %{delta: {:"node-XY5", %{x: 2485, y: -3286}}},
                     %{delta: {:"node-XY4", %{x: 1473, y: -1825}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{connectingLane: %{lane: 10, maneuver: [:maneuverStraightAllowed]}},
                  %{
                    connectingLane: %{lane: 19, maneuver: [:maneuverStraightAllowed]},
                    remoteIntersection: %{id: 1017, region: 0}
                  }
                ],
                egressApproach: 4,
                laneAttributes: %{
                  directionalUse: [:egressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 9,
                maneuvers: [:maneuverStraightAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{delta: {:"node-XY3", %{x: 533, y: -1516}}},
                     %{delta: {:"node-XY5", %{x: 2394, y: -3610}}},
                     %{delta: {:"node-XY5", %{x: 2862, y: -3806}}},
                     %{delta: {:"node-XY4", %{x: 1398, y: -1811}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{connectingLane: %{lane: 5, maneuver: [:maneuverUTurnAllowed]}}
                ],
                egressApproach: 4,
                laneAttributes: %{
                  directionalUse: [:egressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 10,
                maneuvers: [:maneuverUTurnAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{
                       attributes: %{dWidth: -30},
                       delta: {:"node-XY5", %{x: 2927, y: -5126}}
                     },
                     %{delta: {:"node-XY2", %{x: 698, y: -370}}},
                     %{delta: {:"node-XY4", %{x: 2406, y: -3235}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 2, maneuver: [:maneuverStraightAllowed]},
                    signalGroup: 8
                  },
                  %{
                    connectingLane: %{lane: 7, maneuver: [:maneuverRightAllowed]},
                    signalGroup: 8
                  },
                  %{
                    connectingLane: %{lane: 19, maneuver: [:maneuverLeftAllowed]},
                    signalGroup: 8
                  }
                ],
                ingressApproach: 5,
                laneAttributes: %{
                  directionalUse: [:ingressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 11,
                maneuvers: [
                  :maneuverStraightAllowed,
                  :maneuverLeftAllowed,
                  :maneuverRightAllowed,
                  :maneuverRightTurnOnRedAllowed
                ],
                nodeList:
                  {:nodes,
                   [
                     %{
                       attributes: %{
                         dWidth: -30,
                         data: [speedLimits: [%{speed: 559, type: :vehicleMaxSpeed}]]
                       },
                       delta: {:"node-XY3", %{x: -1166, y: -1513}}
                     },
                     %{delta: {:"node-XY4", %{x: -3324, y: -2145}}},
                     %{delta: {:"node-XY4", %{x: -1941, y: -1349}}},
                     %{delta: {:"node-XY3", %{x: -893, y: -1206}}},
                     %{delta: {:"node-XY2", %{x: 223, y: -981}}},
                     %{delta: {:"node-XY2", %{x: 610, y: -795}}},
                     %{delta: {:"node-XY2", %{x: 803, y: -467}}},
                     %{delta: {:"node-XY3", %{x: 1077, y: 40}}},
                     %{delta: {:"node-XY4", %{x: 2356, y: 1671}}}
                   ]}
              },
              %{
                egressApproach: 6,
                laneAttributes: %{
                  directionalUse: [:egressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 12,
                maneuvers: [:maneuverStraightAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{delta: {:"node-XY3", %{x: -1472, y: -1061}}},
                     %{delta: {:"node-XY4", %{x: -3279, y: -2266}}},
                     %{delta: {:"node-XY4", %{x: -1947, y: -1416}}},
                     %{delta: {:"node-XY3", %{x: -886, y: -1433}}},
                     %{delta: {:"node-XY3", %{x: 229, y: -1102}}},
                     %{delta: {:"node-XY3", %{x: 702, y: -876}}},
                     %{delta: {:"node-XY3", %{x: 894, y: -566}}},
                     %{delta: {:"node-XY3", %{x: 1353, y: 146}}},
                     %{delta: {:"node-XY4", %{x: 2375, y: 1645}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 7, maneuver: [:maneuverStraightAllowed]},
                    signalGroup: 2
                  },
                  %{
                    connectingLane: %{lane: 12, maneuver: [:maneuverRightAllowed]},
                    signalGroup: 2
                  }
                ],
                ingressApproach: 7,
                laneAttributes: %{
                  directionalUse: [:ingressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 13,
                maneuvers: [
                  :maneuverStraightAllowed,
                  :maneuverRightAllowed,
                  :maneuverRightTurnOnRedAllowed
                ],
                nodeList:
                  {:nodes,
                   [
                     %{
                       attributes: %{
                         dWidth: 60,
                         data: [speedLimits: [%{speed: 782, type: :vehicleMaxSpeed}]]
                       },
                       delta: {:"node-XY3", %{x: -1632, y: 386}}
                     },
                     %{delta: {:"node-XY5", %{x: -2634, y: 4108}}},
                     %{delta: {:"node-XY6", %{x: -5236, y: 8113}}},
                     %{delta: {:"node-XY5", %{x: -2605, y: 4090}}},
                     %{delta: {:"node-XY5", %{x: -3227, y: 5016}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 8, maneuver: [:maneuverStraightAllowed]},
                    signalGroup: 2
                  }
                ],
                ingressApproach: 7,
                laneAttributes: %{
                  directionalUse: [:ingressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 14,
                maneuvers: [:maneuverStraightAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{delta: {:"node-XY3", %{x: -1380, y: 644}}},
                     %{delta: {:"node-XY5", %{x: -2640, y: 4127}}},
                     %{delta: {:"node-XY6", %{x: -5225, y: 8159}}},
                     %{delta: {:"node-XY5", %{x: -2543, y: 3890}}},
                     %{delta: {:"node-XY5", %{x: -3150, y: 4939}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 9, maneuver: [:maneuverStraightAllowed]},
                    signalGroup: 2
                  },
                  %{connectingLane: %{lane: 16, maneuver: [:maneuverStraightAllowed]}}
                ],
                ingressApproach: 7,
                laneAttributes: %{
                  directionalUse: [:ingressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 15,
                maneuvers: [:maneuverStraightAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{delta: {:"node-XY3", %{x: -1127, y: 923}}},
                     %{delta: {:"node-XY5", %{x: -2703, y: 4207}}},
                     %{delta: {:"node-XY4", %{x: -2186, y: 3419}}},
                     %{delta: {:"node-XY5", %{x: -2940, y: 4590}}},
                     %{delta: {:"node-XY5", %{x: -2642, y: 4066}}},
                     %{delta: {:"node-XY5", %{x: -3091, y: 4723}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 2, maneuver: [:maneuverLeftAllowed]},
                    signalGroup: 5
                  },
                  %{
                    connectingLane: %{lane: 19, maneuver: [:maneuverUTurnAllowed]},
                    signalGroup: 5
                  }
                ],
                ingressApproach: 7,
                laneAttributes: %{
                  directionalUse: [:ingressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 16,
                maneuvers: [:maneuverLeftAllowed, :maneuverUTurnAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{
                       attributes: %{dWidth: -30},
                       delta: {:"node-XY3", %{x: -879, y: 1216}}
                     },
                     %{delta: {:"node-XY5", %{x: -2666, y: 4122}}},
                     %{delta: {:"node-XY4", %{x: -1488, y: 2360}}},
                     %{delta: {:"node-XY3", %{x: -983, y: 851}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 8, maneuver: [:maneuverStraightAllowed]},
                    remoteIntersection: %{id: 1015, region: 0}
                  }
                ],
                egressApproach: 8,
                laneAttributes: %{
                  directionalUse: [:egressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 17,
                maneuvers: [:maneuverStraightAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{
                       attributes: %{dWidth: 30},
                       delta: {:"node-XY4", %{x: 50, y: 2236}}
                     },
                     %{delta: {:"node-XY6", %{x: -5722, y: 8768}}},
                     %{delta: {:"node-XY6", %{x: -5508, y: 8599}}},
                     %{delta: {:"node-XY4", %{x: -2059, y: 3299}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 9, maneuver: [:maneuverStraightAllowed]},
                    remoteIntersection: %{id: 1015, region: 0}
                  }
                ],
                egressApproach: 8,
                laneAttributes: %{
                  directionalUse: [:egressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 18,
                maneuvers: [:maneuverStraightAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{delta: {:"node-XY3", %{x: -236, y: 1880}}},
                     %{delta: {:"node-XY6", %{x: -5732, y: 8840}}},
                     %{delta: {:"node-XY6", %{x: -5509, y: 8534}}},
                     %{delta: {:"node-XY4", %{x: -2102, y: 3457}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 10, maneuver: [:maneuverStraightAllowed]},
                    remoteIntersection: %{id: 1015, region: 0}
                  }
                ],
                egressApproach: 8,
                laneAttributes: %{
                  directionalUse: [:egressPath],
                  laneType: {:vehicle, []},
                  sharedWith: []
                },
                laneID: 19,
                maneuvers: [:maneuverStraightAllowed],
                nodeList:
                  {:nodes,
                   [
                     %{delta: {:"node-XY3", %{x: -498, y: 1621}}},
                     %{delta: {:"node-XY6", %{x: -5813, y: 8969}}},
                     %{delta: {:"node-XY6", %{x: -5497, y: 8524}}},
                     %{delta: {:"node-XY4", %{x: -2049, y: 3392}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 22, maneuver: [:maneuverLeftAllowed]},
                    signalGroup: 14
                  }
                ],
                laneAttributes: %{
                  directionalUse: [:ingressPath, :egressPath],
                  laneType: {:crosswalk, [:hasPushToWalkButton, :audioSupport]},
                  sharedWith: []
                },
                laneID: 20,
                nodeList:
                  {:nodes,
                   [
                     %{
                       attributes: %{dWidth: -30},
                       delta: {:"node-XY4", %{x: 534, y: 2542}}
                     },
                     %{delta: {:"node-XY3", %{x: 862, y: -1329}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 22, maneuver: [:maneuverRightAllowed]},
                    signalGroup: 10
                  }
                ],
                laneAttributes: %{
                  directionalUse: [:ingressPath, :egressPath],
                  laneType: {:crosswalk, [:hasPushToWalkButton, :audioSupport]},
                  sharedWith: []
                },
                laneID: 21,
                nodeList:
                  {:nodes,
                   [
                     %{delta: {:"node-XY4", %{x: -408, y: -2523}}},
                     %{delta: {:"node-XY4", %{x: -1295, y: 1976}}}
                   ]}
              },
              %{
                connectsTo: [
                  %{
                    connectingLane: %{lane: 20, maneuver: [:maneuverRightAllowed]},
                    signalGroup: 12
                  },
                  %{
                    connectingLane: %{lane: 21, maneuver: [:maneuverLeftAllowed]},
                    signalGroup: 12
                  }
                ],
                laneAttributes: %{
                  directionalUse: [:ingressPath, :egressPath],
                  laneType: {:crosswalk, [:hasPushToWalkButton, :audioSupport]},
                  sharedWith: []
                },
                laneID: 22,
                nodeList:
                  {:nodes,
                   [
                     %{delta: {:"node-XY3", %{x: -1884, y: -142}}},
                     %{delta: {:"node-XY4", %{x: 2418, y: 2684}}}
                   ]}
              },
              %{
                laneAttributes: %{
                  directionalUse: [:ingressPath, :egressPath],
                  laneType: {:crosswalk, []},
                  sharedWith: []
                },
                laneID: 23,
                nodeList:
                  {:nodes,
                   [
                     %{delta: {:"node-XY6", %{x: 7623, y: -7688}}},
                     %{delta: {:"node-XY3", %{x: -1244, y: -1043}}},
                     %{delta: {:"node-XY3", %{x: -1505, y: -1051}}}
                   ]}
              }
            ],
            laneWidth: 300,
            refPoint: %{elevation: 180, lat: 374_067_026, long: -1_221_203_447},
            revision: 0,
            speedLimits: [%{speed: 559, type: :vehicleMaxSpeed}]
          }
        ],
        layerID: nil,
        layerType: :intersectionData,
        msgIssueRevision: 11,
        regional: nil,
        restrictionList: nil,
        roadSegments: nil,
        timeStamp: nil
      }

      assert {:ok, result1} == Kitt.Encoder.decode_message(input1, :bsm)
      assert {:ok, result2} == Kitt.Encoder.decode_message(input2, :map)
    end

    test "decodes a binary to a message" do
      input1 = TestHelper.spat_message_binary()
      input2 = TestHelper.srm_message_binary()

      result1 = %Kitt.Message.SPAT{
        intersections: [
          %{
            id: %{id: 1002, region: 0},
            moy: 322_309,
            revision: 1,
            states: [
              %{
                signalGroup: 1,
                "state-time-speed": [
                  %{
                    eventState: :"protected-clearance",
                    timing: %{maxEndTime: 29_788, minEndTime: 29_788, startTime: 29_751}
                  }
                ]
              },
              %{
                signalGroup: 2,
                "state-time-speed": [
                  %{
                    eventState: :"stop-And-Remain",
                    timing: %{maxEndTime: 29_788, minEndTime: 29_788, startTime: 29_751}
                  }
                ]
              },
              %{
                signalGroup: 3,
                "state-time-speed": [
                  %{
                    eventState: :"stop-And-Remain",
                    timing: %{maxEndTime: 30_239, minEndTime: 30_099, startTime: 29_751}
                  }
                ]
              },
              %{
                signalGroup: 4,
                "state-time-speed": [
                  %{
                    eventState: :"stop-And-Remain",
                    timing: %{maxEndTime: 30_746, minEndTime: 30_256, startTime: 29_751}
                  }
                ]
              },
              %{
                signalGroup: 5,
                "state-time-speed": [
                  %{
                    eventState: :"stop-And-Remain",
                    timing: %{maxEndTime: 31_393, minEndTime: 30_723, startTime: 29_751}
                  }
                ]
              },
              %{
                signalGroup: 6,
                "state-time-speed": [
                  %{
                    eventState: :"permissive-Movement-Allowed",
                    timing: %{maxEndTime: 30_161, minEndTime: 29_784, startTime: 29_751}
                  }
                ]
              },
              %{
                signalGroup: 7,
                "state-time-speed": [
                  %{
                    eventState: :"stop-And-Remain",
                    timing: %{maxEndTime: 30_239, minEndTime: 30_099, startTime: 29_751}
                  }
                ]
              },
              %{
                signalGroup: 8,
                "state-time-speed": [
                  %{
                    eventState: :"stop-And-Remain",
                    timing: %{maxEndTime: 30_876, minEndTime: 30_256, startTime: 29_751}
                  }
                ]
              },
              %{
                signalGroup: 10,
                "state-time-speed": [
                  %{
                    eventState: :"stop-And-Remain",
                    timing: %{maxEndTime: 29_788, minEndTime: 29_788, startTime: 29_751}
                  }
                ]
              },
              %{
                signalGroup: 12,
                "state-time-speed": [
                  %{
                    eventState: :"stop-And-Remain",
                    timing: %{maxEndTime: 30_746, minEndTime: 30_256, startTime: 29_751}
                  }
                ]
              },
              %{
                signalGroup: 14,
                "state-time-speed": [
                  %{
                    eventState: :"stop-And-Remain",
                    timing: %{maxEndTime: 31_810, minEndTime: 30_880, startTime: 29_751}
                  }
                ]
              },
              %{
                signalGroup: 16,
                "state-time-speed": [
                  %{
                    eventState: :"stop-And-Remain",
                    timing: %{maxEndTime: 30_876, minEndTime: 30_256, startTime: 29_751}
                  }
                ]
              }
            ],
            status: [],
            timeStamp: 35_193
          }
        ],
        name: nil,
        regional: nil,
        timeStamp: nil
      }

      result2 = %Kitt.Message.SRM{
        regional: nil,
        requestor: %{
          id: {:entityID, <<0, 0, 2, 89>>},
          position: %{
            heading: 4800,
            position: %{elevation: 1260, lat: 374_230_638, long: -1_221_420_467},
            speed: %{speed: 486, transmisson: :unavailable}
          },
          type: %{hpmsType: :bus, role: :transit}
        },
        requests: [
          %{
            duration: 2000,
            minute: 497_732,
            request: %{
              id: %{id: 1003, region: 0},
              inBoundLane: {:lane, 8},
              outBoundLane: {:lane, 30},
              requestID: 5,
              requestType: :priorityRequest
            },
            second: 18_140
          }
        ],
        second: 48_140,
        sequenceNumber: 2,
        timeStamp: 497_731
      }

      assert {:ok, result1} == Kitt.Encoder.decode_message(input1, :spat, format: :binary)
      assert {:ok, result2} == Kitt.Encoder.decode_message(input2, :srm, format: :binary)
    end
  end
end
