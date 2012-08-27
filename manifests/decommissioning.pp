# decomissioning.pp

# ALPHABETIC order!

$decommissioned_servers = [
"adler",
"bayes",
"br1-knams",
"controller",
"dataset1",
"db1",
"db2",
"db3",
"db4",
"db5",
"db7",
"db8",
"db12",
"db13",
"db14",
"db15",
"db16",
"db18",
"db19",
"db20",
"db21",
"db23",
"db24",
"db28",
"db30",
"db41",
"eiximenis",
"ixia",
"ganglia1001",
"gilman",
"knsq1",
"knsq2",
"knsq3",
"knsq4",
"knsq5",
"knsq6",
"knsq7",
"knsq8",
"knsq9",
"knsq10",
"knsq11",
"knsq12",
"knsq13",
"knsq14",
"knsq15",
"knsq30",
"lily",
"lomaria",
"mobile1",
"mobile2",
"mobile3",
"mobile4",
"mobile5",
"msfe1001",
"ms1",
"ms2",
"ms3",
"ms4",
"project1",
"project2",
"searchidx1",
"search1",
"search2",
"search3",
"search4",
"search5",
"search6",
"search7",
"search8",
"search9",
"search10",
"search11",
"search12",
"sq31",
"sq32",
"sq34",
"sq35",
"sq38",
"sq39",
"sq40",
"sq46",
"sq47",
"srv86",
"srv87",
"srv88",
"srv89",
"srv90",
"srv91",
"srv92",
"srv93",
"srv94",
"srv95",
"srv96",
"srv97",
"srv98",
"srv99",
"srv100",
"srv101",
"srv102",
"srv103",
"srv104",
"srv105",
"srv106",
"srv107",
"srv108",
"srv109",
"srv110",
"srv111",
"srv112",
"srv113",
"srv114",
"srv115",
"srv116",
"srv117",
"srv118",
"srv119",
"srv120",
"srv121",
"srv122",
"srv123",
"srv124",
"srv125",
"srv126",
"srv127",
"srv128",
"srv129",
"srv130",
"srv131",
"srv132",
"srv133",
"srv134",
"srv135",
"srv136",
"srv137",
"srv138",
"srv139",
"srv140",
"srv141",
"srv142",
"srv143",
"srv144",
"srv145",
"srv146",
"srv147",
"srv148",
"srv149",
"srv150",
"srv151",
"srv152",
"srv153",
"srv154",
"srv155",
"srv156",
"srv157",
"srv158",
"srv159",
"srv160",
"srv161",
"srv162",
"srv163",
"srv164",
"srv165",
"srv166",
"srv167",
"srv168",
"srv169",
"srv170",
"srv171",
"srv172",
"srv173",
"srv174",
"srv175",
"srv176",
"srv177",
"srv178",
"srv179",
"srv180",
"srv181",
"srv182",
"srv183",
"srv184",
"srv185",
"srv186",
"srv187",
"srv188",
"srv189",
"srv206",
"srv217",
"storage2",
"thistle",
"transcode1",
"transcode2",
"wikinews-lb.wikimedia.org",
"yongle",
"mw1001",
"mw1002",
"mw1003",
"mw1004",
"mw1005",
"mw1006",
"mw1007",
"mw1008",
"mw1009",
"mw1010",
"mw1011",
"mw1012",
"mw1013",
"mw1014",
"mw1015",
"mw1016",
"mw1017",
"mw1019",
"mw1020",
"mw1022",
"mw1023",
"mw1024",
"mw1025",
"mw1026",
"mw1028",
"mw1029",
"mw1030",
"mw1031",
"mw1032",
"mw1034",
"mw1035",
"mw1036",
"mw1037",
"mw1040",
"mw1041",
"mw1042",
"mw1043",
"mw1044",
"mw1045",
"mw1046",
"mw1047",
"mw1048",
"mw1049",
"mw1050",
"mw1051",
"mw1052",
"mw1053",
"mw1055",
"mw1057",
"mw1058",
"mw1059",
"mw1060",
"mw1062",
"mw1063",
"mw1064",
"mw1065",
"mw1067",
"mw1068",
"mw1069",
"mw1070",
"mw1071",
"mw1072",
"mw1073",
"mw1074",
"mw1075",
"mw1076",
"mw1077",
"mw1078",
"mw1079",
"mw1080",
"mw1081",
"mw1082",
"mw1083",
"mw1084",
"mw1085",
"mw1086",
"mw1087",
"mw1088",
"mw1089",
"mw1090",
"mw1091",
"mw1092",
"mw1093",
"mw1095",
"mw1096",
"mw1097",
"mw1098",
"mw1099",
"mw1100",
"mw1101",
"mw1102",
"mw1104",
"mw1105",
"mw1106",
"mw1107",
"mw1108",
"mw1109",
"mw1110",
"mw1111",
"mw1112",
"mw1113",
"mw1114",
"mw1115",
"mw1116",
"mw1117",
"mw1118",
"mw1119",
"mw1121",
"mw1122",
"mw1123",
"mw1124",
"mw1125",
"mw1126",
"mw1127",
"mw1128",
"mw1129",
"mw1130",
"mw1131",
"mw1132",
"mw1133",
"mw1134",
"mw1135",
"mw1136",
"mw1137",
"mw1138",
"mw1139",
"mw1140",
"mw1141",
"mw1142",
"mw1143",
"mw1144",
"mw1145",
"mw1146",
"mw1147",
"mw1148",
"mw1149",
"mw1150",
"mw1151",
"mw1152",
"mw1153",
"mw1154",
"mw1155",
"mw1156",
"mw1157",
"mw1158",
"mw1159",
"mw1160",
"potassium",
]
