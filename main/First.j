scope GameOn initializer main
    // 초기화부
    // 난이도 선택.
    // 영웅선택 구동부
    globals
        private trigger Trig
        private HeroChoice array A 
    endglobals

    private function Action takes nothing returns nothing
        call LevelSelected_main.execute()
        call DestroyTrigger(GetTriggeringTrigger())
    endfunction
    
    private function main takes nothing returns nothing
        set Trig = CreateTrigger()
        call TriggerRegisterPlayerChatEvent(Trig,Player(0),"-난이도",false)
        call TriggerAddAction(Trig,function Action)
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