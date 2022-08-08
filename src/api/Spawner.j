scope Spawn

    private struct tick
        integer number
        integer data
        //! runtextmacro Tick()
    endstruct

    struct Spawner
        private tick T
        private integer I
        private real X
        private real Y
        private real XX
        private real YY
        private integer D
        
        private static boolean stop = false
      
        method setStop takes boolean bol returns nothing
            set stop = bol
        endmethod
        
        static method Action takes nothing returns nothing
            local thistype this = tick.GetExpired().number
            if stop == true then
                return
            endif
            if this.XX == 0 and this.YY == 0 then
                call CreateUnit(Player(11),this.I,this.X,this.Y,270)
            else
                call IssuePointOrder(CreateUnit(Player(11),this.I,this.X,this.Y,270),"attack",this.XX,this.YY)
            endif
            set this.T.data = this.T.data + 1
            if this.T.data == this.D then
                call this.T.Destroy()
                call this.deallocate()
            endif
        endmethod
        
        static method Create takes integer unitcode , real getX, real getY, real getXX, real getYY, integer count, real spawn returns unit
            local thistype this
            if count == 1 then
                if getXX == 0 and getYY == 0 then
                    set bj_lastCreatedUnit = CreateUnit(Player(11),unitcode,getX,getY,270)
                else
                    set bj_lastCreatedUnit = CreateUnit(Player(11),unitcode,getX,getY,270)
                    call IssuePointOrder(bj_lastCreatedUnit,"attack",getXX,getYY)
                endif
                return bj_lastCreatedUnit
            endif
            set this = thistype.allocate()
            set this.T = tick.Create()
            set this.T.number = this
            set this.I = unitcode
            set this.X = getX
            set this.Y = getY
            set this.XX = getXX
            set this.YY = getYY
            set this.D = count
            set this.T.data = 0
            call this.T.Start(spawn,true,function thistype.Action)
            return null
        endmethod
    endstruct
endscope