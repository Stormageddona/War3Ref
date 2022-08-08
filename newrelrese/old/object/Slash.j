scope SlashLib

    globals
        private hashtable H = InitHashtable()
    endglobals
    
    private struct tick
        integer Ex
        integer A
        //! runtextmacro Tick()
    endstruct

    struct Slash
        private unit src
        private string kage 
        private real kagesize
        private integer efxroll
        private real Area
        private real Dur
        private real Speed
        private real DMG
        private real StDUR
        private group G
        private real Coe
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
            local real R = .Speed*.Coe
            local effect EFX
            if IsTerrainPathable(GetUnitX(.src)+Polar.X(R,.An),GetUnitY(.src)+Polar.Y(R,.An),PATHING_TYPE_WALKABILITY) then
                call SetUnitPathing(.src,true)
            endif
            set .efxroll = .efxroll + 1
            if .kage != null and .efxroll == 2 then
                set EFX = AddSpecialEffect(.kage,GetUnitX(.src),GetUnitY(.src))
                call EXSetEffectSize(EFX,.kagesize)
                call DestroyEffect(EFX)
                set .efxroll = 0
            endif
            
            call PolarAngle.UTA(.src,R,.An)
            call SetUnitPathing(.src,false)
            call SaveInteger(H,0,IndexUnit(.src),this)
            call splash.range(splash.ENEMY,.src,GetUnitX(.src),GetUnitY(.src),.Area,function thistype.SP)
            set t.A = t.A + 1
            if .Dur < t.A then
                call t.Destroy()
                call SetUnitPathing(.src,true)
                set .src = null
                set .kage = null
                set .kagesize = 0
                set .Area = 0
                set .Dur = 0
                set .Speed = 0
                set .An = 0
                set .DMG = 0
                set .StDUR = 0
                set .Coe = 0
                call DestroyGroup(.G)
                set .G = null
                call thistype.deallocate(this)
            endif

        endmethod
        
        
        static method Create takes unit u,real eX,real eY, real area, real dmg, real stundur, real movecoe, real dur, string shadow, real shadowSize returns thistype
            local thistype this = thistype.allocate()
            local tick t = tick.Create()
            set t.A = 0
            set .src = u
            set t.Ex = this
            set .kage = shadow
            set .kagesize = shadowSize
            set .An = Angle.WBP(.src,eX,eY)
            set .efxroll = 0
           // set .X = eX
           // set .Y = eY
            set .DMG = dmg
            set .Area = area
            set .Coe = movecoe
            set .Dur = dur*32
            set .StDUR = stundur
            set .Speed = GetUnitMoveSpeed(u)/32
            set .G = CreateGroup()
            
            call t.Start(0.03125,true,function thistype.Action)
            return this
        endmethod
        
    endstruct
    
endscope
