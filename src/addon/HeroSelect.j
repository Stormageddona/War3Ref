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

    static method getClock takes nothing returns clock
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
        elseif GetSpellAbilityId() == 'Che2' then
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