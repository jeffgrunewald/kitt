%% Generated by the Erlang ASN.1 PER (unaligned) compiler. Version: 5.0.9
%% Purpose: Encoding and decoding of the types in ITIS.

-module('ITIS').
-compile(nowarn_unused_vars).
-dialyzer(no_improper_lists).
-asn1_info([{vsn,'5.0.9'},
            {module,'ITIS'},
            {options,[{i,"src"},maps,uper,noobj,{outdir,"src"},{i,"."},{i,"asn1"}]}]).

-export([encoding_rule/0,maps/0,bit_string_format/0,
         legacy_erlang_types/0]).
-export(['dialyzer-suppressions'/1]).
-export([
enc_GenericLocations/1,
enc_IncidentResponseEquipment/1,
enc_ITIStext/1,
enc_ResponderGroupAffected/1,
enc_VehicleGroupAffected/1,
enc_ITIScodesAndText/1,
enc_ITIScodes/1
]).

-export([
dec_GenericLocations/1,
dec_IncidentResponseEquipment/1,
dec_ITIStext/1,
dec_ResponderGroupAffected/1,
dec_VehicleGroupAffected/1,
dec_ITIScodesAndText/1,
dec_ITIScodes/1
]).

-export([info/0]).

-export([encode/2,decode/2]).

encoding_rule() -> uper.

maps() -> true.

bit_string_format() -> bitstring.

legacy_erlang_types() -> false.

encode(Type, Data) ->
try complete(encode_disp(Type, Data)) of
  Bytes ->
    {ok,Bytes}
  catch
    Class:Exception:Stk when Class =:= error; Class =:= exit ->
      case Exception of
        {error,{asn1,Reason}} ->
          {error,{asn1,{Reason,Stk}}};
        Reason ->
         {error,{asn1,{Reason,Stk}}}
      end
end.

decode(Type, Data) ->
try
   {Result,_Rest} = decode_disp(Type, Data),
   {ok,Result}
  catch
    Class:Exception:Stk when Class =:= error; Class =:= exit ->
      case Exception of
        {error,{asn1,Reason}} ->
          {error,{asn1,{Reason,Stk}}};
        Reason ->
         {error,{asn1,{Reason,Stk}}}
      end
end.

encode_disp('GenericLocations', Data) -> enc_GenericLocations(Data);
encode_disp('IncidentResponseEquipment', Data) -> enc_IncidentResponseEquipment(Data);
encode_disp('ITIStext', Data) -> enc_ITIStext(Data);
encode_disp('ResponderGroupAffected', Data) -> enc_ResponderGroupAffected(Data);
encode_disp('VehicleGroupAffected', Data) -> enc_VehicleGroupAffected(Data);
encode_disp('ITIScodesAndText', Data) -> enc_ITIScodesAndText(Data);
encode_disp('ITIScodes', Data) -> enc_ITIScodes(Data);
encode_disp(Type, _Data) -> exit({error,{asn1,{undefined_type,Type}}}).

decode_disp('GenericLocations', Data) -> dec_GenericLocations(Data);
decode_disp('IncidentResponseEquipment', Data) -> dec_IncidentResponseEquipment(Data);
decode_disp('ITIStext', Data) -> dec_ITIStext(Data);
decode_disp('ResponderGroupAffected', Data) -> dec_ResponderGroupAffected(Data);
decode_disp('VehicleGroupAffected', Data) -> dec_VehicleGroupAffected(Data);
decode_disp('ITIScodesAndText', Data) -> dec_ITIScodesAndText(Data);
decode_disp('ITIScodes', Data) -> dec_ITIScodes(Data);
decode_disp(Type, _Data) -> exit({error,{asn1,{undefined_type,Type}}}).

info() ->
   case ?MODULE:module_info(attributes) of
     Attributes when is_list(Attributes) ->
       case lists:keyfind(asn1_info, 1, Attributes) of
         {_,Info} when is_list(Info) ->
           Info;
         _ ->
           []
       end;
     _ ->
       []
   end.
