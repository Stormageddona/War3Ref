globals
    CastleObject Castle
endglobals


struct CastleObject
    private static real X
    private static real Y
    private static unit Unit
    method GetX takes nothing returns real
        return this.X 
    endmethod
    method GetY takes nothing returns real
        return this.Y 
    endmethod
    method GetUnit takes nothing returns unit
        return this.Unit
    endmethod
    
    static method onInit takes nothing returns nothing
        set Castle = CastleObject.create()
        set Castle.X = GetRectCenterX(gg_rct_Center)
        set Castle.Y = GetRectCenterY(gg_rct_Center)
        set Castle.Unit = gg_unit_htow_0002
    endmethod
endstruct