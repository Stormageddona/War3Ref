struct HeroChoice
    private trigger t
    private trigger t2
    private unit hero
    private player pL
    private static hashtable H = InitHashtable()
    private static integer index = 0
    private static real saveclock 
    static clock C

    method SelectHero takes nothing returns nothing 
        if this.hero == null then
            call GetRandomInt(1,10)
        endif
    endmethod

    method getClock takes nothing reutns clock
        return C
    endmethod

    private static method selected takes nothing returns boolean
        local thistype this = LoadInteger(H,GetHandleId(GetTriggeringTrigger()),0)
        if GetOwningPlayer(GetTriggerUnit()) == Player(9) and this.hero == null then
            if this.hero != null then
                call SetUnitOwner(hero,Player(9),true)
            endif
            set this.hero = GetTriggerUnit()
            call SetUnitOwner(GetTriggerUnit(),GetTriggerPlayer(),true)
        endif
        return false
    endmethod

    private static method Action takes nothing returns boolean
        local thistype this = LoadInteger(H,GetHandleId(GetTriggeringTrigger()),0)
        if GetSpellAbilityId() == 'Che1' then
            set this.hero = GetTriggerUnit()
            call UnitRemoveAbility(GetTriggerUnit(),'Che1')
            call Msg(GetHeroProperName(GetTriggerUnit())+"을/를 선택 하셨습니다.",GetTriggerPlayer())
            call UnitAddAbility(GetTriggerUnit(),'Che2')
            set index = index + 1
            if index == playerVJ.getMax() then
                call Msg("모두가 영웅을 선택하여 5초후 게임을 시작합니다.",GetLocalPlayer())
                set saveclock = ClockGetRemaining(C)
                call ClockStart(C,5,false,null)
            endif
        else
            set this.hero = null
            call UnitRemoveAbility(GetTriggerUnit(),'Che2')
            call Msg("유닛 선택을 취소하였습니다.",GetTriggerPlayer())
            call UnitAddAbility(GetTriggerUnit(),'Che1')
            if index == playerVJ.getMax() then
                call Msg(GetPlayerName(this.pL) + "님의 영웅선택이 취소되어 선택시간이 복구됩니다.",GetLocalPlayer())
                call ClockStart(C,saveclock,false,null)
            endif
            set index = index - 1
        endif
        return false
    endmethod


    static method start takes player pl returns thistype
        local thistype this = thistype.allocate()
        call Msg("영웅을 선택해주세요. 80초안에 선택하지않을시 랜덤이 선택됩니다.",pl)
        set this.hero = null
        set this.t = CreateTrigger()
        set this.t2 = CreateTrigger()
        set this.pL = pl
        call SaveInteger(H,GetHandleId(this.t),0,this)
        call SaveInteger(H,GetHandleId(this.t2),0,this)
        call TriggerRegisterPlayerUnitEvent(this.t,pl,EVENT_PLAYER_UNIT_SELECTED,null)
        call TriggerAddCondition(this.t,Filter(function thistype.selected))  
        call TriggerRegisterPlayerUnitEvent(this.t2,pl,EVENT_PLAYER_UNIT_SPELL_EFFECT,null)
        call TriggerAddCondition(this.t2,Filter(function thistype.Action))
        return this
    endmethod

    static method callback takes nothing returns nothing
        call SetUnitPropWindow(GetEnumUnit(),0)
        call SetUnitInvulnerable(GetEnumUnit(),true)
        call UnitAddAbility(GetEnumUnit(),'Che1')
    endmethod

    static method onInit takes nothing returns nothing
        call splash.rect(splash.ANY,Player(9),gg_rct_HeroChoice,function thistype.callback)        
    endmethod

endstruct

// scope HeroChoice
    
//     globals
//         private trigger Trig
//         private clock C
//         private triggercondition TrigCon
//         private triggeraction TrigAc
//         private unit array A
//     endglobals


//     private function filter takes nothing returns boolean
//         return GetOwningPlayer(GetTriggerUnit()) == Player(9) and A[GetPlayerId(GetTriggerPlayer())+6] == null
//     endfunction

//     private function filter2 takes nothing returns boolean
//         return GetSpellAbilityId() == 'Che1' or GetSpellAbilityId() == 'Che2'
//     endfunction

//     private function Action takes nothing returns nothing
//         if A[GetPlayerId(GetTriggerPlayer())] != null then
//             call SetUnitOwner(A[GetPlayerId(GetTriggerPlayer())],Player(9),true)
//         endif
//         set A[GetPlayerId(GetTriggerPlayer())] = GetTriggerUnit()
//         call SetUnitOwner(GetTriggerUnit(),GetTriggerPlayer(),true)
//     endfunction
        
