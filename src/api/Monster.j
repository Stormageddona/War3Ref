struct Monster
    static MonsterData Main 
    static MonsterData Sub
    static MonsterData Creep

    static method addMonster takes string str, integer Code returns nothing
        if str == "Main" then
            set Main.addCode(Code)
        elseif str == "Sub" then
            set Sub.addCode(Code)
        elseif str == "Creep" then
            set Creep.addCode(Code)
        endif
    endmethod

    static method onInit takes nothing returns nothing
        set Main = MonsterData.create()
        set Sub = MonsterData.create()
        set Creep = MonsterData.create()
    endmethod
endstruct



struct MonsterData
    private integer array Code
    private integer index
    
    method getCode takes integer number returns integer
        return .Code[number]
    endmethod
    
    static method getList takes nothing returns integer
        return .index
    endmethod

    static method addCode takes integer i returns nothing
        set .Code[.index] = i
        set .index = .index + 1
    endmethod
endstruct