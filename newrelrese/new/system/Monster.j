scope Monster
    struct Monster extends UnitStatus
        
        private static hashtable H = InitHashtable()
        /*
        unit src
        real HP
        real MP
        real Damage
        real Armorsrc
        real Vamp
        real Shield*/
        
        
        private static method Destroy takes nothing returns boolean
            local thistype this = LoadInteger(H,GetHandleId(GetTriggeringTrigger()),0)
            set .src = null
            call DestroyTrigger(GetTriggeringTrigger())
            call thistype.deallocate(this)
            return false
        endmethod
        
        static method create takes player PL,integer Code, real GetX, real GetY, real getSheld returns thistype
            local thistype this = thistype.allocate()
            local trigger t = CreateTrigger()
            call SaveInteger(H,GetHandleId(t),0,this)
            set .src = CreateUnit(PL,Code,GetX,GetY,270)
            set .HP = JNGetUnitMaxHP(.src) + (JNGetUnitMaxHP(.src) * (Public_GameLevel*GetRandomReal(0,0.55)))
            set .Damage = JNGetUnitBaseDamage(.src,1) + ((JNGetUnitBaseDamage(.src,1) * (R2I(Public_GameLevel)*GetRandomInt(0,25)))/100)
            call TriggerRegisterUnitEvent(t,.src,EVENT_UNIT_DEATH)
            call TriggerAddCondition(t,Filter(function thistype.Destroy))
            set t = null
            set .Shield = getSheld + (getSheld * (Public_GameLevel*GetRandomReal(0,0.55)))
            call JNSetUnitMaxHP(.src,.HP)
            call JNSetUnitHP(.src,.HP)
            call JNSetUnitBaseDamage(.src,.Damage,1)
            return this
        endmethod
        

        
    endstruct
endscope