--키라판은 갓겜이다
Kirafan={}

--메인 캐릭터 유틸
function Kirafan.MainCharacter(c)
	c:EnableCounterPermit(0xc03)
	Kirafan.DuelStartMainCharacter(c)
	Kirafan.DrawStMainCharacter(c)
	Kirafan.TurnPositionMainCharacter(c)
	Kirafan.MainCharacterEff(c)
	Kirafan.MainCharacterSpEff(c)
	Kirafan.RealistTime(c)
	Kirafan.MainCharacterTextEff(c)
end


--듀얼 개시시의 효과
function Kirafan.DuelStartMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCountLimit(1)
	e1:SetOperation(Kirafan.DuelStartop)
	c:RegisterEffect(e1)
end
function Kirafan.battlezonefilter(c)
	return c:IsRace(RACE_WARRIOR|RACE_SPELLCASTER|RACE_FAIRY)
end
function Kirafan.DuelStartop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if Duel.GetMatchingGroupCount(Kirafan.battlezonefilter,tp,LOCATION_DECK+LOCATION_HAND,0,nil)==0
	and not e:GetHandler():IsCode(10050110)
	then Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(10050114,2))
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(10050114,3))
	return Duel.SetLP(tp,0) end
	if Duel.GetMatchingGroupCount(nil,tp,LOCATION_EMZONE,0,nil)>0
	then return Duel.SendtoDeck(e:GetHandler(),nil,-2,REASON_RULE) end
	Duel.SpecialSummon(e:GetHandler(),0,tp,tp,true,true,POS_FACEUP_ATTACK)
	if Duel.GetMatchingGroupCount(nil,tp,LOCATION_EMZONE,0,nil)==0 then
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(10050114,6))
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(10050114,6))
	return Duel.SetLP(tp,0) end
	while Duel.GetMatchingGroupCount(Kirafan.battlezonefilter,tp,LOCATION_HAND,0,nil)==0 
	and not e:GetHandler():IsCode(10050110) do
	shuffle=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDeck(shuffle,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	Duel.ShuffleDeck(tp)
	Duel.Draw(tp,5,REASON_RULE) end
	local fg1=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_HAND,0,nil,RACE_ZOMBIE)
	local fg2=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_HAND,0,nil,RACE_FIEND)
	local fg3=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_HAND,0,nil,RACE_FAIRY)
	local fg4=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_HAND,0,nil,RACE_SPELLCASTER)
	local fg5=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_HAND,0,nil,RACE_WARRIOR)
	Duel.SendtoDeck(fg1,nil,0,REASON_RULE)
	Duel.SendtoDeck(fg2,nil,0,REASON_RULE)
	Duel.SendtoDeck(fg3,nil,0,REASON_RULE)
	Duel.SendtoDeck(fg4,nil,0,REASON_RULE)
	Duel.SendtoDeck(fg5,nil,0,REASON_RULE)
	Duel.Draw(tp,5,REASON_RULE)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(4)
	e:GetHandler():RegisterEffect(e1)
end

--드로우 스탠바이페이즈 처리
function Kirafan.DrawStMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DRAW_COUNT)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetTargetRange(1,0)
	e1:SetValue(0)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_DRAW)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_EMZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(Kirafan.drawcon)
	e2:SetOperation(Kirafan.drawop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DECKDES)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_EMZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(Kirafan.Dottecon)
	e3:SetOperation(Kirafan.Dotteop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DECKDES)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_EMZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(Kirafan.battlecon)
	e4:SetOperation(Kirafan.battleop)
	c:RegisterEffect(e4)
