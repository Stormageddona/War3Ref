scope HeroObject
    struct tick
        integer ExInt
        //! runtextmacro Tick()
    endstruct
    struct HeroObject extends UnitObject
        integer Str
        integer Agi
        integer Int
        integer OriginStr
        integer OriginAgi
        integer OriginInt
        integer TotalStr
        integer TotalAgi
        integer TotalInt
        integer Mind
        real Cool
        real TotalHP
        real TotalMP
        real OriginHP
        real OriginMP
        
        method AddStr takes unit u, integer stat returns nothing
            set this.OriginStr = this.OriginStr + stat
        endmethod
        method AddAgi takes unit u, integer stat returns nothing
            set this.OriginAgi = this.OriginAgi + stat
        endmethod
        method AddInt takes unit u, integer stat returns nothing
            set this.OriginInt = this.OriginInt + stat
        endmethod
        static method Action takes nothing returns nothing
            local tick t = tick.GetExpired()
            local thistype this = t.ExInt
            local integer var = 0
            local real varr = 0
            set var = GetHeroStr(.Src,false) - .TotalStr
            set .OriginStr = .OriginStr + var
            set .TotalStr = R2I(OriginStr * (I2R(.Mind)/100))
            call SetHeroStr(.Src,.TotalStr,false)
            set .Str = GetHeroStr(.Src,true)
            
            set var = GetHeroAgi(.Src,false) - .TotalAgi
            set .OriginAgi = .OriginAgi + var
            set .TotalAgi = R2I(OriginAgi * (I2R(.Mind)/100))
            call SetHeroAgi(.Src,.TotalAgi,false)
            set .Agi = GetHeroAgi(.Src,true)
            
            set var = GetHeroInt(.Src,false) - .TotalInt
            set .OriginInt = .OriginInt + var
            set .TotalInt = R2I(OriginInt * (I2R(.Mind)/100))
            call SetHeroInt(.Src,.TotalInt,false)
            set .Int = GetHeroInt(.Src,true)
            
            set varr = JNGetUnitMaxHP(.Src) - .TotalHP
            set .OriginHP = .OriginHP + varr
            set .TotalHP = OriginHP * (I2R(.Mind)/100)
            call JNSetUnitMaxHP(.Src,.TotalHP)
            set .HP = JNGetUnitMaxHP(.Src)
            
            set varr = JNGetUnitMaxMana(.Src) - .TotalMP
            set .OriginMP = .OriginMP + varr
            set .TotalMP = OriginMP * (I2R(.Mind)/100)
            call JNSetUnitMaxMana(.Src,.TotalMP)
            set .MP = JNGetUnitMaxMana(.Src)
            if .Armor >= 80 then
                call JNSetUnitArmor(.Src,80)            
            elseif .Armor <= -200 then
                call JNSetUnitArmor(.Src,-200)    
            else
                call JNSetUnitArmor(.Src,.Armor)   
            endif
        endmethod
        
        static method Create takes unit u returns thistype
            local thistype this = thistype.allocate()
            local string St
            local string S1
            local tick t = tick.Create()
            set t.ExInt = this
            set .Src = u
            set .OriginStr = GetHeroStr(.Src,false)
            set .OriginAgi = GetHeroAgi(.Src,false)
            set .OriginInt = GetHeroInt(.Src,false)
            set .TotalStr = GetHeroStr(.Src,false)
            set .TotalAgi = GetHeroAgi(.Src,false)
            set .TotalInt = GetHeroInt(.Src,false)
            set .Mind = 100
            set .Damage = 0
            set .Armor = 0
            set .Vamp = 0
            set .Shield = 0
            set .Cool = 0
            set .TotalHP = JNGetUnitMaxHP(.Src)
            set .TotalMP = JNGetUnitMaxMana(.Src)            
            set .OriginHP = JNGetUnitMaxHP(.Src)
            set .OriginMP = JNGetUnitMaxMana(.Src)
            call UnitAbility.Create(u)
            
            call t.Start(0.03125,true,function thistype.Action)
            return this
        endmethod
            
        
        
    endstruct
    
endscope