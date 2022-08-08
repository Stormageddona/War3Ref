struct playerVJ
    private static integer max = 0

    static method getMax takes nothing returns integer
        return max
    endmethod

    static method onInit takes nothing returns nothing
        local integer i = 0
        loop
            exitwhen i == bj_MAX_PLAYERS
            if GetPlayerController(Player(i)) == MAP_CONTROL_USER then
                set max = max + 1
            endif
            set i = i + 1
        endloop
        call Msg("플레이어 수 : " + I2S(max) + "명",GetLocalPlayer())
    endmethod
    call SetUnitAbilityLevel



endstruct