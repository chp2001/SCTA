#ARM Advanced Torpedo Launcher - Advanced Torpedo Launcher
#ARMATL
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMATL = Class(TAStructure) {

    Weapons = {
         ARMATL_TORPEDO = Class(TAweapon) {},
    },

}

TypeClass = ARMATL