enc_GenericLocations(Val) ->
if Val =:= 'on-bridges' ->
<<0:1,0:7>>;
Val =:= 'in-tunnels' ->
<<0:1,1:7>>;
Val =:= 'entering-or-leaving-tunnels' ->
<<0:1,2:7>>;
Val =:= 'on-ramps' ->
<<0:1,3:7>>;
Val =:= 'in-road-construction-area' ->
<<0:1,4:7>>;
Val =:= 'around-a-curve' ->
<<0:1,5:7>>;
Val =:= 'on-minor-roads' ->
<<0:1,6:7>>;
Val =:= 'in-the-opposing-lanes' ->
<<0:1,7:7>>;
Val =:= 'adjacent-to-roadway' ->
<<0:1,8:7>>;
Val =:= 'on-bend' ->
<<0:1,9:7>>;
Val =:= 'entire-intersection' ->
<<0:1,10:7>>;
Val =:= 'in-the-median' ->
<<0:1,11:7>>;
Val =:= 'moved-to-side-of-road' ->
<<0:1,12:7>>;
Val =:= 'moved-to-shoulder' ->
<<0:1,13:7>>;
Val =:= 'on-the-roadway' ->
<<0:1,14:7>>;
Val =:= 'in-shaded-areas' ->
<<0:1,15:7>>;
Val =:= 'in-low-lying-areas' ->
<<0:1,16:7>>;
Val =:= 'in-the-downtown-area' ->
<<0:1,17:7>>;
Val =:= 'in-the-inner-city-area' ->
<<0:1,18:7>>;
Val =:= 'in-parts' ->
<<0:1,19:7>>;
Val =:= 'in-some-places' ->
<<0:1,20:7>>;
Val =:= 'in-the-ditch' ->
<<0:1,21:7>>;
Val =:= 'in-the-valley' ->
<<0:1,22:7>>;
Val =:= 'on-hill-top' ->
<<0:1,23:7>>;
Val =:= 'near-the-foothills' ->
<<0:1,24:7>>;
Val =:= 'at-high-altitudes' ->
<<0:1,25:7>>;
Val =:= 'near-the-lake' ->
<<0:1,26:7>>;
Val =:= 'near-the-shore' ->
<<0:1,27:7>>;
Val =:= 'over-the-crest-of-a-hill' ->
<<0:1,28:7>>;
Val =:= 'other-than-on-the-roadway' ->
<<0:1,29:7>>;
Val =:= 'near-the-beach' ->
<<0:1,30:7>>;
Val =:= 'near-beach-access-point' ->
<<0:1,31:7>>;
Val =:= 'lower-level' ->
<<0:1,32:7>>;
Val =:= 'upper-level' ->
<<0:1,33:7>>;
Val =:= airport ->
<<0:1,34:7>>;
Val =:= concourse ->
<<0:1,35:7>>;
Val =:= gate ->
<<0:1,36:7>>;
Val =:= 'baggage-claim' ->
<<0:1,37:7>>;
Val =:= 'customs-point' ->
<<0:1,38:7>>;
Val =:= station ->
<<0:1,39:7>>;
Val =:= platform ->
<<0:1,40:7>>;
Val =:= dock ->
<<0:1,41:7>>;
Val =:= depot ->
<<0:1,42:7>>;
Val =:= 'ev-charging-point' ->
<<0:1,43:7>>;
Val =:= 'information-welcome-point' ->
<<0:1,44:7>>;
Val =:= 'at-rest-area' ->
<<0:1,45:7>>;
Val =:= 'at-service-area' ->
<<0:1,46:7>>;
Val =:= 'at-weigh-station' ->
<<0:1,47:7>>;
Val =:= 'picnic-areas' ->
<<0:1,48:7>>;
Val =:= 'rest-area' ->
<<0:1,49:7>>;
Val =:= 'service-stations' ->
<<0:1,50:7>>;
Val =:= toilets ->
<<0:1,51:7>>;
Val =:= 'on-the-right' ->
<<0:1,52:7>>;
Val =:= 'on-the-left' ->
<<0:1,53:7>>;
Val =:= 'in-the-center' ->
<<0:1,54:7>>;
Val =:= 'in-the-opposite-direction' ->
<<0:1,55:7>>;
Val =:= 'cross-traffic' ->
<<0:1,56:7>>;
Val =:= 'northbound-traffic' ->
<<0:1,57:7>>;
Val =:= 'eastbound-traffic' ->
<<0:1,58:7>>;
Val =:= 'southbound-traffic' ->
<<0:1,59:7>>;
Val =:= 'westbound-traffic' ->
<<0:1,60:7>>;
Val =:= north ->
<<0:1,61:7>>;
Val =:= south ->
<<0:1,62:7>>;
Val =:= east ->
<<0:1,63:7>>;
Val =:= west ->
<<0:1,64:7>>;
Val =:= northeast ->
<<0:1,65:7>>;
Val =:= northwest ->
<<0:1,66:7>>;
Val =:= southeast ->
<<0:1,67:7>>;
Val =:= southwest ->
<<0:1,68:7>>;
Val =:= 'mountain-pass' ->
<<0:1,69:7>>;
Val =:= 'reservation-center' ->
<<0:1,70:7>>;
Val =:= 'nearby-basin' ->
<<0:1,71:7>>;
Val =:= 'on-tracks' ->
<<0:1,72:7>>;
Val =:= dip ->
<<0:1,73:7>>;
Val =:= 'traffic-circle' ->
<<0:1,74:7>>;
Val =:= 'park-and-ride-lot' ->
<<0:1,75:7>>;
Val =:= to ->
<<0:1,76:7>>;
Val =:= by ->
<<0:1,77:7>>;
Val =:= through ->
<<0:1,78:7>>;
Val =:= 'area-of' ->
<<0:1,79:7>>;
Val =:= under ->
<<0:1,80:7>>;
Val =:= over ->
<<0:1,81:7>>;
Val =:= from ->
<<0:1,82:7>>;
Val =:= approaching ->
<<0:1,83:7>>;
Val =:= 'entering-at' ->
<<0:1,84:7>>;
Val =:= 'exiting-at' ->
<<0:1,85:7>>;
Val =:= 'across-tracks' ->
<<0:1,86:7>>;
Val =:= 'in-street' ->
<<0:1,87:7>>;
Val =:= 'on-curve' ->
<<0:1,88:7>>;
Val =:= shoulder ->
<<0:1,89:7>>;
Val =:= crossover ->
<<0:1,90:7>>;
Val =:= 'cross-road' ->
<<0:1,91:7>>;
Val =:= 'side-road' ->
<<0:1,92:7>>;
Val =:= 'bus-stop' ->
<<0:1,93:7>>;
Val =:= intersection ->
<<0:1,94:7>>;
Val =:= 'roadside-park' ->
<<0:1,95:7>>;
true ->
exit({error,{asn1,{illegal_enumerated,Val}}})
end.