end
function Kirafan.drawcon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetTurnCount()~=1 and Duel.GetTurnCount()~=2)
end
function Kirafan.drawop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetDefense()<=9 then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(1)
	e:GetHandler():RegisterEffect(e1) end
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	if tp==Duel.GetTurnPlayer() then
	if deckcount<3 then
	Duel.Draw(tp,deckcount,REASON_RULE)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	Duel.Draw(tp,3-deckcount,REASON_RULE)
	else
	Duel.Draw(tp,3,REASON_RULE) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050111,9))
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,1,1,nil)
	local tg=g:GetFirst()
	Duel.Remove(tg,POS_FACEUP,REASON_RULE)
	end
end
function Kirafan.Dottecon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function Kirafan.Dotteop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,1,REASON_RULE)
	
	if Duel.GetTurnCount()>2 then
	if Duel.SelectYesNo(tp,aux.Stringid(10050111,0)) then
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND+LOCATION_MZONE,0,0,1,e:GetHandler())
	if #g==0 then return end
	local tc=g:GetFirst()
	if tc:IsLocation(LOCATION_MZONE) then
	local tg=tc:GetOverlayGroup()
	Duel.Remove(tg,POS_FACEUP,REASON_RULE)
	Duel.Remove(tc,POS_FACEUP,REASON_RULE)
	Duel.SendtoGrave(tc,REASON_RULE)
	else
	Duel.SendtoGrave(tc,REASON_RULE) end end end
	
	if Duel.GetMatchingGroupCount(nil,tp,LOCATION_MZONE,0,nil)==1
	and Duel.GetMatchingGroupCount(Kirafan.battlezonefilter,tp,LOCATION_HAND,0,nil)==0
	and not e:GetHandler():IsCode(10050110) then
	local sg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.ConfirmCards(1-tp,sg)
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(10050114,0))
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(10050114,1))
	return Duel.SetLP(tp,0) end
	
	if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==1 and not e:GetHandler():IsCode(10050110) then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local summon=Duel.SelectMatchingCard(tp,Kirafan.battlezonefilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	Duel.SpecialSummon(summon,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
function Kirafan.battlecon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function Kirafan.battleop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local btcreamate=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,LOCATION_MZONE,0,nil)
	local ag=btcreamate:GetFirst()
	for ag in aux.Next(btcreamate) do
	ag:AddCounter(0xc01,1) end
end

--턴 종료시에 표시 형식 변경
function Kirafan.TurnPositionMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetCountLimit(1)
	e1:SetOperation(Kirafan.TurnPositionop)
	c:RegisterEffect(e1)
end
function Kirafan.TurnPositionfilter(c)
	return c:IsDefensePos() and not c:IsLocation(LOCATION_EMZONE)
end
function Kirafan.TurnPositionop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetMatchingGroup(Kirafan.TurnPositionfilter,tp,LOCATION_MZONE,0,nil)
	Duel.ChangePosition(sg,POS_FACEUP_ATTACK)

	local ag=Duel.GetFieldGroup(tp,LOCATION_SZONE,0)
	Duel.Remove(ag,POS_FACEUP,REASON_RULE)

	local enemy2=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,LOCATION_MZONE,0,nil)
	local cg=enemy2:GetFirst()
	for cg in aux.Next(enemy2) do
	cg:RemoveCounter(tp,0xb01,1,REASON_EFFECT)
	cg:RemoveCounter(tp,0xb02,1,REASON_EFFECT)
	cg:RemoveCounter(tp,0xb03,1,REASON_EFFECT)
	cg:RemoveCounter(tp,0xb04,1,REASON_EFFECT)
	cg:RemoveCounter(tp,0xb05,1,REASON_EFFECT)
	cg:RemoveCounter(tp,0xb06,1,REASON_EFFECT)
	cg:RemoveCounter(tp,0xc02,1,REASON_EFFECT)
	cg:RemoveCounter(tp,0xc01,cg:GetCounter(0xc01),REASON_EFFECT)
	cg:RemoveCounter(tp,0xc04,cg:GetCounter(0xc04),REASON_EFFECT)	end
	
	local g=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if tp~=Duel.GetTurnPlayer() and g>5 then
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050111,2))
	local tg=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,g-5,g-5,nil)
	Duel.Remove(tg,POS_FACEUP,REASON_RULE)
	else end
	
	local ally=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_EXTRA,0,nil):GetSum(Card.GetLevel)
	local enemy=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_EXTRA,nil):GetSum(Card.GetLevel)
	
	if c:IsSetCard(0xc01) and tp==Duel.GetTurnPlayer() and ally>=enemy then	
	Duel.SetLP(tp,0)
	else end
