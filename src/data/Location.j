struct Loc
    
    private static LocAPI MidSpawn
    private static LocAPI LeftSpawn
    private static LocAPI RightSpawn


    private static method onInit takes nothing returns nothing
        set MidSpawn = LocAPI.create(GetRectCenterX(gg_rct_MidZen),GetRectCenterY(gg_rct_MidZen))
        set LeftSpawn = LocAPI.create(GetRectCenterX(gg_rct_LeftZen),GetRectCenterY(gg_rct_LeftZen))
        set RightSpawn = LocAPI.create(GetRectCenterX(gg_rct_RightZen),GetRectCenterY(gg_rct_RightZen))
    endfunction
endstruct