dec_GenericLocations(Bytes) ->
begin
{V1@V0,V1@Buf1} = case Bytes of
<<0:1,V1@V3:7,V1@Buf4/bitstring>> ->
V1@Int5 = case V1@V3 of
0 -> 'on-bridges';
1 -> 'in-tunnels';
2 -> 'entering-or-leaving-tunnels';
3 -> 'on-ramps';
4 -> 'in-road-construction-area';
5 -> 'around-a-curve';
6 -> 'on-minor-roads';
7 -> 'in-the-opposing-lanes';
8 -> 'adjacent-to-roadway';
9 -> 'on-bend';
10 -> 'entire-intersection';
11 -> 'in-the-median';
12 -> 'moved-to-side-of-road';
13 -> 'moved-to-shoulder';
14 -> 'on-the-roadway';
15 -> 'in-shaded-areas';
16 -> 'in-low-lying-areas';
17 -> 'in-the-downtown-area';
18 -> 'in-the-inner-city-area';
19 -> 'in-parts';
20 -> 'in-some-places';
21 -> 'in-the-ditch';
22 -> 'in-the-valley';
23 -> 'on-hill-top';
24 -> 'near-the-foothills';
25 -> 'at-high-altitudes';
26 -> 'near-the-lake';
27 -> 'near-the-shore';
28 -> 'over-the-crest-of-a-hill';
29 -> 'other-than-on-the-roadway';
30 -> 'near-the-beach';
31 -> 'near-beach-access-point';
32 -> 'lower-level';
33 -> 'upper-level';
34 -> airport;
35 -> concourse;
36 -> gate;
37 -> 'baggage-claim';
38 -> 'customs-point';
39 -> station;
40 -> platform;
41 -> dock;
42 -> depot;
43 -> 'ev-charging-point';
44 -> 'information-welcome-point';
45 -> 'at-rest-area';
46 -> 'at-service-area';
47 -> 'at-weigh-station';
48 -> 'picnic-areas';
49 -> 'rest-area';
50 -> 'service-stations';
51 -> toilets;
52 -> 'on-the-right';
53 -> 'on-the-left';
54 -> 'in-the-center';
55 -> 'in-the-opposite-direction';
56 -> 'cross-traffic';
57 -> 'northbound-traffic';
58 -> 'eastbound-traffic';
59 -> 'southbound-traffic';
60 -> 'westbound-traffic';
61 -> north;
62 -> south;
63 -> east;
64 -> west;
65 -> northeast;
66 -> northwest;
67 -> southeast;
68 -> southwest;
69 -> 'mountain-pass';
70 -> 'reservation-center';
71 -> 'nearby-basin';
72 -> 'on-tracks';
73 -> dip;
74 -> 'traffic-circle';
75 -> 'park-and-ride-lot';
76 -> to;
77 -> by;
78 -> through;
79 -> 'area-of';
80 -> under;
81 -> over;
82 -> from;
83 -> approaching;
84 -> 'entering-at';
85 -> 'exiting-at';
86 -> 'across-tracks';
87 -> 'in-street';
88 -> 'on-curve';
89 -> shoulder;
90 -> crossover;
91 -> 'cross-road';
92 -> 'side-road';
93 -> 'bus-stop';
94 -> intersection;
95 -> 'roadside-park';
_ -> exit({error,{asn1,{decode_enumerated,V1@V3}}})
end,
{V1@Int5,V1@Buf4};
<<1:1,V1@Buf2/bitstring>> ->
{V1@V3,V1@Buf4} = case V1@Buf2 of
<<0:1,V1@V6:6,V1@Buf7/bitstring>> ->
{V1@V6,V1@Buf7};
<<1:1,V1@Buf5/bitstring>> ->
{V1@V6,V1@Buf7} = case V1@Buf5 of
<<0:1,V1@V9:7,V1@Buf10/bitstring>> when V1@V9 =/= 0 ->
{V1@V9,V1@Buf10};
<<1:1,0:1,V1@V10:14,V1@Buf11/bitstring>> when V1@V10 =/= 0 ->
{V1@V10,V1@Buf11}
end,
<<V1@V12:V1@V6/unit:8,V1@Buf13/bitstring>> = V1@Buf7,
{V1@V12,V1@Buf13}
end,
V1@Int14 = case V1@V3 of
_ -> {asn1_enum,V1@V3}
end,
{V1@Int14,V1@Buf4}
end,
{V1@V0,V1@Buf1}
end.

