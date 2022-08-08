struct Castle
    private static unit Unit
    static method getX takes nothing returns real
        return GetUnitX(Unit)
    endmethod
    static method getY takes nothing returns real
        return GetUnitY(Unit)
    endmethod
    static method getUnit takes nothing returns unit
        return Unit
    endmethod
    static method setUnit takes unit u returns nothing
        set Unit = u
    endmethod

endstruct