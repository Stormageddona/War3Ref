library MoveSpeedLimit initializer main requires JNMemory

    function SetMaxMoveSpeedLimit takes real msLimit returns nothing
        local integer pGameDll = JNGetModuleHandle("game.dll")
        call JNMemorySetReal(pGameDll + 0xD38804, msLimit)
        call JNMemorySetReal(JNMemoryGetInteger(pGameDll + 0xD04438) + 0x80, msLimit)
    endfunction

    private function main takes nothing returns nothing
        call SetMaxMoveSpeedLimit(1050)
    endfunction

endlibrary
