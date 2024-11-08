--키라판은 갓겜이다
Kirafan7={}

--메인 캐릭터 유틸
function Kirafan7.BossCharacter(c)
	c:EnableCounterPermit(0xc03)
	Kirafan7.DuelStartMainCharacter(c)
	Kirafan7.SkipBossCharacter(c)
	Kirafan7.BossCharacterEff(c)
end

--듀얼 개시시의 효과
function Kirafan7.DuelStartMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_DRAW)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCountLimit(1)
	e1:SetOperation(Kirafan7.DuelStartop)
	c:RegisterEffect(e1)
end
function Kirafan7.DuelStartop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if Duel.GetTurnPlayer()~=tp then
	local main2=Duel.GetMatchingGroup(nil,tp,0,LOCATION_EMZONE,nil):GetFirst()
	local e1=Effect.CreateEffect(main2)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(2)
	main2:RegisterEffect(e1)
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	Duel.SendtoDeck(main,nil,-2,REASON_RULE)
	Duel.SpecialSummon(c,0,tp,tp,true,true,POS_FACEUP_ATTACK)
	shuffle=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDeck(shuffle,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	local sg2=Duel.GetFieldGroup(tp,LOCATION_EXTRA,0)
	Duel.SendtoDeck(sg2,nil,-2,REASON_RULE)
	--난이도 설정
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(10041001,2))
	local opt=Duel.SelectOption(1-tp,aux.Stringid(10041001,4),aux.Stringid(10041001,6),aux.Stringid(10041001,8),(aux.Stringid(10041001,10)))
	if opt==0 then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetValue(0xd01)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
	Kirafan8.difficulthint1(e,tp,eg,ep,ev,re,r,rp)
	elseif opt==1 then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetValue(0xd02)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
	Kirafan8.difficulthint2(e,tp,eg,ep,ev,re,r,rp)
	elseif opt==2 then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetValue(0xd03)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
	Kirafan8.difficulthint3(e,tp,eg,ep,ev,re,r,rp)
	else
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetValue(0xd04)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
	Kirafan8.difficulthint4(e,tp,eg,ep,ev,re,r,rp) end	
	else Duel.SendtoDeck(c,nil,-2,REASON_RULE) end
end

--1배틀로 직행,2배틀 페이즈 강제 소환
function Kirafan7.SkipBossCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_DRAW)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(Kirafan7.DuelSkipcon)
	e1:SetOperation(Kirafan7.DuelSkipop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetRange(LOCATION_EMZONE)
	e2:SetCondition(Kirafan7.nocreamatecon)
	e2:SetOperation(Kirafan7.nocreamateop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_EMZONE)
	e3:SetCode(EVENT_ADJUST)
	e3:SetOperation(Kirafan7.Bossexcon)
	e3:SetOperation(Kirafan7.Bossexop)
	c:RegisterEffect(e3)
end
function Kirafan7.DuelSkipcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function Kirafan7.DuelSkipop(e,tp,eg,ep,ev,re,r,rp)	
	local main=Duel.GetMatchingGroup(nil,tp,0,LOCATION_EMZONE,nil):GetFirst()
	if main:GetDefense()<=9 then
	local e1=Effect.CreateEffect(main)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(1)
	main:RegisterEffect(e1)	end
	
	Duel.SkipPhase(tp,PHASE_DRAW,RESET_PHASE+PHASE_END,0)
	Duel.SkipPhase(tp,PHASE_STANDBY,RESET_PHASE+PHASE_END,0)
	Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,0)
end
function Kirafan7.nocreamatecon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsBattlePhase() and Duel.GetTurnPlayer()==tp
	and Duel.GetMatchingGroupCount(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)==0
end
function Kirafan7.nocreamateop(e,tp,eg,ep,ev,re,r,rp)	
	if Duel.GetMatchingGroupCount(Kirafan7.stcallfilter,1-tp,LOCATION_HAND,0,nil)==0 then
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(10041001,11))
	Duel.SetLP(1-tp,0)
	else
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
	local summon=Duel.SelectMatchingCard(1-tp,Kirafan7.stcallfilter,1-tp,LOCATION_HAND,0,1,1,nil,e,tp)
	Duel.SpecialSummon(summon,0,1-tp,1-tp,false,false,POS_FACEUP_ATTACK) end
end
function Kirafan7.stcallfilter(c,e,tp)
	return c:IsRace(RACE_WARRIOR|RACE_SPELLCASTER|RACE_FAIRY)
end
function Kirafan7.Bossexcon(e,tp,eg,ep,ev,re,r,rp)
	local extra=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_EXTRA,0,nil)
	return extra>0
end
function Kirafan7.Bossexop(e,tp,eg,ep,ev,re,r,rp,chk)
	local extra=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_EXTRA,0,nil)
	Duel.SendtoDeck(extra,nil,-2,REASON_RULE)
end



function Kirafan7.BossCharacterEff(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DRAW_COUNT)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetTargetRange(1,0)
	e1:SetValue(0)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_EMZONE)
	e2:SetCode(EVENT_ADJUST)
	e2:SetCondition(Kirafan.Refreshcon)
	e2:SetOperation(Kirafan.Refreshop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_MUST_ATTACK)
	e3:SetCondition(Kirafan.aatcon2)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_EMZONE)
	e4:SetCondition(Kirafan.lifecon)
	e4:SetOperation(Kirafan.lifeop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCondition(Kirafan.lifecon2)
	e5:SetOperation(Kirafan.lifeop2)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_CANNOT_ACTIVATE)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetRange(LOCATION_EMZONE)
	e6:SetTargetRange(1,0)
	e6:SetValue(Kirafan7.dottelimit)
	c:RegisterEffect(e6)
end
function Kirafan7.dottelimit(e,re,tp)
	return re:GetHandler():IsLocation(LOCATION_GRAVE)
end