end

--유희왕과 다른 룰(1메인2스킵,2공격대상안됨,3패매수제한X,4표시형식변경불가,5공격불가,6필드봉인,7전투데미지없음,8공격력=필드레벨합,9랭크=성전레벨)
function Kirafan.MainCharacterEff(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetTargetRange(1,1)
	e1:SetCode(EFFECT_CANNOT_M2)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e2:SetRange(LOCATION_EMZONE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_HAND_LIMIT)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_EMZONE)
	e3:SetTargetRange(1,0)
	e3:SetValue(100)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_ATTACK)
	e5:SetCondition(Kirafan.aatcon)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetRange(LOCATION_EMZONE)
	e6:SetCode(EFFECT_DISABLE_FIELD)
	e6:SetOperation(Kirafan.FieldTheRockop)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetRange(LOCATION_EMZONE)
	e7:SetTargetRange(1,0)
	e7:SetValue(1)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_SET_ATTACK)
	e8:SetRange(LOCATION_MZONE)
	e8:SetValue(Kirafan.fieldlevel)
	c:RegisterEffect(e8)
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetCode(EFFECT_CHANGE_RANK)
	e9:SetRange(LOCATION_MZONE)
	e9:SetValue(Kirafan.extrarank)
	c:RegisterEffect(e9)
end
function Kirafan.aatcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsBattlePhase()
end
function Kirafan.FieldTheRockop(e,tp)
	return 0x150a
end
function Kirafan.fieldlevel(e,c)
	local CreamateLv=Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),LOCATION_ONFIELD,0,nil):GetSum(Card.GetLevel)
	return CreamateLv
end
function Kirafan.extrarank(e,c)
	local ally=Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),LOCATION_EXTRA,0,nil):GetSum(Card.GetLevel)
	return ally
end

--메인 캐릭터 기동효과
--1패정렬,2돗테오키제한10,3리프레시,4무조건공격,5~6라이프설정,7헛체인,8선공배페
function Kirafan.MainCharacterSpEff(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050111,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetOperation(Kirafan.handop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_EMZONE)
	e2:SetCode(EVENT_ADJUST)
	e2:SetCondition(Kirafan.Dotte10con)
	e2:SetOperation(Kirafan.Dotte10op)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_EMZONE)
	e3:SetCode(EVENT_ADJUST)
	e3:SetCondition(Kirafan.Refreshcon)
	e3:SetOperation(Kirafan.Refreshop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_MUST_ATTACK)
	e4:SetCondition(Kirafan.aatcon2)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e5:SetCountLimit(1)
	e5:SetRange(LOCATION_EMZONE)
	e5:SetCondition(Kirafan.lifecon)
	e5:SetOperation(Kirafan.lifeop)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCondition(Kirafan.lifecon2)
	e6:SetOperation(Kirafan.lifeop2)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_QUICK_O)
	e7:SetCode(EVENT_FREE_CHAIN)
	e7:SetHintTiming(TIMING_BATTLE_STEP_END)
	e7:SetRange(LOCATION_EMZONE)
	e7:SetCondition(Kirafan6.spcreamatecon)
	e7:SetTarget(Kirafan.noeffecttg)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e8:SetCode(EFFECT_BP_FIRST_TURN)
	e8:SetRange(LOCATION_EMZONE)
	e8:SetTargetRange(1,1)
	c:RegisterEffect(e8)
