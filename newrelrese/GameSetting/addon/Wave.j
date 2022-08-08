scope Wave
 
private struct tick
    //! runtextmacro Tick()
endstruct

struct WaveSystem
    
    method 

    static method Start takes integer i, code F returns thistype
        local thistype this = thistype.allocate()
        local tick t = t.Create()
        call t.Start(WAVE_TICK,true,F)
        return this
    endmethod
endstruct

endscope