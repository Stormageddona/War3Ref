scope GameStart

    globals
        WaveSystem Wave
        clock MainTimer
        
    endglobals

    private function Action takes nothing returns nothing
        set Wave = WaveSystem.Start(GameLevel)
    endfunction
    
    public function main takes nothing returns nothing
        set MainTimer = CreateClock()
        call ClockStart(MainTimer,WAVE_TIME,true,function Action)        
        
        call setunia
        
    endfunction
endscope