enc_IncidentResponseEquipment(Val) ->
if Val =:= 'ground-fire-suppression' ->
<<0:1,0:7>>;
Val =:= 'heavy-ground-equipment' ->
<<0:1,1:7>>;
Val =:= aircraft ->
<<0:1,2:7>>;
Val =:= 'marine-equipment' ->
<<0:1,3:7>>;
Val =:= 'support-equipment' ->
<<0:1,4:7>>;
Val =:= 'medical-rescue-unit' ->
<<0:1,5:7>>;
Val =:= other ->
<<0:1,6:7>>;
Val =:= 'ground-fire-suppression-other' ->
<<0:1,7:7>>;
Val =:= engine ->
<<0:1,8:7>>;
Val =:= 'truck-or-aerial' ->
<<0:1,9:7>>;
Val =:= quint ->
<<0:1,10:7>>;
Val =:= 'tanker-pumper-combination' ->
<<0:1,11:7>>;
Val =:= 'brush-truck' ->
<<0:1,12:7>>;
Val =:= 'aircraft-rescue-firefighting' ->
<<0:1,13:7>>;
Val =:= 'heavy-ground-equipment-other' ->
<<0:1,14:7>>;
Val =:= 'dozer-or-plow' ->
<<0:1,15:7>>;
Val =:= tractor ->
<<0:1,16:7>>;
Val =:= 'tanker-or-tender' ->
<<0:1,17:7>>;
Val =:= 'aircraft-other' ->
<<0:1,18:7>>;
Val =:= 'aircraft-fixed-wing-tanker' ->
<<0:1,19:7>>;
Val =:= helitanker ->
<<0:1,20:7>>;
Val =:= helicopter ->
<<0:1,21:7>>;
Val =:= 'marine-equipment-other' ->
<<0:1,22:7>>;
Val =:= 'fire-boat-with-pump' ->
<<0:1,23:7>>;
Val =:= 'boat-no-pump' ->
<<0:1,24:7>>;
Val =:= 'support-apparatus-other' ->
<<0:1,25:7>>;
Val =:= 'breathing-apparatus-support' ->
<<0:1,26:7>>;
Val =:= 'light-and-air-unit' ->
<<0:1,27:7>>;
Val =:= 'medical-rescue-unit-other' ->
<<0:1,28:7>>;
Val =:= 'rescue-unit' ->
<<0:1,29:7>>;
Val =:= 'urban-search-rescue-unit' ->
<<0:1,30:7>>;
Val =:= 'high-angle-rescue' ->
<<0:1,31:7>>;
Val =:= 'crash-fire-rescue' ->
<<0:1,32:7>>;
Val =:= 'bLS-unit' ->
<<0:1,33:7>>;
Val =:= 'aLS-unit' ->
<<0:1,34:7>>;
Val =:= 'mobile-command-post' ->
<<0:1,35:7>>;
Val =:= 'chief-officer-car' ->
<<0:1,36:7>>;
Val =:= 'hAZMAT-unit' ->
<<0:1,37:7>>;
Val =:= 'type-i-hand-crew' ->
<<0:1,38:7>>;
Val =:= 'type-ii-hand-crew' ->
<<0:1,39:7>>;
Val =:= 'privately-owned-vehicle' ->
<<0:1,40:7>>;
Val =:= 'other-apparatus-resource' ->
<<0:1,41:7>>;
Val =:= ambulance ->
<<0:1,42:7>>;
Val =:= 'bomb-squad-van' ->
<<0:1,43:7>>;
Val =:= 'combine-harvester' ->
<<0:1,44:7>>;
Val =:= 'construction-vehicle' ->
<<0:1,45:7>>;
Val =:= 'farm-tractor' ->
<<0:1,46:7>>;
Val =:= 'grass-cutting-machines' ->
<<0:1,47:7>>;
Val =:= 'hAZMAT-containment-tow' ->
<<0:1,48:7>>;
Val =:= 'heavy-tow' ->
<<0:1,49:7>>;
Val =:= 'hedge-cutting-machines' ->
<<0:1,50:7>>;
Val =:= 'light-tow' ->
<<0:1,51:7>>;
Val =:= 'mobile-crane' ->
<<0:1,52:7>>;
Val =:= 'refuse-collection-vehicle' ->
<<0:1,53:7>>;
Val =:= 'resurfacing-vehicle' ->
<<0:1,54:7>>;
Val =:= 'road-sweeper' ->
<<0:1,55:7>>;
Val =:= 'roadside-litter-collection-crews' ->
<<0:1,56:7>>;
Val =:= 'salvage-vehicle' ->
<<0:1,57:7>>;
Val =:= 'sand-truck' ->
<<0:1,58:7>>;
Val =:= snowplow ->
<<0:1,59:7>>;
Val =:= 'steam-roller' ->
<<0:1,60:7>>;
Val =:= 'swat-team-van' ->
<<0:1,61:7>>;
Val =:= 'track-laying-vehicle' ->
<<0:1,62:7>>;
Val =:= 'unknown-vehicle' ->
<<0:1,63:7>>;
Val =:= 'white-lining-vehicle' ->
<<0:1,64:7>>;
Val =:= 'dump-truck' ->
<<0:1,65:7>>;
Val =:= 'supervisor-vehicle' ->
<<0:1,66:7>>;
Val =:= 'snow-blower' ->
<<0:1,67:7>>;
Val =:= 'rotary-snow-blower' ->
<<0:1,68:7>>;
Val =:= 'road-grader' ->
<<0:1,69:7>>;
Val =:= 'steam-truck' ->
<<0:1,70:7>>;
Val =:= 'flatbed-tow' ->
<<0:1,71:7>>;
true ->
exit({error,{asn1,{illegal_enumerated,Val}}})
end.


