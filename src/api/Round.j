struct Round
    private static integer I = 0
    private static integer array TAC
    private static trigger TAF = CreateTrigger()
    private static integer index = 0
    
    static method get takes nothing returns integer
        return I
    endmethod
    
    
    static method addTrigger takes integer round, code func returns nothing
        set TAC[index] = round
        call TriggerAddCondition(TAF,Filter(func))
        set index = index + 1
    endmethod
    
    static method add takes nothing returns nothing
        local integer loopA = 0
        set I = I + 1
        loop
            exitwhen loopA == index
            if TAC[loopA] == I then
                call TriggerEvaluate(TAF)
            endif
            set loopA = loopA + 1
        endloop
    endmethod
endstruct