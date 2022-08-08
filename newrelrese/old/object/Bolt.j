scope BoltLib
    
    globals
        private hashtable H = InitHashtable()
    endglobals
    
    private struct tick
        integer Ex
        integer A

        //! runtextmacro Tick()
    endstruct

    struct bolt
        private unit src
        private effect kage 
        private real Area
        private real Dur
        private real Speed
        private real DMG
        private real StDUR
        private group G
        private real An
        
        private static method SP takes nothing returns nothing
            local thistype this = LoadInteger(H,0,IndexUnit(splash.source))
            call SetUnitPathing(.src,false)
            if IsUnitInGroup(GetEnumUnit(),.G) then
                return
            endif
            call GroupAddUnit(.G,GetEnumUnit())
            if not (.StDUR == 0 ) then
                call CustomStun.Stun(GetEnumUnit(),.StDUR)
            endif
            call DamageUnit(.src,GetEnumUnit(),.DMG)
        endmethod
        
        private static method Action takes nothing returns nothing
            local tick t = tick.GetExpired()
            local thistype this = t.Ex
            local integer loopa = 0
            local real R = .Speed/32
            call EXSetEffectXY(.kage,EXGetEffectX(.kage)+ R * Cos(.An * bj_DEGTORAD),EXGetEffectY(.kage)+ R * Sin(.An * bj_DEGTORAD))
            call SaveInteger(H,0,IndexUnit(.src),this)
            call splash.range(splash.ENEMY,.src,EXGetEffectX(.kage),EXGetEffectY(.kage),.Area,function thistype.SP)
            set t.A = t.A + 1
            if .Dur < t.A then
                call t.Destroy()
                call DestroyEffect(.kage)
                set .src = null
                set .kage = null

                set .Area = 0
                set .Dur = 0
                set .Speed = 0
                set .An = 0
                set .DMG = 0
                set .StDUR = 0
                call DestroyGroup(.G)
                set .G = null
                call thistype.deallocate(this)
            endif

        endmethod
        
        
        static method Create takes unit u, string shadow, real shadowSize,real eX,real eY, real area, real dmg, real stundur, real spd, real dur returns thistype
            local thistype this = thistype.allocate()
            local tick t = tick.Create()
            set t.A = 0
            set .src = u
            set t.Ex = this
            set .An = Angle.WBP(.src,eX,eY)
            set .kage = AddSpecialEffect(shadow,GetUnitX(u),GetUnitY(u))
            call EXSetEffectSize(.kage,shadowSize)
            call EXEffectMatRotateZ(.kage,.An)
            set .DMG = dmg
            set .Area = area
            set .Dur = dur*32
            set .StDUR = stundur
            set .Speed = spd
            
            call SetUnitPathing(.src,false)
            set .G = CreateGroup()
            
            call t.Start(0.03125,true,function thistype.Action)
            return this
        endmethod
        
    endstruct
    
    
    
endscope
