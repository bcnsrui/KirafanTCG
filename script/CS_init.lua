LOCATION_EMZONE = 0x1000

function Duel.IsMainPhase()
	local phase=Duel.GetCurrentPhase()
	return phase==PHASE_MAIN1 or phase==PHASE_MAIN2
end

function Duel.IsBattlePhase()
	local phase=Duel.GetCurrentPhase()
	return phase>=PHASE_BATTLE_START and phase<=PHASE_BATTLE
end

--Kirafan TCG Utility
Duel.LoadScript("KirafanMainCharacter.lua")
Duel.LoadScript("KirafanCreamate.lua")
Duel.LoadScript("KirafanSupportCreamate.lua")
Duel.LoadScript("KirafanAlcheCreamate.lua")
Duel.LoadScript("KirafanKnightCreamate.lua")
Duel.LoadScript("KirafanBattleCreamate.lua")
Duel.LoadScript("KirafanBossCharacter.lua")
Duel.LoadScript("KirafanBossRule.lua")