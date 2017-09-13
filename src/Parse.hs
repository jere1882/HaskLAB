{-# OPTIONS_GHC -w #-}
module Parse where
import Common
import Data.Char
import Data.Maybe

-- parser produced by Happy Version 1.19.0

data HappyAbsSyn t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16

action_0 (17) = happyShift action_4
action_0 (18) = happyShift action_29
action_0 (19) = happyShift action_30
action_0 (20) = happyShift action_31
action_0 (21) = happyShift action_32
action_0 (22) = happyShift action_33
action_0 (23) = happyShift action_34
action_0 (24) = happyShift action_35
action_0 (25) = happyShift action_36
action_0 (26) = happyShift action_37
action_0 (27) = happyShift action_38
action_0 (28) = happyShift action_39
action_0 (29) = happyShift action_40
action_0 (30) = happyShift action_41
action_0 (31) = happyShift action_42
action_0 (32) = happyShift action_43
action_0 (33) = happyShift action_44
action_0 (34) = happyShift action_45
action_0 (35) = happyShift action_46
action_0 (36) = happyShift action_47
action_0 (37) = happyShift action_48
action_0 (6) = happyGoto action_27
action_0 (7) = happyGoto action_28
action_0 _ = happyFail

action_1 (17) = happyShift action_4
action_1 (6) = happyGoto action_25
action_1 (11) = happyGoto action_26
action_1 _ = happyReduce_34

action_2 (39) = happyShift action_10
action_2 (40) = happyShift action_11
action_2 (41) = happyShift action_12
action_2 (43) = happyShift action_13
action_2 (47) = happyShift action_14
action_2 (52) = happyShift action_15
action_2 (53) = happyShift action_16
action_2 (54) = happyShift action_17
action_2 (55) = happyShift action_18
action_2 (56) = happyShift action_19
action_2 (57) = happyShift action_20
action_2 (58) = happyShift action_21
action_2 (59) = happyShift action_22
action_2 (60) = happyShift action_23
action_2 (61) = happyShift action_24
action_2 (12) = happyGoto action_5
action_2 (13) = happyGoto action_6
action_2 (14) = happyGoto action_7
action_2 (15) = happyGoto action_8
action_2 (16) = happyGoto action_9
action_2 _ = happyFail

action_3 (17) = happyShift action_4
action_3 _ = happyFail

action_4 (40) = happyShift action_89
action_4 _ = happyFail

action_5 (42) = happyShift action_87
action_5 (43) = happyShift action_88
action_5 (62) = happyAccept
action_5 _ = happyFail

action_6 (44) = happyShift action_85
action_6 (45) = happyShift action_86
action_6 _ = happyReduce_37

action_7 (46) = happyShift action_84
action_7 _ = happyReduce_41

action_8 _ = happyReduce_43

action_9 _ = happyReduce_54

action_10 _ = happyReduce_55

action_11 (47) = happyShift action_83
action_11 _ = happyFail

action_12 _ = happyReduce_57

action_13 (39) = happyShift action_10
action_13 (40) = happyShift action_11
action_13 (41) = happyShift action_12
action_13 (43) = happyShift action_13
action_13 (47) = happyShift action_14
action_13 (52) = happyShift action_15
action_13 (53) = happyShift action_16
action_13 (54) = happyShift action_17
action_13 (55) = happyShift action_18
action_13 (56) = happyShift action_19
action_13 (57) = happyShift action_20
action_13 (58) = happyShift action_21
action_13 (59) = happyShift action_22
action_13 (60) = happyShift action_23
action_13 (61) = happyShift action_24
action_13 (13) = happyGoto action_82
action_13 (14) = happyGoto action_7
action_13 (15) = happyGoto action_8
action_13 (16) = happyGoto action_9
action_13 _ = happyFail

action_14 (39) = happyShift action_10
action_14 (40) = happyShift action_11
action_14 (41) = happyShift action_12
action_14 (43) = happyShift action_13
action_14 (47) = happyShift action_14
action_14 (52) = happyShift action_15
action_14 (53) = happyShift action_16
action_14 (54) = happyShift action_17
action_14 (55) = happyShift action_18
action_14 (56) = happyShift action_19
action_14 (57) = happyShift action_20
action_14 (58) = happyShift action_21
action_14 (59) = happyShift action_22
action_14 (60) = happyShift action_23
action_14 (61) = happyShift action_24
action_14 (12) = happyGoto action_81
action_14 (13) = happyGoto action_6
action_14 (14) = happyGoto action_7
action_14 (15) = happyGoto action_8
action_14 (16) = happyGoto action_9
action_14 _ = happyFail

action_15 (39) = happyShift action_10
action_15 (40) = happyShift action_11
action_15 (41) = happyShift action_12
action_15 (47) = happyShift action_14
action_15 (52) = happyShift action_15
action_15 (53) = happyShift action_16
action_15 (54) = happyShift action_17
action_15 (55) = happyShift action_18
action_15 (56) = happyShift action_19
action_15 (57) = happyShift action_20
action_15 (58) = happyShift action_21
action_15 (59) = happyShift action_22
action_15 (60) = happyShift action_23
action_15 (61) = happyShift action_24
action_15 (15) = happyGoto action_80
action_15 (16) = happyGoto action_9
action_15 _ = happyFail

action_16 (39) = happyShift action_10
action_16 (40) = happyShift action_11
action_16 (41) = happyShift action_12
action_16 (47) = happyShift action_14
action_16 (52) = happyShift action_15
action_16 (53) = happyShift action_16
action_16 (54) = happyShift action_17
action_16 (55) = happyShift action_18
action_16 (56) = happyShift action_19
action_16 (57) = happyShift action_20
action_16 (58) = happyShift action_21
action_16 (59) = happyShift action_22
action_16 (60) = happyShift action_23
action_16 (61) = happyShift action_24
action_16 (15) = happyGoto action_79
action_16 (16) = happyGoto action_9
action_16 _ = happyFail

action_17 (39) = happyShift action_10
action_17 (40) = happyShift action_11
action_17 (41) = happyShift action_12
action_17 (47) = happyShift action_14
action_17 (52) = happyShift action_15
action_17 (53) = happyShift action_16
action_17 (54) = happyShift action_17
action_17 (55) = happyShift action_18
action_17 (56) = happyShift action_19
action_17 (57) = happyShift action_20
action_17 (58) = happyShift action_21
action_17 (59) = happyShift action_22
action_17 (60) = happyShift action_23
action_17 (61) = happyShift action_24
action_17 (15) = happyGoto action_78
action_17 (16) = happyGoto action_9
action_17 _ = happyFail

action_18 (39) = happyShift action_10
action_18 (40) = happyShift action_11
action_18 (41) = happyShift action_12
action_18 (47) = happyShift action_14
action_18 (52) = happyShift action_15
action_18 (53) = happyShift action_16
action_18 (54) = happyShift action_17
action_18 (55) = happyShift action_18
action_18 (56) = happyShift action_19
action_18 (57) = happyShift action_20
action_18 (58) = happyShift action_21
action_18 (59) = happyShift action_22
action_18 (60) = happyShift action_23
action_18 (61) = happyShift action_24
action_18 (15) = happyGoto action_77
action_18 (16) = happyGoto action_9
action_18 _ = happyFail

action_19 (39) = happyShift action_10
action_19 (40) = happyShift action_11
action_19 (41) = happyShift action_12
action_19 (47) = happyShift action_14
action_19 (52) = happyShift action_15
action_19 (53) = happyShift action_16
action_19 (54) = happyShift action_17
action_19 (55) = happyShift action_18
action_19 (56) = happyShift action_19
action_19 (57) = happyShift action_20
action_19 (58) = happyShift action_21
action_19 (59) = happyShift action_22
action_19 (60) = happyShift action_23
action_19 (61) = happyShift action_24
action_19 (15) = happyGoto action_76
action_19 (16) = happyGoto action_9
action_19 _ = happyFail

action_20 (39) = happyShift action_10
action_20 (40) = happyShift action_11
action_20 (41) = happyShift action_12
action_20 (47) = happyShift action_14
action_20 (52) = happyShift action_15
action_20 (53) = happyShift action_16
action_20 (54) = happyShift action_17
action_20 (55) = happyShift action_18
action_20 (56) = happyShift action_19
action_20 (57) = happyShift action_20
action_20 (58) = happyShift action_21
action_20 (59) = happyShift action_22
action_20 (60) = happyShift action_23
action_20 (61) = happyShift action_24
action_20 (15) = happyGoto action_75
action_20 (16) = happyGoto action_9
action_20 _ = happyFail

action_21 (39) = happyShift action_10
action_21 (40) = happyShift action_11
action_21 (41) = happyShift action_12
action_21 (47) = happyShift action_14
action_21 (52) = happyShift action_15
action_21 (53) = happyShift action_16
action_21 (54) = happyShift action_17
action_21 (55) = happyShift action_18
action_21 (56) = happyShift action_19
action_21 (57) = happyShift action_20
action_21 (58) = happyShift action_21
action_21 (59) = happyShift action_22
action_21 (60) = happyShift action_23
action_21 (61) = happyShift action_24
action_21 (15) = happyGoto action_74
action_21 (16) = happyGoto action_9
action_21 _ = happyFail

action_22 (39) = happyShift action_10
action_22 (40) = happyShift action_11
action_22 (41) = happyShift action_12
action_22 (47) = happyShift action_14
action_22 (52) = happyShift action_15
action_22 (53) = happyShift action_16
action_22 (54) = happyShift action_17
action_22 (55) = happyShift action_18
action_22 (56) = happyShift action_19
action_22 (57) = happyShift action_20
action_22 (58) = happyShift action_21
action_22 (59) = happyShift action_22
action_22 (60) = happyShift action_23
action_22 (61) = happyShift action_24
action_22 (15) = happyGoto action_73
action_22 (16) = happyGoto action_9
action_22 _ = happyFail

action_23 (39) = happyShift action_10
action_23 (40) = happyShift action_11
action_23 (41) = happyShift action_12
action_23 (47) = happyShift action_14
action_23 (52) = happyShift action_15
action_23 (53) = happyShift action_16
action_23 (54) = happyShift action_17
action_23 (55) = happyShift action_18
action_23 (56) = happyShift action_19
action_23 (57) = happyShift action_20
action_23 (58) = happyShift action_21
action_23 (59) = happyShift action_22
action_23 (60) = happyShift action_23
action_23 (61) = happyShift action_24
action_23 (15) = happyGoto action_72
action_23 (16) = happyGoto action_9
action_23 _ = happyFail

action_24 (39) = happyShift action_10
action_24 (40) = happyShift action_11
action_24 (41) = happyShift action_12
action_24 (47) = happyShift action_14
action_24 (52) = happyShift action_15
action_24 (53) = happyShift action_16
action_24 (54) = happyShift action_17
action_24 (55) = happyShift action_18
action_24 (56) = happyShift action_19
action_24 (57) = happyShift action_20
action_24 (58) = happyShift action_21
action_24 (59) = happyShift action_22
action_24 (60) = happyShift action_23
action_24 (61) = happyShift action_24
action_24 (15) = happyGoto action_71
action_24 (16) = happyGoto action_9
action_24 _ = happyFail

action_25 (17) = happyShift action_4
action_25 (6) = happyGoto action_25
action_25 (11) = happyGoto action_70
action_25 _ = happyReduce_34

action_26 (62) = happyAccept
action_26 _ = happyFail

action_27 _ = happyReduce_4

action_28 (62) = happyAccept
action_28 _ = happyFail

action_29 (40) = happyShift action_68
action_29 (50) = happyShift action_69
action_29 _ = happyFail

action_30 (40) = happyShift action_67
action_30 _ = happyFail

action_31 (40) = happyShift action_66
action_31 _ = happyFail

action_32 (40) = happyShift action_65
action_32 _ = happyFail

action_33 (40) = happyShift action_64
action_33 _ = happyFail

action_34 (40) = happyShift action_63
action_34 _ = happyFail

action_35 (40) = happyShift action_62
action_35 _ = happyFail

action_36 (40) = happyShift action_61
action_36 _ = happyFail

action_37 (40) = happyShift action_60
action_37 _ = happyFail

action_38 (40) = happyShift action_59
action_38 _ = happyFail

action_39 (40) = happyShift action_58
action_39 _ = happyFail

action_40 (40) = happyShift action_57
action_40 _ = happyFail

action_41 (40) = happyShift action_56
action_41 _ = happyFail

action_42 (40) = happyShift action_55
action_42 _ = happyFail

action_43 (40) = happyShift action_54
action_43 _ = happyFail

action_44 (40) = happyShift action_53
action_44 _ = happyFail

action_45 (40) = happyShift action_52
action_45 _ = happyFail

action_46 (40) = happyShift action_51
action_46 _ = happyFail

action_47 (40) = happyShift action_50
action_47 _ = happyFail

action_48 (40) = happyShift action_49
action_48 _ = happyFail

action_49 (39) = happyShift action_101
action_49 (43) = happyShift action_102
action_49 (47) = happyShift action_103
action_49 (8) = happyGoto action_120
action_49 _ = happyFail

action_50 (50) = happyShift action_119
action_50 _ = happyFail

action_51 (50) = happyShift action_118
action_51 _ = happyFail

action_52 (39) = happyShift action_101
action_52 (43) = happyShift action_102
action_52 (47) = happyShift action_103
action_52 (8) = happyGoto action_117
action_52 _ = happyFail

action_53 (39) = happyShift action_101
action_53 (43) = happyShift action_102
action_53 (47) = happyShift action_103
action_53 (8) = happyGoto action_116
action_53 _ = happyFail

action_54 (39) = happyShift action_101
action_54 (43) = happyShift action_102
action_54 (47) = happyShift action_103
action_54 (8) = happyGoto action_115
action_54 _ = happyFail

action_55 (39) = happyShift action_101
action_55 (43) = happyShift action_102
action_55 (47) = happyShift action_103
action_55 (8) = happyGoto action_114
action_55 _ = happyFail

action_56 (39) = happyShift action_101
action_56 (43) = happyShift action_102
action_56 (47) = happyShift action_103
action_56 (8) = happyGoto action_113
action_56 _ = happyFail

action_57 (39) = happyShift action_101
action_57 (43) = happyShift action_102
action_57 (47) = happyShift action_103
action_57 (8) = happyGoto action_112
action_57 _ = happyFail

action_58 (40) = happyShift action_111
action_58 _ = happyFail

action_59 (39) = happyShift action_101
action_59 (43) = happyShift action_102
action_59 (47) = happyShift action_103
action_59 (8) = happyGoto action_110
action_59 _ = happyFail

action_60 (40) = happyShift action_109
action_60 _ = happyFail

action_61 (39) = happyShift action_101
action_61 (43) = happyShift action_102
action_61 (47) = happyShift action_103
action_61 (8) = happyGoto action_108
action_61 _ = happyFail

action_62 (39) = happyShift action_101
action_62 (43) = happyShift action_102
action_62 (47) = happyShift action_103
action_62 (8) = happyGoto action_107
action_62 _ = happyFail

action_63 (39) = happyShift action_101
action_63 (43) = happyShift action_102
action_63 (47) = happyShift action_103
action_63 (8) = happyGoto action_106
action_63 _ = happyFail

action_64 (40) = happyShift action_105
action_64 _ = happyFail

action_65 (39) = happyShift action_101
action_65 (43) = happyShift action_102
action_65 (47) = happyShift action_103
action_65 (8) = happyGoto action_104
action_65 _ = happyFail

action_66 _ = happyReduce_8

action_67 _ = happyReduce_5

action_68 (39) = happyShift action_101
action_68 (43) = happyShift action_102
action_68 (47) = happyShift action_103
action_68 (8) = happyGoto action_100
action_68 _ = happyFail

action_69 (40) = happyShift action_99
action_69 (10) = happyGoto action_98
action_69 _ = happyFail

action_70 _ = happyReduce_33

action_71 _ = happyReduce_53

action_72 _ = happyReduce_49

action_73 _ = happyReduce_46

action_74 _ = happyReduce_52

action_75 _ = happyReduce_48

action_76 _ = happyReduce_45

action_77 _ = happyReduce_51

action_78 _ = happyReduce_47

action_79 _ = happyReduce_44

action_80 _ = happyReduce_50

action_81 (42) = happyShift action_87
action_81 (43) = happyShift action_88
action_81 (48) = happyShift action_97
action_81 _ = happyFail

action_82 (44) = happyShift action_85
action_82 (45) = happyShift action_86
action_82 _ = happyReduce_40

action_83 (39) = happyShift action_10
action_83 (40) = happyShift action_11
action_83 (41) = happyShift action_12
action_83 (43) = happyShift action_13
action_83 (47) = happyShift action_14
action_83 (52) = happyShift action_15
action_83 (53) = happyShift action_16
action_83 (54) = happyShift action_17
action_83 (55) = happyShift action_18
action_83 (56) = happyShift action_19
action_83 (57) = happyShift action_20
action_83 (58) = happyShift action_21
action_83 (59) = happyShift action_22
action_83 (60) = happyShift action_23
action_83 (61) = happyShift action_24
action_83 (12) = happyGoto action_96
action_83 (13) = happyGoto action_6
action_83 (14) = happyGoto action_7
action_83 (15) = happyGoto action_8
action_83 (16) = happyGoto action_9
action_83 _ = happyFail

action_84 (39) = happyShift action_10
action_84 (40) = happyShift action_11
action_84 (41) = happyShift action_12
action_84 (47) = happyShift action_14
action_84 (52) = happyShift action_15
action_84 (53) = happyShift action_16
action_84 (54) = happyShift action_17
action_84 (55) = happyShift action_18
action_84 (56) = happyShift action_19
action_84 (57) = happyShift action_20
action_84 (58) = happyShift action_21
action_84 (59) = happyShift action_22
action_84 (60) = happyShift action_23
action_84 (61) = happyShift action_24
action_84 (15) = happyGoto action_95
action_84 (16) = happyGoto action_9
action_84 _ = happyFail

action_85 (39) = happyShift action_10
action_85 (40) = happyShift action_11
action_85 (41) = happyShift action_12
action_85 (47) = happyShift action_14
action_85 (52) = happyShift action_15
action_85 (53) = happyShift action_16
action_85 (54) = happyShift action_17
action_85 (55) = happyShift action_18
action_85 (56) = happyShift action_19
action_85 (57) = happyShift action_20
action_85 (58) = happyShift action_21
action_85 (59) = happyShift action_22
action_85 (60) = happyShift action_23
action_85 (61) = happyShift action_24
action_85 (14) = happyGoto action_94
action_85 (15) = happyGoto action_8
action_85 (16) = happyGoto action_9
action_85 _ = happyFail

action_86 (39) = happyShift action_10
action_86 (40) = happyShift action_11
action_86 (41) = happyShift action_12
action_86 (47) = happyShift action_14
action_86 (52) = happyShift action_15
action_86 (53) = happyShift action_16
action_86 (54) = happyShift action_17
action_86 (55) = happyShift action_18
action_86 (56) = happyShift action_19
action_86 (57) = happyShift action_20
action_86 (58) = happyShift action_21
action_86 (59) = happyShift action_22
action_86 (60) = happyShift action_23
action_86 (61) = happyShift action_24
action_86 (14) = happyGoto action_93
action_86 (15) = happyGoto action_8
action_86 (16) = happyGoto action_9
action_86 _ = happyFail

action_87 (39) = happyShift action_10
action_87 (40) = happyShift action_11
action_87 (41) = happyShift action_12
action_87 (43) = happyShift action_13
action_87 (47) = happyShift action_14
action_87 (52) = happyShift action_15
action_87 (53) = happyShift action_16
action_87 (54) = happyShift action_17
action_87 (55) = happyShift action_18
action_87 (56) = happyShift action_19
action_87 (57) = happyShift action_20
action_87 (58) = happyShift action_21
action_87 (59) = happyShift action_22
action_87 (60) = happyShift action_23
action_87 (61) = happyShift action_24
action_87 (13) = happyGoto action_92
action_87 (14) = happyGoto action_7
action_87 (15) = happyGoto action_8
action_87 (16) = happyGoto action_9
action_87 _ = happyFail

action_88 (39) = happyShift action_10
action_88 (40) = happyShift action_11
action_88 (41) = happyShift action_12
action_88 (43) = happyShift action_13
action_88 (47) = happyShift action_14
action_88 (52) = happyShift action_15
action_88 (53) = happyShift action_16
action_88 (54) = happyShift action_17
action_88 (55) = happyShift action_18
action_88 (56) = happyShift action_19
action_88 (57) = happyShift action_20
action_88 (58) = happyShift action_21
action_88 (59) = happyShift action_22
action_88 (60) = happyShift action_23
action_88 (61) = happyShift action_24
action_88 (13) = happyGoto action_91
action_88 (14) = happyGoto action_7
action_88 (15) = happyGoto action_8
action_88 (16) = happyGoto action_9
action_88 _ = happyFail

action_89 (47) = happyShift action_90
action_89 _ = happyFail

action_90 (41) = happyShift action_143
action_90 _ = happyFail

action_91 (44) = happyShift action_85
action_91 (45) = happyShift action_86
action_91 _ = happyReduce_36

action_92 (44) = happyShift action_85
action_92 (45) = happyShift action_86
action_92 _ = happyReduce_35

action_93 (46) = happyShift action_84
action_93 _ = happyReduce_39

action_94 (46) = happyShift action_84
action_94 _ = happyReduce_38

action_95 _ = happyReduce_42

action_96 (42) = happyShift action_87
action_96 (43) = happyShift action_88
action_96 (48) = happyShift action_142
action_96 _ = happyFail

action_97 _ = happyReduce_58

action_98 (51) = happyShift action_141
action_98 _ = happyFail

action_99 (49) = happyShift action_140
action_99 _ = happyReduce_32

action_100 (39) = happyShift action_101
action_100 (43) = happyShift action_102
action_100 (47) = happyShift action_103
action_100 (8) = happyGoto action_139
action_100 _ = happyFail

action_101 _ = happyReduce_28

action_102 (39) = happyShift action_138
action_102 _ = happyFail

action_103 (39) = happyShift action_101
action_103 (43) = happyShift action_102
action_103 (47) = happyShift action_103
action_103 (8) = happyGoto action_137
action_103 _ = happyFail

action_104 (39) = happyShift action_101
action_104 (43) = happyShift action_102
action_104 (47) = happyShift action_103
action_104 (8) = happyGoto action_136
action_104 _ = happyFail

action_105 _ = happyReduce_10

action_106 (39) = happyShift action_101
action_106 (43) = happyShift action_102
action_106 (47) = happyShift action_103
action_106 (8) = happyGoto action_135
action_106 _ = happyFail

action_107 _ = happyReduce_12

action_108 (39) = happyShift action_101
action_108 (43) = happyShift action_102
action_108 (47) = happyShift action_103
action_108 (8) = happyGoto action_134
action_108 _ = happyFail

action_109 (39) = happyShift action_101
action_109 (43) = happyShift action_102
action_109 (47) = happyShift action_103
action_109 (8) = happyGoto action_133
action_109 _ = happyFail

action_110 (39) = happyShift action_101
action_110 (43) = happyShift action_102
action_110 (47) = happyShift action_103
action_110 (8) = happyGoto action_132
action_110 _ = happyFail

action_111 (39) = happyShift action_101
action_111 (43) = happyShift action_102
action_111 (47) = happyShift action_103
action_111 (8) = happyGoto action_131
action_111 _ = happyFail

action_112 (39) = happyShift action_101
action_112 (43) = happyShift action_102
action_112 (47) = happyShift action_103
action_112 (8) = happyGoto action_130
action_112 _ = happyFail

action_113 (39) = happyShift action_101
action_113 (43) = happyShift action_102
action_113 (47) = happyShift action_103
action_113 (8) = happyGoto action_129
action_113 _ = happyFail

action_114 (39) = happyShift action_101
action_114 (43) = happyShift action_102
action_114 (47) = happyShift action_103
action_114 (8) = happyGoto action_128
action_114 _ = happyFail

action_115 (39) = happyShift action_101
action_115 (43) = happyShift action_102
action_115 (47) = happyShift action_103
action_115 (8) = happyGoto action_127
action_115 _ = happyFail

action_116 (39) = happyShift action_101
action_116 (43) = happyShift action_102
action_116 (47) = happyShift action_103
action_116 (8) = happyGoto action_126
action_116 _ = happyFail

action_117 (39) = happyShift action_101
action_117 (43) = happyShift action_102
action_117 (47) = happyShift action_103
action_117 (8) = happyGoto action_125
action_117 _ = happyFail

action_118 (39) = happyShift action_101
action_118 (43) = happyShift action_102
action_118 (47) = happyShift action_103
action_118 (8) = happyGoto action_122
action_118 (9) = happyGoto action_124
action_118 _ = happyFail

action_119 (39) = happyShift action_101
action_119 (43) = happyShift action_102
action_119 (47) = happyShift action_103
action_119 (8) = happyGoto action_122
action_119 (9) = happyGoto action_123
action_119 _ = happyFail

action_120 (39) = happyShift action_101
action_120 (43) = happyShift action_102
action_120 (47) = happyShift action_103
action_120 (8) = happyGoto action_121
action_120 _ = happyFail

action_121 (39) = happyShift action_101
action_121 (43) = happyShift action_102
action_121 (47) = happyShift action_103
action_121 (8) = happyGoto action_161
action_121 _ = happyFail

action_122 (49) = happyShift action_160
action_122 _ = happyReduce_30

action_123 (51) = happyShift action_159
action_123 _ = happyFail

action_124 (51) = happyShift action_158
action_124 _ = happyFail

action_125 (39) = happyShift action_101
action_125 (43) = happyShift action_102
action_125 (47) = happyShift action_103
action_125 (8) = happyGoto action_157
action_125 _ = happyFail

action_126 (39) = happyShift action_101
action_126 (43) = happyShift action_102
action_126 (47) = happyShift action_103
action_126 (8) = happyGoto action_156
action_126 _ = happyFail

action_127 _ = happyReduce_20

action_128 (39) = happyShift action_101
action_128 (43) = happyShift action_102
action_128 (47) = happyShift action_103
action_128 (8) = happyGoto action_155
action_128 _ = happyFail

action_129 _ = happyReduce_18

action_130 (39) = happyShift action_101
action_130 (43) = happyShift action_102
action_130 (47) = happyShift action_103
action_130 (8) = happyGoto action_154
action_130 _ = happyFail

action_131 (39) = happyShift action_101
action_131 (43) = happyShift action_102
action_131 (47) = happyShift action_103
action_131 (8) = happyGoto action_153
action_131 _ = happyFail

action_132 (39) = happyShift action_101
action_132 (43) = happyShift action_102
action_132 (47) = happyShift action_103
action_132 (8) = happyGoto action_152
action_132 _ = happyFail

action_133 (39) = happyShift action_101
action_133 (43) = happyShift action_102
action_133 (47) = happyShift action_103
action_133 (8) = happyGoto action_151
action_133 _ = happyFail

action_134 (39) = happyShift action_101
action_134 (43) = happyShift action_102
action_134 (47) = happyShift action_103
action_134 (8) = happyGoto action_150
action_134 _ = happyFail

action_135 (39) = happyShift action_101
action_135 (43) = happyShift action_102
action_135 (47) = happyShift action_103
action_135 (8) = happyGoto action_149
action_135 _ = happyFail

action_136 _ = happyReduce_9

action_137 (48) = happyShift action_148
action_137 _ = happyFail

action_138 _ = happyReduce_26

action_139 (39) = happyShift action_101
action_139 (43) = happyShift action_102
action_139 (47) = happyShift action_103
action_139 (8) = happyGoto action_147
action_139 _ = happyFail

action_140 (40) = happyShift action_99
action_140 (10) = happyGoto action_146
action_140 _ = happyFail

action_141 (39) = happyShift action_101
action_141 (43) = happyShift action_102
action_141 (47) = happyShift action_103
action_141 (8) = happyGoto action_145
action_141 _ = happyFail

action_142 _ = happyReduce_56

action_143 (48) = happyShift action_144
action_143 _ = happyFail

action_144 (38) = happyShift action_169
action_144 _ = happyFail

action_145 (39) = happyShift action_101
action_145 (43) = happyShift action_102
action_145 (47) = happyShift action_103
action_145 (8) = happyGoto action_168
action_145 _ = happyFail

action_146 _ = happyReduce_31

action_147 _ = happyReduce_7

action_148 _ = happyReduce_27

action_149 _ = happyReduce_11

action_150 (39) = happyShift action_101
action_150 (43) = happyShift action_102
action_150 (47) = happyShift action_103
action_150 (8) = happyGoto action_167
action_150 _ = happyFail

action_151 (39) = happyShift action_101
action_151 (43) = happyShift action_102
action_151 (47) = happyShift action_103
action_151 (8) = happyGoto action_166
action_151 _ = happyFail

action_152 (39) = happyShift action_101
action_152 (43) = happyShift action_102
action_152 (47) = happyShift action_103
action_152 (8) = happyGoto action_165
action_152 _ = happyFail

action_153 (39) = happyShift action_101
action_153 (43) = happyShift action_102
action_153 (47) = happyShift action_103
action_153 (8) = happyGoto action_164
action_153 _ = happyFail

action_154 (39) = happyShift action_101
action_154 (43) = happyShift action_102
action_154 (47) = happyShift action_103
action_154 (8) = happyGoto action_163
action_154 _ = happyFail

action_155 _ = happyReduce_19

action_156 _ = happyReduce_21

action_157 _ = happyReduce_22

action_158 _ = happyReduce_23

action_159 _ = happyReduce_24

action_160 (39) = happyShift action_101
action_160 (43) = happyShift action_102
action_160 (47) = happyShift action_103
action_160 (8) = happyGoto action_122
action_160 (9) = happyGoto action_162
action_160 _ = happyFail

action_161 _ = happyReduce_25

action_162 _ = happyReduce_29

action_163 (39) = happyShift action_101
action_163 (43) = happyShift action_102
action_163 (47) = happyShift action_103
action_163 (8) = happyGoto action_176
action_163 _ = happyFail

action_164 (39) = happyShift action_101
action_164 (43) = happyShift action_102
action_164 (47) = happyShift action_103
action_164 (8) = happyGoto action_175
action_164 _ = happyFail

action_165 (39) = happyShift action_101
action_165 (43) = happyShift action_102
action_165 (47) = happyShift action_103
action_165 (8) = happyGoto action_174
action_165 _ = happyFail

action_166 (39) = happyShift action_101
action_166 (43) = happyShift action_102
action_166 (47) = happyShift action_103
action_166 (8) = happyGoto action_173
action_166 _ = happyFail

action_167 (39) = happyShift action_101
action_167 (43) = happyShift action_102
action_167 (47) = happyShift action_103
action_167 (8) = happyGoto action_172
action_167 _ = happyFail

action_168 (39) = happyShift action_101
action_168 (43) = happyShift action_102
action_168 (47) = happyShift action_103
action_168 (8) = happyGoto action_171
action_168 _ = happyFail

action_169 (39) = happyShift action_10
action_169 (40) = happyShift action_11
action_169 (41) = happyShift action_12
action_169 (43) = happyShift action_13
action_169 (47) = happyShift action_14
action_169 (52) = happyShift action_15
action_169 (53) = happyShift action_16
action_169 (54) = happyShift action_17
action_169 (55) = happyShift action_18
action_169 (56) = happyShift action_19
action_169 (57) = happyShift action_20
action_169 (58) = happyShift action_21
action_169 (59) = happyShift action_22
action_169 (60) = happyShift action_23
action_169 (61) = happyShift action_24
action_169 (12) = happyGoto action_170
action_169 (13) = happyGoto action_6
action_169 (14) = happyGoto action_7
action_169 (15) = happyGoto action_8
action_169 (16) = happyGoto action_9
action_169 _ = happyFail

action_170 (42) = happyShift action_87
action_170 (43) = happyShift action_88
action_170 _ = happyReduce_3

action_171 _ = happyReduce_6

action_172 _ = happyReduce_13

action_173 _ = happyReduce_14

action_174 _ = happyReduce_15

action_175 (39) = happyShift action_101
action_175 (43) = happyShift action_102
action_175 (47) = happyShift action_103
action_175 (8) = happyGoto action_178
action_175 _ = happyFail

action_176 (39) = happyShift action_101
action_176 (43) = happyShift action_102
action_176 (47) = happyShift action_103
action_176 (8) = happyGoto action_177
action_176 _ = happyFail

action_177 _ = happyReduce_17

action_178 _ = happyReduce_16

happyReduce_3 = happyReduce 7 6 happyReduction_3
happyReduction_3 ((HappyAbsSyn12  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Def happy_var_2 happy_var_7
	) `HappyStk` happyRest

happyReduce_4 = happySpecReduce_1  7 happyReduction_4
happyReduction_4 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_2  7 happyReduction_5
happyReduction_5 (HappyTerminal (TokenId happy_var_2))
	_
	 =  HappyAbsSyn7
		 (Disp happy_var_2
	)
happyReduction_5 _ _  = notHappyAtAll 

happyReduce_6 = happyReduce 7 7 happyReduction_6
happyReduction_6 ((HappyAbsSyn8  happy_var_7) `HappyStk`
	(HappyAbsSyn8  happy_var_6) `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Plot happy_var_3 happy_var_5 happy_var_6 happy_var_7
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 5 7 happyReduction_7
happyReduction_7 ((HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Plot [happy_var_2] happy_var_3 happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_8 = happySpecReduce_2  7 happyReduction_8
happyReduction_8 (HappyTerminal (TokenId happy_var_2))
	_
	 =  HappyAbsSyn7
		 (Derivate happy_var_2
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happyReduce 4 7 happyReduction_9
happyReduction_9 ((HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (HDerivate happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_10 = happySpecReduce_3  7 happyReduction_10
happyReduction_10 (HappyTerminal (TokenId happy_var_3))
	(HappyTerminal (TokenId happy_var_2))
	_
	 =  HappyAbsSyn7
		 (Compose happy_var_2 happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happyReduce 5 7 happyReduction_11
happyReduction_11 ((HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Bisection happy_var_2 happy_var_3 happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_12 = happySpecReduce_3  7 happyReduction_12
happyReduction_12 (HappyAbsSyn8  happy_var_3)
	(HappyTerminal (TokenId happy_var_2))
	_
	 =  HappyAbsSyn7
		 (Eval happy_var_2 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happyReduce 7 7 happyReduction_13
happyReduction_13 ((HappyAbsSyn8  happy_var_7) `HappyStk`
	(HappyAbsSyn8  happy_var_6) `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (RegulaFalsi happy_var_2 happy_var_3 happy_var_4 happy_var_5 happy_var_6 (double2int happy_var_7)
	) `HappyStk` happyRest

happyReduce_14 = happyReduce 7 7 happyReduction_14
happyReduction_14 ((HappyAbsSyn8  happy_var_7) `HappyStk`
	(HappyAbsSyn8  happy_var_6) `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyTerminal (TokenId happy_var_3)) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (NewtonRaphson happy_var_2 happy_var_3 happy_var_4 happy_var_5 happy_var_6 (double2int happy_var_7)
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 7 7 happyReduction_15
happyReduction_15 ((HappyAbsSyn8  happy_var_7) `HappyStk`
	(HappyAbsSyn8  happy_var_6) `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (HNewtonRaphson happy_var_2 happy_var_3 happy_var_4 happy_var_5 happy_var_6 (double2int happy_var_7)
	) `HappyStk` happyRest

happyReduce_16 = happyReduce 8 7 happyReduction_16
happyReduction_16 ((HappyAbsSyn8  happy_var_8) `HappyStk`
	(HappyAbsSyn8  happy_var_7) `HappyStk`
	(HappyAbsSyn8  happy_var_6) `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyTerminal (TokenId happy_var_3)) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Secante happy_var_2 happy_var_3 happy_var_4 happy_var_5 happy_var_6 happy_var_7 (double2int happy_var_8)
	) `HappyStk` happyRest

happyReduce_17 = happyReduce 8 7 happyReduction_17
happyReduction_17 ((HappyAbsSyn8  happy_var_8) `HappyStk`
	(HappyAbsSyn8  happy_var_7) `HappyStk`
	(HappyAbsSyn8  happy_var_6) `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (HSecante happy_var_2 happy_var_3 happy_var_4 happy_var_5 happy_var_6 happy_var_7 (double2int happy_var_8)
	) `HappyStk` happyRest

happyReduce_18 = happyReduce 4 7 happyReduction_18
happyReduction_18 ((HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Trapecio happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 5 7 happyReduction_19
happyReduction_19 ((HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (TrapecioC happy_var_2 happy_var_3 happy_var_4 (double2int happy_var_5)
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 4 7 happyReduction_20
happyReduction_20 ((HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Simpson happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 5 7 happyReduction_21
happyReduction_21 ((HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (SimpsonC happy_var_2 happy_var_3 happy_var_4 (double2int happy_var_5)
	) `HappyStk` happyRest

happyReduce_22 = happyReduce 5 7 happyReduction_22
happyReduction_22 ((HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Taylor happy_var_2 happy_var_3 happy_var_4 (double2int happy_var_5)
	) `HappyStk` happyRest

happyReduce_23 = happyReduce 5 7 happyReduction_23
happyReduction_23 (_ `HappyStk`
	(HappyAbsSyn9  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (InterpolacionL happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_24 = happyReduce 5 7 happyReduction_24
happyReduction_24 (_ `HappyStk`
	(HappyAbsSyn9  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (InterpolacionN happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_25 = happyReduce 5 7 happyReduction_25
happyReduction_25 ((HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Chebyshev happy_var_2 happy_var_3 happy_var_4 (double2int happy_var_5)
	) `HappyStk` happyRest

happyReduce_26 = happySpecReduce_2  8 happyReduction_26
happyReduction_26 (HappyTerminal (TokenReal happy_var_2))
	_
	 =  HappyAbsSyn8
		 ((- happy_var_2)
	)
happyReduction_26 _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  8 happyReduction_27
happyReduction_27 _
	(HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (happy_var_2
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  8 happyReduction_28
happyReduction_28 (HappyTerminal (TokenReal happy_var_1))
	 =  HappyAbsSyn8
		 (happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  9 happyReduction_29
happyReduction_29 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1 : happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  9 happyReduction_30
happyReduction_30 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 ([happy_var_1]
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  10 happyReduction_31
happyReduction_31 (HappyAbsSyn10  happy_var_3)
	_
	(HappyTerminal (TokenId happy_var_1))
	 =  HappyAbsSyn10
		 (happy_var_1 : happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  10 happyReduction_32
happyReduction_32 (HappyTerminal (TokenId happy_var_1))
	 =  HappyAbsSyn10
		 ([happy_var_1]
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_2  11 happyReduction_33
happyReduction_33 (HappyAbsSyn11  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1 : happy_var_2
	)
happyReduction_33 _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_0  11 happyReduction_34
happyReduction_34  =  HappyAbsSyn11
		 ([]
	)

happyReduce_35 = happySpecReduce_3  12 happyReduction_35
happyReduction_35 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (FSum happy_var_1 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  12 happyReduction_36
happyReduction_36 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (FDif happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  12 happyReduction_37
happyReduction_37 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_1
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  13 happyReduction_38
happyReduction_38 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (FMul happy_var_1 happy_var_3
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  13 happyReduction_39
happyReduction_39 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (FCoc happy_var_1 happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_2  13 happyReduction_40
happyReduction_40 (HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (FUmin happy_var_2
	)
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  13 happyReduction_41
happyReduction_41 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  14 happyReduction_42
happyReduction_42 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (FPot happy_var_1 happy_var_3
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  14 happyReduction_43
happyReduction_43 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_2  15 happyReduction_44
happyReduction_44 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (FCosh happy_var_2
	)
happyReduction_44 _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_2  15 happyReduction_45
happyReduction_45 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (FSinh happy_var_2
	)
happyReduction_45 _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_2  15 happyReduction_46
happyReduction_46 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (FTanh happy_var_2
	)
happyReduction_46 _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_2  15 happyReduction_47
happyReduction_47 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (FCos happy_var_2
	)
happyReduction_47 _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_2  15 happyReduction_48
happyReduction_48 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (FSin happy_var_2
	)
happyReduction_48 _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_2  15 happyReduction_49
happyReduction_49 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (FTan happy_var_2
	)
happyReduction_49 _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_2  15 happyReduction_50
happyReduction_50 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (FAcos happy_var_2
	)
happyReduction_50 _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_2  15 happyReduction_51
happyReduction_51 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (FAsin happy_var_2
	)
happyReduction_51 _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_2  15 happyReduction_52
happyReduction_52 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (FAtan happy_var_2
	)
happyReduction_52 _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_2  15 happyReduction_53
happyReduction_53 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (FLog happy_var_2
	)
happyReduction_53 _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_1  15 happyReduction_54
happyReduction_54 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  16 happyReduction_55
happyReduction_55 (HappyTerminal (TokenReal happy_var_1))
	 =  HappyAbsSyn16
		 (FConst happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happyReduce 4 16 happyReduction_56
happyReduction_56 (_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (FId happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_57 = happySpecReduce_1  16 happyReduction_57
happyReduction_57 _
	 =  HappyAbsSyn16
		 (FVar
	)

happyReduce_58 = happySpecReduce_3  16 happyReduction_58
happyReduction_58 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (happy_var_2
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	TEOF -> action 62 62 tk (HappyState action) sts stk;
	TokenDef -> cont 17;
	TokenPlot -> cont 18;
	TokenDisp -> cont 19;
	TokenDerivate -> cont 20;
	TokenHDerivate -> cont 21;
	TokenCompose -> cont 22;
	TokenBisection -> cont 23;
	TokenEval -> cont 24;
	TokenRegulaFalsi -> cont 25;
	TokenNewtonRaphson -> cont 26;
	TokenHNewtonRaphson -> cont 27;
	TokenSecante -> cont 28;
	TokenHSecante -> cont 29;
	TokenTrapecio -> cont 30;
	TokenTrapecioc -> cont 31;
	TokenSimpson -> cont 32;
	TokenSimpsonc -> cont 33;
	TokenTaylor -> cont 34;
	TokenInterpolacionL -> cont 35;
	TokenInterpolacionN -> cont 36;
	TokenChebyshev -> cont 37;
	TokenEquals -> cont 38;
	TokenReal happy_dollar_dollar -> cont 39;
	TokenId happy_dollar_dollar -> cont 40;
	TokenVar -> cont 41;
	TokenPlus -> cont 42;
	TokenMinus -> cont 43;
	TokenTimes -> cont 44;
	TokenDiv -> cont 45;
	TokenPower -> cont 46;
	TokenOB -> cont 47;
	TokenCB -> cont 48;
	TokenComma -> cont 49;
	TokenOC -> cont 50;
	TokenCC -> cont 51;
	TokenAcos -> cont 52;
	TokenCosh -> cont 53;
	TokenCos -> cont 54;
	TokenAsin -> cont 55;
	TokenSinh -> cont 56;
	TokenSin -> cont 57;
	TokenAtan -> cont 58;
	TokenTanh -> cont 59;
	TokenTan -> cont 60;
	TokenLog -> cont 61;
	_ -> happyError' tk
	})

happyError_ 62 tk = happyError' tk
happyError_ _ tk = happyError' tk

happyThen :: () => P a -> (a -> P b) -> P b
happyThen = (thenP)
happyReturn :: () => a -> P a
happyReturn = (returnP)
happyThen1 = happyThen
happyReturn1 :: () => a -> P a
happyReturn1 = happyReturn
happyError' :: () => (Token) -> P a
happyError' tk = (\token -> happyError) tk

parseStmt = happySomeParser where
  happySomeParser = happyThen (happyParse action_0) (\x -> case x of {HappyAbsSyn7 z -> happyReturn z; _other -> notHappyAtAll })

parseStmts = happySomeParser where
  happySomeParser = happyThen (happyParse action_1) (\x -> case x of {HappyAbsSyn11 z -> happyReturn z; _other -> notHappyAtAll })

term = happySomeParser where
  happySomeParser = happyThen (happyParse action_2) (\x -> case x of {HappyAbsSyn12 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


data ParseResult a = Ok a | Failed String
                     deriving Show                     
type LineNumber = Int
type P a = String -> LineNumber -> ParseResult a

getLineNo :: P LineNumber
getLineNo = \s l -> Ok l

thenP :: P a -> (a -> P b) -> P b
m `thenP` k = \s l-> case m s l of
                         Ok a     -> k a s l
                         Failed e -> Failed e
                         
returnP :: a -> P a
returnP a = \s l-> Ok a

failP :: String -> P a
failP err = \s l -> Failed err

catchP :: P a -> (String -> P a) -> P a
catchP m k = \s l -> case m s l of
                        Ok a     -> Ok a
                        Failed e -> k e s l

happyError :: P a
happyError = \ s i -> Failed $ "Línea "++(show (i::LineNumber))++": Error de parseo\n"++(s)

double2int :: Double -> Int
double2int x = round x

-------------
      
data Token
      = TokenReal Double
      | TokenId String
      | TokenVar
      | TokenPlus
      | TokenMinus
      | TokenTimes
      | TokenDiv
      | TokenPower     
      | TokenOB
      | TokenCB
      | TokenCos
      | TokenSin
      | TokenTan
      | TokenCosh
      | TokenSinh
      | TokenTanh
      | TokenLog
      | TokenAtan
      | TokenAsin
      | TokenAcos
      | TokenDef   
      | TokenEquals
      | TokenPlot
      | TokenDisp
      | TokenDerivate
      | TokenHDerivate
      | TokenCompose
      | TokenBisection
      | TokenHNewtonRaphson 
      | TokenNewtonRaphson 
      | TokenRegulaFalsi
      | TokenSecante
      | TokenHSecante
      | TokenEval
      | TokenCC
      | TokenOC
      | TokenComma
      | TEOF 
      | TokenTrapecio 
      | TokenTrapecioc 
      | TokenSimpson 
      | TokenSimpsonc 
      | TokenTaylor 
      | TokenInterpolacionL 
      | TokenInterpolacionN 
      | TokenChebyshev 
 deriving Show
-----------------------------

lexer cont s = case s of
            [] -> cont TEOF []
            ('\n':s)  ->  \line -> lexer cont s (line + 1)
            (c:cs)
                  | isSpace c -> lexer cont cs
                  | isAlpha c -> lexVar (c:cs) cont
                  | isDigit c -> lexNum (c:cs) cont
            ('-':('-':cs)) -> lexer cont $ dropWhile ((/=) '\n') cs
            ('{':('-':cs)) -> consumirBK 0 0 cont cs    
            ('-':('}':cs)) -> \ line -> Failed $ "Línea "++(show line)++": Comentario no abierto"
            ('^':cs) -> cont TokenPower cs
            ('+':cs) -> cont TokenPlus cs
            ('-':cs) -> cont TokenMinus cs
            ('*':'*':cs) -> cont TokenPower cs
            ('*':cs) -> cont TokenTimes cs
            ('/':cs) -> cont TokenDiv cs
            ('(':cs) -> cont TokenOB cs
            (')':cs) -> cont TokenCB cs
            ('=':cs) -> cont TokenEquals cs
            (',':cs) -> cont TokenComma cs
            ('[':cs) -> cont TokenOC cs
            (']':cs) -> cont TokenCC cs
            unknown -> \line -> Failed $ "Línea "++(show line)++": No se puede reconocer "++(show $ take 10 unknown)++ "..."
            where consumirBK anidado cl cont s = case s of
                                                      ('-':('-':cs)) -> consumirBK anidado cl cont $ dropWhile ((/=) '\n') cs
                                                      ('{':('-':cs)) -> consumirBK (anidado+1) cl cont cs   
                                                      ('-':('}':cs)) -> case anidado of
                                                                         0 -> \line -> lexer cont cs (line+cl)
                                                                         _ -> consumirBK (anidado-1) cl cont cs
                                                      ('\n':cs) -> consumirBK anidado (cl+1) cont cs
                                                      (_:cs) -> consumirBK anidado cl cont cs   
                                    
                                    
lexNum cs cont = cont (TokenReal(read num)) rest'
      where (ent,rest) = span isDigit cs
            (frac,rest') = if (is_point rest) then (span isDigit (tail rest)) else ("0",rest)
            num = ent ++ "." ++ frac
            is_point (x:xs) | x=='.' = True
            is_point _               = False  
              
lexVar cs cont =
   case span (\c -> isAlpha c || c=='_' || c=='\'') cs of
      ("e",rest)    -> cont (TokenReal (2.71828182846)) rest
      ("pi",rest)   -> cont (TokenReal (3.14159265259)) rest
      ("cosh",rest) -> cont TokenCosh rest
      ("sinh",rest) -> cont TokenSinh rest
      ("senh",rest) -> cont TokenSinh rest
      ("tanh",rest) -> cont TokenTanh rest
      ("cos",rest) -> cont TokenCos rest
      ("sin",rest) -> cont TokenSin rest
      ("sen",rest) -> cont TokenSin rest
      ("tan",rest) -> cont TokenTan rest
      ("tg",rest)  -> cont TokenTan rest
      ("acos",rest) -> cont TokenAcos rest
      ("asin",rest) -> cont TokenAsin rest
      ("asen",rest) -> cont TokenAsin rest
      ("atan",rest) -> cont TokenAtan rest
      ("log",rest) -> cont TokenLog rest
      ("ln",rest)  -> cont TokenLog rest
      ("def",rest) -> cont TokenDef  rest
      ("plot",rest) -> cont TokenPlot  rest
      ("disp",rest) -> cont TokenDisp  rest
      ("compose",rest) -> cont TokenCompose rest
      ("eval",rest) -> cont TokenEval  rest      
      ("derivate",rest) -> cont TokenDerivate rest
      ("hderivate",rest) -> cont TokenHDerivate rest      
      ("bisection",rest) -> cont TokenBisection rest
      ("regula_falsi",rest) -> cont TokenRegulaFalsi rest
      ("newton_raphson",rest) -> cont TokenNewtonRaphson  rest
      ("hnewton_raphson",rest) -> cont TokenHNewtonRaphson  rest
      ("secante",rest) -> cont TokenSecante rest
      ("hsecante",rest) -> cont TokenHSecante rest
      ("x",rest) -> cont TokenVar rest
      ("trapecio",rest) -> cont  TokenTrapecio rest
      ("trapecio_compuesto",rest) -> cont  TokenTrapecioc rest
      ("simpson",rest) -> cont  TokenSimpson rest
      ("simpson_compuesto",rest) -> cont  TokenSimpsonc rest
      ("taylor",rest) -> cont  TokenTaylor rest
      ("interpolacion_lagrange",rest) -> cont  TokenInterpolacionL rest
      ("interpolacion_newton",rest) -> cont  TokenInterpolacionN rest
      ("chebyshev",rest) -> cont  TokenChebyshev rest      
      (id,rest)     -> cont (TokenId id)  rest
---------     
stmts_parse s = parseStmts s 1
stmt_parse s = parseStmt s 1
term_parse s = term s 1
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<command-line>" #-}





# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4














# 1 "/usr/include/x86_64-linux-gnu/bits/predefs.h" 1 3 4

# 18 "/usr/include/x86_64-linux-gnu/bits/predefs.h" 3 4












# 31 "/usr/include/stdc-predef.h" 2 3 4








# 5 "<command-line>" 2
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 13 "templates/GenericTemplate.hs" #-}

{-# LINE 45 "templates/GenericTemplate.hs" #-}








{-# LINE 66 "templates/GenericTemplate.hs" #-}

{-# LINE 76 "templates/GenericTemplate.hs" #-}

{-# LINE 85 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	 (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 154 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
	 sts1@(((st1@(HappyState (action))):(_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 255 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--	trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 321 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
