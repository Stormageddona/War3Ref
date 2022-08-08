scope GameStart


    
    public function main takes nothing returns nothing

        call Wave_main.execute()
    endfunction
endscope

scope Wave
 

    private function Action takes nothing returns nothing
        call Round.add()
        call ClockSetTitle(MainTimer,I2S(Round.get())+" 라운드")
        call Spawner.Create(Monster.Main.getCode(Round.get()),Loc.MidSpawn.getX(),Loc.MidSpawn.getY(),Castle.getX(),Castle.getY(),WAVE_SPAWN,WAVE_TICK)
        call Spawner.Create(Monster.Main.getCode(Round.get()),Loc.LeftSpawn.getX(),Loc.LeftSpawn.getY(),Castle.getX(),Castle.getY(),WAVE_SPAWN,WAVE_TICK)
        call Spawner.Create(Monster.Main.getCode(Round.get()),Loc.RightSpawn.getX(),Loc.RightSpawn.getY(),Castle.getX(),Castle.getY(),WAVE_SPAWN,WAVE_TICK)
    endfunction
    
    public function main takes nothing returns nothing
        set MainTimer = CreateClock()
        call ClockStart(MainTimer,WAVE_TIME,true,function Action)  
        call ClockDisplay(MainTimer,true)
        call ClockSetTitle(MainTimer,"시작까지")
    endfunction
    
endscope