dec_IncidentResponseEquipment(Bytes) ->
begin
{V1@V0,V1@Buf1} = case Bytes of
<<0:1,V1@V3:7,V1@Buf4/bitstring>> ->
V1@Int5 = case V1@V3 of
0 -> 'ground-fire-suppression';
1 -> 'heavy-ground-equipment';
2 -> aircraft;
3 -> 'marine-equipment';
4 -> 'support-equipment';
5 -> 'medical-rescue-unit';
6 -> other;
7 -> 'ground-fire-suppression-other';
8 -> engine;
9 -> 'truck-or-aerial';
10 -> quint;
11 -> 'tanker-pumper-combination';
12 -> 'brush-truck';
13 -> 'aircraft-rescue-firefighting';
14 -> 'heavy-ground-equipment-other';
15 -> 'dozer-or-plow';
16 -> tractor;
17 -> 'tanker-or-tender';
18 -> 'aircraft-other';
19 -> 'aircraft-fixed-wing-tanker';
20 -> helitanker;
21 -> helicopter;
22 -> 'marine-equipment-other';
23 -> 'fire-boat-with-pump';
24 -> 'boat-no-pump';
25 -> 'support-apparatus-other';
26 -> 'breathing-apparatus-support';
27 -> 'light-and-air-unit';
28 -> 'medical-rescue-unit-other';
29 -> 'rescue-unit';
30 -> 'urban-search-rescue-unit';
31 -> 'high-angle-rescue';
32 -> 'crash-fire-rescue';
33 -> 'bLS-unit';
34 -> 'aLS-unit';
35 -> 'mobile-command-post';
36 -> 'chief-officer-car';
37 -> 'hAZMAT-unit';
38 -> 'type-i-hand-crew';
39 -> 'type-ii-hand-crew';
40 -> 'privately-owned-vehicle';
41 -> 'other-apparatus-resource';
42 -> ambulance;
43 -> 'bomb-squad-van';
44 -> 'combine-harvester';
45 -> 'construction-vehicle';
46 -> 'farm-tractor';
47 -> 'grass-cutting-machines';
48 -> 'hAZMAT-containment-tow';
49 -> 'heavy-tow';
50 -> 'hedge-cutting-machines';
51 -> 'light-tow';
52 -> 'mobile-crane';
53 -> 'refuse-collection-vehicle';
54 -> 'resurfacing-vehicle';
55 -> 'road-sweeper';
56 -> 'roadside-litter-collection-crews';
57 -> 'salvage-vehicle';
58 -> 'sand-truck';
59 -> snowplow;
60 -> 'steam-roller';
61 -> 'swat-team-van';
62 -> 'track-laying-vehicle';
63 -> 'unknown-vehicle';
64 -> 'white-lining-vehicle';
65 -> 'dump-truck';
66 -> 'supervisor-vehicle';
67 -> 'snow-blower';
68 -> 'rotary-snow-blower';
69 -> 'road-grader';
70 -> 'steam-truck';
71 -> 'flatbed-tow';
_ -> exit({error,{asn1,{decode_enumerated,V1@V3}}})
end,
{V1@Int5,V1@Buf4};
<<1:1,V1@Buf2/bitstring>> ->
{V1@V3,V1@Buf4} = case V1@Buf2 of
<<0:1,V1@V6:6,V1@Buf7/bitstring>> ->
{V1@V6,V1@Buf7};
<<1:1,V1@Buf5/bitstring>> ->
{V1@V6,V1@Buf7} = case V1@Buf5 of
<<0:1,V1@V9:7,V1@Buf10/bitstring>> when V1@V9 =/= 0 ->
{V1@V9,V1@Buf10};
<<1:1,0:1,V1@V10:14,V1@Buf11/bitstring>> when V1@V10 =/= 0 ->
{V1@V10,V1@Buf11}
end,
<<V1@V12:V1@V6/unit:8,V1@Buf13/bitstring>> = V1@Buf7,
{V1@V12,V1@Buf13}
end,
V1@Int14 = case V1@V3 of
_ -> {asn1_enum,V1@V3}
end,
{V1@Int14,V1@Buf4}
end,
{V1@V0,V1@Buf1}
end.

