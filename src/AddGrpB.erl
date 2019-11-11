%% Generated by the Erlang ASN.1 PER (unaligned) compiler. Version: 5.0.9
%% Purpose: Encoding and decoding of the types in AddGrpB.

-module('AddGrpB').
-compile(nowarn_unused_vars).
-dialyzer(no_improper_lists).
-asn1_info([{vsn,'5.0.9'},
            {module,'AddGrpB'},
            {options,[{i,"src"},maps,uper,noobj,{outdir,"src"},{i,"."},{i,"asn1"}]}]).

-export([encoding_rule/0,maps/0,bit_string_format/0,
         legacy_erlang_types/0]).
-export(['dialyzer-suppressions'/1]).
-export([
enc_Angle/1,
enc_Day/1,
enc_DayOfWeek/1,
enc_DegreesLat/1,
enc_DegreesLong/1,
enc_Elevation/1,
enc_Holiday/1,
enc_Hour/1,
enc_LatitudeDMS/1,
enc_LongitudeDMS/1,
enc_MaxTimetoChange/1,
enc_MinTimetoChange/1,
enc_Minute/1,
enc_MinutesAngle/1,
enc_Month/1,
enc_MsgCount/1,
enc_Second/1,
enc_SecondsAngle/1,
enc_SummerTime/1,
enc_TenthSecond/1,
enc_TimeRemaining/1,
enc_Year/1,
enc_LatitudeDMS2/1,
enc_LongitudeDMS2/1,
'enc_Node-LLdms-48b'/1,
'enc_Node-LLdms-80b'/1,
'enc_LaneDataAttribute-addGrpB'/1,
'enc_MovementEvent-addGrpB'/1,
'enc_NodeOffsetPointXY-addGrpB'/1,
'enc_Position3D-addGrpB'/1,
enc_TimeMark/1
]).

