```
Secondo => @@createberlingenmo.sec
*** Begin processing file 'createberlingenmo.sec'.
 ### switch off transactions: SecondoConfig.ini RTFlags += SMI:NoTransactions
 create database berlingenmo;
command 
'create database berlingenmo'
started at: Wed May 19 05:42:08 2021

Total runtime ...   Times (elapsed / cpu): 0.021221sec / 0sec = inf

=> []
 open database berlingenmo;
command 
'open database berlingenmo'
started at: Wed May 19 05:42:08 2021

Total runtime ...   Times (elapsed / cpu): 0.000454sec / 0sec = inf

=> []
 let roadwidth = 4;
command 
'let roadwidth = 4'
started at: Wed May 19 05:42:08 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.000254sec / 0sec = inf

=> []
 restore r from 'TM-Data/berlinroads';
command 
'restore r from 'TM-Data/berlinroads''
started at: Wed May 19 05:42:08 2021

Reading file ...
Restoring objects ...
  r ... processed and succeeded.
Total runtime ...   Times (elapsed / cpu): 0.527406sec / 0.52sec = 1.01424

=> []
 restore streets_speed from 'TM-Data/streets_speed';
command 
'restore streets_speed from 'TM-Data/streets_speed''
started at: Wed May 19 05:42:09 2021

Reading file ...
Restoring objects ...
  streets_speed ... processed and succeeded.
Total runtime ...   Times (elapsed / cpu): 0.037798sec / 0.03sec = 1.25993

=> []
 let j =
 r feed {r1}
 r feed {r2}
 #spatialjoin [curve_r1, curve_r2]
 spatialjoin0 [Curve_r1, Curve_r2]
 filter [.Id_r1 < .Id_r2]
 filter [.Curve_r1 intersects1 .Curve_r2]
 projectextendstream[Id_r1, Curve_r1, Id_r2, Curve_r2; CROSSING_POINT: components(crossings1(.Curve_r1, .Curve_r2))]
 extend [R1id : .Id_r1]
 extend [R1meas : at_point(.Curve_r1, single(.CROSSING_POINT), TRUE)]
 extend [R2id : .Id_r2]
 extend [R2meas : at_point(.Curve_r2, single(.CROSSING_POINT), TRUE)]
 extend [Cc: 65535]
 project [R1id, R1meas, R2id, R2meas, Cc]
 consume;
command 
'let j = 
r feed {r1} 
r feed {r2} 
spatialjoin0 [Curve_r1, Curve_r2] 
filter [.Id_r1 < .Id_r2] 
filter [.Curve_r1 intersects1 .Curve_r2] 
projectextendstream[Id_r1, Curve_r1, Id_r2, Curve_r2; CROSSING_POINT: components(crossings1(.Curve_r1, .Curve_r2))] 
extend [R1id : .Id_r1] 
extend [R1meas : at_point(.Curve_r1, single(.CROSSING_POINT), TRUE)] 
extend [R2id : .Id_r2] 
extend [R2meas : at_point(.Curve_r2, single(.CROSSING_POINT), TRUE)] 
extend [Cc: 65535] 
project [R1id, R1meas, R2id, R2meas, Cc] 
consume'
started at: Wed May 19 05:42:09 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.867962sec / 0.84sec = 1.03329

=> []
 let rn = thenetwork(1, 1.0, r, j);
command 
'let rn = thenetwork(1, 1.0, r, j)'
started at: Wed May 19 05:42:10 2021

noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 1
perOperator = 128
noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 1
perOperator = 128
Message: (simple 1)Message: (simple 3250)noMemoryOperators = 1
perOperator = 128
noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 2.2542sec / 2.18sec = 1.03404

=> []
 close database;
command 
'close database'
started at: Wed May 19 05:42:12 2021

Total runtime ...   Times (elapsed / cpu): 0.015949sec / 0sec = inf

=> []
 # x:[0, 44411]
 # y:[0, 34781]
 ###############################
 #### create pavement areas  ###
 ###############################
 open database berlingenmo;
command 
'open database berlingenmo'
started at: Wed May 19 05:42:12 2021

Total runtime ...   Times (elapsed / cpu): 0.000533sec / 0sec = inf

=> []
 @createpave1.sec;
*** Begin processing file 'createpave1.sec'.
 ######################################################################
 ######################################################################
 # create pavement regions and streets from  data.
 ######################################################################
 ######################################################################
 #######################################
 ###1 add road network into the space###
 #######################################
 let space_1 = [const space value ( 1 )];
command 
'let space_1 = [const space value ( 1 )]'
started at: Wed May 19 05:42:12 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.000518sec / 0sec = inf

=> []
 query putinfra(space_1, rn) consume;
command 
'query putinfra(space_1, rn) consume'
started at: Wed May 19 05:42:12 2021

noMemoryOperators = 0
perOperator = 0
ref id 1 infra type LINE low refid 1 high refid 3250
Warning: Resize a persistent Flob
Warning: Manipulate a persistent Flob
Total runtime ...   Times (elapsed / cpu): 0.018009sec / 0.03sec = 0.6003


      SpaceId : 1
RoadNetworkId : 1

 query getinfra(space_1, "LINE") count;
command 
'query getinfra(space_1, "LINE") count'
started at: Wed May 19 05:42:12 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.064395sec / 0.04sec = 1.60987

3250
 query getinfra(space_1, "FREESPACE") count;
command 
'query getinfra(space_1, "FREESPACE") count'
started at: Wed May 19 05:42:12 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.006618sec / 0sec = inf

0
 query putrel(space_1, streets_speed) consume;
command 
'query putrel(space_1, streets_speed) consume'
started at: Wed May 19 05:42:12 2021

noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.009172sec / 0.02sec = 0.4586


   SpaceId : 1
SpeedRelNo : 3250

 ######################################
 ### add road graph into the space###
 ######################################
 let rg_nodes = get_rg_nodes(rn) consume;
command 
'let rg_nodes = get_rg_nodes(rn) consume'
started at: Wed May 19 05:42:12 2021

noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.139546sec / 0.12sec = 1.16288

=> []
 let rtree_nodes = rg_nodes feed addid bulkloadrtree[Jun_p];
command 
'let rtree_nodes = rg_nodes feed addid bulkloadrtree[Jun_p]'
started at: Wed May 19 05:42:12 2021

noMemoryOperators = 0
perOperator = 0
Message: (simple 1)Message: (simple 10001)Message: (simple 10628)Total runtime ...   Times (elapsed / cpu): 0.024718sec / 0.02sec = 1.2359

=> []
 let rg_edges1 = get_rg_edges1(rg_nodes, rtree_nodes) consume;
command 
'let rg_edges1 = get_rg_edges1(rg_nodes, rtree_nodes) consume'
started at: Wed May 19 05:42:12 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 5.09129sec / 5.07sec = 1.0042

=> []
 let rg_edges2 = get_rg_edges2(rn, rg_nodes) consume;
command 
'let rg_edges2 = get_rg_edges2(rn, rg_nodes) consume'
started at: Wed May 19 05:42:17 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.707443sec / 0.7sec = 1.01063

=> []
 let rg =  creatergraph(1, rg_nodes, rg_edges1, rg_edges2);
command 
'let rg =  creatergraph(1, rg_nodes, rg_edges1, rg_edges2)'
started at: Wed May 19 05:42:18 2021

noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.833376sec / 0.82sec = 1.01631

=> []
 query putinfra(space_1, rg) consume;
command 
'query putinfra(space_1, rg) consume'
started at: Wed May 19 05:42:19 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.002688sec / 0sec = inf


    SpaceId : 1
RoadGraphId : 1

 delete rg_nodes;
command 
'delete rg_nodes'
started at: Wed May 19 05:42:19 2021

Total runtime ...   Times (elapsed / cpu): 0.002477sec / 0.01sec = 0.2477

=> []
 delete rg_edges1;
command 
'delete rg_edges1'
started at: Wed May 19 05:42:19 2021

Total runtime ...   Times (elapsed / cpu): 0.000485sec / 0sec = inf

=> []
 delete rg_edges2;
command 
'delete rg_edges2'
started at: Wed May 19 05:42:19 2021

Total runtime ...   Times (elapsed / cpu): 0.001538sec / 0sec = inf

=> []
 ################################
 ### create pavement areas    ###
 ################################
 let allregions_out = segment2region(r, Curve,roadwidth) project[Oid, Outborder] consume;
command 
'let allregions_out = segment2region(r, Curve,roadwidth) project[Oid, Outborder] consume'
started at: Wed May 19 05:42:19 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 3.45856sec / 3.46sec = 0.999585

=> []
 let regions_outborder = allregions_out feed aggregateB[Outborder; fun(r1:region,r2:region) r1 union r2; [const region value()]];
command 
'let regions_outborder = allregions_out feed aggregateB[Outborder; fun(r1:region,r2:region) r1 union r2; [const region value()]]'
started at: Wed May 19 05:42:22 2021

no face found within the cycles
noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 25.031sec / 25.02sec = 1.00044

=> []
 let rtreeroad = routes(rn) feed projectextend[;TID:tupleid(.), MBR:bbox(.Curve)] sortby[MBR asc] bulkloadrtree[MBR];
command 
'let rtreeroad = routes(rn) feed projectextend[;TID:tupleid(.), MBR:bbox(.Curve)] sortby[MBR asc] bulkloadrtree[MBR]'
started at: Wed May 19 05:42:48 2021

noMemoryOperators = 1
perOperator = 4096
Message: (simple 1)Message: (simple 3250)Total runtime ...   Times (elapsed / cpu): 0.106271sec / 0.08sec = 1.32839

=> []
 let newboundary = modifyboundary(bbox(rtreeroad),roadwidth);
command 
'let newboundary = modifyboundary(bbox(rtreeroad),roadwidth)'
started at: Wed May 19 05:42:48 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.001115sec / 0sec = inf

=> []
 delete rtreeroad;
command 
'delete rtreeroad'
started at: Wed May 19 05:42:48 2021

Total runtime ...   Times (elapsed / cpu): 0.00071sec / 0sec = inf

=> []
 let partition_regions =  newboundary minus regions_outborder;
command 
'let partition_regions =  newboundary minus regions_outborder'
started at: Wed May 19 05:42:48 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.568378sec / 0.57sec = 0.997154

=> []
 #decomposed subregions by road network
 let region_elem = decomposeregion(partition_regions) consume;
command 
'let region_elem = decomposeregion(partition_regions) consume'
started at: Wed May 19 05:42:48 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.103017sec / 0.1sec = 1.03017

=> []
 delete partition_regions;
command 
'delete partition_regions'
started at: Wed May 19 05:42:48 2021

Total runtime ...   Times (elapsed / cpu): 0.000577sec / 0sec = inf

=> []
 let allregions_pave = segment2region(r, Curve, roadwidth) extend[Pave1: .Paveroad1 minus .Road1] extend[Pave2: .Paveroad2 minus .Road2] project[Oid, Pave1, Pave2] consume;
command 
'let allregions_pave = segment2region(r, Curve, roadwidth) extend[Pave1: .Paveroad1 minus .Road1] extend[Pave2: .Paveroad2 minus .Road2] project[Oid, Pave1, Pave2] consume'
started at: Wed May 19 05:42:48 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 5.38313sec / 5.38sec = 1.00058

=> []
 let allregions_in = segment2region(r, Curve,roadwidth) project[Oid, Inborder] consume;
command 
'let allregions_in = segment2region(r, Curve,roadwidth) project[Oid, Inborder] consume'
started at: Wed May 19 05:42:54 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 3.37685sec / 3.33sec = 1.01407

=> []
 #pavement beside road
 let pave_regions1 = paveregion(rn, allregions_in, Inborder, allregions_pave, Pave1, Pave2, roadwidth) consume;
command 
'let pave_regions1 = paveregion(rn, allregions_in, Inborder, allregions_pave, Pave1, Pave2, roadwidth) consume'
started at: Wed May 19 05:42:57 2021

noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 14.4404sec / 14.43sec = 1.00072

=> []
 #zebra crossing at junction
 let pave_regions2 = junregion(rn, pave_regions1, Pavement1, Pavement2, roadwidth, allregions_in, Inborder) project[Rid, Crossreg] consume;
command 
'let pave_regions2 = junregion(rn, pave_regions1, Pavement1, Pavement2, roadwidth, allregions_in, Inborder) project[Rid, Crossreg] consume'
started at: Wed May 19 05:43:12 2021

noMemoryOperators = 0
perOperator = 0
noMemoryOperators = 0
perOperator = 0
before copying regions, the statistic is 
created Flobs70122536
reusedFlobs 70122534
----------------------

region 0 has a size of 0
region 1 has a size of 0
region 2 has a size of 0
region 3 has a size of 0
region 4 has a size of 0
region 5 has a size of 0
region 6 has a size of 0
region 7 has a size of 0
region 8 has a size of 0
region 9 has a size of 0
region 10 has a size of 0
region 11 has a size of 0
region 12 has a size of 0
region 13 has a size of 0
region 14 has a size of 0
region 15 has a size of 0
region 16 has a size of 0
region 17 has a size of 0
region 18 has a size of 0
region 19 has a size of 0
region 20 has a size of 0
region 21 has a size of 0
region 22 has a size of 0
region 23 has a size of 0
region 24 has a size of 0
region 25 has a size of 0
region 26 has a size of 0
region 27 has a size of 0
region 28 has a size of 0
region 29 has a size of 0
region 30 has a size of 0
region 31 has a size of 0
region 32 has a size of 0
region 33 has a size of 0
region 34 has a size of 0
region 35 has a size of 0
region 36 has a size of 0
region 37 has a size of 0
region 38 has a size of 0
region 39 has a size of 0
region 40 has a size of 0
region 41 has a size of 0
region 42 has a size of 0
region 43 has a size of 0
region 44 has a size of 0
region 45 has a size of 0
region 46 has a size of 0
region 47 has a size of 0
region 48 has a size of 0
region 49 has a size of 0
region 50 has a size of 0
region 51 has a size of 0
region 52 has a size of 0
region 53 has a size of 0
region 54 has a size of 0
region 55 has a size of 0
region 56 has a size of 0
region 57 has a size of 0
region 58 has a size of 0
region 59 has a size of 0
region 60 has a size of 0
region 61 has a size of 0
region 62 has a size of 0
region 63 has a size of 0
region 64 has a size of 0
region 65 has a size of 0
region 66 has a size of 0
region 67 has a size of 0
region 68 has a size of 0
region 69 has a size of 0
region 70 has a size of 0
region 71 has a size of 0
region 72 has a size of 0
region 73 has a size of 0
region 74 has a size of 0
region 75 has a size of 0
region 76 has a size of 0
region 77 has a size of 0
region 78 has a size of 0
region 79 has a size of 0
region 80 has a size of 0
region 81 has a size of 0
region 82 has a size of 0
region 83 has a size of 0
region 84 has a size of 0
region 85 has a size of 0
region 86 has a size of 0
region 87 has a size of 0
region 88 has a size of 0
region 89 has a size of 0
region 90 has a size of 0
region 91 has a size of 0
region 92 has a size of 0
region 93 has a size of 0
region 94 has a size of 0
region 95 has a size of 0
region 96 has a size of 0
region 97 has a size of 0
region 98 has a size of 0
region 99 has a size of 0
region 100 has a size of 0
region 101 has a size of 0
region 102 has a size of 0
region 103 has a size of 0
region 104 has a size of 0
region 105 has a size of 0
region 106 has a size of 0
region 107 has a size of 0
region 108 has a size of 0
region 109 has a size of 0
region 110 has a size of 0
region 111 has a size of 0
region 112 has a size of 0
region 113 has a size of 0
region 114 has a size of 0
region 115 has a size of 0
region 116 has a size of 0
region 117 has a size of 0
region 118 has a size of 0
region 119 has a size of 0
region 120 has a size of 0
region 121 has a size of 0
region 122 has a size of 0
region 123 has a size of 0
region 124 has a size of 0
region 125 has a size of 0
region 126 has a size of 0
region 127 has a size of 0
region 128 has a size of 0
region 129 has a size of 0
region 130 has a size of 0
region 131 has a size of 0
region 132 has a size of 0
region 133 has a size of 0
region 134 has a size of 0
region 135 has a size of 0
region 136 has a size of 0
region 137 has a size of 0
region 138 has a size of 0
region 139 has a size of 0
region 140 has a size of 0
region 141 has a size of 0
region 142 has a size of 0
region 143 has a size of 0
region 144 has a size of 0
region 145 has a size of 0
region 146 has a size of 0
region 147 has a size of 0
region 148 has a size of 0
region 149 has a size of 0
region 150 has a size of 0
region 151 has a size of 0
region 152 has a size of 0
region 153 has a size of 0
region 154 has a size of 0
region 155 has a size of 0
region 156 has a size of 0
region 157 has a size of 0
region 158 has a size of 0
region 159 has a size of 0
region 160 has a size of 0
region 161 has a size of 0
region 162 has a size of 0
region 163 has a size of 0
region 164 has a size of 0
region 165 has a size of 0
region 166 has a size of 0
region 167 has a size of 0
region 168 has a size of 0
region 169 has a size of 0
region 170 has a size of 0
region 171 has a size of 0
region 172 has a size of 0
region 173 has a size of 0
region 174 has a size of 0
region 175 has a size of 0
region 176 has a size of 0
region 177 has a size of 0
region 178 has a size of 0
region 179 has a size of 0
region 180 has a size of 0
region 181 has a size of 0
region 182 has a size of 0
region 183 has a size of 0
region 184 has a size of 0
region 185 has a size of 0
region 186 has a size of 0
region 187 has a size of 0
region 188 has a size of 0
region 189 has a size of 0
region 190 has a size of 0
region 191 has a size of 0
region 192 has a size of 0
region 193 has a size of 0
region 194 has a size of 0
region 195 has a size of 0
region 196 has a size of 0
region 197 has a size of 0
region 198 has a size of 0
region 199 has a size of 0
region 200 has a size of 0
region 201 has a size of 0
region 202 has a size of 0
region 203 has a size of 0
region 204 has a size of 0
region 205 has a size of 0
region 206 has a size of 0
region 207 has a size of 0
region 208 has a size of 0
region 209 has a size of 0
region 210 has a size of 0
region 211 has a size of 0
region 212 has a size of 0
region 213 has a size of 0
region 214 has a size of 0
region 215 has a size of 0
region 216 has a size of 0
region 217 has a size of 0
region 218 has a size of 0
region 219 has a size of 0
region 220 has a size of 0
region 221 has a size of 0
region 222 has a size of 0
region 223 has a size of 0
region 224 has a size of 0
region 225 has a size of 0
region 226 has a size of 0
region 227 has a size of 0
region 228 has a size of 0
region 229 has a size of 0
region 230 has a size of 0
region 231 has a size of 0
region 232 has a size of 0
region 233 has a size of 0
region 234 has a size of 0
region 235 has a size of 0
region 236 has a size of 0
region 237 has a size of 0
region 238 has a size of 0
region 239 has a size of 0
region 240 has a size of 0
region 241 has a size of 0
region 242 has a size of 0
region 243 has a size of 0
region 244 has a size of 0
region 245 has a size of 0
region 246 has a size of 0
region 247 has a size of 0
region 248 has a size of 0
region 249 has a size of 0
region 250 has a size of 0
region 251 has a size of 0
region 252 has a size of 0
region 253 has a size of 0
region 254 has a size of 0
region 255 has a size of 0
region 256 has a size of 0
region 257 has a size of 0
region 258 has a size of 0
region 259 has a size of 0
region 260 has a size of 0
region 261 has a size of 0
region 262 has a size of 0
region 263 has a size of 0
region 264 has a size of 0
region 265 has a size of 0
region 266 has a size of 0
region 267 has a size of 0
region 268 has a size of 0
region 269 has a size of 0
region 270 has a size of 0
region 271 has a size of 0
region 272 has a size of 0
region 273 has a size of 0
region 274 has a size of 0
region 275 has a size of 0
region 276 has a size of 0
region 277 has a size of 0
region 278 has a size of 0
region 279 has a size of 0
region 280 has a size of 0
region 281 has a size of 0
region 282 has a size of 0
region 283 has a size of 0
region 284 has a size of 0
region 285 has a size of 0
region 286 has a size of 0
region 287 has a size of 0
region 288 has a size of 0
region 289 has a size of 0
region 290 has a size of 0
region 291 has a size of 0
region 292 has a size of 0
region 293 has a size of 0
region 294 has a size of 0
region 295 has a size of 0
region 296 has a size of 0
region 297 has a size of 0
region 298 has a size of 0
region 299 has a size of 0
region 300 has a size of 0
region 301 has a size of 0
region 302 has a size of 0
region 303 has a size of 0
region 304 has a size of 0
region 305 has a size of 0
region 306 has a size of 0
region 307 has a size of 0
region 308 has a size of 0
region 309 has a size of 0
region 310 has a size of 0
region 311 has a size of 0
region 312 has a size of 0
region 313 has a size of 0
region 314 has a size of 0
region 315 has a size of 0
region 316 has a size of 0
region 317 has a size of 0
region 318 has a size of 0
region 319 has a size of 0
region 320 has a size of 0
region 321 has a size of 0
region 322 has a size of 0
region 323 has a size of 0
region 324 has a size of 0
region 325 has a size of 0
region 326 has a size of 0
region 327 has a size of 0
region 328 has a size of 0
region 329 has a size of 0
region 330 has a size of 0
region 331 has a size of 0
region 332 has a size of 0
region 333 has a size of 0
region 334 has a size of 0
region 335 has a size of 0
region 336 has a size of 0
region 337 has a size of 0
region 338 has a size of 0
region 339 has a size of 0
region 340 has a size of 0
region 341 has a size of 0
region 342 has a size of 0
region 343 has a size of 0
region 344 has a size of 0
region 345 has a size of 0
region 346 has a size of 0
region 347 has a size of 0
region 348 has a size of 0
region 349 has a size of 0
region 350 has a size of 0
region 351 has a size of 0
region 352 has a size of 0
region 353 has a size of 0
region 354 has a size of 0
region 355 has a size of 0
region 356 has a size of 0
region 357 has a size of 0
region 358 has a size of 0
region 359 has a size of 0
region 360 has a size of 0
region 361 has a size of 0
region 362 has a size of 0
region 363 has a size of 0
region 364 has a size of 0
region 365 has a size of 0
region 366 has a size of 0
region 367 has a size of 0
region 368 has a size of 0
region 369 has a size of 0
region 370 has a size of 0
region 371 has a size of 0
region 372 has a size of 0
region 373 has a size of 0
region 374 has a size of 0
region 375 has a size of 0
region 376 has a size of 0
region 377 has a size of 0
region 378 has a size of 0
region 379 has a size of 0
region 380 has a size of 0
region 381 has a size of 0
region 382 has a size of 0
region 383 has a size of 0
region 384 has a size of 0
region 385 has a size of 0
region 386 has a size of 0
region 387 has a size of 0
region 388 has a size of 0
region 389 has a size of 0
region 390 has a size of 0
region 391 has a size of 0
region 392 has a size of 0
region 393 has a size of 0
region 394 has a size of 0
region 395 has a size of 0
region 396 has a size of 0
region 397 has a size of 0
region 398 has a size of 0
region 399 has a size of 0
region 400 has a size of 0
region 401 has a size of 0
region 402 has a size of 0
region 403 has a size of 0
region 404 has a size of 0
region 405 has a size of 0
region 406 has a size of 0
region 407 has a size of 0
region 408 has a size of 0
region 409 has a size of 0
region 410 has a size of 0
region 411 has a size of 0
region 412 has a size of 0
region 413 has a size of 0
region 414 has a size of 0
region 415 has a size of 0
region 416 has a size of 0
region 417 has a size of 0
region 418 has a size of 0
region 419 has a size of 0
region 420 has a size of 0
region 421 has a size of 0
region 422 has a size of 0
region 423 has a size of 0
region 424 has a size of 0
region 425 has a size of 0
region 426 has a size of 0
region 427 has a size of 0
region 428 has a size of 0
region 429 has a size of 0
region 430 has a size of 0
region 431 has a size of 0
region 432 has a size of 0
region 433 has a size of 0
region 434 has a size of 0
region 435 has a size of 0
region 436 has a size of 0
region 437 has a size of 0
region 438 has a size of 0
region 439 has a size of 0
region 440 has a size of 0
region 441 has a size of 0
region 442 has a size of 0
region 443 has a size of 0
region 444 has a size of 0
region 445 has a size of 0
region 446 has a size of 0
region 447 has a size of 0
region 448 has a size of 0
region 449 has a size of 0
region 450 has a size of 0
region 451 has a size of 0
region 452 has a size of 0
region 453 has a size of 0
region 454 has a size of 0
region 455 has a size of 0
region 456 has a size of 0
region 457 has a size of 0
region 458 has a size of 0
region 459 has a size of 0
region 460 has a size of 0
region 461 has a size of 0
region 462 has a size of 0
region 463 has a size of 0
region 464 has a size of 0
region 465 has a size of 0
region 466 has a size of 0
region 467 has a size of 0
region 468 has a size of 0
region 469 has a size of 0
region 470 has a size of 0
region 471 has a size of 0
region 472 has a size of 0
region 473 has a size of 0
region 474 has a size of 0
region 475 has a size of 0
region 476 has a size of 0
region 477 has a size of 0
region 478 has a size of 0
region 479 has a size of 0
region 480 has a size of 0
region 481 has a size of 0
region 482 has a size of 0
region 483 has a size of 0
region 484 has a size of 0
region 485 has a size of 0
region 486 has a size of 0
region 487 has a size of 0
region 488 has a size of 0
region 489 has a size of 0
region 490 has a size of 0
region 491 has a size of 0
region 492 has a size of 0
region 493 has a size of 0
region 494 has a size of 0
region 495 has a size of 0
region 496 has a size of 0
region 497 has a size of 0
region 498 has a size of 0
region 499 has a size of 0
region 500 has a size of 0
region 501 has a size of 0
region 502 has a size of 0
region 503 has a size of 0
region 504 has a size of 0
region 505 has a size of 0
region 506 has a size of 0
region 507 has a size of 0
region 508 has a size of 0
region 509 has a size of 0
region 510 has a size of 0
region 511 has a size of 0
region 512 has a size of 0
region 513 has a size of 0
region 514 has a size of 0
region 515 has a size of 0
region 516 has a size of 0
region 517 has a size of 0
region 518 has a size of 0
region 519 has a size of 0
region 520 has a size of 0
region 521 has a size of 0
region 522 has a size of 0
region 523 has a size of 0
region 524 has a size of 0
region 525 has a size of 0
region 526 has a size of 0
region 527 has a size of 0
region 528 has a size of 0
region 529 has a size of 0
region 530 has a size of 0
region 531 has a size of 0
region 532 has a size of 0
region 533 has a size of 0
region 534 has a size of 0
region 535 has a size of 0
region 536 has a size of 0
region 537 has a size of 0
region 538 has a size of 0
region 539 has a size of 0
region 540 has a size of 0
region 541 has a size of 0
region 542 has a size of 0
region 543 has a size of 0
region 544 has a size of 0
region 545 has a size of 0
region 546 has a size of 0
region 547 has a size of 0
region 548 has a size of 0
region 549 has a size of 0
region 550 has a size of 0
region 551 has a size of 0
region 552 has a size of 0
region 553 has a size of 0
region 554 has a size of 0
region 555 has a size of 0
region 556 has a size of 0
region 557 has a size of 0
region 558 has a size of 0
region 559 has a size of 0
region 560 has a size of 0
region 561 has a size of 0
region 562 has a size of 0
region 563 has a size of 0
region 564 has a size of 0
region 565 has a size of 0
region 566 has a size of 0
region 567 has a size of 0
region 568 has a size of 0
region 569 has a size of 0
region 570 has a size of 0
region 571 has a size of 0
region 572 has a size of 0
region 573 has a size of 0
region 574 has a size of 0
region 575 has a size of 0
region 576 has a size of 0
region 577 has a size of 0
region 578 has a size of 0
region 579 has a size of 0
region 580 has a size of 0
region 581 has a size of 0
region 582 has a size of 0
region 583 has a size of 0
region 584 has a size of 0
region 585 has a size of 0
region 586 has a size of 0
region 587 has a size of 0
region 588 has a size of 0
region 589 has a size of 0
region 590 has a size of 0
region 591 has a size of 0
region 592 has a size of 0
region 593 has a size of 0
region 594 has a size of 0
region 595 has a size of 0
region 596 has a size of 0
region 597 has a size of 0
region 598 has a size of 0
region 599 has a size of 0
region 600 has a size of 0
region 601 has a size of 0
region 602 has a size of 0
region 603 has a size of 0
region 604 has a size of 0
region 605 has a size of 0
region 606 has a size of 0
region 607 has a size of 0
region 608 has a size of 0
region 609 has a size of 0
region 610 has a size of 0
region 611 has a size of 0
region 612 has a size of 0
region 613 has a size of 0
region 614 has a size of 0
region 615 has a size of 0
region 616 has a size of 0
region 617 has a size of 0
region 618 has a size of 0
region 619 has a size of 0
region 620 has a size of 0
region 621 has a size of 0
region 622 has a size of 0
region 623 has a size of 0
region 624 has a size of 0
region 625 has a size of 0
region 626 has a size of 0
region 627 has a size of 0
region 628 has a size of 0
region 629 has a size of 0
region 630 has a size of 0
region 631 has a size of 0
region 632 has a size of 0
region 633 has a size of 0
region 634 has a size of 0
region 635 has a size of 0
region 636 has a size of 0
region 637 has a size of 0
region 638 has a size of 0
region 639 has a size of 0
region 640 has a size of 0
region 641 has a size of 0
region 642 has a size of 0
region 643 has a size of 0
region 644 has a size of 0
region 645 has a size of 0
region 646 has a size of 0
region 647 has a size of 0
region 648 has a size of 0
region 649 has a size of 0
region 650 has a size of 0
region 651 has a size of 0
region 652 has a size of 0
region 653 has a size of 0
region 654 has a size of 0
region 655 has a size of 0
region 656 has a size of 0
region 657 has a size of 0
region 658 has a size of 0
region 659 has a size of 0
region 660 has a size of 0
region 661 has a size of 0
region 662 has a size of 0
region 663 has a size of 0
region 664 has a size of 0
region 665 has a size of 0
region 666 has a size of 0
region 667 has a size of 0
region 668 has a size of 0
region 669 has a size of 0
region 670 has a size of 0
region 671 has a size of 0
region 672 has a size of 0
region 673 has a size of 0
region 674 has a size of 0
region 675 has a size of 0
region 676 has a size of 0
region 677 has a size of 0
region 678 has a size of 0
region 679 has a size of 0
region 680 has a size of 0
region 681 has a size of 0
region 682 has a size of 0
region 683 has a size of 0
region 684 has a size of 0
region 685 has a size of 0
region 686 has a size of 0
region 687 has a size of 0
region 688 has a size of 0
region 689 has a size of 0
region 690 has a size of 0
region 691 has a size of 0
region 692 has a size of 0
region 693 has a size of 0
region 694 has a size of 0
region 695 has a size of 0
region 696 has a size of 0
region 697 has a size of 0
region 698 has a size of 0
region 699 has a size of 0
region 700 has a size of 0
region 701 has a size of 0
region 702 has a size of 0
region 703 has a size of 0
region 704 has a size of 0
region 705 has a size of 0
region 706 has a size of 0
region 707 has a size of 0
region 708 has a size of 0
region 709 has a size of 0
region 710 has a size of 0
region 711 has a size of 0
region 712 has a size of 0
region 713 has a size of 0
region 714 has a size of 0
region 715 has a size of 0
region 716 has a size of 0
region 717 has a size of 0
region 718 has a size of 0
region 719 has a size of 0
region 720 has a size of 0
region 721 has a size of 0
region 722 has a size of 0
region 723 has a size of 0
region 724 has a size of 0
region 725 has a size of 0
region 726 has a size of 0
region 727 has a size of 0
region 728 has a size of 0
region 729 has a size of 0
region 730 has a size of 0
region 731 has a size of 0
region 732 has a size of 0
region 733 has a size of 0
region 734 has a size of 0
region 735 has a size of 0
region 736 has a size of 0
region 737 has a size of 0
region 738 has a size of 0
region 739 has a size of 0
region 740 has a size of 0
region 741 has a size of 0
region 742 has a size of 0
region 743 has a size of 0
region 744 has a size of 0
region 745 has a size of 0
region 746 has a size of 0
region 747 has a size of 0
region 748 has a size of 0
region 749 has a size of 0
region 750 has a size of 0
region 751 has a size of 0
region 752 has a size of 0
region 753 has a size of 0
region 754 has a size of 0
region 755 has a size of 0
region 756 has a size of 0
region 757 has a size of 0
region 758 has a size of 0
region 759 has a size of 0
region 760 has a size of 0
region 761 has a size of 0
region 762 has a size of 0
region 763 has a size of 0
region 764 has a size of 0
region 765 has a size of 0
region 766 has a size of 0
region 767 has a size of 0
region 768 has a size of 0
region 769 has a size of 0
region 770 has a size of 0
region 771 has a size of 0
region 772 has a size of 0
region 773 has a size of 0
region 774 has a size of 0
region 775 has a size of 0
region 776 has a size of 0
region 777 has a size of 0
region 778 has a size of 0
region 779 has a size of 0
region 780 has a size of 0
region 781 has a size of 0
region 782 has a size of 0
region 783 has a size of 0
region 784 has a size of 0
region 785 has a size of 0
region 786 has a size of 0
region 787 has a size of 0
region 788 has a size of 0
region 789 has a size of 0
region 790 has a size of 0
region 791 has a size of 0
region 792 has a size of 0
region 793 has a size of 0
region 794 has a size of 0
region 795 has a size of 0
region 796 has a size of 0
region 797 has a size of 0
region 798 has a size of 0
region 799 has a size of 0
region 800 has a size of 0
region 801 has a size of 0
region 802 has a size of 0
region 803 has a size of 0
region 804 has a size of 0
region 805 has a size of 0
region 806 has a size of 0
region 807 has a size of 0
region 808 has a size of 0
region 809 has a size of 0
region 810 has a size of 0
region 811 has a size of 0
region 812 has a size of 0
region 813 has a size of 0
region 814 has a size of 0
region 815 has a size of 0
region 816 has a size of 0
region 817 has a size of 0
region 818 has a size of 0
region 819 has a size of 0
region 820 has a size of 0
region 821 has a size of 0
region 822 has a size of 0
region 823 has a size of 0
region 824 has a size of 0
region 825 has a size of 0
region 826 has a size of 0
region 827 has a size of 0
region 828 has a size of 0
region 829 has a size of 0
region 830 has a size of 0
region 831 has a size of 0
region 832 has a size of 0
region 833 has a size of 0
region 834 has a size of 0
region 835 has a size of 0
region 836 has a size of 0
region 837 has a size of 0
region 838 has a size of 0
region 839 has a size of 0
region 840 has a size of 0
region 841 has a size of 0
region 842 has a size of 0
region 843 has a size of 0
region 844 has a size of 0
region 845 has a size of 0
region 846 has a size of 0
region 847 has a size of 0
region 848 has a size of 0
region 849 has a size of 0
region 850 has a size of 0
region 851 has a size of 0
region 852 has a size of 0
region 853 has a size of 0
region 854 has a size of 0
region 855 has a size of 0
region 856 has a size of 0
region 857 has a size of 0
region 858 has a size of 0
region 859 has a size of 0
region 860 has a size of 0
region 861 has a size of 0
region 862 has a size of 0
region 863 has a size of 0
region 864 has a size of 0
region 865 has a size of 0
region 866 has a size of 0
region 867 has a size of 0
region 868 has a size of 0
region 869 has a size of 0
region 870 has a size of 0
region 871 has a size of 0
region 872 has a size of 0
region 873 has a size of 0
region 874 has a size of 0
region 875 has a size of 0
region 876 has a size of 0
region 877 has a size of 0
region 878 has a size of 0
region 879 has a size of 0
region 880 has a size of 0
region 881 has a size of 0
region 882 has a size of 0
region 883 has a size of 0
region 884 has a size of 0
region 885 has a size of 0
region 886 has a size of 0
region 887 has a size of 0
region 888 has a size of 0
region 889 has a size of 0
region 890 has a size of 0
region 891 has a size of 0
region 892 has a size of 0
region 893 has a size of 0
region 894 has a size of 0
region 895 has a size of 0
region 896 has a size of 0
region 897 has a size of 0
region 898 has a size of 0
region 899 has a size of 0
region 900 has a size of 0
region 901 has a size of 0
region 902 has a size of 0
region 903 has a size of 0
region 904 has a size of 0
region 905 has a size of 0
region 906 has a size of 0
region 907 has a size of 0
region 908 has a size of 0
region 909 has a size of 0
region 910 has a size of 0
region 911 has a size of 0
region 912 has a size of 0
region 913 has a size of 0
region 914 has a size of 0
region 915 has a size of 0
region 916 has a size of 0
region 917 has a size of 0
region 918 has a size of 0
region 919 has a size of 0
region 920 has a size of 0
region 921 has a size of 0
region 922 has a size of 0
region 923 has a size of 0
region 924 has a size of 0
region 925 has a size of 0
region 926 has a size of 0
region 927 has a size of 0
region 928 has a size of 0
region 929 has a size of 0
region 930 has a size of 0
region 931 has a size of 0
region 932 has a size of 0
region 933 has a size of 0
region 934 has a size of 0
region 935 has a size of 0
region 936 has a size of 0
region 937 has a size of 0
region 938 has a size of 0
region 939 has a size of 0
region 940 has a size of 0
region 941 has a size of 0
region 942 has a size of 0
region 943 has a size of 0
region 944 has a size of 0
region 945 has a size of 0
region 946 has a size of 0
region 947 has a size of 0
region 948 has a size of 0
region 949 has a size of 0
region 950 has a size of 0
region 951 has a size of 0
region 952 has a size of 0
region 953 has a size of 0
region 954 has a size of 0
region 955 has a size of 0
region 956 has a size of 0
region 957 has a size of 0
region 958 has a size of 0
region 959 has a size of 0
region 960 has a size of 0
region 961 has a size of 0
region 962 has a size of 0
region 963 has a size of 0
region 964 has a size of 0
region 965 has a size of 0
region 966 has a size of 0
region 967 has a size of 0
region 968 has a size of 0
region 969 has a size of 0
region 970 has a size of 0
region 971 has a size of 0
region 972 has a size of 0
region 973 has a size of 0
region 974 has a size of 0
region 975 has a size of 0
region 976 has a size of 0
region 977 has a size of 0
region 978 has a size of 0
region 979 has a size of 0
region 980 has a size of 0
region 981 has a size of 0
region 982 has a size of 0
region 983 has a size of 0
region 984 has a size of 0
region 985 has a size of 0
region 986 has a size of 0
region 987 has a size of 0
region 988 has a size of 0
region 989 has a size of 0
region 990 has a size of 0
region 991 has a size of 0
region 992 has a size of 0
region 993 has a size of 0
region 994 has a size of 0
region 995 has a size of 0
region 996 has a size of 0
region 997 has a size of 0
region 998 has a size of 0
region 999 has a size of 0
region 1000 has a size of 0
region 1001 has a size of 0
region 1002 has a size of 0
region 1003 has a size of 0
region 1004 has a size of 0
region 1005 has a size of 0
region 1006 has a size of 0
region 1007 has a size of 0
region 1008 has a size of 0
region 1009 has a size of 0
region 1010 has a size of 0
region 1011 has a size of 0
region 1012 has a size of 0
region 1013 has a size of 0
region 1014 has a size of 0
region 1015 has a size of 0
region 1016 has a size of 0
region 1017 has a size of 0
region 1018 has a size of 0
region 1019 has a size of 0
region 1020 has a size of 0
region 1021 has a size of 0
region 1022 has a size of 0
region 1023 has a size of 0
region 1024 has a size of 0
region 1025 has a size of 0
region 1026 has a size of 0
region 1027 has a size of 0
region 1028 has a size of 0
region 1029 has a size of 0
region 1030 has a size of 0
region 1031 has a size of 0
region 1032 has a size of 0
region 1033 has a size of 0
region 1034 has a size of 0
region 1035 has a size of 0
region 1036 has a size of 0
region 1037 has a size of 0
region 1038 has a size of 0
region 1039 has a size of 0
region 1040 has a size of 0
region 1041 has a size of 0
region 1042 has a size of 0
region 1043 has a size of 0
region 1044 has a size of 0
region 1045 has a size of 0
region 1046 has a size of 0
region 1047 has a size of 0
region 1048 has a size of 0
region 1049 has a size of 0
region 1050 has a size of 0
region 1051 has a size of 0
region 1052 has a size of 0
region 1053 has a size of 0
region 1054 has a size of 0
region 1055 has a size of 0
region 1056 has a size of 0
region 1057 has a size of 0
region 1058 has a size of 0
region 1059 has a size of 0
region 1060 has a size of 0
region 1061 has a size of 0
region 1062 has a size of 0
region 1063 has a size of 0
region 1064 has a size of 0
region 1065 has a size of 0
region 1066 has a size of 0
region 1067 has a size of 0
region 1068 has a size of 0
region 1069 has a size of 0
region 1070 has a size of 0
region 1071 has a size of 0
region 1072 has a size of 0
region 1073 has a size of 0
region 1074 has a size of 0
region 1075 has a size of 0
region 1076 has a size of 0
region 1077 has a size of 0
region 1078 has a size of 0
region 1079 has a size of 0
region 1080 has a size of 0
region 1081 has a size of 0
region 1082 has a size of 0
region 1083 has a size of 0
region 1084 has a size of 0
region 1085 has a size of 0
region 1086 has a size of 0
region 1087 has a size of 0
region 1088 has a size of 0
region 1089 has a size of 0
region 1090 has a size of 0
region 1091 has a size of 0
region 1092 has a size of 0
region 1093 has a size of 0
region 1094 has a size of 0
region 1095 has a size of 0
region 1096 has a size of 0
region 1097 has a size of 0
region 1098 has a size of 0
region 1099 has a size of 0
region 1100 has a size of 0
region 1101 has a size of 0
region 1102 has a size of 0
region 1103 has a size of 0
region 1104 has a size of 0
region 1105 has a size of 0
region 1106 has a size of 0
region 1107 has a size of 0
region 1108 has a size of 0
region 1109 has a size of 0
region 1110 has a size of 0
region 1111 has a size of 0
region 1112 has a size of 0
region 1113 has a size of 0
region 1114 has a size of 0
region 1115 has a size of 0
region 1116 has a size of 0
region 1117 has a size of 0
region 1118 has a size of 0
region 1119 has a size of 0
region 1120 has a size of 0
region 1121 has a size of 0
region 1122 has a size of 0
region 1123 has a size of 0
region 1124 has a size of 0
region 1125 has a size of 0
region 1126 has a size of 0
region 1127 has a size of 0
region 1128 has a size of 0
region 1129 has a size of 0
region 1130 has a size of 0
region 1131 has a size of 0
region 1132 has a size of 0
region 1133 has a size of 0
region 1134 has a size of 0
region 1135 has a size of 0
region 1136 has a size of 0
region 1137 has a size of 0
region 1138 has a size of 0
region 1139 has a size of 0
region 1140 has a size of 0
region 1141 has a size of 0
region 1142 has a size of 0
region 1143 has a size of 0
region 1144 has a size of 0
region 1145 has a size of 0
region 1146 has a size of 0
region 1147 has a size of 0
region 1148 has a size of 0
region 1149 has a size of 0
region 1150 has a size of 0
region 1151 has a size of 0
region 1152 has a size of 0
region 1153 has a size of 0
region 1154 has a size of 0
region 1155 has a size of 0
region 1156 has a size of 0
region 1157 has a size of 0
region 1158 has a size of 0
region 1159 has a size of 0
region 1160 has a size of 0
region 1161 has a size of 0
region 1162 has a size of 0
region 1163 has a size of 0
region 1164 has a size of 0
region 1165 has a size of 0
region 1166 has a size of 0
region 1167 has a size of 0
region 1168 has a size of 0
region 1169 has a size of 0
region 1170 has a size of 0
region 1171 has a size of 0
region 1172 has a size of 0
region 1173 has a size of 0
region 1174 has a size of 0
region 1175 has a size of 0
region 1176 has a size of 0
region 1177 has a size of 0
region 1178 has a size of 0
region 1179 has a size of 0
region 1180 has a size of 0
region 1181 has a size of 0
region 1182 has a size of 0
region 1183 has a size of 0
region 1184 has a size of 0
region 1185 has a size of 0
region 1186 has a size of 0
region 1187 has a size of 0
region 1188 has a size of 0
region 1189 has a size of 0
region 1190 has a size of 0
region 1191 has a size of 0
region 1192 has a size of 0
region 1193 has a size of 0
region 1194 has a size of 0
region 1195 has a size of 0
region 1196 has a size of 0
region 1197 has a size of 0
region 1198 has a size of 0
region 1199 has a size of 0
region 1200 has a size of 0
region 1201 has a size of 0
region 1202 has a size of 0
region 1203 has a size of 0
region 1204 has a size of 0
region 1205 has a size of 0
region 1206 has a size of 0
region 1207 has a size of 0
region 1208 has a size of 0
region 1209 has a size of 0
region 1210 has a size of 0
region 1211 has a size of 0
region 1212 has a size of 0
region 1213 has a size of 0
region 1214 has a size of 0
region 1215 has a size of 0
region 1216 has a size of 0
region 1217 has a size of 0
region 1218 has a size of 0
region 1219 has a size of 0
region 1220 has a size of 0
region 1221 has a size of 0
region 1222 has a size of 0
region 1223 has a size of 0
region 1224 has a size of 0
region 1225 has a size of 0
region 1226 has a size of 0
region 1227 has a size of 0
region 1228 has a size of 0
region 1229 has a size of 0
region 1230 has a size of 0
region 1231 has a size of 0
region 1232 has a size of 0
region 1233 has a size of 0
region 1234 has a size of 0
region 1235 has a size of 0
region 1236 has a size of 0
region 1237 has a size of 0
region 1238 has a size of 0
region 1239 has a size of 0
region 1240 has a size of 0
region 1241 has a size of 0
region 1242 has a size of 0
region 1243 has a size of 0
region 1244 has a size of 0
region 1245 has a size of 0
region 1246 has a size of 0
region 1247 has a size of 0
region 1248 has a size of 0
region 1249 has a size of 0
region 1250 has a size of 0
region 1251 has a size of 0
region 1252 has a size of 0
region 1253 has a size of 0
region 1254 has a size of 0
region 1255 has a size of 0
region 1256 has a size of 0
region 1257 has a size of 0
region 1258 has a size of 0
region 1259 has a size of 0
region 1260 has a size of 0
region 1261 has a size of 0
region 1262 has a size of 0
region 1263 has a size of 0
region 1264 has a size of 0
region 1265 has a size of 0
region 1266 has a size of 0
region 1267 has a size of 0
region 1268 has a size of 0
region 1269 has a size of 0
region 1270 has a size of 0
region 1271 has a size of 0
region 1272 has a size of 0
region 1273 has a size of 0
region 1274 has a size of 0
region 1275 has a size of 0
region 1276 has a size of 0
region 1277 has a size of 0
region 1278 has a size of 0
region 1279 has a size of 0
region 1280 has a size of 0
region 1281 has a size of 0
region 1282 has a size of 0
region 1283 has a size of 0
region 1284 has a size of 0
region 1285 has a size of 0
region 1286 has a size of 0
region 1287 has a size of 0
region 1288 has a size of 0
region 1289 has a size of 0
region 1290 has a size of 0
region 1291 has a size of 0
region 1292 has a size of 0
region 1293 has a size of 0
region 1294 has a size of 0
region 1295 has a size of 0
region 1296 has a size of 0
region 1297 has a size of 0
region 1298 has a size of 0
region 1299 has a size of 0
region 1300 has a size of 0
region 1301 has a size of 0
region 1302 has a size of 0
region 1303 has a size of 0
region 1304 has a size of 0
region 1305 has a size of 0
region 1306 has a size of 0
region 1307 has a size of 0
region 1308 has a size of 0
region 1309 has a size of 0
region 1310 has a size of 0
region 1311 has a size of 0
region 1312 has a size of 0
region 1313 has a size of 0
region 1314 has a size of 0
region 1315 has a size of 0
region 1316 has a size of 0
region 1317 has a size of 0
region 1318 has a size of 0
region 1319 has a size of 0
region 1320 has a size of 0
region 1321 has a size of 0
region 1322 has a size of 0
region 1323 has a size of 0
region 1324 has a size of 0
region 1325 has a size of 0
region 1326 has a size of 0
region 1327 has a size of 0
region 1328 has a size of 0
region 1329 has a size of 0
region 1330 has a size of 0
region 1331 has a size of 0
region 1332 has a size of 0
region 1333 has a size of 0
region 1334 has a size of 0
region 1335 has a size of 0
region 1336 has a size of 0
region 1337 has a size of 0
region 1338 has a size of 0
region 1339 has a size of 0
region 1340 has a size of 0
region 1341 has a size of 0
region 1342 has a size of 0
region 1343 has a size of 0
region 1344 has a size of 0
region 1345 has a size of 0
region 1346 has a size of 0
region 1347 has a size of 0
region 1348 has a size of 0
region 1349 has a size of 0
region 1350 has a size of 0
region 1351 has a size of 0
region 1352 has a size of 0
region 1353 has a size of 0
region 1354 has a size of 0
region 1355 has a size of 0
region 1356 has a size of 0
region 1357 has a size of 0
region 1358 has a size of 0
region 1359 has a size of 0
region 1360 has a size of 0
region 1361 has a size of 0
region 1362 has a size of 0
region 1363 has a size of 0
region 1364 has a size of 0
region 1365 has a size of 0
region 1366 has a size of 0
region 1367 has a size of 0
region 1368 has a size of 0
region 1369 has a size of 0
region 1370 has a size of 0
region 1371 has a size of 0
region 1372 has a size of 0
region 1373 has a size of 0
region 1374 has a size of 0
region 1375 has a size of 0
region 1376 has a size of 0
region 1377 has a size of 0
region 1378 has a size of 0
region 1379 has a size of 0
region 1380 has a size of 0
region 1381 has a size of 0
region 1382 has a size of 0
region 1383 has a size of 0
region 1384 has a size of 0
region 1385 has a size of 0
region 1386 has a size of 0
region 1387 has a size of 0
region 1388 has a size of 0
region 1389 has a size of 0
region 1390 has a size of 0
region 1391 has a size of 0
region 1392 has a size of 0
region 1393 has a size of 0
region 1394 has a size of 0
region 1395 has a size of 0
region 1396 has a size of 0
region 1397 has a size of 0
region 1398 has a size of 0
region 1399 has a size of 0
region 1400 has a size of 0
region 1401 has a size of 0
region 1402 has a size of 0
region 1403 has a size of 0
region 1404 has a size of 0
region 1405 has a size of 0
region 1406 has a size of 0
region 1407 has a size of 0
region 1408 has a size of 0
region 1409 has a size of 0
region 1410 has a size of 0
region 1411 has a size of 0
region 1412 has a size of 0
region 1413 has a size of 0
region 1414 has a size of 0
region 1415 has a size of 0
region 1416 has a size of 0
region 1417 has a size of 0
region 1418 has a size of 0
region 1419 has a size of 0
region 1420 has a size of 0
region 1421 has a size of 0
region 1422 has a size of 0
region 1423 has a size of 0
region 1424 has a size of 0
region 1425 has a size of 0
region 1426 has a size of 0
region 1427 has a size of 0
region 1428 has a size of 0
region 1429 has a size of 0
region 1430 has a size of 0
region 1431 has a size of 0
region 1432 has a size of 0
region 1433 has a size of 0
region 1434 has a size of 0
region 1435 has a size of 0
region 1436 has a size of 0
region 1437 has a size of 0
region 1438 has a size of 0
region 1439 has a size of 0
region 1440 has a size of 0
region 1441 has a size of 0
region 1442 has a size of 0
region 1443 has a size of 0
region 1444 has a size of 0
region 1445 has a size of 0
region 1446 has a size of 0
region 1447 has a size of 0
region 1448 has a size of 0
region 1449 has a size of 0
region 1450 has a size of 0
region 1451 has a size of 0
region 1452 has a size of 0
region 1453 has a size of 0
region 1454 has a size of 0
region 1455 has a size of 0
region 1456 has a size of 0
region 1457 has a size of 0
region 1458 has a size of 0
region 1459 has a size of 0
region 1460 has a size of 0
region 1461 has a size of 0
region 1462 has a size of 0
region 1463 has a size of 0
region 1464 has a size of 0
region 1465 has a size of 0
region 1466 has a size of 0
region 1467 has a size of 0
region 1468 has a size of 0
region 1469 has a size of 0
region 1470 has a size of 0
region 1471 has a size of 0
region 1472 has a size of 0
region 1473 has a size of 0
region 1474 has a size of 0
region 1475 has a size of 0
region 1476 has a size of 0
region 1477 has a size of 0
region 1478 has a size of 0
region 1479 has a size of 0
region 1480 has a size of 0
region 1481 has a size of 0
region 1482 has a size of 0
region 1483 has a size of 0
region 1484 has a size of 0
region 1485 has a size of 0
region 1486 has a size of 0
region 1487 has a size of 0
region 1488 has a size of 0
region 1489 has a size of 0
region 1490 has a size of 0
region 1491 has a size of 0
region 1492 has a size of 0
region 1493 has a size of 0
region 1494 has a size of 0
region 1495 has a size of 0
region 1496 has a size of 0
region 1497 has a size of 0
region 1498 has a size of 0
region 1499 has a size of 0
region 1500 has a size of 0
region 1501 has a size of 0
region 1502 has a size of 0
region 1503 has a size of 0
region 1504 has a size of 0
region 1505 has a size of 0
region 1506 has a size of 0
region 1507 has a size of 0
region 1508 has a size of 0
region 1509 has a size of 0
region 1510 has a size of 0
region 1511 has a size of 0
region 1512 has a size of 0
region 1513 has a size of 0
region 1514 has a size of 0
region 1515 has a size of 0
region 1516 has a size of 0
region 1517 has a size of 0
region 1518 has a size of 0
region 1519 has a size of 0
region 1520 has a size of 0
region 1521 has a size of 0
region 1522 has a size of 0
region 1523 has a size of 0
region 1524 has a size of 0
region 1525 has a size of 0
region 1526 has a size of 0
region 1527 has a size of 0
region 1528 has a size of 0
region 1529 has a size of 0
region 1530 has a size of 0
region 1531 has a size of 0
region 1532 has a size of 0
region 1533 has a size of 0
region 1534 has a size of 0
region 1535 has a size of 0
region 1536 has a size of 0
region 1537 has a size of 0
region 1538 has a size of 0
region 1539 has a size of 0
region 1540 has a size of 0
region 1541 has a size of 0
region 1542 has a size of 0
region 1543 has a size of 0
region 1544 has a size of 0
region 1545 has a size of 0
region 1546 has a size of 0
region 1547 has a size of 0
region 1548 has a size of 0
region 1549 has a size of 0
region 1550 has a size of 0
region 1551 has a size of 0
region 1552 has a size of 0
region 1553 has a size of 0
region 1554 has a size of 0
region 1555 has a size of 0
region 1556 has a size of 0
region 1557 has a size of 0
region 1558 has a size of 0
region 1559 has a size of 0
region 1560 has a size of 0
region 1561 has a size of 0
region 1562 has a size of 0
region 1563 has a size of 0
region 1564 has a size of 0
region 1565 has a size of 0
region 1566 has a size of 0
region 1567 has a size of 0
region 1568 has a size of 0
region 1569 has a size of 0
region 1570 has a size of 0
region 1571 has a size of 0
region 1572 has a size of 0
region 1573 has a size of 0
region 1574 has a size of 0
region 1575 has a size of 0
region 1576 has a size of 0
region 1577 has a size of 0
region 1578 has a size of 0
region 1579 has a size of 0
region 1580 has a size of 0
region 1581 has a size of 0
region 1582 has a size of 0
region 1583 has a size of 0
region 1584 has a size of 0
region 1585 has a size of 0
region 1586 has a size of 0
region 1587 has a size of 0
region 1588 has a size of 0
region 1589 has a size of 0
region 1590 has a size of 0
region 1591 has a size of 0
region 1592 has a size of 0
region 1593 has a size of 0
region 1594 has a size of 0
region 1595 has a size of 0
region 1596 has a size of 0
region 1597 has a size of 0
region 1598 has a size of 0
region 1599 has a size of 0
region 1600 has a size of 0
region 1601 has a size of 0
region 1602 has a size of 0
region 1603 has a size of 0
region 1604 has a size of 0
region 1605 has a size of 0
region 1606 has a size of 0
region 1607 has a size of 0
region 1608 has a size of 0
region 1609 has a size of 0
region 1610 has a size of 0
region 1611 has a size of 0
region 1612 has a size of 0
region 1613 has a size of 0
region 1614 has a size of 0
region 1615 has a size of 0
region 1616 has a size of 0
region 1617 has a size of 0
region 1618 has a size of 0
region 1619 has a size of 0
region 1620 has a size of 0
region 1621 has a size of 0
region 1622 has a size of 0
region 1623 has a size of 0
region 1624 has a size of 0
region 1625 has a size of 0
region 1626 has a size of 0
region 1627 has a size of 0
region 1628 has a size of 0
region 1629 has a size of 0
region 1630 has a size of 0
region 1631 has a size of 0
region 1632 has a size of 0
region 1633 has a size of 0
region 1634 has a size of 0
region 1635 has a size of 0
region 1636 has a size of 0
region 1637 has a size of 0
region 1638 has a size of 0
region 1639 has a size of 0
region 1640 has a size of 0
region 1641 has a size of 0
region 1642 has a size of 0
region 1643 has a size of 0
region 1644 has a size of 0
region 1645 has a size of 0
region 1646 has a size of 0
region 1647 has a size of 0
region 1648 has a size of 0
region 1649 has a size of 0
region 1650 has a size of 0
region 1651 has a size of 0
region 1652 has a size of 0
region 1653 has a size of 0
region 1654 has a size of 0
region 1655 has a size of 0
region 1656 has a size of 0
region 1657 has a size of 0
region 1658 has a size of 0
region 1659 has a size of 0
region 1660 has a size of 0
region 1661 has a size of 0
region 1662 has a size of 0
region 1663 has a size of 0
region 1664 has a size of 0
region 1665 has a size of 0
region 1666 has a size of 0
region 1667 has a size of 0
region 1668 has a size of 0
region 1669 has a size of 0
region 1670 has a size of 0
region 1671 has a size of 0
region 1672 has a size of 0
region 1673 has a size of 0
region 1674 has a size of 0
region 1675 has a size of 0
region 1676 has a size of 0
region 1677 has a size of 0
region 1678 has a size of 0
region 1679 has a size of 0
region 1680 has a size of 0
region 1681 has a size of 0
region 1682 has a size of 0
region 1683 has a size of 0
region 1684 has a size of 0
region 1685 has a size of 0
region 1686 has a size of 0
region 1687 has a size of 0
region 1688 has a size of 0
region 1689 has a size of 0
region 1690 has a size of 0
region 1691 has a size of 0
region 1692 has a size of 0
region 1693 has a size of 0
region 1694 has a size of 0
region 1695 has a size of 0
region 1696 has a size of 0
region 1697 has a size of 0
region 1698 has a size of 0
region 1699 has a size of 0
region 1700 has a size of 0
region 1701 has a size of 0
region 1702 has a size of 0
region 1703 has a size of 0
region 1704 has a size of 0
region 1705 has a size of 0
region 1706 has a size of 0
region 1707 has a size of 0
region 1708 has a size of 0
region 1709 has a size of 0
region 1710 has a size of 0
region 1711 has a size of 0
region 1712 has a size of 0
region 1713 has a size of 0
region 1714 has a size of 0
region 1715 has a size of 0
region 1716 has a size of 0
region 1717 has a size of 0
region 1718 has a size of 0
region 1719 has a size of 0
region 1720 has a size of 0
region 1721 has a size of 0
region 1722 has a size of 0
region 1723 has a size of 0
region 1724 has a size of 0
region 1725 has a size of 0
region 1726 has a size of 0
region 1727 has a size of 0
region 1728 has a size of 0
region 1729 has a size of 0
region 1730 has a size of 0
region 1731 has a size of 0
region 1732 has a size of 0
region 1733 has a size of 0
region 1734 has a size of 0
region 1735 has a size of 0
region 1736 has a size of 0
region 1737 has a size of 0
region 1738 has a size of 0
region 1739 has a size of 0
region 1740 has a size of 0
region 1741 has a size of 0
region 1742 has a size of 0
region 1743 has a size of 0
region 1744 has a size of 0
region 1745 has a size of 0
region 1746 has a size of 0
region 1747 has a size of 0
region 1748 has a size of 0
region 1749 has a size of 0
region 1750 has a size of 0
region 1751 has a size of 0
region 1752 has a size of 0
region 1753 has a size of 0
region 1754 has a size of 0
region 1755 has a size of 0
region 1756 has a size of 0
region 1757 has a size of 0
region 1758 has a size of 0
region 1759 has a size of 0
region 1760 has a size of 0
region 1761 has a size of 0
region 1762 has a size of 0
region 1763 has a size of 0
region 1764 has a size of 0
region 1765 has a size of 0
region 1766 has a size of 0
region 1767 has a size of 0
region 1768 has a size of 0
region 1769 has a size of 0
region 1770 has a size of 0
region 1771 has a size of 0
region 1772 has a size of 0
region 1773 has a size of 0
region 1774 has a size of 0
region 1775 has a size of 0
region 1776 has a size of 0
region 1777 has a size of 0
region 1778 has a size of 0
region 1779 has a size of 0
region 1780 has a size of 0
region 1781 has a size of 0
region 1782 has a size of 0
region 1783 has a size of 0
region 1784 has a size of 0
region 1785 has a size of 0
region 1786 has a size of 0
region 1787 has a size of 0
region 1788 has a size of 0
region 1789 has a size of 0
region 1790 has a size of 0
region 1791 has a size of 0
region 1792 has a size of 0
region 1793 has a size of 0
region 1794 has a size of 0
region 1795 has a size of 0
region 1796 has a size of 0
region 1797 has a size of 0
region 1798 has a size of 0
region 1799 has a size of 0
region 1800 has a size of 0
region 1801 has a size of 0
region 1802 has a size of 0
region 1803 has a size of 0
region 1804 has a size of 0
region 1805 has a size of 0
region 1806 has a size of 0
region 1807 has a size of 0
region 1808 has a size of 0
region 1809 has a size of 0
region 1810 has a size of 0
region 1811 has a size of 0
region 1812 has a size of 0
region 1813 has a size of 0
region 1814 has a size of 0
region 1815 has a size of 0
region 1816 has a size of 0
region 1817 has a size of 0
region 1818 has a size of 0
region 1819 has a size of 0
region 1820 has a size of 0
region 1821 has a size of 0
region 1822 has a size of 0
region 1823 has a size of 0
region 1824 has a size of 0
region 1825 has a size of 0
region 1826 has a size of 0
region 1827 has a size of 0
region 1828 has a size of 0
region 1829 has a size of 0
region 1830 has a size of 0
region 1831 has a size of 0
region 1832 has a size of 0
region 1833 has a size of 0
region 1834 has a size of 0
region 1835 has a size of 0
region 1836 has a size of 0
region 1837 has a size of 0
region 1838 has a size of 0
region 1839 has a size of 0
region 1840 has a size of 0
region 1841 has a size of 0
region 1842 has a size of 0
region 1843 has a size of 0
region 1844 has a size of 0
region 1845 has a size of 0
region 1846 has a size of 0
region 1847 has a size of 0
region 1848 has a size of 0
region 1849 has a size of 0
region 1850 has a size of 0
region 1851 has a size of 0
region 1852 has a size of 0
region 1853 has a size of 0
region 1854 has a size of 0
region 1855 has a size of 0
region 1856 has a size of 0
region 1857 has a size of 0
region 1858 has a size of 0
region 1859 has a size of 0
region 1860 has a size of 0
region 1861 has a size of 0
region 1862 has a size of 0
region 1863 has a size of 0
region 1864 has a size of 0
region 1865 has a size of 0
region 1866 has a size of 0
region 1867 has a size of 0
region 1868 has a size of 0
region 1869 has a size of 0
region 1870 has a size of 0
region 1871 has a size of 0
region 1872 has a size of 0
region 1873 has a size of 0
region 1874 has a size of 0
region 1875 has a size of 0
region 1876 has a size of 0
region 1877 has a size of 0
region 1878 has a size of 0
region 1879 has a size of 0
region 1880 has a size of 0
region 1881 has a size of 0
region 1882 has a size of 0
region 1883 has a size of 0
region 1884 has a size of 0
region 1885 has a size of 0
region 1886 has a size of 0
region 1887 has a size of 0
region 1888 has a size of 0
region 1889 has a size of 0
region 1890 has a size of 0
region 1891 has a size of 0
region 1892 has a size of 0
region 1893 has a size of 0
region 1894 has a size of 0
region 1895 has a size of 0
region 1896 has a size of 0
region 1897 has a size of 0
region 1898 has a size of 0
region 1899 has a size of 0
region 1900 has a size of 0
region 1901 has a size of 0
region 1902 has a size of 0
region 1903 has a size of 0
region 1904 has a size of 0
region 1905 has a size of 0
region 1906 has a size of 0
region 1907 has a size of 0
region 1908 has a size of 0
region 1909 has a size of 0
region 1910 has a size of 0
region 1911 has a size of 0
region 1912 has a size of 0
region 1913 has a size of 0
region 1914 has a size of 0
region 1915 has a size of 0
region 1916 has a size of 0
region 1917 has a size of 0
region 1918 has a size of 0
region 1919 has a size of 0
region 1920 has a size of 0
region 1921 has a size of 0
region 1922 has a size of 0
region 1923 has a size of 0
region 1924 has a size of 0
region 1925 has a size of 0
region 1926 has a size of 0
region 1927 has a size of 0
region 1928 has a size of 0
region 1929 has a size of 0
region 1930 has a size of 0
region 1931 has a size of 0
region 1932 has a size of 0
region 1933 has a size of 0
region 1934 has a size of 0
region 1935 has a size of 0
region 1936 has a size of 0
region 1937 has a size of 0
region 1938 has a size of 0
region 1939 has a size of 0
region 1940 has a size of 0
region 1941 has a size of 0
region 1942 has a size of 0
region 1943 has a size of 0
region 1944 has a size of 0
region 1945 has a size of 0
region 1946 has a size of 0
region 1947 has a size of 0
region 1948 has a size of 0
region 1949 has a size of 0
region 1950 has a size of 0
region 1951 has a size of 0
region 1952 has a size of 0
region 1953 has a size of 0
region 1954 has a size of 0
region 1955 has a size of 0
region 1956 has a size of 0
region 1957 has a size of 0
region 1958 has a size of 0
region 1959 has a size of 0
region 1960 has a size of 0
region 1961 has a size of 0
region 1962 has a size of 0
region 1963 has a size of 0
region 1964 has a size of 0
region 1965 has a size of 0
region 1966 has a size of 0
region 1967 has a size of 0
region 1968 has a size of 0
region 1969 has a size of 0
region 1970 has a size of 0
region 1971 has a size of 0
region 1972 has a size of 0
region 1973 has a size of 0
region 1974 has a size of 0
region 1975 has a size of 0
region 1976 has a size of 0
region 1977 has a size of 0
region 1978 has a size of 0
region 1979 has a size of 0
region 1980 has a size of 0
region 1981 has a size of 0
region 1982 has a size of 0
region 1983 has a size of 0
region 1984 has a size of 0
region 1985 has a size of 0
region 1986 has a size of 0
region 1987 has a size of 0
region 1988 has a size of 0
region 1989 has a size of 0
region 1990 has a size of 0
region 1991 has a size of 0
region 1992 has a size of 0
region 1993 has a size of 0
region 1994 has a size of 0
region 1995 has a size of 0
region 1996 has a size of 0
region 1997 has a size of 0
region 1998 has a size of 0
region 1999 has a size of 0
region 2000 has a size of 0
region 2001 has a size of 0
region 2002 has a size of 0
region 2003 has a size of 0
region 2004 has a size of 0
region 2005 has a size of 0
region 2006 has a size of 0
region 2007 has a size of 0
region 2008 has a size of 0
region 2009 has a size of 0
region 2010 has a size of 0
region 2011 has a size of 0
region 2012 has a size of 0
region 2013 has a size of 0
region 2014 has a size of 0
region 2015 has a size of 0
region 2016 has a size of 0
region 2017 has a size of 0
region 2018 has a size of 0
region 2019 has a size of 0
region 2020 has a size of 0
region 2021 has a size of 0
region 2022 has a size of 0
region 2023 has a size of 0
region 2024 has a size of 0
region 2025 has a size of 0
region 2026 has a size of 0
region 2027 has a size of 0
region 2028 has a size of 0
region 2029 has a size of 0
region 2030 has a size of 0
region 2031 has a size of 0
region 2032 has a size of 0
region 2033 has a size of 0
region 2034 has a size of 0
region 2035 has a size of 0
region 2036 has a size of 0
region 2037 has a size of 0
region 2038 has a size of 0
region 2039 has a size of 0
region 2040 has a size of 0
region 2041 has a size of 0
region 2042 has a size of 0
region 2043 has a size of 0
region 2044 has a size of 0
region 2045 has a size of 0
region 2046 has a size of 0
region 2047 has a size of 0
region 2048 has a size of 0
region 2049 has a size of 0
region 2050 has a size of 0
region 2051 has a size of 0
region 2052 has a size of 0
region 2053 has a size of 0
region 2054 has a size of 0
region 2055 has a size of 0
region 2056 has a size of 0
region 2057 has a size of 0
region 2058 has a size of 0
region 2059 has a size of 0
region 2060 has a size of 0
region 2061 has a size of 0
region 2062 has a size of 0
region 2063 has a size of 0
region 2064 has a size of 0
region 2065 has a size of 0
region 2066 has a size of 0
region 2067 has a size of 0
region 2068 has a size of 0
region 2069 has a size of 0
region 2070 has a size of 0
region 2071 has a size of 0
region 2072 has a size of 0
region 2073 has a size of 0
region 2074 has a size of 0
region 2075 has a size of 0
region 2076 has a size of 0
region 2077 has a size of 0
region 2078 has a size of 0
region 2079 has a size of 0
region 2080 has a size of 0
region 2081 has a size of 0
region 2082 has a size of 0
region 2083 has a size of 0
region 2084 has a size of 0
region 2085 has a size of 0
region 2086 has a size of 0
region 2087 has a size of 0
region 2088 has a size of 0
region 2089 has a size of 0
region 2090 has a size of 0
region 2091 has a size of 0
region 2092 has a size of 0
region 2093 has a size of 0
region 2094 has a size of 0
region 2095 has a size of 0
region 2096 has a size of 0
region 2097 has a size of 0
region 2098 has a size of 0
region 2099 has a size of 0
region 2100 has a size of 0
region 2101 has a size of 0
region 2102 has a size of 0
region 2103 has a size of 0
region 2104 has a size of 0
region 2105 has a size of 0
region 2106 has a size of 0
region 2107 has a size of 0
region 2108 has a size of 0
region 2109 has a size of 0
region 2110 has a size of 0
region 2111 has a size of 0
region 2112 has a size of 0
region 2113 has a size of 0
region 2114 has a size of 0
region 2115 has a size of 0
region 2116 has a size of 0
region 2117 has a size of 0
region 2118 has a size of 0
region 2119 has a size of 0
region 2120 has a size of 0
region 2121 has a size of 0
region 2122 has a size of 0
region 2123 has a size of 0
region 2124 has a size of 0
region 2125 has a size of 0
region 2126 has a size of 0
region 2127 has a size of 0
region 2128 has a size of 0
region 2129 has a size of 0
region 2130 has a size of 0
region 2131 has a size of 0
region 2132 has a size of 0
region 2133 has a size of 0
region 2134 has a size of 0
region 2135 has a size of 0
region 2136 has a size of 0
region 2137 has a size of 0
region 2138 has a size of 0
region 2139 has a size of 0
region 2140 has a size of 0
region 2141 has a size of 0
region 2142 has a size of 0
region 2143 has a size of 0
region 2144 has a size of 0
region 2145 has a size of 0
region 2146 has a size of 0
region 2147 has a size of 0
region 2148 has a size of 0
region 2149 has a size of 0
region 2150 has a size of 0
region 2151 has a size of 0
region 2152 has a size of 0
region 2153 has a size of 0
region 2154 has a size of 0
region 2155 has a size of 0
region 2156 has a size of 0
region 2157 has a size of 0
region 2158 has a size of 0
region 2159 has a size of 0
region 2160 has a size of 0
region 2161 has a size of 0
region 2162 has a size of 0
region 2163 has a size of 0
region 2164 has a size of 0
region 2165 has a size of 0
region 2166 has a size of 0
region 2167 has a size of 0
region 2168 has a size of 0
region 2169 has a size of 0
region 2170 has a size of 0
region 2171 has a size of 0
region 2172 has a size of 0
region 2173 has a size of 0
region 2174 has a size of 0
region 2175 has a size of 0
region 2176 has a size of 0
region 2177 has a size of 0
region 2178 has a size of 0
region 2179 has a size of 0
region 2180 has a size of 0
region 2181 has a size of 0
region 2182 has a size of 0
region 2183 has a size of 0
region 2184 has a size of 0
region 2185 has a size of 0
region 2186 has a size of 0
region 2187 has a size of 0
region 2188 has a size of 0
region 2189 has a size of 0
region 2190 has a size of 0
region 2191 has a size of 0
region 2192 has a size of 0
region 2193 has a size of 0
region 2194 has a size of 0
region 2195 has a size of 0
region 2196 has a size of 0
region 2197 has a size of 0
region 2198 has a size of 0
region 2199 has a size of 0
region 2200 has a size of 0
region 2201 has a size of 0
region 2202 has a size of 0
region 2203 has a size of 0
region 2204 has a size of 0
region 2205 has a size of 0
region 2206 has a size of 0
region 2207 has a size of 0
region 2208 has a size of 0
region 2209 has a size of 0
region 2210 has a size of 0
region 2211 has a size of 0
region 2212 has a size of 0
region 2213 has a size of 0
region 2214 has a size of 0
region 2215 has a size of 0
region 2216 has a size of 0
region 2217 has a size of 0
region 2218 has a size of 0
region 2219 has a size of 0
region 2220 has a size of 0
region 2221 has a size of 0
region 2222 has a size of 0
region 2223 has a size of 0
region 2224 has a size of 0
region 2225 has a size of 0
region 2226 has a size of 0
region 2227 has a size of 0
region 2228 has a size of 0
region 2229 has a size of 0
region 2230 has a size of 0
region 2231 has a size of 0
region 2232 has a size of 0
region 2233 has a size of 0
region 2234 has a size of 0
region 2235 has a size of 0
region 2236 has a size of 0
region 2237 has a size of 0
region 2238 has a size of 0
region 2239 has a size of 0
region 2240 has a size of 0
region 2241 has a size of 0
region 2242 has a size of 0
region 2243 has a size of 0
region 2244 has a size of 0
region 2245 has a size of 0
region 2246 has a size of 0
region 2247 has a size of 0
region 2248 has a size of 0
region 2249 has a size of 0
region 2250 has a size of 0
region 2251 has a size of 0
region 2252 has a size of 0
region 2253 has a size of 0
region 2254 has a size of 0
region 2255 has a size of 0
region 2256 has a size of 0
region 2257 has a size of 0
region 2258 has a size of 0
region 2259 has a size of 0
region 2260 has a size of 0
region 2261 has a size of 0
region 2262 has a size of 0
region 2263 has a size of 0
region 2264 has a size of 0
region 2265 has a size of 0
region 2266 has a size of 0
region 2267 has a size of 0
region 2268 has a size of 0
region 2269 has a size of 0
region 2270 has a size of 0
region 2271 has a size of 0
region 2272 has a size of 0
region 2273 has a size of 0
region 2274 has a size of 0
region 2275 has a size of 0
region 2276 has a size of 0
region 2277 has a size of 0
region 2278 has a size of 0
region 2279 has a size of 0
region 2280 has a size of 0
region 2281 has a size of 0
region 2282 has a size of 0
region 2283 has a size of 0
region 2284 has a size of 0
region 2285 has a size of 0
region 2286 has a size of 0
region 2287 has a size of 0
region 2288 has a size of 0
region 2289 has a size of 0
region 2290 has a size of 0
region 2291 has a size of 0
region 2292 has a size of 0
region 2293 has a size of 0
region 2294 has a size of 0
region 2295 has a size of 0
region 2296 has a size of 0
region 2297 has a size of 0
region 2298 has a size of 0
region 2299 has a size of 0
region 2300 has a size of 0
region 2301 has a size of 0
region 2302 has a size of 0
region 2303 has a size of 0
region 2304 has a size of 0
region 2305 has a size of 0
region 2306 has a size of 0
region 2307 has a size of 0
region 2308 has a size of 0
region 2309 has a size of 0
region 2310 has a size of 0
region 2311 has a size of 0
region 2312 has a size of 0
region 2313 has a size of 0
region 2314 has a size of 0
region 2315 has a size of 0
region 2316 has a size of 0
region 2317 has a size of 0
region 2318 has a size of 0
region 2319 has a size of 0
region 2320 has a size of 0
region 2321 has a size of 0
region 2322 has a size of 0
region 2323 has a size of 0
region 2324 has a size of 0
region 2325 has a size of 0
region 2326 has a size of 0
region 2327 has a size of 0
region 2328 has a size of 0
region 2329 has a size of 0
region 2330 has a size of 0
region 2331 has a size of 0
region 2332 has a size of 0
region 2333 has a size of 0
region 2334 has a size of 0
region 2335 has a size of 0
region 2336 has a size of 0
region 2337 has a size of 0
region 2338 has a size of 0
region 2339 has a size of 0
region 2340 has a size of 0
region 2341 has a size of 0
region 2342 has a size of 0
region 2343 has a size of 0
region 2344 has a size of 0
region 2345 has a size of 0
region 2346 has a size of 0
region 2347 has a size of 0
region 2348 has a size of 0
region 2349 has a size of 0
region 2350 has a size of 0
region 2351 has a size of 0
region 2352 has a size of 0
region 2353 has a size of 0
region 2354 has a size of 0
region 2355 has a size of 0
region 2356 has a size of 0
region 2357 has a size of 0
region 2358 has a size of 0
region 2359 has a size of 0
region 2360 has a size of 0
region 2361 has a size of 0
region 2362 has a size of 0
region 2363 has a size of 0
region 2364 has a size of 0
region 2365 has a size of 0
region 2366 has a size of 0
region 2367 has a size of 0
region 2368 has a size of 0
region 2369 has a size of 0
region 2370 has a size of 0
region 2371 has a size of 0
region 2372 has a size of 0
region 2373 has a size of 0
region 2374 has a size of 0
region 2375 has a size of 0
region 2376 has a size of 0
region 2377 has a size of 0
region 2378 has a size of 0
region 2379 has a size of 0
region 2380 has a size of 0
region 2381 has a size of 0
region 2382 has a size of 0
region 2383 has a size of 0
region 2384 has a size of 0
region 2385 has a size of 0
region 2386 has a size of 0
region 2387 has a size of 0
region 2388 has a size of 0
region 2389 has a size of 0
region 2390 has a size of 0
region 2391 has a size of 0
region 2392 has a size of 0
region 2393 has a size of 0
region 2394 has a size of 0
region 2395 has a size of 0
region 2396 has a size of 0
region 2397 has a size of 0
region 2398 has a size of 0
region 2399 has a size of 0
region 2400 has a size of 0
region 2401 has a size of 0
region 2402 has a size of 0
region 2403 has a size of 0
region 2404 has a size of 0
region 2405 has a size of 0
region 2406 has a size of 0
region 2407 has a size of 0
region 2408 has a size of 0
region 2409 has a size of 0
region 2410 has a size of 0
region 2411 has a size of 0
region 2412 has a size of 0
region 2413 has a size of 0
region 2414 has a size of 0
region 2415 has a size of 0
region 2416 has a size of 0
region 2417 has a size of 0
region 2418 has a size of 0
region 2419 has a size of 0
region 2420 has a size of 0
region 2421 has a size of 0
region 2422 has a size of 0
region 2423 has a size of 0
region 2424 has a size of 0
region 2425 has a size of 0
region 2426 has a size of 0
region 2427 has a size of 0
region 2428 has a size of 0
region 2429 has a size of 0
region 2430 has a size of 0
region 2431 has a size of 0
region 2432 has a size of 0
region 2433 has a size of 0
region 2434 has a size of 0
region 2435 has a size of 0
region 2436 has a size of 0
region 2437 has a size of 0
region 2438 has a size of 0
region 2439 has a size of 0
region 2440 has a size of 0
region 2441 has a size of 0
region 2442 has a size of 0
region 2443 has a size of 0
region 2444 has a size of 0
region 2445 has a size of 0
region 2446 has a size of 0
region 2447 has a size of 0
region 2448 has a size of 0
region 2449 has a size of 0
region 2450 has a size of 0
region 2451 has a size of 0
region 2452 has a size of 0
region 2453 has a size of 0
region 2454 has a size of 0
region 2455 has a size of 0
region 2456 has a size of 0
region 2457 has a size of 0
region 2458 has a size of 0
region 2459 has a size of 0
region 2460 has a size of 0
region 2461 has a size of 0
region 2462 has a size of 0
region 2463 has a size of 0
region 2464 has a size of 0
region 2465 has a size of 0
region 2466 has a size of 0
region 2467 has a size of 0
region 2468 has a size of 0
region 2469 has a size of 0
region 2470 has a size of 0
region 2471 has a size of 0
region 2472 has a size of 0
region 2473 has a size of 0
region 2474 has a size of 0
region 2475 has a size of 0
region 2476 has a size of 0
region 2477 has a size of 0
region 2478 has a size of 0
region 2479 has a size of 0
region 2480 has a size of 0
region 2481 has a size of 0
region 2482 has a size of 0
region 2483 has a size of 0
region 2484 has a size of 0
region 2485 has a size of 0
region 2486 has a size of 0
region 2487 has a size of 0
region 2488 has a size of 0
region 2489 has a size of 0
region 2490 has a size of 0
region 2491 has a size of 0
region 2492 has a size of 0
region 2493 has a size of 0
region 2494 has a size of 0
region 2495 has a size of 0
region 2496 has a size of 0
region 2497 has a size of 0
region 2498 has a size of 0
region 2499 has a size of 0
region 2500 has a size of 0
region 2501 has a size of 0
region 2502 has a size of 0
region 2503 has a size of 0
region 2504 has a size of 0
region 2505 has a size of 0
region 2506 has a size of 0
region 2507 has a size of 0
region 2508 has a size of 0
region 2509 has a size of 0
region 2510 has a size of 0
region 2511 has a size of 0
region 2512 has a size of 0
region 2513 has a size of 0
region 2514 has a size of 0
region 2515 has a size of 0
region 2516 has a size of 0
region 2517 has a size of 0
region 2518 has a size of 0
region 2519 has a size of 0
region 2520 has a size of 0
region 2521 has a size of 0
region 2522 has a size of 0
region 2523 has a size of 0
region 2524 has a size of 0
region 2525 has a size of 0
region 2526 has a size of 0
region 2527 has a size of 0
region 2528 has a size of 0
region 2529 has a size of 0
region 2530 has a size of 0
region 2531 has a size of 0
region 2532 has a size of 0
region 2533 has a size of 0
region 2534 has a size of 0
region 2535 has a size of 0
region 2536 has a size of 0
region 2537 has a size of 0
region 2538 has a size of 0
region 2539 has a size of 0
region 2540 has a size of 0
region 2541 has a size of 0
region 2542 has a size of 0
region 2543 has a size of 0
region 2544 has a size of 0
region 2545 has a size of 0
region 2546 has a size of 0
region 2547 has a size of 0
region 2548 has a size of 0
region 2549 has a size of 0
region 2550 has a size of 0
region 2551 has a size of 0
region 2552 has a size of 0
region 2553 has a size of 0
region 2554 has a size of 0
region 2555 has a size of 0
region 2556 has a size of 0
region 2557 has a size of 0
region 2558 has a size of 0
region 2559 has a size of 0
region 2560 has a size of 0
region 2561 has a size of 0
region 2562 has a size of 0
region 2563 has a size of 0
region 2564 has a size of 0
region 2565 has a size of 0
region 2566 has a size of 0
region 2567 has a size of 0
region 2568 has a size of 0
region 2569 has a size of 0
region 2570 has a size of 0
region 2571 has a size of 0
region 2572 has a size of 0
region 2573 has a size of 0
region 2574 has a size of 0
region 2575 has a size of 0
region 2576 has a size of 0
region 2577 has a size of 0
region 2578 has a size of 0
region 2579 has a size of 0
region 2580 has a size of 0
region 2581 has a size of 0
region 2582 has a size of 0
region 2583 has a size of 0
region 2584 has a size of 0
region 2585 has a size of 0
region 2586 has a size of 0
region 2587 has a size of 0
region 2588 has a size of 0
region 2589 has a size of 0
region 2590 has a size of 0
region 2591 has a size of 0
region 2592 has a size of 0
region 2593 has a size of 0
region 2594 has a size of 0
region 2595 has a size of 0
region 2596 has a size of 0
region 2597 has a size of 0
region 2598 has a size of 0
region 2599 has a size of 0
region 2600 has a size of 0
region 2601 has a size of 0
region 2602 has a size of 0
region 2603 has a size of 0
region 2604 has a size of 0
region 2605 has a size of 0
region 2606 has a size of 0
region 2607 has a size of 0
region 2608 has a size of 0
region 2609 has a size of 0
region 2610 has a size of 0
region 2611 has a size of 0
region 2612 has a size of 0
region 2613 has a size of 0
region 2614 has a size of 0
region 2615 has a size of 0
region 2616 has a size of 0
region 2617 has a size of 0
region 2618 has a size of 0
region 2619 has a size of 0
region 2620 has a size of 0
region 2621 has a size of 0
region 2622 has a size of 0
region 2623 has a size of 0
region 2624 has a size of 0
region 2625 has a size of 0
region 2626 has a size of 0
region 2627 has a size of 0
region 2628 has a size of 0
region 2629 has a size of 0
region 2630 has a size of 0
region 2631 has a size of 0
region 2632 has a size of 0
region 2633 has a size of 0
region 2634 has a size of 0
region 2635 has a size of 0
region 2636 has a size of 0
region 2637 has a size of 0
region 2638 has a size of 0
region 2639 has a size of 0
region 2640 has a size of 0
region 2641 has a size of 0
region 2642 has a size of 0
region 2643 has a size of 0
region 2644 has a size of 0
region 2645 has a size of 0
region 2646 has a size of 0
region 2647 has a size of 0
region 2648 has a size of 0
region 2649 has a size of 0
region 2650 has a size of 0
region 2651 has a size of 0
region 2652 has a size of 0
region 2653 has a size of 0
region 2654 has a size of 0
region 2655 has a size of 0
region 2656 has a size of 0
region 2657 has a size of 0
region 2658 has a size of 0
region 2659 has a size of 0
region 2660 has a size of 0
region 2661 has a size of 0
region 2662 has a size of 0
region 2663 has a size of 0
region 2664 has a size of 0
region 2665 has a size of 0
region 2666 has a size of 0
region 2667 has a size of 0
region 2668 has a size of 0
region 2669 has a size of 0
region 2670 has a size of 0
region 2671 has a size of 0
region 2672 has a size of 0
region 2673 has a size of 0
region 2674 has a size of 0
region 2675 has a size of 0
region 2676 has a size of 0
region 2677 has a size of 0
region 2678 has a size of 0
region 2679 has a size of 0
region 2680 has a size of 0
region 2681 has a size of 0
region 2682 has a size of 0
region 2683 has a size of 0
region 2684 has a size of 0
region 2685 has a size of 0
region 2686 has a size of 0
region 2687 has a size of 0
region 2688 has a size of 0
region 2689 has a size of 0
region 2690 has a size of 0
region 2691 has a size of 0
region 2692 has a size of 0
region 2693 has a size of 0
region 2694 has a size of 0
region 2695 has a size of 0
region 2696 has a size of 0
region 2697 has a size of 0
region 2698 has a size of 0
region 2699 has a size of 0
region 2700 has a size of 0
region 2701 has a size of 0
region 2702 has a size of 0
region 2703 has a size of 0
region 2704 has a size of 0
region 2705 has a size of 0
region 2706 has a size of 0
region 2707 has a size of 0
region 2708 has a size of 0
region 2709 has a size of 0
region 2710 has a size of 0
region 2711 has a size of 0
region 2712 has a size of 0
region 2713 has a size of 0
region 2714 has a size of 0
region 2715 has a size of 0
region 2716 has a size of 0
region 2717 has a size of 0
region 2718 has a size of 0
region 2719 has a size of 0
region 2720 has a size of 0
region 2721 has a size of 0
region 2722 has a size of 0
region 2723 has a size of 0
region 2724 has a size of 0
region 2725 has a size of 0
region 2726 has a size of 0
region 2727 has a size of 0
region 2728 has a size of 0
region 2729 has a size of 0
region 2730 has a size of 0
region 2731 has a size of 0
region 2732 has a size of 0
region 2733 has a size of 0
region 2734 has a size of 0
region 2735 has a size of 0
region 2736 has a size of 0
region 2737 has a size of 0
region 2738 has a size of 0
region 2739 has a size of 0
region 2740 has a size of 0
region 2741 has a size of 0
region 2742 has a size of 0
region 2743 has a size of 0
region 2744 has a size of 0
region 2745 has a size of 0
region 2746 has a size of 0
region 2747 has a size of 0
region 2748 has a size of 0
region 2749 has a size of 0
region 2750 has a size of 0
region 2751 has a size of 0
region 2752 has a size of 0
region 2753 has a size of 0
region 2754 has a size of 0
region 2755 has a size of 0
region 2756 has a size of 0
region 2757 has a size of 0
region 2758 has a size of 0
region 2759 has a size of 0
region 2760 has a size of 0
region 2761 has a size of 0
region 2762 has a size of 0
region 2763 has a size of 0
region 2764 has a size of 0
region 2765 has a size of 0
region 2766 has a size of 0
region 2767 has a size of 0
region 2768 has a size of 0
region 2769 has a size of 0
region 2770 has a size of 0
region 2771 has a size of 0
region 2772 has a size of 0
region 2773 has a size of 0
region 2774 has a size of 0
region 2775 has a size of 0
region 2776 has a size of 0
region 2777 has a size of 0
region 2778 has a size of 0
region 2779 has a size of 0
region 2780 has a size of 0
region 2781 has a size of 0
region 2782 has a size of 0
region 2783 has a size of 0
region 2784 has a size of 0
region 2785 has a size of 0
region 2786 has a size of 0
region 2787 has a size of 0
region 2788 has a size of 0
region 2789 has a size of 0
region 2790 has a size of 0
region 2791 has a size of 0
region 2792 has a size of 0
region 2793 has a size of 0
region 2794 has a size of 0
region 2795 has a size of 0
region 2796 has a size of 0
region 2797 has a size of 0
region 2798 has a size of 0
region 2799 has a size of 0
region 2800 has a size of 0
region 2801 has a size of 0
region 2802 has a size of 0
region 2803 has a size of 0
region 2804 has a size of 0
region 2805 has a size of 0
region 2806 has a size of 0
region 2807 has a size of 0
region 2808 has a size of 0
region 2809 has a size of 0
region 2810 has a size of 0
region 2811 has a size of 0
region 2812 has a size of 0
region 2813 has a size of 0
region 2814 has a size of 0
region 2815 has a size of 0
region 2816 has a size of 0
region 2817 has a size of 0
region 2818 has a size of 0
region 2819 has a size of 0
region 2820 has a size of 0
region 2821 has a size of 0
region 2822 has a size of 0
region 2823 has a size of 0
region 2824 has a size of 0
region 2825 has a size of 0
region 2826 has a size of 0
region 2827 has a size of 0
region 2828 has a size of 0
region 2829 has a size of 0
region 2830 has a size of 0
region 2831 has a size of 0
region 2832 has a size of 0
region 2833 has a size of 0
region 2834 has a size of 0
region 2835 has a size of 0
region 2836 has a size of 0
region 2837 has a size of 0
region 2838 has a size of 0
region 2839 has a size of 0
region 2840 has a size of 0
region 2841 has a size of 0
region 2842 has a size of 0
region 2843 has a size of 0
region 2844 has a size of 0
region 2845 has a size of 0
region 2846 has a size of 0
region 2847 has a size of 0
region 2848 has a size of 0
region 2849 has a size of 0
region 2850 has a size of 0
region 2851 has a size of 0
region 2852 has a size of 0
region 2853 has a size of 0
region 2854 has a size of 0
region 2855 has a size of 0
region 2856 has a size of 0
region 2857 has a size of 0
region 2858 has a size of 0
region 2859 has a size of 0
region 2860 has a size of 0
region 2861 has a size of 0
region 2862 has a size of 0
region 2863 has a size of 0
region 2864 has a size of 0
region 2865 has a size of 0
region 2866 has a size of 0
region 2867 has a size of 0
region 2868 has a size of 0
region 2869 has a size of 0
region 2870 has a size of 0
region 2871 has a size of 0
region 2872 has a size of 0
region 2873 has a size of 0
region 2874 has a size of 0
region 2875 has a size of 0
region 2876 has a size of 0
region 2877 has a size of 0
region 2878 has a size of 0
region 2879 has a size of 0
region 2880 has a size of 0
region 2881 has a size of 0
region 2882 has a size of 0
region 2883 has a size of 0
region 2884 has a size of 0
region 2885 has a size of 0
region 2886 has a size of 0
region 2887 has a size of 0
region 2888 has a size of 0
region 2889 has a size of 0
region 2890 has a size of 0
region 2891 has a size of 0
region 2892 has a size of 0
region 2893 has a size of 0
region 2894 has a size of 0
region 2895 has a size of 0
region 2896 has a size of 0
region 2897 has a size of 0
region 2898 has a size of 0
region 2899 has a size of 0
region 2900 has a size of 0
region 2901 has a size of 0
region 2902 has a size of 0
region 2903 has a size of 0
region 2904 has a size of 0
region 2905 has a size of 0
region 2906 has a size of 0
region 2907 has a size of 0
region 2908 has a size of 0
region 2909 has a size of 0
region 2910 has a size of 0
region 2911 has a size of 0
region 2912 has a size of 0
region 2913 has a size of 0
region 2914 has a size of 0
region 2915 has a size of 0
region 2916 has a size of 0
region 2917 has a size of 0
region 2918 has a size of 0
region 2919 has a size of 0
region 2920 has a size of 0
region 2921 has a size of 0
region 2922 has a size of 0
region 2923 has a size of 0
region 2924 has a size of 0
region 2925 has a size of 0
region 2926 has a size of 0
region 2927 has a size of 0
region 2928 has a size of 0
region 2929 has a size of 0
region 2930 has a size of 0
region 2931 has a size of 0
region 2932 has a size of 0
region 2933 has a size of 0
region 2934 has a size of 0
region 2935 has a size of 0
region 2936 has a size of 0
region 2937 has a size of 0
region 2938 has a size of 0
region 2939 has a size of 0
region 2940 has a size of 0
region 2941 has a size of 0
region 2942 has a size of 0
region 2943 has a size of 0
region 2944 has a size of 0
region 2945 has a size of 0
region 2946 has a size of 0
region 2947 has a size of 0
region 2948 has a size of 0
region 2949 has a size of 0
region 2950 has a size of 0
region 2951 has a size of 0
region 2952 has a size of 0
region 2953 has a size of 0
region 2954 has a size of 0
region 2955 has a size of 0
region 2956 has a size of 0
region 2957 has a size of 0
region 2958 has a size of 0
region 2959 has a size of 0
region 2960 has a size of 0
region 2961 has a size of 0
region 2962 has a size of 0
region 2963 has a size of 0
region 2964 has a size of 0
region 2965 has a size of 0
region 2966 has a size of 0
region 2967 has a size of 0
region 2968 has a size of 0
region 2969 has a size of 0
region 2970 has a size of 0
region 2971 has a size of 0
region 2972 has a size of 0
region 2973 has a size of 0
region 2974 has a size of 0
region 2975 has a size of 0
region 2976 has a size of 0
region 2977 has a size of 0
region 2978 has a size of 0
region 2979 has a size of 0
region 2980 has a size of 0
region 2981 has a size of 0
region 2982 has a size of 0
region 2983 has a size of 0
region 2984 has a size of 0
region 2985 has a size of 0
region 2986 has a size of 0
region 2987 has a size of 0
region 2988 has a size of 0
region 2989 has a size of 0
region 2990 has a size of 0
region 2991 has a size of 0
region 2992 has a size of 0
region 2993 has a size of 0
region 2994 has a size of 0
region 2995 has a size of 0
region 2996 has a size of 0
region 2997 has a size of 0
region 2998 has a size of 0
region 2999 has a size of 0
region 3000 has a size of 0
region 3001 has a size of 0
region 3002 has a size of 0
region 3003 has a size of 0
region 3004 has a size of 0
region 3005 has a size of 0
region 3006 has a size of 0
region 3007 has a size of 0
region 3008 has a size of 0
region 3009 has a size of 0
region 3010 has a size of 0
region 3011 has a size of 0
region 3012 has a size of 0
region 3013 has a size of 0
region 3014 has a size of 0
region 3015 has a size of 0
region 3016 has a size of 0
region 3017 has a size of 0
region 3018 has a size of 0
region 3019 has a size of 0
region 3020 has a size of 0
region 3021 has a size of 0
region 3022 has a size of 0
region 3023 has a size of 0
region 3024 has a size of 0
region 3025 has a size of 0
region 3026 has a size of 0
region 3027 has a size of 0
region 3028 has a size of 0
region 3029 has a size of 0
region 3030 has a size of 0
region 3031 has a size of 0
region 3032 has a size of 0
region 3033 has a size of 0
region 3034 has a size of 0
region 3035 has a size of 0
region 3036 has a size of 0
region 3037 has a size of 0
region 3038 has a size of 0
region 3039 has a size of 0
region 3040 has a size of 0
region 3041 has a size of 0
region 3042 has a size of 0
region 3043 has a size of 0
region 3044 has a size of 0
region 3045 has a size of 0
region 3046 has a size of 0
region 3047 has a size of 0
region 3048 has a size of 0
region 3049 has a size of 0
region 3050 has a size of 0
region 3051 has a size of 0
region 3052 has a size of 0
region 3053 has a size of 0
region 3054 has a size of 0
region 3055 has a size of 0
region 3056 has a size of 0
region 3057 has a size of 0
region 3058 has a size of 0
region 3059 has a size of 0
region 3060 has a size of 0
region 3061 has a size of 0
region 3062 has a size of 0
region 3063 has a size of 0
region 3064 has a size of 0
region 3065 has a size of 0
region 3066 has a size of 0
region 3067 has a size of 0
region 3068 has a size of 0
region 3069 has a size of 0
region 3070 has a size of 0
region 3071 has a size of 0
region 3072 has a size of 0
region 3073 has a size of 0
region 3074 has a size of 0
region 3075 has a size of 0
region 3076 has a size of 0
region 3077 has a size of 0
region 3078 has a size of 0
region 3079 has a size of 0
region 3080 has a size of 0
region 3081 has a size of 0
region 3082 has a size of 0
region 3083 has a size of 0
region 3084 has a size of 0
region 3085 has a size of 0
region 3086 has a size of 0
region 3087 has a size of 0
region 3088 has a size of 0
region 3089 has a size of 0
region 3090 has a size of 0
region 3091 has a size of 0
region 3092 has a size of 0
region 3093 has a size of 0
region 3094 has a size of 0
region 3095 has a size of 0
region 3096 has a size of 0
region 3097 has a size of 0
region 3098 has a size of 0
region 3099 has a size of 0
region 3100 has a size of 0
region 3101 has a size of 0
region 3102 has a size of 0
region 3103 has a size of 0
region 3104 has a size of 0
region 3105 has a size of 0
region 3106 has a size of 0
region 3107 has a size of 0
region 3108 has a size of 0
region 3109 has a size of 0
region 3110 has a size of 0
region 3111 has a size of 0
region 3112 has a size of 0
region 3113 has a size of 0
region 3114 has a size of 0
region 3115 has a size of 0
region 3116 has a size of 0
region 3117 has a size of 0
region 3118 has a size of 0
region 3119 has a size of 0
region 3120 has a size of 0
region 3121 has a size of 0
region 3122 has a size of 0
region 3123 has a size of 0
region 3124 has a size of 0
region 3125 has a size of 0
region 3126 has a size of 0
region 3127 has a size of 0
region 3128 has a size of 0
region 3129 has a size of 0
region 3130 has a size of 0
region 3131 has a size of 0
region 3132 has a size of 0
region 3133 has a size of 0
region 3134 has a size of 0
region 3135 has a size of 0
region 3136 has a size of 0
region 3137 has a size of 0
region 3138 has a size of 0
region 3139 has a size of 0
region 3140 has a size of 0
region 3141 has a size of 0
region 3142 has a size of 0
region 3143 has a size of 0
region 3144 has a size of 0
region 3145 has a size of 0
region 3146 has a size of 0
region 3147 has a size of 0
region 3148 has a size of 0
region 3149 has a size of 0
region 3150 has a size of 0
region 3151 has a size of 0
region 3152 has a size of 0
region 3153 has a size of 0
region 3154 has a size of 0
region 3155 has a size of 0
region 3156 has a size of 0
region 3157 has a size of 0
region 3158 has a size of 0
region 3159 has a size of 0
region 3160 has a size of 0
region 3161 has a size of 0
region 3162 has a size of 0
region 3163 has a size of 0
region 3164 has a size of 0
region 3165 has a size of 0
region 3166 has a size of 0
region 3167 has a size of 0
region 3168 has a size of 0
region 3169 has a size of 0
region 3170 has a size of 0
region 3171 has a size of 0
region 3172 has a size of 0
region 3173 has a size of 0
region 3174 has a size of 0
region 3175 has a size of 0
region 3176 has a size of 0
region 3177 has a size of 0
region 3178 has a size of 0
region 3179 has a size of 0
region 3180 has a size of 0
region 3181 has a size of 0
region 3182 has a size of 0
region 3183 has a size of 0
region 3184 has a size of 0
region 3185 has a size of 0
region 3186 has a size of 0
region 3187 has a size of 0
region 3188 has a size of 0
region 3189 has a size of 0
region 3190 has a size of 0
region 3191 has a size of 0
region 3192 has a size of 0
region 3193 has a size of 0
region 3194 has a size of 0
region 3195 has a size of 0
region 3196 has a size of 0
region 3197 has a size of 0
region 3198 has a size of 0
region 3199 has a size of 0
region 3200 has a size of 0
region 3201 has a size of 0
region 3202 has a size of 0
region 3203 has a size of 0
region 3204 has a size of 0
region 3205 has a size of 0
region 3206 has a size of 0
region 3207 has a size of 0
region 3208 has a size of 0
region 3209 has a size of 0
region 3210 has a size of 0
region 3211 has a size of 0
region 3212 has a size of 0
region 3213 has a size of 0
region 3214 has a size of 0
region 3215 has a size of 0
region 3216 has a size of 0
region 3217 has a size of 0
region 3218 has a size of 0
region 3219 has a size of 0
region 3220 has a size of 0
region 3221 has a size of 0
region 3222 has a size of 0
region 3223 has a size of 0
region 3224 has a size of 0
region 3225 has a size of 0
region 3226 has a size of 0
region 3227 has a size of 0
region 3228 has a size of 0
region 3229 has a size of 0
region 3230 has a size of 0
region 3231 has a size of 0
region 3232 has a size of 0
region 3233 has a size of 0
region 3234 has a size of 0
region 3235 has a size of 0
region 3236 has a size of 0
region 3237 has a size of 0
region 3238 has a size of 0
region 3239 has a size of 0
region 3240 has a size of 0
region 3241 has a size of 0
region 3242 has a size of 0
region 3243 has a size of 0
region 3244 has a size of 0
region 3245 has a size of 0
region 3246 has a size of 0
region 3247 has a size of 0
region 3248 has a size of 0
region 3249 has a size of 0
result's size summarized is 0
temporarly data has sizes 
temp : 0
crossregion1: 0
crossregion2: 0
crossregion3: 0
crossregion4: 0
temp_reg: 0
cross12: 0
created Flobs70133131
reusedFlobs 70122536
Total runtime ...   Times (elapsed / cpu): 112:43min (6762.58sec) /6750.61sec = 1.00177

=> []
 ##################################
 ########      query      #########
 ##################################
 #1 road line, use blue color in Javagui
 #query r;
 #2 pavement beside road, use gray color in Javagui
 #query pave_regions1;
 #3 zebra crossings at junctions, use yellow color in Javagui
 #query pave_regions2;
 #4 regions partitioned by roadnetwork, use red color in Javagui
 #query region_elem;
 delete allregions_in;
command 
'delete allregions_in'
started at: Wed May 19 07:35:54 2021

Total runtime ...   Times (elapsed / cpu): 0.002708sec / 0sec = inf

=> []
 delete allregions_out;
command 
'delete allregions_out'
started at: Wed May 19 07:35:54 2021

Total runtime ...   Times (elapsed / cpu): 0.001978sec / 0sec = inf

=> []
 delete allregions_pave;
command 
'delete allregions_pave'
started at: Wed May 19 07:35:54 2021

Total runtime ...   Times (elapsed / cpu): 0.002768sec / 0.01sec = 0.2768

=> []
 delete regions_outborder;
command 
'delete regions_outborder'
started at: Wed May 19 07:35:54 2021

Total runtime ...   Times (elapsed / cpu): 0.011394sec / 0.01sec = 1.1394

=> []
 #####################################################################
 ########## create region for pavement, one big region  ##############
 ########## create dual grapn on triangles and visibility graph ######
 #####################################################################
 let subpaves1 = getpavenode1(rn,pave_regions1,Rid,Pavement1,Pavement2) consume;
command 
'let subpaves1 = getpavenode1(rn,pave_regions1,Rid,Pavement1,Pavement2) consume'
started at: Wed May 19 07:35:54 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 4.90483sec / 4.88sec = 1.00509

=> []
 ## used in creating bus network
 let subpaves2 = getpavenode2(subpaves1 count, pave_regions2, Rid, Crossreg) consume;
command 
'let subpaves2 = getpavenode2(subpaves1 count, pave_regions2, Rid, Crossreg) consume'
started at: Wed May 19 07:35:59 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.024175sec / 0.02sec = 1.20875

=> []
 let graph_node = subpaves1 feed subpaves2 feed concat consume;
command 
'let graph_node = subpaves1 feed subpaves2 feed concat consume'
started at: Wed May 19 07:35:59 2021

noMemoryOperators = 0
perOperator = 0
Total runtime ...   Times (elapsed / cpu): 0.228319sec / 0.2sec = 1.14159

=> []
 delete subpaves1;
command 
'delete subpaves1'
started at: Wed May 19 07:35:59 2021

Total runtime ...   Times (elapsed / cpu): 0.004903sec / 0sec = inf

=> []
 #subpaves2 will be used later
 ## Berlin 10 minutes; Houston 25 minutes
 let node_reg = graph_node feed aggregateB[Pavement; fun(r1:region,r2:region) r1 union r2; [const region value()]];
command 
'let node_reg = graph_node feed aggregateB[Pavement; fun(r1:region,r2:region) r1 union r2; [const region value()]]'
started at: Wed May 19 07:35:59 2021

no face found within the cycles
noMemoryOperators = 0
perOperator = 0

 Generating stack trace ... 
 ************ BEGIN STACKTRACE ************
Writing stacktrace to: /tmp/tmp.zD3V8UroyB

 *********** END STACKTRACE **********************

*** Signal SIGSEGV (11) caught! Calling default signal handler ...
./SecondoTTYBDB: line 34: 12692 Segmentation fault      (core dumped) $runner $*


========
SECONDO has crashed, printing stack trace....
========


?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
?? ??:0
========

```