enc_ITIStext(Val) ->
Enc1@len = length(Val),
Enc1@bin = encode_chars(Val, 7),
Enc1@len@sub = Enc1@len - 1,
if 0 =< Enc1@len@sub, Enc1@len@sub < 500 ->
[<<Enc1@len@sub:9>>|Enc1@bin]
end.


dec_ITIStext(Bytes) ->
begin
<<V1@V0:9,V1@Buf1/bitstring>> = Bytes,
V1@Add2 = V1@V0 + 1,
<<V1@V3:V1@Add2/binary-unit:7,V1@Buf4/bitstring>> = V1@Buf1,
{V1@V5,V1@Buf6}  = {decode_chars(V1@V3, 7),V1@Buf4},
{V1@V5,V1@Buf6}
end.

enc_ResponderGroupAffected(Val) ->
if Val =:= 'emergency-vehicle-units' ->
<<0:1,0:4>>;
Val =:= 'federal-law-enforcement-units' ->
<<0:1,1:4>>;
Val =:= 'state-police-units' ->
<<0:1,2:4>>;
Val =:= 'county-police-units' ->
<<0:1,3:4>>;
Val =:= 'local-police-units' ->
<<0:1,4:4>>;
Val =:= 'ambulance-units' ->
<<0:1,5:4>>;
Val =:= 'rescue-units' ->
<<0:1,6:4>>;
Val =:= 'fire-units' ->
<<0:1,7:4>>;
Val =:= 'hAZMAT-units' ->
<<0:1,8:4>>;
Val =:= 'light-tow-unit' ->
<<0:1,9:4>>;
Val =:= 'heavy-tow-unit' ->
<<0:1,10:4>>;
Val =:= 'freeway-service-patrols' ->
<<0:1,11:4>>;
Val =:= 'transportation-response-units' ->
<<0:1,12:4>>;
Val =:= 'private-contractor-response-units' ->
<<0:1,13:4>>;
true ->
exit({error,{asn1,{illegal_enumerated,Val}}})
end.


dec_ResponderGroupAffected(Bytes) ->
begin
{V1@V0,V1@Buf1} = case Bytes of
<<0:1,V1@V3:4,V1@Buf4/bitstring>> ->
V1@Int5 = case V1@V3 of
0 -> 'emergency-vehicle-units';
1 -> 'federal-law-enforcement-units';
2 -> 'state-police-units';
3 -> 'county-police-units';
4 -> 'local-police-units';
5 -> 'ambulance-units';
6 -> 'rescue-units';
7 -> 'fire-units';
8 -> 'hAZMAT-units';
9 -> 'light-tow-unit';
10 -> 'heavy-tow-unit';
11 -> 'freeway-service-patrols';
12 -> 'transportation-response-units';
13 -> 'private-contractor-response-units';
_ -> exit({error,{asn1,{decode_enumerated,V1@V3}}})
end,
{V1@Int5,V1@Buf4};
<<1:1,V1@Buf2/bitstring>> ->
{V1@V3,V1@Buf4} = case V1@Buf2 of
<<0:1,V1@V6:6,V1@Buf7/bitstring>> ->
{V1@V6,V1@Buf7};
<<1:1,V1@Buf5/bitstring>> ->
{V1@V6,V1@Buf7} = case V1@Buf5 of
<<0:1,V1@V9:7,V1@Buf10/bitstring>> when V1@V9 =/= 0 ->
{V1@V9,V1@Buf10};
<<1:1,0:1,V1@V10:14,V1@Buf11/bitstring>> when V1@V10 =/= 0 ->
{V1@V10,V1@Buf11}
end,
<<V1@V12:V1@V6/unit:8,V1@Buf13/bitstring>> = V1@Buf7,
{V1@V12,V1@Buf13}
end,
V1@Int14 = case V1@V3 of
_ -> {asn1_enum,V1@V3}
end,
{V1@Int14,V1@Buf4}
end,
{V1@V0,V1@Buf1}
end.

