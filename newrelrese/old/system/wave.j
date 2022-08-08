

struct WaveSystem extends Addon_Wave
    
    static method Action takes nothing returns nothing 
        local GlobalsTick t = GlobalsTick.GetExpired()
        local thistype this =  t.Exint
        set t.int = t.int + 1
        call IssuePointOrder(CreateUnit(Player(11),Monster.Main[WAVE_LEVEL],Zen.X[1],Zen.Y[1],270),"attack",Castle.GetX(),Castle.GetY())
        call IssuePointOrder(CreateUnit(Player(11),Monster.Main[WAVE_LEVEL],Zen.X[2],Zen.Y[2],270),"attack",Castle.GetX(),Castle.GetY())
        call IssuePointOrder(CreateUnit(Player(11),Monster.Main[WAVE_LEVEL],Zen.X[3],Zen.Y[3],270),"attack",Castle.GetX(),Castle.GetY())
        if t.int == 35 then
            call t.Destroy()
            call thistype.deallocate(this)
        endif
    endmethod
    
    static method create takes nothing returns thistype
        local thistype this = thistype.allocate()
        local GlobalsTick t = GlobalsTick.Create()
        set t.Exint = this
        call t.Start(1.2,true,function thistype.Action)
        return this
    endmethod

endstruct

globals
    //  clock MainTime
    integer WaveLevel
  endglobals
  
  struct Addon_Wave
      private static clock MainTime
      private static real time = 1
      static integer WAVE_LEVEL = 0
      private static method Action takes nothing returns nothing
          local thistype this = GetExpiredClock()
          call ClockSetTitle(MainTime,I2S(WAVE_LEVEL) + " Wave")
          call ClockStart(MainTime,120,false,function thistype.Action)
          set WAVE_LEVEL = WAVE_LEVEL + 1
          call AddonMainWave.create()
      endmethod
          
      static method Init takes real StartTime, real Time returns clock
          set MainTime = CreateClock()
          set time = Time
          call ClockSetTitle(MainTime,"준비 시간")
          call ClockDisplay(MainTime,true)
          call ClockStart(MainTime,StartTime,false,function thistype.Action)
          return MainTime
      endmethod
      
  endstruct
  