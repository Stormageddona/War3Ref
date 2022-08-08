struct gameover
    
    private static method Destroy takes nothing returns nothing
        if not UnitAlive(Unit) then
            call DestroyTimer(GetExpiredTimer())
            call Msg(GetUnitName(Unit) + "이/가 파괴되었습니다. 20초후 패배합니다.",GetLocalPlayer())
            call TriggerSleepAction(20)
            call EndGame( true )
        endif
    endmethod
    
    static method onInit takes nothing returns nothing
        local timer t = CreateTimer()
        call TimerStart(t,1,true,function thistype.Destroy)
        call Castle.setUnit(gg_unit_htow_0002)
    endmethod

endstruct
    
    