enc_VehicleGroupAffected(Val) ->
if Val =:= 'all-vehicles' ->
<<0:1,0:6>>;
Val =:= bicycles ->
<<0:1,1:6>>;
Val =:= motorcycles ->
<<0:1,2:6>>;
Val =:= cars ->
<<0:1,3:6>>;
Val =:= 'light-vehicles' ->
<<0:1,4:6>>;
Val =:= 'cars-and-light-vehicles' ->
<<0:1,5:6>>;
Val =:= 'cars-with-trailers' ->
<<0:1,6:6>>;
Val =:= 'cars-with-recreational-trailers' ->
<<0:1,7:6>>;
Val =:= 'vehicles-with-trailers' ->
<<0:1,8:6>>;
Val =:= 'heavy-vehicles' ->
<<0:1,9:6>>;
Val =:= trucks ->
<<0:1,10:6>>;
Val =:= buses ->
<<0:1,11:6>>;
Val =:= 'articulated-buses' ->
<<0:1,12:6>>;
Val =:= 'school-buses' ->
<<0:1,13:6>>;
Val =:= 'vehicles-with-semi-trailers' ->
<<0:1,14:6>>;
Val =:= 'vehicles-with-double-trailers' ->
<<0:1,15:6>>;
Val =:= 'high-profile-vehicles' ->
<<0:1,16:6>>;
Val =:= 'wide-vehicles' ->
<<0:1,17:6>>;
Val =:= 'long-vehicles' ->
<<0:1,18:6>>;
Val =:= 'hazardous-loads' ->
<<0:1,19:6>>;
Val =:= 'exceptional-loads' ->
<<0:1,20:6>>;
Val =:= 'abnormal-loads' ->
<<0:1,21:6>>;
Val =:= convoys ->
<<0:1,22:6>>;
Val =:= 'maintenance-vehicles' ->
<<0:1,23:6>>;
Val =:= 'delivery-vehicles' ->
<<0:1,24:6>>;
Val =:= 'vehicles-with-even-numbered-license-plates' ->
<<0:1,25:6>>;
Val =:= 'vehicles-with-odd-numbered-license-plates' ->
<<0:1,26:6>>;
Val =:= 'vehicles-with-parking-permits' ->
<<0:1,27:6>>;
Val =:= 'vehicles-with-catalytic-converters' ->
<<0:1,28:6>>;
Val =:= 'vehicles-without-catalytic-converters' ->
<<0:1,29:6>>;
Val =:= 'gas-powered-vehicles' ->
<<0:1,30:6>>;
Val =:= 'diesel-powered-vehicles' ->
<<0:1,31:6>>;
Val =:= 'lPG-vehicles' ->
<<0:1,32:6>>;
Val =:= 'military-convoys' ->
<<0:1,33:6>>;
Val =:= 'military-vehicles' ->
<<0:1,34:6>>;
true ->
exit({error,{asn1,{illegal_enumerated,Val}}})
end.


dec_VehicleGroupAffected(Bytes) ->
begin
{V1@V0,V1@Buf1} = case Bytes of
<<0:1,V1@V3:6,V1@Buf4/bitstring>> ->
V1@Int5 = case V1@V3 of
0 -> 'all-vehicles';
1 -> bicycles;
2 -> motorcycles;
3 -> cars;
4 -> 'light-vehicles';
5 -> 'cars-and-light-vehicles';
6 -> 'cars-with-trailers';
7 -> 'cars-with-recreational-trailers';
8 -> 'vehicles-with-trailers';
9 -> 'heavy-vehicles';
10 -> trucks;
11 -> buses;
12 -> 'articulated-buses';
13 -> 'school-buses';
14 -> 'vehicles-with-semi-trailers';
15 -> 'vehicles-with-double-trailers';
16 -> 'high-profile-vehicles';
17 -> 'wide-vehicles';
18 -> 'long-vehicles';
19 -> 'hazardous-loads';
20 -> 'exceptional-loads';
21 -> 'abnormal-loads';
22 -> convoys;
23 -> 'maintenance-vehicles';
24 -> 'delivery-vehicles';
25 -> 'vehicles-with-even-numbered-license-plates';
26 -> 'vehicles-with-odd-numbered-license-plates';
27 -> 'vehicles-with-parking-permits';
28 -> 'vehicles-with-catalytic-converters';
29 -> 'vehicles-without-catalytic-converters';
30 -> 'gas-powered-vehicles';
31 -> 'diesel-powered-vehicles';
32 -> 'lPG-vehicles';
33 -> 'military-convoys';
34 -> 'military-vehicles';
_ -> exit({error,{asn1,{decode_enumerated,V1@V3}}})
end,
{V1@Int5,V1@Buf4};
<<1:1,V1@Buf2/bitstring>> ->
{V1@V3,V1@Buf4} = case V1@Buf2 of
<<0:1,V1@V6:6,V1@Buf7/bitstring>> ->
{V1@V6,V1@Buf7};
<<1:1,V1@Buf5/bitstring>> ->
{V1@V6,V1@Buf7} = case V1@Buf5 of
<<0:1,V1@V9:7,V1@Buf10/bitstring>> when V1@V9 =/= 0 ->
{V1@V9,V1@Buf10};
<<1:1,0:1,V1@V10:14,V1@Buf11/bitstring>> when V1@V10 =/= 0 ->
{V1@V10,V1@Buf11}
end,
<<V1@V12:V1@V6/unit:8,V1@Buf13/bitstring>> = V1@Buf7,
{V1@V12,V1@Buf13}
end,
V1@Int14 = case V1@V3 of
_ -> {asn1_enum,V1@V3}
end,
{V1@Int14,V1@Buf4}
end,
{V1@V0,V1@Buf1}
end.