//     private function Action2 takes nothing returns nothing
//         if GetSpellAbilityId() == 'Che1' then
//             set A[GetPlayerId(GetTriggerPlayer())+6] = GetTriggerUnit()
//             call UnitRemoveAbility(GetTriggerUnit(),'Che1')
//             call Msg(GetHeroProperName(GetTriggerUnit())+"을/를 선택 하셨습니다.",GetTriggerPlayer())
//             call UnitAddAbility(GetTriggerUnit(),'Che2')
//         else
//             set A[GetPlayerId(GetTriggerPlayer())+6] = null
//             call UnitRemoveAbility(GetTriggerUnit(),'Che2')
//             call Msg("유닛 선택을 취소하였습니다.",GetTriggerPlayer())
//             call UnitAddAbility(GetTriggerUnit(),'Che1')
//         endif
//     endfunction

//     private function callback takes nothing returns nothing
//         call SetUnitPropWindow(GetEnumUnit(),0)
//         call SetUnitInvulnerable(GetEnumUnit(),true)
//         call UnitAddAbility(GetEnumUnit(),'Che1')
//     endfunction

//     private function callback2 takes nothing returns nothing
//         call KillUnit(GetEnumUnit())
//         call RemoveUnit(GetEnumUnit())
//     endfunction

//     private function ClockAction takes nothing returns nothing
//         call TriggerRemoveCondition(Trig,TrigCon)
//         call TriggerRemoveAction(Trig,TrigAc)
//         set TrigCon = null
//         set TrigAc = null
//         call DestroyTrigger(Trig)
//         set Trig = null    
//         call splash.rect(splash.ANY,Player(9),gg_rct_HeroChoice,function callback2)
//         //외부 트리거 실행 부분
//         call ExecuteFunc("WaveSetting_main")
//     endfunction

//     public function main takes nothing returns nothing
//         local trigger t = CreateTrigger()

        
//         call TriggerRegisterPlayerUnitEvent(t,Player(0),EVENT_PLAYER_UNIT_SPELL_EFFECT,null)
//         call TriggerRegisterPlayerUnitEvent(t,Player(1),EVENT_PLAYER_UNIT_SPELL_EFFECT,null)
//         call TriggerRegisterPlayerUnitEvent(t,Player(2),EVENT_PLAYER_UNIT_SPELL_EFFECT,null)
//         call TriggerRegisterPlayerUnitEvent(t,Player(3),EVENT_PLAYER_UNIT_SPELL_EFFECT,null)
//         call TriggerRegisterPlayerUnitEvent(t,Player(4),EVENT_PLAYER_UNIT_SPELL_EFFECT,null)
//         call TriggerRegisterPlayerUnitEvent(t,Player(5),EVENT_PLAYER_UNIT_SPELL_EFFECT,null)
//         call TriggerAddCondition(t,Filter(function filter2))
//         call TriggerAddAction(t,function Action2)
//         set t = null
//         set C = CreateClock()
//         call ClockSetTitle(C,"영웅 선택 시간")
//         call ClockStart(C,10,false,function ClockAction)
//         call ClockDisplay(C,true)
//         set Trig = CreateTrigger()
//         call TriggerRegisterPlayerUnitEvent(Trig,Player(0), EVENT_PLAYER_UNIT_SELECTED, null)
//         call TriggerRegisterPlayerUnitEvent(Trig,Player(1), EVENT_PLAYER_UNIT_SELECTED, null)
//         call TriggerRegisterPlayerUnitEvent(Trig,Player(2), EVENT_PLAYER_UNIT_SELECTED, null)
//         call TriggerRegisterPlayerUnitEvent(Trig,Player(3), EVENT_PLAYER_UNIT_SELECTED, null)
//         call TriggerRegisterPlayerUnitEvent(Trig,Player(4), EVENT_PLAYER_UNIT_SELECTED, null)
//         call TriggerRegisterPlayerUnitEvent(Trig,Player(5), EVENT_PLAYER_UNIT_SELECTED, null)
//         set TrigCon = TriggerAddCondition(Trig,Filter(function filter))
//         set TrigAc = TriggerAddAction(Trig,function Action)
//         call splash.rect(splash.ANY,Player(9),gg_rct_HeroChoice,function callback)        
//     endfunction
// endscope