-export([
dec_Angle/1,
dec_Day/1,
dec_DayOfWeek/1,
dec_DegreesLat/1,
dec_DegreesLong/1,
dec_Elevation/1,
dec_Holiday/1,
dec_Hour/1,
dec_LatitudeDMS/1,
dec_LongitudeDMS/1,
dec_MaxTimetoChange/1,
dec_MinTimetoChange/1,
dec_Minute/1,
dec_MinutesAngle/1,
dec_Month/1,
dec_MsgCount/1,
dec_Second/1,
dec_SecondsAngle/1,
dec_SummerTime/1,
dec_TenthSecond/1,
dec_TimeRemaining/1,
dec_Year/1,
dec_LatitudeDMS2/1,
dec_LongitudeDMS2/1,
'dec_Node-LLdms-48b'/1,
'dec_Node-LLdms-80b'/1,
'dec_LaneDataAttribute-addGrpB'/1,
'dec_MovementEvent-addGrpB'/1,
'dec_NodeOffsetPointXY-addGrpB'/1,
'dec_Position3D-addGrpB'/1,
dec_TimeMark/1
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

encode_disp('Angle', Data) -> enc_Angle(Data);
encode_disp('Day', Data) -> enc_Day(Data);
encode_disp('DayOfWeek', Data) -> enc_DayOfWeek(Data);
encode_disp('DegreesLat', Data) -> enc_DegreesLat(Data);
encode_disp('DegreesLong', Data) -> enc_DegreesLong(Data);
encode_disp('Elevation', Data) -> enc_Elevation(Data);
encode_disp('Holiday', Data) -> enc_Holiday(Data);
encode_disp('Hour', Data) -> enc_Hour(Data);
encode_disp('LatitudeDMS', Data) -> enc_LatitudeDMS(Data);
encode_disp('LongitudeDMS', Data) -> enc_LongitudeDMS(Data);
encode_disp('MaxTimetoChange', Data) -> enc_MaxTimetoChange(Data);
encode_disp('MinTimetoChange', Data) -> enc_MinTimetoChange(Data);
encode_disp('Minute', Data) -> enc_Minute(Data);
encode_disp('MinutesAngle', Data) -> enc_MinutesAngle(Data);
encode_disp('Month', Data) -> enc_Month(Data);
encode_disp('MsgCount', Data) -> enc_MsgCount(Data);
encode_disp('Second', Data) -> enc_Second(Data);
encode_disp('SecondsAngle', Data) -> enc_SecondsAngle(Data);
encode_disp('SummerTime', Data) -> enc_SummerTime(Data);
encode_disp('TenthSecond', Data) -> enc_TenthSecond(Data);
encode_disp('TimeRemaining', Data) -> enc_TimeRemaining(Data);
encode_disp('Year', Data) -> enc_Year(Data);
encode_disp('LatitudeDMS2', Data) -> enc_LatitudeDMS2(Data);
encode_disp('LongitudeDMS2', Data) -> enc_LongitudeDMS2(Data);
encode_disp('Node-LLdms-48b', Data) -> 'enc_Node-LLdms-48b'(Data);
encode_disp('Node-LLdms-80b', Data) -> 'enc_Node-LLdms-80b'(Data);
encode_disp('LaneDataAttribute-addGrpB', Data) -> 'enc_LaneDataAttribute-addGrpB'(Data);
encode_disp('MovementEvent-addGrpB', Data) -> 'enc_MovementEvent-addGrpB'(Data);
encode_disp('NodeOffsetPointXY-addGrpB', Data) -> 'enc_NodeOffsetPointXY-addGrpB'(Data);
encode_disp('Position3D-addGrpB', Data) -> 'enc_Position3D-addGrpB'(Data);
encode_disp('TimeMark', Data) -> enc_TimeMark(Data);
encode_disp(Type, _Data) -> exit({error,{asn1,{undefined_type,Type}}}).

decode_disp('Angle', Data) -> dec_Angle(Data);
decode_disp('Day', Data) -> dec_Day(Data);
decode_disp('DayOfWeek', Data) -> dec_DayOfWeek(Data);
decode_disp('DegreesLat', Data) -> dec_DegreesLat(Data);
decode_disp('DegreesLong', Data) -> dec_DegreesLong(Data);
decode_disp('Elevation', Data) -> dec_Elevation(Data);
decode_disp('Holiday', Data) -> dec_Holiday(Data);
decode_disp('Hour', Data) -> dec_Hour(Data);
decode_disp('LatitudeDMS', Data) -> dec_LatitudeDMS(Data);
decode_disp('LongitudeDMS', Data) -> dec_LongitudeDMS(Data);
decode_disp('MaxTimetoChange', Data) -> dec_MaxTimetoChange(Data);
decode_disp('MinTimetoChange', Data) -> dec_MinTimetoChange(Data);
decode_disp('Minute', Data) -> dec_Minute(Data);
decode_disp('MinutesAngle', Data) -> dec_MinutesAngle(Data);
decode_disp('Month', Data) -> dec_Month(Data);
decode_disp('MsgCount', Data) -> dec_MsgCount(Data);
decode_disp('Second', Data) -> dec_Second(Data);
decode_disp('SecondsAngle', Data) -> dec_SecondsAngle(Data);
decode_disp('SummerTime', Data) -> dec_SummerTime(Data);
decode_disp('TenthSecond', Data) -> dec_TenthSecond(Data);
decode_disp('TimeRemaining', Data) -> dec_TimeRemaining(Data);
decode_disp('Year', Data) -> dec_Year(Data);
decode_disp('LatitudeDMS2', Data) -> dec_LatitudeDMS2(Data);
decode_disp('LongitudeDMS2', Data) -> dec_LongitudeDMS2(Data);
decode_disp('Node-LLdms-48b', Data) -> 'dec_Node-LLdms-48b'(Data);
decode_disp('Node-LLdms-80b', Data) -> 'dec_Node-LLdms-80b'(Data);
decode_disp('LaneDataAttribute-addGrpB', Data) -> 'dec_LaneDataAttribute-addGrpB'(Data);
decode_disp('MovementEvent-addGrpB', Data) -> 'dec_MovementEvent-addGrpB'(Data);
decode_disp('NodeOffsetPointXY-addGrpB', Data) -> 'dec_NodeOffsetPointXY-addGrpB'(Data);
decode_disp('Position3D-addGrpB', Data) -> 'dec_Position3D-addGrpB'(Data);
decode_disp('TimeMark', Data) -> dec_TimeMark(Data);
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
enc_Angle(Val) ->
if 0 =< Val, Val < 240 ->
[Val];
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_Angle(Bytes) ->
begin
<<V1@V0:8,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end.

enc_Day(Val) ->
if Val bsr 8 =:= 0 ->
[Val];
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_Day(Bytes) ->
begin
<<V1@V0:8,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end.

enc_DayOfWeek(Val) ->
if Val =:= unknown ->
<<0:3>>;
Val =:= monday ->
<<1:3>>;
Val =:= tuesday ->
<<2:3>>;
Val =:= wednesday ->
<<3:3>>;
Val =:= thursday ->
<<4:3>>;
Val =:= friday ->
<<5:3>>;
Val =:= saturday ->
<<6:3>>;
Val =:= sunday ->
<<7:3>>;
true ->
exit({error,{asn1,{illegal_enumerated,Val}}})
end.


dec_DayOfWeek(Bytes) ->
begin
<<V1@V0:3,V1@Buf1/bitstring>> = Bytes,
V1@Int2 = case V1@V0 of
0 -> unknown;
1 -> monday;
2 -> tuesday;
3 -> wednesday;
4 -> thursday;
5 -> friday;
6 -> saturday;
7 -> sunday
end,
{V1@Int2,V1@Buf1}
end.

enc_DegreesLat(Val) ->
Val@sub = Val - -90,
if 0 =< Val@sub, Val@sub < 181 ->
[Val@sub];
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_DegreesLat(Bytes) ->
begin
<<V1@V0:8,V1@Buf1/bitstring>> = Bytes,
V1@Add2 = V1@V0 + -90,
{V1@Add2,V1@Buf1}
end.

enc_DegreesLong(Val) ->
Val@sub = Val - -180,
if 0 =< Val@sub, Val@sub < 361 ->
<<Val@sub:9>>;
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_DegreesLong(Bytes) ->
begin
<<V1@V0:9,V1@Buf1/bitstring>> = Bytes,
V1@Add2 = V1@V0 + -180,
{V1@Add2,V1@Buf1}
end.

enc_Elevation(Val) ->
Val@sub = Val - -32768,
if Val@sub bsr 16 =:= 0 ->
<<Val@sub:16>>;
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_Elevation(Bytes) ->
begin
<<V1@V0:16,V1@Buf1/bitstring>> = Bytes,
V1@Add2 = V1@V0 + -32768,
{V1@Add2,V1@Buf1}
end.

enc_Holiday(Val) ->
if Val =:= weekday ->
<<0:1>>;
Val =:= holiday ->
<<1:1>>;
true ->
exit({error,{asn1,{illegal_enumerated,Val}}})
end.


dec_Holiday(Bytes) ->
begin
<<V1@V0:1,V1@Buf1/bitstring>> = Bytes,
V1@Int2 = case V1@V0 of
0 -> weekday;
1 -> holiday
end,
{V1@Int2,V1@Buf1}
end.

enc_Hour(Val) ->
if Val bsr 8 =:= 0 ->
[Val];
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_Hour(Bytes) ->
begin
<<V1@V0:8,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end.

enc_LatitudeDMS(Val) ->
Val@sub = Val - -32400000,
if 0 =< Val@sub, Val@sub < 64800001 ->
<<Val@sub:26>>;
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_LatitudeDMS(Bytes) ->
begin
<<V1@V0:26,V1@Buf1/bitstring>> = Bytes,
V1@Add2 = V1@V0 + -32400000,
{V1@Add2,V1@Buf1}
end.

enc_LongitudeDMS(Val) ->
Val@sub = Val - -64800000,
if 0 =< Val@sub, Val@sub < 129600001 ->
<<Val@sub:27>>;
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_LongitudeDMS(Bytes) ->
begin
<<V1@V0:27,V1@Buf1/bitstring>> = Bytes,
V1@Add2 = V1@V0 + -64800000,
{V1@Add2,V1@Buf1}
end.

enc_MaxTimetoChange(Val) ->
if 0 =< Val, Val < 2403 ->
<<Val:12>>;
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_MaxTimetoChange(Bytes) ->
begin
<<V1@V0:12,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end.

enc_MinTimetoChange(Val) ->
if 0 =< Val, Val < 2403 ->
<<Val:12>>;
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_MinTimetoChange(Bytes) ->
begin
<<V1@V0:12,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end.

enc_Minute(Val) ->
if Val bsr 8 =:= 0 ->
[Val];
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_Minute(Bytes) ->
begin
<<V1@V0:8,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end.

enc_MinutesAngle(Val) ->
if 0 =< Val, Val < 60 ->
<<Val:6>>;
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_MinutesAngle(Bytes) ->
begin
<<V1@V0:6,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end.

enc_Month(Val) ->
Val@sub = Val - 1,
if 0 =< Val@sub, Val@sub < 255 ->
[Val@sub];
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_Month(Bytes) ->
begin
<<V1@V0:8,V1@Buf1/bitstring>> = Bytes,
V1@Add2 = V1@V0 + 1,
{V1@Add2,V1@Buf1}
end.

enc_MsgCount(Val) ->
if Val bsr 8 =:= 0 ->
[Val];
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_MsgCount(Bytes) ->
begin
<<V1@V0:8,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end.

enc_Second(Val) ->
if 0 =< Val, Val < 61 ->
<<Val:6>>;
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_Second(Bytes) ->
begin
<<V1@V0:6,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end.

enc_SecondsAngle(Val) ->
if 0 =< Val, Val < 6000 ->
<<Val:13>>;
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_SecondsAngle(Bytes) ->
begin
<<V1@V0:13,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end.

enc_SummerTime(Val) ->
if Val =:= notInSummerTime ->
<<0:1>>;
Val =:= inSummerTime ->
<<1:1>>;
true ->
exit({error,{asn1,{illegal_enumerated,Val}}})
end.


dec_SummerTime(Bytes) ->
begin
<<V1@V0:1,V1@Buf1/bitstring>> = Bytes,
V1@Int2 = case V1@V0 of
0 -> notInSummerTime;
1 -> inSummerTime
end,
{V1@Int2,V1@Buf1}
end.

enc_TenthSecond(Val) ->
if 0 =< Val, Val < 10 ->
<<Val:4>>;
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_TenthSecond(Bytes) ->
begin
<<V1@V0:4,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end.

enc_TimeRemaining(Val) ->
if 0 =< Val, Val < 9002 ->
<<Val:14>>;
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_TimeRemaining(Bytes) ->
begin
<<V1@V0:14,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end.

enc_Year(Val) ->
Val@sub = Val - 1,
if 0 =< Val@sub, Val@sub < 65535 ->
<<Val@sub:16>>;
true ->
exit({error,{asn1,{illegal_integer,Val}}})
end.


dec_Year(Bytes) ->
begin
<<V1@V0:16,V1@Buf1/bitstring>> = Bytes,
V1@Add2 = V1@V0 + 1,
{V1@Add2,V1@Buf1}
end.

enc_LatitudeDMS2(Val) ->
#{d:=Input@1,m:=Input@2,s:=Input@3} = Val,
[begin
%% attribute d(1) with type INTEGER
Input@1@sub = Input@1 - -90,
if 0 =< Input@1@sub, Input@1@sub < 181 ->
Input@1@sub;
true ->
exit({error,{asn1,{illegal_integer,Input@1}}})
end
end,
begin
%% attribute m(2) with type INTEGER
if 0 =< Input@2, Input@2 < 60 ->
<<Input@2:6>>;
true ->
exit({error,{asn1,{illegal_integer,Input@2}}})
end
end|begin
%% attribute s(3) with type INTEGER
if 0 =< Input@3, Input@3 < 6000 ->
<<Input@3:13>>;
true ->
exit({error,{asn1,{illegal_integer,Input@3}}})
end
end].


dec_LatitudeDMS2(Bytes) ->

%% attribute d(1) with type INTEGER
{Term1,Bytes1} = begin
<<V1@V0:8,V1@Buf1/bitstring>> = Bytes,
V1@Add2 = V1@V0 + -90,
{V1@Add2,V1@Buf1}
end,

%% attribute m(2) with type INTEGER
{Term2,Bytes2} = begin
<<V2@V0:6,V2@Buf1/bitstring>> = Bytes1,
{V2@V0,V2@Buf1}
end,

%% attribute s(3) with type INTEGER
{Term3,Bytes3} = begin
<<V3@V0:13,V3@Buf1/bitstring>> = Bytes2,
{V3@V0,V3@Buf1}
end,
Res1 = #{d=>Term1,m=>Term2,s=>Term3},
{Res1,Bytes3}.

enc_LongitudeDMS2(Val) ->
#{d:=Input@1,m:=Input@2,s:=Input@3} = Val,
[begin
%% attribute d(1) with type INTEGER
Input@1@sub = Input@1 - -180,
if 0 =< Input@1@sub, Input@1@sub < 361 ->
<<Input@1@sub:9>>;
true ->
exit({error,{asn1,{illegal_integer,Input@1}}})
end
end,
begin
%% attribute m(2) with type INTEGER
if 0 =< Input@2, Input@2 < 60 ->
<<Input@2:6>>;
true ->
exit({error,{asn1,{illegal_integer,Input@2}}})
end
end|begin
%% attribute s(3) with type INTEGER
if 0 =< Input@3, Input@3 < 6000 ->
<<Input@3:13>>;
true ->
exit({error,{asn1,{illegal_integer,Input@3}}})
end
end].


dec_LongitudeDMS2(Bytes) ->

%% attribute d(1) with type INTEGER
{Term1,Bytes1} = begin
<<V1@V0:9,V1@Buf1/bitstring>> = Bytes,
V1@Add2 = V1@V0 + -180,
{V1@Add2,V1@Buf1}
end,

%% attribute m(2) with type INTEGER
{Term2,Bytes2} = begin
<<V2@V0:6,V2@Buf1/bitstring>> = Bytes1,
{V2@V0,V2@Buf1}
end,

%% attribute s(3) with type INTEGER
{Term3,Bytes3} = begin
<<V3@V0:13,V3@Buf1/bitstring>> = Bytes2,
{V3@V0,V3@Buf1}
end,
Res1 = #{d=>Term1,m=>Term2,s=>Term3},
{Res1,Bytes3}.

'enc_Node-LLdms-48b'(Val) ->
#{lon:=Input@1,lat:=Input@2} = Val,
[begin
%% attribute lon(1) with type INTEGER
Input@1@sub = Input@1 - -64800000,
if 0 =< Input@1@sub, Input@1@sub < 129600001 ->
<<Input@1@sub:27>>;
true ->
exit({error,{asn1,{illegal_integer,Input@1}}})
end
end|begin
%% attribute lat(2) with type INTEGER
Input@2@sub = Input@2 - -32400000,
if 0 =< Input@2@sub, Input@2@sub < 64800001 ->
<<Input@2@sub:26>>;
true ->
exit({error,{asn1,{illegal_integer,Input@2}}})
end
end].


'dec_Node-LLdms-48b'(Bytes) ->

%% attribute lon(1) with type INTEGER
{Term1,Bytes1} = begin
<<V1@V0:27,V1@Buf1/bitstring>> = Bytes,
V1@Add2 = V1@V0 + -64800000,
{V1@Add2,V1@Buf1}
end,

%% attribute lat(2) with type INTEGER
{Term2,Bytes2} = begin
<<V2@V0:26,V2@Buf1/bitstring>> = Bytes1,
V2@Add2 = V2@V0 + -32400000,
{V2@Add2,V2@Buf1}
end,
Res1 = #{lon=>Term1,lat=>Term2},
{Res1,Bytes2}.

'enc_Node-LLdms-80b'(Val) ->
#{lon:=Input@1,lat:=Input@2} = Val,
[begin
%% attribute lon(1) with type LongitudeDMS2
enc_LongitudeDMS2(Input@1)
end|begin
%% attribute lat(2) with type LatitudeDMS2
enc_LatitudeDMS2(Input@2)
end].


'dec_Node-LLdms-80b'(Bytes) ->

%% attribute lon(1) with type LongitudeDMS2
{Term1,Bytes1} = dec_LongitudeDMS2(Bytes),

%% attribute lat(2) with type LatitudeDMS2
{Term2,Bytes2} = dec_LatitudeDMS2(Bytes1),
Res1 = #{lon=>Term1,lat=>Term2},
{Res1,Bytes2}.

'enc_LaneDataAttribute-addGrpB'(Val) ->
<<0:1>>.


'dec_LaneDataAttribute-addGrpB'(Bytes) ->
{Ext,Bytes1} = begin
<<V1@V0:1,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end,

%% Extensions
{Extensions,Bytes2} = case Ext of
0 -> {<<>>,Bytes1};
1 ->
{V2@V0,V2@Buf1} = case Bytes1 of
<<0:1,V2@V3:6,V2@Buf4/bitstring>> ->
V2@Add5 = V2@V3 + 1,
{V2@Add5,V2@Buf4};
<<1:1,V2@Buf2/bitstring>> ->
{V2@V3,V2@Buf4} = case V2@Buf2 of
<<0:1,V2@V6:7,V2@Buf7/bitstring>> when V2@V6 =/= 0 ->
{V2@V6,V2@Buf7};
<<1:1,0:1,V2@V7:14,V2@Buf8/bitstring>> when V2@V7 =/= 0 ->
{V2@V7,V2@Buf8}
end,
{V2@V3,V2@Buf4}
end,
<<V2@V9:V2@V0/bitstring-unit:1,V2@Buf10/bitstring>> = V2@Buf1,
{V2@V9,V2@Buf10}
end,
Bytes3= skipextensions(Bytes2, 1, Extensions),
Res1 = #{},
{Res1,Bytes3}.

'enc_MovementEvent-addGrpB'(Val) ->
#{minEndTime:=Input@2} = Val,
Input@1 = case Val of
  #{startTime:=Input@1_0} -> Input@1_0;
  _ -> asn1__MISSING_IN_MAP
end,
Input@3 = case Val of
  #{maxEndTime:=Input@3_0} -> Input@3_0;
  _ -> asn1__MISSING_IN_MAP
end,
Input@4 = case Val of
  #{likelyTime:=Input@4_0} -> Input@4_0;
  _ -> asn1__MISSING_IN_MAP
end,
Input@5 = case Val of
  #{confidence:=Input@5_0} -> Input@5_0;
  _ -> asn1__MISSING_IN_MAP
end,
Input@6 = case Val of
  #{nextTime:=Input@6_0} -> Input@6_0;
  _ -> asn1__MISSING_IN_MAP
end,
[if Input@1 =:= asn1__MISSING_IN_MAP ->
if Input@3 =:= asn1__MISSING_IN_MAP ->
<<0:1,0:1,0:1>>;
true ->
<<0:1,0:1,1:1>>
end;
true ->
if Input@3 =:= asn1__MISSING_IN_MAP ->
<<0:1,1:1,0:1>>;
true ->
<<0:1,1:1,1:1>>
end
end,
if Input@4 =:= asn1__MISSING_IN_MAP ->
if Input@5 =:= asn1__MISSING_IN_MAP ->
<<0:1,0:1>>;
true ->
<<0:1,1:1>>
end;
true ->
if Input@5 =:= asn1__MISSING_IN_MAP ->
<<1:1,0:1>>;
true ->
<<1:1,1:1>>
end
end,
if Input@6 =:= asn1__MISSING_IN_MAP ->
<<0:1>>;
true ->
<<1:1>>
end,
begin
%% attribute startTime(1) with type INTEGER
if Input@1 =:= asn1__MISSING_IN_MAP ->
[];
0 =< Input@1, Input@1 < 9002 ->
<<Input@1:14>>;
true ->
exit({error,{asn1,{illegal_integer,Input@1}}})
end
end,
begin
%% attribute minEndTime(2) with type INTEGER
if 0 =< Input@2, Input@2 < 2403 ->
<<Input@2:12>>;
true ->
exit({error,{asn1,{illegal_integer,Input@2}}})
end
end,
begin
%% attribute maxEndTime(3) with type INTEGER
if Input@3 =:= asn1__MISSING_IN_MAP ->
[];
0 =< Input@3, Input@3 < 2403 ->
<<Input@3:12>>;
true ->
exit({error,{asn1,{illegal_integer,Input@3}}})
end
end,
begin
%% attribute likelyTime(4) with type INTEGER
if Input@4 =:= asn1__MISSING_IN_MAP ->
[];
0 =< Input@4, Input@4 < 9002 ->
<<Input@4:14>>;
true ->
exit({error,{asn1,{illegal_integer,Input@4}}})
end
end,
begin
%% attribute confidence(5) with type INTEGER
if Input@5 =:= asn1__MISSING_IN_MAP ->
[];
Input@5 bsr 4 =:= 0 ->
<<Input@5:4>>;
true ->
exit({error,{asn1,{illegal_integer,Input@5}}})
end
end|begin
%% attribute nextTime(6) with type INTEGER
if Input@6 =:= asn1__MISSING_IN_MAP ->
[];
0 =< Input@6, Input@6 < 9002 ->
<<Input@6:14>>;
true ->
exit({error,{asn1,{illegal_integer,Input@6}}})
end
end].


'dec_MovementEvent-addGrpB'(Bytes) ->
{Ext,Bytes1} = begin
<<V1@V0:1,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end,
{Opt,Bytes2} = begin
<<V2@V0:5,V2@Buf1/bitstring>> = Bytes1,
{V2@V0,V2@Buf1}
end,

%% attribute startTime(1) with type INTEGER
{Term1,Bytes3} = case (Opt bsr 4) band 1 of
1 ->
begin
<<V3@V0:14,V3@Buf1/bitstring>> = Bytes2,
{V3@V0,V3@Buf1}
end;
0 ->
{asn1_NOVALUE,Bytes2}
end,

%% attribute minEndTime(2) with type INTEGER
{Term2,Bytes4} = begin
<<V4@V0:12,V4@Buf1/bitstring>> = Bytes3,
{V4@V0,V4@Buf1}
end,

%% attribute maxEndTime(3) with type INTEGER
{Term3,Bytes5} = case (Opt bsr 3) band 1 of
1 ->
begin
<<V5@V0:12,V5@Buf1/bitstring>> = Bytes4,
{V5@V0,V5@Buf1}
end;
0 ->
{asn1_NOVALUE,Bytes4}
end,

%% attribute likelyTime(4) with type INTEGER
{Term4,Bytes6} = case (Opt bsr 2) band 1 of
1 ->
begin
<<V6@V0:14,V6@Buf1/bitstring>> = Bytes5,
{V6@V0,V6@Buf1}
end;
0 ->
{asn1_NOVALUE,Bytes5}
end,

%% attribute confidence(5) with type INTEGER
{Term5,Bytes7} = case (Opt bsr 1) band 1 of
1 ->
begin
<<V7@V0:4,V7@Buf1/bitstring>> = Bytes6,
{V7@V0,V7@Buf1}
end;
0 ->
{asn1_NOVALUE,Bytes6}
end,

%% attribute nextTime(6) with type INTEGER
{Term6,Bytes8} = case Opt band 1 of
1 ->
begin
<<V8@V0:14,V8@Buf1/bitstring>> = Bytes7,
{V8@V0,V8@Buf1}
end;
0 ->
{asn1_NOVALUE,Bytes7}
end,

%% Extensions
{Extensions,Bytes9} = case Ext of
0 -> {<<>>,Bytes8};
1 ->
{V9@V0,V9@Buf1} = case Bytes8 of
<<0:1,V9@V3:6,V9@Buf4/bitstring>> ->
V9@Add5 = V9@V3 + 1,
{V9@Add5,V9@Buf4};
<<1:1,V9@Buf2/bitstring>> ->
{V9@V3,V9@Buf4} = case V9@Buf2 of
<<0:1,V9@V6:7,V9@Buf7/bitstring>> when V9@V6 =/= 0 ->
{V9@V6,V9@Buf7};
<<1:1,0:1,V9@V7:14,V9@Buf8/bitstring>> when V9@V7 =/= 0 ->
{V9@V7,V9@Buf8}
end,
{V9@V3,V9@Buf4}
end,
<<V9@V9:V9@V0/bitstring-unit:1,V9@Buf10/bitstring>> = V9@Buf1,
{V9@V9,V9@Buf10}
end,
Bytes10= skipextensions(Bytes9, 1, Extensions),
Res1 = #{minEndTime=>Term2},
Res2 = case Term1 of
  asn1_NOVALUE -> Res1;
  _ -> Res1#{startTime=>Term1}
end,
Res3 = case Term3 of
  asn1_NOVALUE -> Res2;
  _ -> Res2#{maxEndTime=>Term3}
end,
Res4 = case Term4 of
  asn1_NOVALUE -> Res3;
  _ -> Res3#{likelyTime=>Term4}
end,
Res5 = case Term5 of
  asn1_NOVALUE -> Res4;
  _ -> Res4#{confidence=>Term5}
end,
Res6 = case Term6 of
  asn1_NOVALUE -> Res5;
  _ -> Res5#{nextTime=>Term6}
end,
{Res6,Bytes10}.

'enc_NodeOffsetPointXY-addGrpB'(Val) ->
{ChoiceTag,ChoiceVal} = Val,
if ChoiceTag =:= posA ->
[<<0:1,0:1>>|'enc_Node-LLdms-48b'(ChoiceVal)];
ChoiceTag =:= posB ->
[<<0:1,1:1>>|'enc_Node-LLdms-80b'(ChoiceVal)]
end.


'dec_NodeOffsetPointXY-addGrpB'(Bytes) ->
case Bytes of
<<0:1,Bytes1/bitstring>> ->
{Choice,Bytes2} = 
begin
<<V1@V0:1,V1@Buf1/bitstring>> = Bytes1,
{V1@V0,V1@Buf1}
end,
case Choice of
0 ->
{Val,NewBytes} = begin
'dec_Node-LLdms-48b'(Bytes2)
end,
{{posA,Val},NewBytes};
1 ->
{Val,NewBytes} = begin
'dec_Node-LLdms-80b'(Bytes2)
end,
{{posB,Val},NewBytes}
end;

<<1:1,Bytes1/bitstring>> ->
{Choice,Bytes2} = 
begin
{V1@V0,V1@Buf1} = case Bytes1 of
<<0:1,V1@V3:6,V1@Buf4/bitstring>> ->
{V1@V3,V1@Buf4};
<<1:1,V1@Buf2/bitstring>> ->
{V1@V3,V1@Buf4} = case V1@Buf2 of
<<0:1,V1@V6:7,V1@Buf7/bitstring>> when V1@V6 =/= 0 ->
{V1@V6,V1@Buf7};
<<1:1,0:1,V1@V7:14,V1@Buf8/bitstring>> when V1@V7 =/= 0 ->
{V1@V7,V1@Buf8}
end,
<<V1@V9:V1@V3/unit:8,V1@Buf10/bitstring>> = V1@Buf4,
{V1@V9,V1@Buf10}
end,
{V1@V0,V1@Buf1}
end,
begin
{V2@V0,V2@Buf1} = case Bytes2 of
<<0:1,V2@V3:7,V2@V5:V2@V3/binary-unit:8,V2@Buf6/bitstring>> ->
{V2@V5,V2@Buf6};
<<1:1,0:1,V2@V4:14,V2@V6:V2@V4/binary-unit:8,V2@Buf7/bitstring>> ->
{V2@V6,V2@Buf7};
<<1:1,1:1,V2@V4:6,V2@Buf5/bitstring>> ->
{V2@V6,V2@Buf7}  = decode_fragmented(V2@V4, V2@Buf5, 8),
{V2@V6,V2@Buf7}
end
end,
case Choice of
_ ->
{{asn1_ExtAlt,V2@V0},V2@Buf1}
end
end.
'enc_Position3D-addGrpB'(Val) ->
#{latitude:=Input@1,longitude:=Input@2,elevation:=Input@3} = Val,
[<<0:1>>,
begin
%% attribute latitude(1) with type LatitudeDMS2
enc_LatitudeDMS2(Input@1)
end,
begin
%% attribute longitude(2) with type LongitudeDMS2
enc_LongitudeDMS2(Input@2)
end|begin
%% attribute elevation(3) with type INTEGER
Input@3@sub = Input@3 - -32768,
if Input@3@sub bsr 16 =:= 0 ->
<<Input@3@sub:16>>;
true ->
exit({error,{asn1,{illegal_integer,Input@3}}})
end
end].


'dec_Position3D-addGrpB'(Bytes) ->
{Ext,Bytes1} = begin
<<V1@V0:1,V1@Buf1/bitstring>> = Bytes,
{V1@V0,V1@Buf1}
end,

%% attribute latitude(1) with type LatitudeDMS2
{Term1,Bytes2} = dec_LatitudeDMS2(Bytes1),

%% attribute longitude(2) with type LongitudeDMS2
{Term2,Bytes3} = dec_LongitudeDMS2(Bytes2),

%% attribute elevation(3) with type INTEGER
{Term3,Bytes4} = begin
<<V2@V0:16,V2@Buf1/bitstring>> = Bytes3,
V2@Add2 = V2@V0 + -32768,
{V2@Add2,V2@Buf1}
end,

%% Extensions
{Extensions,Bytes5} = case Ext of
0 -> {<<>>,Bytes4};
1 ->
{V3@V0,V3@Buf1} = case Bytes4 of
<<0:1,V3@V3:6,V3@Buf4/bitstring>> ->
V3@Add5 = V3@V3 + 1,
{V3@Add5,V3@Buf4};
<<1:1,V3@Buf2/bitstring>> ->
{V3@V3,V3@Buf4} = case V3@Buf2 of
<<0:1,V3@V6:7,V3@Buf7/bitstring>> when V3@V6 =/= 0 ->
{V3@V6,V3@Buf7};
<<1:1,0:1,V3@V7:14,V3@Buf8/bitstring>> when V3@V7 =/= 0 ->
{V3@V7,V3@Buf8}
end,
{V3@V3,V3@Buf4}
end,
<<V3@V9:V3@V0/bitstring-unit:1,V3@Buf10/bitstring>> = V3@Buf1,
{V3@V9,V3@Buf10}
end,
Bytes6= skipextensions(Bytes5, 1, Extensions),
Res1 = #{latitude=>Term1,longitude=>Term2,elevation=>Term3},
{Res1,Bytes6}.

enc_TimeMark(Val) ->
#{year:=Input@1,month:=Input@2,day:=Input@3,summerTime:=Input@4,holiday:=Input@5,dayofWeek:=Input@6,hour:=Input@7,minute:=Input@8,second:=Input@9,tenthSecond:=Input@10} = Val,
[begin
%% attribute year(1) with type INTEGER
Input@1@sub = Input@1 - 1,
if 0 =< Input@1@sub, Input@1@sub < 65535 ->
<<Input@1@sub:16>>;
true ->
exit({error,{asn1,{illegal_integer,Input@1}}})
end
end,
begin
%% attribute month(2) with type INTEGER
Input@2@sub = Input@2 - 1,
if 0 =< Input@2@sub, Input@2@sub < 255 ->
Input@2@sub;
true ->
exit({error,{asn1,{illegal_integer,Input@2}}})
end
end,
begin
%% attribute day(3) with type INTEGER
if Input@3 bsr 8 =:= 0 ->
Input@3;
true ->
exit({error,{asn1,{illegal_integer,Input@3}}})
end
end,
begin
%% attribute summerTime(4) with type ENUMERATED
%% attribute holiday(5) with type ENUMERATED
if Input@4 =:= notInSummerTime ->
if Input@5 =:= weekday ->
<<0:1,0:1>>;
Input@5 =:= holiday ->
<<0:1,1:1>>;
true ->
exit({error,{asn1,{illegal_enumerated,Input@5}}})
end;
Input@4 =:= inSummerTime ->
if Input@5 =:= weekday ->
<<1:1,0:1>>;
Input@5 =:= holiday ->
<<1:1,1:1>>;
true ->
exit({error,{asn1,{illegal_enumerated,Input@5}}})
end;
true ->
exit({error,{asn1,{illegal_enumerated,Input@4}}})
end
end,
begin
%% attribute dayofWeek(6) with type ENUMERATED
if Input@6 =:= unknown ->
<<0:3>>;
Input@6 =:= monday ->
<<1:3>>;
Input@6 =:= tuesday ->
<<2:3>>;
Input@6 =:= wednesday ->
<<3:3>>;
Input@6 =:= thursday ->
<<4:3>>;
Input@6 =:= friday ->
<<5:3>>;
Input@6 =:= saturday ->
<<6:3>>;
Input@6 =:= sunday ->
<<7:3>>;
true ->
exit({error,{asn1,{illegal_enumerated,Input@6}}})
end
end,
begin
%% attribute hour(7) with type INTEGER
if Input@7 bsr 8 =:= 0 ->
Input@7;
true ->
exit({error,{asn1,{illegal_integer,Input@7}}})
end
end,
begin
%% attribute minute(8) with type INTEGER
if Input@8 bsr 8 =:= 0 ->
Input@8;
true ->
exit({error,{asn1,{illegal_integer,Input@8}}})
end
end,
begin
%% attribute second(9) with type INTEGER
if 0 =< Input@9, Input@9 < 61 ->
<<Input@9:6>>;
true ->
exit({error,{asn1,{illegal_integer,Input@9}}})
end
end|begin
%% attribute tenthSecond(10) with type INTEGER
if 0 =< Input@10, Input@10 < 10 ->
<<Input@10:4>>;
true ->
exit({error,{asn1,{illegal_integer,Input@10}}})
end
end].


dec_TimeMark(Bytes) ->

%% attribute year(1) with type INTEGER
{Term1,Bytes1} = begin
<<V1@V0:16,V1@Buf1/bitstring>> = Bytes,
V1@Add2 = V1@V0 + 1,
{V1@Add2,V1@Buf1}
end,

%% attribute month(2) with type INTEGER
{Term2,Bytes2} = begin
<<V2@V0:8,V2@Buf1/bitstring>> = Bytes1,
V2@Add2 = V2@V0 + 1,
{V2@Add2,V2@Buf1}
end,

%% attribute day(3) with type INTEGER
{Term3,Bytes3} = begin
<<V3@V0:8,V3@Buf1/bitstring>> = Bytes2,
{V3@V0,V3@Buf1}
end,

%% attribute summerTime(4) with type ENUMERATED
{Term4,Bytes4} = begin
<<V4@V0:1,V4@Buf1/bitstring>> = Bytes3,
V4@Int2 = case V4@V0 of
0 -> notInSummerTime;
1 -> inSummerTime
end,
{V4@Int2,V4@Buf1}
end,

%% attribute holiday(5) with type ENUMERATED
{Term5,Bytes5} = begin
<<V5@V0:1,V5@Buf1/bitstring>> = Bytes4,
V5@Int2 = case V5@V0 of
0 -> weekday;
1 -> holiday
end,
{V5@Int2,V5@Buf1}
end,

%% attribute dayofWeek(6) with type ENUMERATED
{Term6,Bytes6} = begin
<<V6@V0:3,V6@Buf1/bitstring>> = Bytes5,
V6@Int2 = case V6@V0 of
0 -> unknown;
1 -> monday;
2 -> tuesday;
3 -> wednesday;
4 -> thursday;
5 -> friday;
6 -> saturday;
7 -> sunday
end,
{V6@Int2,V6@Buf1}
end,

%% attribute hour(7) with type INTEGER
{Term7,Bytes7} = begin
<<V7@V0:8,V7@Buf1/bitstring>> = Bytes6,
{V7@V0,V7@Buf1}
end,

%% attribute minute(8) with type INTEGER
{Term8,Bytes8} = begin
<<V8@V0:8,V8@Buf1/bitstring>> = Bytes7,
{V8@V0,V8@Buf1}
end,

%% attribute second(9) with type INTEGER
{Term9,Bytes9} = begin
<<V9@V0:6,V9@Buf1/bitstring>> = Bytes8,
{V9@V0,V9@Buf1}
end,

%% attribute tenthSecond(10) with type INTEGER
{Term10,Bytes10} = begin
<<V10@V0:4,V10@Buf1/bitstring>> = Bytes9,
{V10@V0,V10@Buf1}
end,
Res1 = #{year=>Term1,month=>Term2,day=>Term3,summerTime=>Term4,holiday=>Term5,dayofWeek=>Term6,hour=>Term7,minute=>Term8,second=>Term9,tenthSecond=>Term10},
{Res1,Bytes10}.


%%%
%%% Run-time functions.
%%%

'dialyzer-suppressions'(Arg) ->
    complete(element(1, Arg)),
    ok.

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

decode_fragmented(SegSz0, Buf0, Unit) ->
    SegSz = SegSz0 * Unit * 16384,
    <<Res:SegSz/bitstring,Buf/bitstring>> = Buf0,
    decode_fragmented_1(Buf, Unit, Res).

decode_fragmented_1(<<0:1,N:7,Buf0/bitstring>>, Unit, Res) ->
    Sz = N * Unit,
    <<S:Sz/bitstring,Buf/bitstring>> = Buf0,
    {<<Res/bitstring,S/bitstring>>, Buf};
decode_fragmented_1(<<1:1,0:1,N:14,Buf0/bitstring>>, Unit, Res) ->
    Sz = N * Unit,
    <<S:Sz/bitstring,Buf/bitstring>> = Buf0,
    {<<Res/bitstring,S/bitstring>>, Buf};
decode_fragmented_1(<<1:1,1:1,SegSz0:6,Buf0/bitstring>>, Unit, Res0) ->
    SegSz = SegSz0 * Unit * 16384,
    <<Frag:SegSz/bitstring,Buf/bitstring>> = Buf0,
    Res = <<Res0/bitstring,Frag/bitstring>>,
    decode_fragmented_1(Buf, Unit, Res).

decode_length(<<0:1,Oct:7,Rest/bitstring>>) ->
    {Oct, Rest};
decode_length(<<2:2,Val:14,Rest/bitstring>>) ->
    {Val, Rest};
decode_length(<<3:2,_:14,_Rest/bitstring>>) ->
    exit({error, {asn1, {decode_length, {nyi, above_16k}}}}).

skipextensions(Bytes0, Nr, ExtensionBitstr)
    when is_bitstring(ExtensionBitstr) ->
    Prev = Nr - 1,
    case ExtensionBitstr of
        <<_:Prev,1:1,_/bitstring>> ->
            {Len, Bytes1} = decode_length(Bytes0),
            <<_:Len/binary,Bytes2/bitstring>> = Bytes1,
            skipextensions(Bytes2, Nr + 1, ExtensionBitstr);
        <<_:Prev,0:1,_/bitstring>> ->
            skipextensions(Bytes0, Nr + 1, ExtensionBitstr);
        _ ->
            Bytes0
    end.
