LAND = 0x01
SEABED = 0x02
SUB = 0x04
WATER = 0x08
AIR = 0x10
ORBIT = 0x20


SpecFootprints {
    { Name = 'Spider1x2', SizeX = 1,  SizeZ = 2,  Caps=LAND, MaxWaterDepth=0.05,  MaxSlope=1.5, Flags=0 },
    { Name = 'Vehicle3x3',   SizeX = 3,  SizeZ = 3,  Caps=LAND, MaxWaterDepth=0.05, MaxSlope=0.75, Flags=0 },
}