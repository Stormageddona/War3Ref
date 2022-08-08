scope Monster

    private function Destroy takes nothing returns boolean
        call Unit[IndexUnit(GetTriggerUnit())].Destroy()
        call DestroyTrigger(GetTriggeringTrigger())
        return false
    endfunction
    
    struct Monster extends UnitObject
        
        static integer array Main
        static integer array Creep
        /*
        unit Src
        real HP
        real MP
        real Damage
        real Armor
        real Vamp
        real Shield*/
        
        
        method Destroy takes nothing returns nothing
            set .Src = null
            call thistype.deallocate(this)
        endmethod
        
        static method create takes player PL,integer Code, real GetX, real GetY returns thistype
            local thistype this = thistype.allocate()
            local trigger t = CreateTrigger()
            set .Src = CreateUnit(PL,Code,GetX,GetY,270)
            set .HP = JNGetUnitMaxHP(.Src) + (JNGetUnitMaxHP(.Src) * (Public_GameLevel*GetRandomReal(0,0.55)))
            set .Damage = JNGetUnitBaseDamage(.Src,1) + ((JNGetUnitBaseDamage(.Src,1) * (R2I(Public_GameLevel)*GetRandomInt(0,25)))/100)
            call TriggerRegisterUnitEvent(t,.Src,EVENT_UNIT_DEATH)
            call TriggerAddCondition(t,Filter(function Destroy))
            set t = null
            if GetRandomInt(1,100) <= Public_GameLevel*10 then
                set .Shield = JNGetUnitMaxHP(.Src) * GetRandomReal(0,1)
            endif
            call JNSetUnitMaxHP(.Src,.HP)
            call JNSetUnitHP(.Src,.HP)
            call JNSetUnitBaseDamage(.Src,.Damage,1)
            return this
        endmethod
        
        
        static method onInit takes nothing returns nothing
            set Main[1] = 'mw01'
            set Main[2] = 'mw02'
            set Main[3] = 'mw03'
            set Main[4] = 'mw04'
            set Main[5] = 'mw05'
            set Main[6] = 'mw06'
            set Main[7] = 'mw07'
            set Main[8] = 'mw08'
            set Main[9] = 'mw09'
            set Main[10] = 'mw10'
            set Main[11] = 'mw11'
            set Main[12] = 'mw12'
            set Main[13] = 'mw13'
            set Main[14] = 'mw14'
            set Main[15] = 'mw15'
            set Main[16] = 'mw16'
            set Main[17] = 'mw17'
            set Main[18] = 'mw18'
            set Main[19] = 'mw19'
            set Main[20] = 'mw20'
            set Main[21] = 'mw21'
            set Main[22] = 'mw22'
            set Main[23] = 'mw23'
            set Main[24] = 'mw24'
            set Main[25] = 'mw25'
            set Main[26] = 'mw26'
            set Main[27] = 'mw27'
            set Main[28] = 'mw28'
            set Main[29] = 'mw29'
            set Main[30] = 'mw30'
            
            
            set Creep[1] = 'cr01'
            set Creep[2] = 'cr02'
            


        endmethod
        
    endstruct
endscope