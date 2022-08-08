scope GameOn initializer main
    // 초기화부
    // 난이도 선택.
    // 영웅선택 구동부
    globals
        private trigger Trig
        integer GameLevel = 0
        private HeroChoice array A 
    endglobals


    private function onLevel takes nothing returns nothing
        local window log = GetClickedWindow()
        local integer btn = GetClickedWindowButton()
        local trigger t = CreateTrigger()

        local integer i = 0
        if btn == 0 then
            call DestroyWindow(log)
            call TriggerSleepAction(0)
            call GameOn_main2.execute()
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
            set A[i] = HeroChoice.start(Player(i))
            set i = i + 1
        endloop
        set HeroChoice.getClock() = CreateClock()
        call ClockDisplay(HeroChoice.getClock(),true)
        call ClockStart(HeroChoice.getClock(),60,false,null)
        call TriggerRegisterClockExpireEvent(t,HeroChoice.getClock())
        call TriggerAddAction(t,function GameStart_main)
        //set MainWave = Addon_Wave.Init(90,150)
    endfunction


    public function main2 takes nothing returns nothing
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
    
    private function main takes nothing returns nothing
        set Trig = CreateTrigger()
        call TriggerRegisterPlayerChatEvent(Trig,Player(0),"-난이도",false)
        call TriggerAddAction(Trig,function main2)
        call FogEnable(false)
        call FogMaskEnable(false)

        set bj_lastCreatedQuest = CreateQuest()
        call QuestSetTitle(bj_lastCreatedQuest,"개요")
        call QuestSetDescription(bj_lastCreatedQuest, "제작자 - Stormageddon/김형태|n과연 완성될까?")
        call QuestSetIconPath(bj_lastCreatedQuest, "ReplaceableTextures\\CommandButtons\\BTNAmbush.blp")
        call QuestSetRequired(bj_lastCreatedQuest, true)
        call QuestSetDiscovered(bj_lastCreatedQuest, true)
        call QuestSetCompleted(bj_lastCreatedQuest, false)
    endfunction 
endscope