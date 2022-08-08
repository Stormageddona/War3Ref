struct LocAPI
    private real X
    private real Y
    
    method getX takes nothing returns real
        return .X
    endmethod
    
    method getY takes nothing returns real
        return .Y
    endmethod

    method setX takes real float returns nothing
        set .X = float
    endmethod

    method setY takes real float returns nothing
        set .Y = float
    endmethod

    static method create takes real x, real y returns thistype
        local thistype this = thistype.allocate()
        set .X = x
        set .Y = y
        return this
    endmethod
endstruct