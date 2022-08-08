scope ATS
    private struct tick
        integer data
        //! runtextmacro Tick()
    endstruct

    struct AutoTooltip
        private hashtable InhashTooltip = InitHashtable()


        static method Action takes nothing returns nothing
            local tick t = tick.GetExpired()
            local thistype this = t.data

            
        endmethod

        static method create takes unit src, string DefaultString, real value returns nothing
            local thistype this = thistype.allocate()
            local tick t = t.Create()
            set t.data = this
            set .dString = DefaultString
            set .vue = value

            
            set .Pri = EXExecuteScript("(require'jass.slk').unit[" + I2S(GetUnitTypeId(A)) + "].Primary")
            set .Skillcode =  EXExecuteScript("(require'jass.slk').unit[" + I2S(GetUnitTypeId(A)) + "].heroAbilList") + EXExecuteScript("(require'jass.slk').unit[" + I2S(GetUnitTypeId(A)) + "].abilList")
            set .Skillcode = JNStringReplace(.Skillcode,",","")
            call t.Start(1,true,function thistype.Action)
        endmethod
    endstruct

endscope




scope AutoTooltip
    globals
        private hashtable InhashDamage = InitHashtable()
        public hashtable InhashCool = InitHashtable()
        private hashtable InhashAnot = InitHashtable()
    endglobals

    private struct tick
        integer IntEx
        //! runtextmacro Tick()
    endstruct

    private function R2D takes real damage returns string
        local real D = damage
        local string S = I2S(R2I(D))
        if (damage >= 1000000) then
            set D = damage/10000
            set S = I2S(R2I(D))+"만"
        endif
        return S
    endfunction
    
    
    private function TXFD takes unit u, integer abilcode, integer statcode returns nothing
        local string array Str
        if GetUnitAbilityLevel(u,abilcode) >= 1 then
            set Str[1] = JNGetAbilityExtendedTooltip(abilcode,GetUnitAbilityLevel(u,abilcode))
            if JNStringLength(Str[1]) == 0 then
                return
            endif
            if JNStringCount(Str[1],"DefaultDamage") == 1 then
                set Str[2] = "DefaultDamage"
            elseif LoadStr(InhashDamage,GetPlayerId(GetOwningPlayer(u)), abilcode) != null then
                set Str[2] = LoadStr(InhashDamage,GetPlayerId(GetOwningPlayer(u)), abilcode)
            else
                return
            endif 
            set Str[3] = E2S(u,abilcode,"DataA")
            set Str[0] = "|cffffdead"+R2D(statcode*S2R(Str[3]))+"|r"
            set Str[4] = JNStringReplace(Str[1],Str[2],Str[0])

            call JNSetAbilityExtendedTooltip(abilcode,Str[4],GetUnitAbilityLevel(u,abilcode))
            call SaveStr(InhashDamage,GetPlayerId(GetOwningPlayer(u)), abilcode,Str[0])
        endif
    endfunction
    
    private function TXFC takes unit u, integer abilcode returns nothing
        local string array Str
        if GetUnitAbilityLevel(u,abilcode) >= 1 then
            set Str[1] = JNGetAbilityExtendedTooltip(abilcode,GetUnitAbilityLevel(u,abilcode))
            if JNStringLength(Str[1]) == 0 then
                return
            endif
            if JNStringCount(Str[1],"DefaultCool") == 1 then
                set Str[5] = "DefaultCool"
            elseif LoadStr(InhashCool,GetPlayerId(GetOwningPlayer(u)), abilcode) != null then
                set Str[5] = LoadStr(InhashCool,GetPlayerId(GetOwningPlayer(u)), abilcode)
            else
                return
            endif 
            set Str[6] = E2S(u,abilcode,"Cool")
            set Str[6] = R2S(S2R(Str[6])-(S2R(Str[6])/100)*Hero[IndexUnit(u)].Cool)
            set Str[6] = "|cffafeeee"+Str[6]+"|r"
            set Str[4] = JNStringReplace(Str[1],Str[5],Str[6])
            call JNSetAbilityExtendedTooltip(abilcode,Str[4],GetUnitAbilityLevel(u,abilcode))
            call SaveStr(InhashCool,GetPlayerId(GetOwningPlayer(u)), abilcode,Str[6])
        endif
    endfunction
    
    private function TXFA takes unit u, integer abilcode, string DefultName, string incode, real var returns nothing
        local string array Str
        if DefultName == null then
            return
        endif
        if GetUnitAbilityLevel(u,abilcode) >= 1 then
            set Str[1] = JNGetAbilityExtendedTooltip(abilcode,GetUnitAbilityLevel(u,abilcode))
            if JNStringLength(Str[1]) == 0 then
                return
            endif
            if JNStringCount(Str[1],DefultName) == 1 then
                set Str[2] = DefultName
            elseif LoadStr(InhashAnot,abilcode, StringHash(DefultName)) != null then
                set Str[2] = LoadStr(InhashAnot,abilcode, StringHash(DefultName))
            else
                return
            endif 
            if incode != null then
                set Str[3] = E2S(u,abilcode,incode)
            else
                set Str[3] = "1"
            endif
            set Str[0] = "|cffee82ee"+I2S(R2I(S2R(Str[3])*var))+"|r"
            set Str[4] = JNStringReplace(Str[1],Str[2],Str[0])

            call JNSetAbilityExtendedTooltip(abilcode,Str[4],GetUnitAbilityLevel(u,abilcode))
            call SaveStr(InhashAnot,abilcode,StringHash(DefultName),Str[0])
        endif
    endfunction

    struct Tooltip
        unit src
        string Skillcode
        string Pri
        string data


        private static method Action takes nothing returns nothing
            local tick t = tick.GetExpired()
            local thistype this = t.IntEx
            local integer LoopA = 0
            local string Skill
            local integer stat = 0
            local integer a
            if .Pri == "STR" then
                set stat = GetHeroStr(.src,true)
            elseif .Pri == "AGI" then
                set stat = GetHeroAgi(.src,true)      
            elseif .Pri == "INT" then     
                set stat = GetHeroInt(.src,true)  
            endif
            loop
                set Skill = JNStringSub(.Skillcode,LoopA,4)
                call TXFD(.src,S2A(Skill), stat)
                call TXFC(.src,S2A(Skill))
                call TXFA(.src,S2A(Skill),.data,"DataB",GetUnitMoveSpeed(.src))
                set LoopA = LoopA + 4
                //  call BJDebugMsg("스킬갱신 : "+ Skill + A2S(a))
                //  call BJDebugMsg("스킬갱신 : " + I2S('Hsh1')+ I2S(a))
                exitwhen JNStringSub(.Skillcode,LoopA,4) == ""
            endloop
            //call TXFD(.src,S2A("Hsh1"), GetHeroAgi(.src,true), "DataA")
            // call TXFD(.src,'Hsh2', GetHeroAgi(.src,true), "DataA")
        endmethod

        static method Create takes unit A, string Data,  returns nothing
            local tick t = tick.Create()
            local thistype this = thistype.allocate()
            local trigger Trig = CreateTrigger()
            set t.IntEx = this
            set .src = A
            set .data = Data
            set .Pri = EXExecuteScript("(require'jass.slk').unit[" + I2S(GetUnitTypeId(A)) + "].Primary")
            set .Skillcode =  EXExecuteScript("(require'jass.slk').unit[" + I2S(GetUnitTypeId(A)) + "].heroAbilList") + EXExecuteScript("(require'jass.slk').unit[" + I2S(GetUnitTypeId(A)) + "].abilList")
            set .Skillcode = JNStringReplace(.Skillcode,",","")
            call t.Start(1,true,function thistype.Action)
        endmethod
    endstruct
endscope