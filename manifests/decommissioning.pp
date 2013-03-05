# decomissioning.pp

# ALPHABETIC order!

$decommissioned_servers = [
"adler",
"argon", # not really decom, just need to stop nagios monitoring
"bayes",
"br1-knams",
"constable", #moved from external to internal ip, temp move
"controller",
"copper", #moved from external to internal ip, will come back out once spence updates
"cp3001",
"cp3002",
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
"db17",
"db18",
"db19",
"db20",
"db21",
"db22",
"db23",
"db24",
"db25",
"db27",
"db28",
"db30",
"db41",
"ixia",
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
"knsq25",
"knsq30",
"lily",
"lomaria",
"mobile1",
"mobile2",
"mobile3",
"mobile4",
"mobile5",
"ms1",
"ms2",
"ms3",
"ms4",
"msfe1002",
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
"spence",
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
"srv190",
"srv191",
"srv192",
"srv194",
"srv195",
"srv196",
"srv197",
"srv198",
"srv199",
"srv200",
"srv201",
"srv202",
"srv203",
"srv204",
"srv205",
"srv206",
"srv207",
"srv208",
"srv209",
"srv210",
"srv211",
"srv212",
"srv213",
"srv214",
"srv215",
"srv216",
"srv217",
"srv218",
"srv219",
"srv220",
"srv221",
"srv222",
"srv223",
"srv224",
"srv225",
"srv226",
"srv227",
"srv228",
"srv229",
"srv230",
"srv231",
"srv232",
"srv233",
"srv234",
"srv266",
"srv278",
"storage1",
"storage2",
"storage3",
"thistle",
"virt1001",
"virt1002",
"virt1003",
"wikinews-lb.wikimedia.org",
]
