//! import ""
//! import ""
//! import ""
//! import ""
//! import ""

library commonfunction
    globals

    endglobals

    function Msg takes string s, player p returns nothing
        call DisplayTimedTextToPlayer(p,0,0,5,s)
    endfunction

    //더미 생성 함수
    function dummy takes unit caster, unit targetXY, integer abilityId, integer level, real realTime returns unit
        local real Time
        if realTime == 0 then
            set Time = 2
        else
            set Time = realTime
        endif
        set bj_lastCreatedUnit = CreateUnit(GetOwningPlayer(caster), 'dumy' , GetUnitX(targetXY),GetUnitY(targetXY),GetUnitFacing(caster))
        call UnitApplyTimedLife(bj_lastCreatedUnit,'BTLF',Time)
        call UnitAddAbility(bj_lastCreatedUnit,abilityId)
        call SetUnitAbilityLevel(bj_lastCreatedUnit,abilityId,level)
        set Time = 0
        return bj_lastCreatedUnit
    endfunction

    scope LDMG
        globals
            private real array DMG
        endglobals

        function DamageUnit takes unit u, unit target, real damage returns nothing
            local real DMG = damage
            call UnitDamageTarget(u,target,DMG,true,true,ATTACK_TYPE_MAGIC,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
        endfunction
        
        private function DRA takes nothing returns nothing
            local real damage = DMG[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]
            call DamageUnit(GetTriggerUnit(),GetEnumUnit(),damage)
            //call UnitDamageTarget(GetTriggerUnit(),GetEnumUnit(),damage,true,true,ATTACK_TYPE_HERO,DAMAGE_TYPE_UNIVERSAL,WEAPON_TYPE_WHOKNOWS)
        endfunction

        function DamageRange takes unit u, real damage, real X, real Y, real rng returns nothing
            set DMG[GetPlayerId(GetOwningPlayer(u))] = damage
            call SplashRange(splash.ENEMY,u,X,Y,rng,function DRA)
            set DMG[GetPlayerId(GetOwningPlayer(u))] = 0
        endfunction

        function ObjRcall takes integer abilityid, string abilitycode, integer level returns real
                return S2R(EXExecuteScript("(require'jass.slk').ability[" + I2S(abilityid)+"]."+abilitycode+I2S(level)))
        endfunction

        // function UseSlash takes unit Unit,real GetX,real GetY, real area, real DMG, real StunDur, real MoveCoe, real Dur, string EFFECT, real EFFECTSIZE returns nothing
        //     call Slash.Create( Unit, GetX, GetY,  area,  DMG,  StunDur,  MoveCoe,  Dur,  EFFECT, EFFECTSIZE)
        // endfunction

        // function UseWave takes unit Unit, string shadow, real shadowSize,real GetX,real GetY, real area, real dmg, real stundur, real spd, real dur returns nothing
        //     call wave.Create( Unit, shadow, shadowSize,  GetX,  GetY,  area,  dmg,  stundur, spd, dur)
        // endfunction

        function E2S takes unit u, integer i, string s returns string
            return EXExecuteScript("(require'jass.slk').ability[" + I2S(i)+"]."+s+I2S(GetUnitAbilityLevel(u,i)))
        endfunction
    endscope



    struct GlobalsTick
        integer int
        integer Exint
        //! runtextmacro Tick()
    endstruct

endlibrary