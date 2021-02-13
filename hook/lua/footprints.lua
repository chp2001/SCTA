LAND = 0x01
SEABED = 0x02
SUB = 0x04
WATER = 0x08
AIR = 0x10
ORBIT = 0x20


SpecFootprints {
    { Name = 'Spider1x2', SizeX = 1,  SizeZ = 2,  Caps=LAND, MaxWaterDepth=0.05,  MaxSlope=1.5, Flags=0 },
    { Name = 'Commander1x2',   SizeX = 1,  SizeZ = 2,  Caps=LAND|SEABED, MaxWaterDepth=15, MaxSlope=1.25, Flags=0 },
    { Name = 'Hover1x2',   SizeX = 1,  SizeZ = 2,  Caps=LAND|WATER, MaxWaterDepth=1, MinWaterDepth=0.1, MaxSlope=1.25, Flags=0 },
}