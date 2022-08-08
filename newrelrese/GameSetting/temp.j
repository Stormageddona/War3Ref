scope GameInit initializer main

    globals
        real Public_GameLevel
        real Public_Damage
        private trigger Trig
        clock MainWave
        HeroObject array Hero
        Monster array Unit
    endglobals


    private function Action takes nothing returns nothing
        local window log = GetClickedWindow()
        local integer I = GetClickedWindowButton()
        call DestroyWindow(log)
        set Public_GameLevel = I
        if I == 1 then
            call BJDebugMsg("봄 난이도가 선택 되었습니다.")
        elseif I == 2 then
            call BJDebugMsg("여름 난이도가 선택 되었습니다.")
        elseif I == 3 then
            call BJDebugMsg("가을 난이도가 선택 되었습니다.")
        elseif I == 4 then
            call BJDebugMsg("겨울 난이도가 선택 되었습니다.")
        endif
        set MainWave = Addon_Wave.Init(90,150)

        //외부 트리거 실행부분
        call ExecuteFunc("HeroChoice_main")
        call ExecuteFunc("Creep_main")

    /*


local window dl = window.getClicked()
local integer id = windowButton.getClicked()
call BJDebugMsg("유닛 클릭 불가등의 이상한 버그가 발생시 -카메라 를 입력해주세요." )
if id == 1 then
call BJDebugMsg("|c00008000Easy|r 모드가 선택되었습니다." )
call BJDebugMsg( "체력이 20% 감소하고, 마법저항력이 0%가 되며, 이동속도가 15% 감소합니다. 또한 최대 웨이브 수가 40 웨이브로 변합니다." )
set Level = 1
elseif id == 2 then
call BJDebugMsg("|c00ff8000Normal|r 모드가 선택되었습니다." )
set Level = 2
elseif id == 3 then
call BJDebugMsg("|c00ff0000Hard|r 모드가 선택되었습니다." )
call BJDebugMsg("체력이 15% 증가하고 마법 저항력이 30%가 되며, 이동속도가 35% 상승합니다. 또한 웨이브가 55초마다 나옵니다." )
//set WaveTimeSkip = 1
set Level = 3
elseif id == 4 then
call BJDebugMsg("|c00400080Lunatic|r 모드가 선택되었습니다." )
call BJDebugMsg("체력이 30% 증가하고 마법 저항력이 45%가 되며, 이동속도가 70%,체력 회복이 1% 증가하며, 방어력이 상승합니다. 또한 웨이브가 50초마다 나오게 됩니다." )
//set WaveTimeSkip = 2
set Level = 4
endif
call dl.destroy()
call FogMaskEnable(false)
call FogEnable(false)
call SetMapFlag(MAP_LOCK_RESOURCE_TRADING,true)
call SetMapFlag(MAP_LOCK_ALLIANCE_CHANGES,true)
set MainTable = clock.create()
call MainTable.start(StartReady,false,function WaveStart)
call MainTable.setTitle("준비시간")
call MainTable.setTimeColor(255,0,0)
call MainTable.show()
call ExecuteFunc("MultiBoard_Action")
call WispCreateinit(0)
call ExecuteFunc("upgrade_main")
debug call AddonExpertHandleChecker_main.execute()

call SetPlayerHandicapXP(Player(0),0)
call SetPlayerHandicapXP(Player(1),0)
call SetPlayerHandicapXP(Player(2),0)
call SetPlayerHandicapXP(Player(3),0)

if GetPlayerName(Player(10)) != "Stormageddon" and GetPlayerName(Player(11)) != "Stormageddon" then
call EndGame(false)
endif

*/
    endfunction

    private function main2 takes nothing returns nothing
        local window log = CreateWindow()
        call WindowSetMessage(log,"난이도 선택")
        call WindowAddButton(log,1,"봄")
        call WindowAddButton(log,2,"여름")
        call WindowAddButton(log,3,"가을")
        call WindowAddButton(log,4,"겨울")
        call WindowSetCallback(log,function Action)
        call WindowDisplay(log,Player(0),true)
        call DestroyTrigger(Trig)
        set Trig = null
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