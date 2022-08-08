struct CreepMonsterData
    private static integer array code

    method getCode takes number returns integer
        return code[number]
    endmethod

    static method onInit takes nothing returns nothing
        set code[1] = 'cr01'
        set code[2] = 'cr02'
    endmethod
endstruct

setunita
