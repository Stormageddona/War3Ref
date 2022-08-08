scope Shana 

    private scope Yogasa
        
        public function condition takes nothing returns boolean
            return GetSpellAbilityId() == 'Hsh0'
        endfunction
    
    
        public function Action takes nothing returns nothing
            local real R = GetHeroLevel(GetTriggerUnit())*GetHeroAgi(GetTriggerUnit(),true)*20
            call SetUnitMoveSpeed(GetTriggerUnit(),GetUnitMoveSpeed(GetTriggerUnit())+200)
            set Hero[IndexUnit(GetTriggerUnit())].Damage = Hero[IndexUnit(GetTriggerUnit())].Damage + 40
            set Hero[IndexUnit(GetTriggerUnit())].Armor = Hero[IndexUnit(GetTriggerUnit())].Armor + 20
            set Hero[IndexUnit(GetTriggerUnit())].Shield= Hero[IndexUnit(GetTriggerUnit())].Shield + R
            
            call TriggerSleepActionByTimer(S2R(E2S(GetTriggerUnit(),'Hsh0',"Area")))
            
            call SetUnitMoveSpeed(GetTriggerUnit(),GetUnitMoveSpeed(GetTriggerUnit())-200)
            set Hero[IndexUnit(GetTriggerUnit())].Damage = Hero[IndexUnit(GetTriggerUnit())].Damage - 40
            set Hero[IndexUnit(GetTriggerUnit())].Armor= Hero[IndexUnit(GetTriggerUnit())].Armor - 20        
            set Hero[IndexUnit(GetTriggerUnit())].Shield = Hero[IndexUnit(GetTriggerUnit())].Shield - R
        endfunction
    
    endscope
    
    
    private scope Urusai
        public function condition takes nothing returns boolean
            return GetSpellAbilityId() == 'Hsh1'
        endfunction
        
        public function SPC takes nothing returns nothing
            local real R = GetHeroAgi(GetTriggerUnit(),true)*S2R(EXExecuteScript("(require'jass.slk').ability[" + I2S('Hsh1')+"].DataA"+I2S(GetUnitAbilityLevel(GetTriggerUnit(),'Hsh1'))))
            local real R2 = S2R(EXExecuteScript("(require'jass.slk').ability[" + I2S('Hsh1')+"].Dur"+I2S(GetUnitAbilityLevel(GetTriggerUnit(),'Hsh1'))))
            call CustomStun.Stun(GetEnumUnit(),R2)
            call DamageUnit(GetTriggerUnit(),GetEnumUnit(),R)
        endfunction

        public function Action takes nothing returns nothing
            local real R2 = GetHeroAgi(GetTriggerUnit(),true)*S2R(EXExecuteScript("(require'jass.slk').ability[" + I2S('Hsh1')+"].DataA"+I2S(GetUnitAbilityLevel(GetTriggerUnit(),'Hsh1'))))
            local real R = S2R(EXExecuteScript("(require'jass.slk').ability[" + I2S('Hsh1')+"].Area1"))
            local unit A = dummy(GetTriggerUnit(),GetTriggerUnit(),'Stp1',1,3)
            local effect E
            call JNSetUnitAbilityAreaOfEffect(A,'Stp1',1,R)
            call SetUnitX(A,GetUnitX(GetTriggerUnit()))
            call SetUnitY(A,GetUnitY(GetTriggerUnit()))
            call IssueImmediateOrder(A,"stomp")
            call splash.range(splash.ENEMY,GetTriggerUnit(),GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),R,function SPC)
            set E = AddSpecialEffectTarget("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl",GetTriggerUnit(),"origin")
            call EXSetEffectSize(E,1.5)
            call TriggerSleepActionByTimer(0.45)
            call DestroyEffect(E)
            call JNSetUnitAbilityAreaOfEffect(A,'Stp1',1,R+50)
            call SetUnitX(A,GetUnitX(GetTriggerUnit()))
            call SetUnitY(A,GetUnitY(GetTriggerUnit()))
            call IssueImmediateOrder(A,"stomp")
            call splash.range(splash.ENEMY,GetTriggerUnit(),GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),R+100,function SPC)
            set E = AddSpecialEffectTarget("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl",GetTriggerUnit(),"origin")
            call EXSetEffectSize(E,1.5)
            call TriggerSleepActionByTimer(0.45)
            call DestroyEffect(E)
            call JNSetUnitAbilityAreaOfEffect(A,'Stp1',1,R+125)
            call SetUnitX(A,GetUnitX(GetTriggerUnit()))
            call SetUnitY(A,GetUnitY(GetTriggerUnit()))
            call IssueImmediateOrder(A,"stomp")
            call splash.range(splash.ENEMY,GetTriggerUnit(),GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),R+250,function SPC)
            set E = AddSpecialEffectTarget("Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl",GetTriggerUnit(),"origin")
            call EXSetEffectSize(E,1.5)
            call TriggerSleepActionByTimer(0.45)
            call DestroyEffect(E)
            set E = null
            set A = null
        endfunction

    endscope
    
    private scope Slash
        globals
            private boolean array bool
        endglobals
        public function condition takes nothing returns boolean
            return GetSpellAbilityId() == 'Hsh2'
        endfunction
        
        public function Action takes nothing returns nothing
            local integer I = GetUnitAbilityLevel(GetTriggerUnit(),'Hsh2')
            call UseSlash(GetTriggerUnit(),GetSpellTargetX(),GetSpellTargetY(),ObjRcall('Hsh2',"Area",I),/*
            */GetHeroAgi(GetTriggerUnit(),true)*ObjRcall('Hsh2',"DataA",I),ObjRcall('Hsh2',"Dur",I),ObjRcall('Hsh2',"DataC",I),/*
            */ObjRcall('Hsh2',"DataD",I),"Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl",4)
            if not bool[IndexUnit(GetTriggerUnit())] then
                call JNSetUnitAbilityCooldown(GetTriggerUnit(),'Hsh2',GetUnitAbilityLevel(GetTriggerUnit(),'Hsh2'),1)
                set bool[IndexUnit(GetTriggerUnit())] = true
            else
                set bool[IndexUnit(GetTriggerUnit())] = false
            endif

        endfunction
        
    endscope
    
    private scope Wave
        
        public function Action takes nothing returns nothing
            local integer I = GetUnitAbilityLevel(GetEventDamageSource(),'Hsh3')
            if (ATTACK_TYPE_HERO== JNGetEventAttackType()) and GetRandomInt(1,100) <= ObjRcall('Hsh3',"HeroDur",I) and GetUnitAbilityLevel(GetEventDamageSource(),'Hsh3') != 0 then
                call UseWave(GetEventDamageSource(),"Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl",2.5,GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),ObjRcall('Hsh3',"Area",I),GetHeroAgi(GetEventDamageSource(),true)*ObjRcall('Hsh3',"DataA",I),ObjRcall('Hsh3',"Rng",I),ObjRcall('Hsh3',"Cast",I),ObjRcall('Hsh3',"Dur",I))
            endif
            
        endfunction
        
    endscope
    
    private scope Wing
        
        public function condition takes nothing returns boolean
            return GetSpellAbilityId() == 'Hsh4'
        endfunction
    
        public function Action takes nothing returns nothing
            call EXSetUnitMoveType(GetTriggerUnit(),1)
        endfunction
    endscope
    
    public function main takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t,Condition(function Urusai_condition))
        call TriggerAddAction(t,function Urusai_Action)
        set t = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t,Condition(function Slash_condition))
        call TriggerAddAction(t,function Slash_Action)
        set t = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t,Condition(function Yogasa_condition))
        call TriggerAddAction(t,function Yogasa_Action)
        call DamageEngine.RegisterUnitTypeAttackEvent('Hr01',function Wave_Action)
        set t = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t,Condition(function Wing_condition))
        call TriggerAddAction(t,function Wing_Action)
        set t = null
    endfunction
endscope