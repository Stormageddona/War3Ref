scope LevelSelected

    private function Action takes nothing returns nothing
        call GameStart_main.execute()
        call DestroyTrigger(GetTriggeringTrigger())
    endfunction

    private function onLevel takes nothing returns nothing
        local window log = GetClickedWindow()
        local integer btn = GetClickedWindowButton()
        local trigger t = CreateTrigger()
        local integer i = 0
        if btn == 0 then
            call DestroyWindow(log)
            call LevelSelected_main.execute()
            return
        elseif btn == 1 then
            call Msg("봄 난이도를 고르셨습니다.",GetLocalPlayer())
        elseif btn == 2 then
            call Msg("여름 난이도를 고르셨습니다.",GetLocalPlayer())
        elseif btn == 3 then
            call Msg("가을 난이도를 고르셨습니다.",GetLocalPlayer())
        elseif btn == 4 then
            call Msg("겨울 난이도를 고르셨습니다.",GetLocalPlayer())
        endif
        set GameLevel = btn
        loop
            exitwhen i == playerVJ.getMax()
            call HeroChoice.start(Player(i))
            set i = i + 1
        endloop
        set HeroChoice.C = CreateClock()
        call ClockDisplay(HeroChoice.getClock(),true)
        call ClockStart(HeroChoice.getClock(),60,false,null)
        call TriggerRegisterClockExpireEvent(t,HeroChoice.getClock())
        call TriggerAddAction(t,function Action)
        //set MainWave = Addon_Wave.Init(90,150)
    endfunction


    public function main takes nothing returns nothing
        local window log = CreateWindow()
        call WindowSetMessage(log,"난이도 선택")
        call WindowAddButton(log,0,"무지성 엔터 방지용")
        call WindowAddButton(log,1,"봄")
        call WindowAddButton(log,2,"여름")
        call WindowAddButton(log,3,"가을")
        call WindowAddButton(log,4,"겨울")
        call WindowSetCallback(log,function onLevel)
        call WindowDisplay(log,Player(0),true)
    
    endfunction
endscope