enc_ITIScodesAndText(Val) ->
Enc1@len = length(Val),
Enc1@len@sub = Enc1@len - 1,
if 0 =< Enc1@len@sub, Enc1@len@sub < 100 ->
[<<Enc1@len@sub:7>>|[enc_ITIScodesAndText_SEQOF(Comp) || Comp <- Val]]
end.

enc_ITIScodesAndText_SEQOF(Val) ->
#{item:=Input@1} = Val,
%% attribute item(1) with type CHOICE
enc_ITIScodesAndText_SEQOF_item(Input@1).
enc_ITIScodesAndText_SEQOF_item(Val) ->
{ChoiceTag,ChoiceVal} = Val,
if ChoiceTag =:= itis ->
if ChoiceVal bsr 16 =:= 0 ->
<<0:1,ChoiceVal:16>>;
true ->
exit({error,{asn1,{illegal_integer,ChoiceVal}}})
end;
ChoiceTag =:= text ->
begin
Enc4@len = length(ChoiceVal),
Enc4@bin = encode_chars(ChoiceVal, 7),
Enc4@len@sub = Enc4@len - 1,
if 0 =< Enc4@len@sub, Enc4@len@sub < 500 ->
[<<1:1,Enc4@len@sub:9>>|Enc4@bin]
end
end
end.


dec_ITIScodesAndText(Bytes) ->
%% Length with constraint {1,100}
<<V1@V0:7,V1@Buf1/bitstring>> = Bytes,
V1@Add2 = V1@V0 + 1,
dec_components1(V1@Add2, V1@Buf1, []).


dec_ITIScodesAndText_SEQOF(Bytes) ->

%% attribute item(1) with type CHOICE
{Term1,Bytes1} = dec_ITIScodesAndText_SEQOF_item(Bytes),
Res1 = #{item=>Term1},
{Res1,Bytes1}.


dec_ITIScodesAndText_SEQOF_item(Bytes) ->
{Choice,Bytes1} = 
begin
<<V1@V0:1,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end,
case Choice of
0 ->
{Val,NewBytes} = begin
begin
<<V2@V0:16,V2@Buf1/bitstring>> = Bytes1,
{V2@V0,V2@Buf1}
end
end,
{{itis,Val},NewBytes};
1 ->
{Val,NewBytes} = begin
begin
<<V3@V0:9,V3@Buf1/bitstring>> = Bytes1,
V3@Add2 = V3@V0 + 1,
<<V3@V3:V3@Add2/binary-unit:7,V3@Buf4/bitstring>> = V3@Buf1,
{V3@V5,V3@Buf6}  = {decode_chars(V3@V3, 7),V3@Buf4},
{V3@V5,V3@Buf6}
end
end,
{{text,Val},NewBytes}
end.
enc_ITIScodes(Val) ->
if Val bsr 16 =:= 0 ->
<<Val:16>>;
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_ITIScodes(Bytes) ->
begin
<<V1@V0:16,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end.


%%%
%%% Run-time functions.
%%%

'dialyzer-suppressions'(Arg) ->
    complete(element(1, Arg)),
    ok.

dec_components1(0, Bytes, Acc) ->
{lists:reverse(Acc),Bytes};
dec_components1(Num, Bytes, Acc) ->
{Term,Remain} = dec_ITIScodesAndText_SEQOF(Bytes),
dec_components1(Num-1, Remain, [Term|Acc]).

complete(InList) when is_list(InList) ->
    case list_to_bitstring(InList) of
        <<>> ->
            <<0>>;
        Res ->
            Sz = bit_size(Res),
            case Sz band 7 of
                0 ->
                    Res;
                Bits ->
                    <<Res:Sz/bitstring,0:(8 - Bits)>>
            end
    end;
complete(Bin) when is_binary(Bin) ->
    case Bin of
        <<>> ->
            <<0>>;
        _ ->
            Bin
    end;
complete(InList) when is_bitstring(InList) ->
    Sz = bit_size(InList),
    PadLen = 8 - Sz band 7,
    <<InList:Sz/bitstring,0:PadLen>>.

decode_chars(Val, N) ->
    [ 
     C ||
         <<C:N>> <= Val
    ].

encode_chars(Val, NumBits) ->
    << 
      <<C:NumBits>> ||
          C <- Val
    >>.