end
function Kirafan.aatcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsMainPhase()
end
function Kirafan.handop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local fg1=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_HAND,0,nil,RACE_ZOMBIE)
	local fg2=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_HAND,0,nil,RACE_FIEND)
	local fg3=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_HAND,0,nil,RACE_FAIRY)
	local fg4=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_HAND,0,nil,RACE_SPELLCASTER)
	local fg5=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_HAND,0,nil,RACE_WARRIOR)
	Duel.SendtoDeck(fg1,nil,0,REASON_RULE)
	Duel.SendtoDeck(fg2,nil,0,REASON_RULE)
	Duel.SendtoDeck(fg3,nil,0,REASON_RULE)
	Duel.SendtoDeck(fg4,nil,0,REASON_RULE)
	Duel.SendtoDeck(fg5,nil,0,REASON_RULE)
	Duel.Draw(tp,#g,REASON_RULE)
end
function Kirafan.Dotte10con(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_GRAVE,0)>=10
end
function Kirafan.Dotte10op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_GRAVE,0,nil)
	local last=g:GetFirst()
	local tc=g:GetNext()
	for tc in aux.Next(g) do
		if tc:GetSequence()<last:GetSequence() then last=tc end
	end
	Duel.Remove(last,POS_FACEUP,REASON_EFFECT)
end
function Kirafan.Refreshcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_DECK,0)==0
	and Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_REMOVED,0)~=0
end
function Kirafan.Refreshop(e,tp,eg,ep,ev,re,r,rp)
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
end
function Kirafan.lifecon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSetCard(0xc01) and Duel.GetLP(tp)>3000
end
function Kirafan.lifeop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ally=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_EXTRA,0,nil):GetSum(Card.GetLevel)
	local enemy=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_EXTRA,nil):GetSum(Card.GetLevel)
	if enemy<ally then Duel.SetLP(tp,1000) end
end
function Kirafan.lifecon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSetCard(0xc01) and Duel.GetLP(tp)<3000
end
function Kirafan.lifeop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ally=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_EXTRA,0,nil):GetSum(Card.GetLevel)
	local enemy=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_EXTRA,nil):GetSum(Card.GetLevel)
	
	if ally<enemy then Duel.SetLP(tp,5000) end
end
function Kirafan.noeffecttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local code=c:GetOriginalCode()
	if chk==0 then return c:GetFlagEffect(code)==0 end
	c:RegisterFlagEffect(code,RESET_EVENT|RESETS_STANDARD|RESET_CHAIN,0,1)
	Duel.SetChainLimit(Kirafan3.noeffectchainlm)
end

--리얼리스트의 시간
function Kirafan.RealistTime(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCountLimit(1,id)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(Kirafan.realistcon)
	e1:SetTarget(Kirafan.realisttg)
	e1:SetOperation(Kirafan.realistop)
	c:RegisterEffect(e1)
end
function Kirafan.realistcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,0,LOCATION_EMZONE,nil):GetFirst()
	return main:IsSetCard(0xc01) or (Duel.GetTurnPlayer()==tp and not c:IsSetCard(0xc01) and
	Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_EXTRA,nil):GetSum(Card.GetLevel)>=10)
end
function Kirafan.realisttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetChainLimit(aux.FALSE)
end

function Kirafan.realistop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ally=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_EXTRA,0,nil):GetSum(Card.GetLevel)
	local enemy=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_EXTRA,nil):GetSum(Card.GetLevel)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(0xc01)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
	if Duel.GetTurnPlayer()==tp and enemy>=10 then
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(10050114,4))
	else Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(10050114,5)) end
end

--텍스트
function Kirafan.MainCharacterTextEff(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetCondition(Kirafan.hintcon)
	e1:SetOperation(Kirafan.hintop)
	c:RegisterEffect(e1)
end
function Kirafan.hintcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSetCard(0xc01)
end
function Kirafan.hintop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050112,3))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end