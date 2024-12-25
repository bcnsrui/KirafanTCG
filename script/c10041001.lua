local s,id=GetID()
function s.initial_effect(c)
	Kirafan7.BossCharacter(c)
	Kirafan.TurnPositionMainCharacter(c)
	Kirafan.MainCharacterEff(c)
	Kirafan.MainCharacterTextEff(c)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e0:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e0:SetRange(LOCATION_EMZONE)
	e0:SetCondition(s.bosscon)
	e0:SetTarget(s.bosstg)
	e0:SetOperation(s.bossop)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetCountLimit(1)
	e1:SetOperation(s.spsummon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetRange(LOCATION_EMZONE)
	e2:SetCondition(s.resetcon)
	e2:SetOperation(s.spsummon)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e3:SetRange(LOCATION_EMZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(s.resetcon2)
	e3:SetTarget(s.resettg2)
	e3:SetOperation(s.resetop2)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_EMZONE)
	e4:SetCode(EFFECT_CANNOT_PLACE_COUNTER)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(0,1)
	e4:SetTarget(s.cannotcounter)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_PHASE+PHASE_DRAW)
	e5:SetRange(LOCATION_EMZONE)
	e5:SetCountLimit(1)
	e5:SetCondition(s.lgcon)
	e5:SetOperation(s.lgop)
	c:RegisterEffect(e5)
end
function s.cannotcounter(e,c,tp,ctype)
	return c:IsControler(1-tp) and (ctype==0xb03 or ctype==0xb04)
end
function s.bossdamfilter(c)
	return c:IsAttackPos() and not c:IsLocation(LOCATION_EMZONE)
end
function s.bosscon(e,tp,eg,ep,ev,re,r,rp)
	local ally=Duel.GetMatchingGroup(s.bossdamfilter,tp,LOCATION_MZONE,0,nil)
	return Duel.IsBattlePhase() and Duel.GetTurnPlayer()==tp and Duel.GetCurrentChain()==0
	and Duel.GetMatchingGroupCount(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)<2	and #ally<2
end
function s.bosstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(10041002,5))
end
function s.bossop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(tp,PHASE_BATTLE,RESET_PHASE+PHASE_END,0)
	Duel.SkipPhase(tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,0)
end
function s.cfilter(c)
	return c:IsCode(10041002)
end
function s.resetcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil)
end
function s.spsummon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ally=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,LOCATION_MZONE,0,nil)
	if #ally>0 then
	local ag=ally:GetFirst()
	for ag in aux.Next(ally) do
	local g=ag:GetOverlayGroup()
	tc=ag:GetOverlayGroup()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT) end
	Duel.Destroy(ally,REASON_EFFECT) end
	
	if c:GetDefense()==0 then
	Duel.SetLP(tp,0)
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(id,1))
	
	else 	
	if c:GetDefense()==2 then
	sugar=Duel.CreateToken(tp,10041002)
	Duel.SpecialSummon(sugar,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	else
	sugar=Duel.CreateToken(tp,10041003)
	Duel.SpecialSummon(sugar,0,tp,tp,false,false,POS_FACEUP_ATTACK)	end
	
	sugar1=Duel.CreateToken(tp,10041004)
	Duel.SpecialSummon(sugar1,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	sugar2=Duel.CreateToken(tp,10041005)
	Duel.SpecialSummon(sugar2,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	
	if c:IsSetCard(0xd04) or c:IsSetCard(0xd03) then
	extrabosshp=5
	extrabosshp1=2
	else
	extrabosshp=0
	extrabosshp1=0 end

	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	local bg=Duel.GetDecktopGroup(tp,extrabosshp)
	Duel.Overlay(sugar,bg)
	local bg1=Duel.GetDecktopGroup(tp,extrabosshp1)
	Duel.Overlay(sugar1,bg1)
	local bg2=Duel.GetDecktopGroup(tp,extrabosshp1)
	Duel.Overlay(sugar2,bg2) end

	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(-1)
	c:RegisterEffect(e1)
end
function s.resetcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsBattlePhase() and Duel.GetTurnPlayer()==tp and Duel.GetCurrentChain()==0
end
function s.resettg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return true end
	Duel.SetChainLimit(aux.FALSE)
end
function s.resetop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnCount()<3 then
	local a=0
	while a<=7 do
	sugar1=Duel.CreateToken(tp,10041002)
	sugar2=Duel.CreateToken(tp,10041003)
	sugar3=Duel.CreateToken(tp,10041004)
	sugar4=Duel.CreateToken(tp,10041005)
	Duel.SendtoDeck(sugar1,nil,0,REASON_RULE)
	Duel.SendtoDeck(sugar2,nil,0,REASON_RULE)
	Duel.SendtoDeck(sugar3,nil,0,REASON_RULE)
	Duel.SendtoDeck(sugar4,nil,0,REASON_RULE)
	a=a+1 end
	Duel.ShuffleDeck(tp)
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(id,0)) 
	end
end
function s.lgcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function s.lgop(e,tp,eg,ep,ev,re,r,rp)
	local main=Duel.GetMatchingGroup(nil,e:GetHandlerPlayer(),0,LOCATION_EMZONE,nil):GetFirst()
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	local Turn=math.min(Duel.GetTurnCount()+1,10)
	if main:GetRank()>=20 then
	difficultyguage=1
	elseif main:GetRank()>=30 then
	difficultyguage=2
	elseif main:GetRank()>=40 then
	difficultyguage=3
	elseif main:GetRank()>=50 then
	difficultyguage=4 
	else difficultyguage=0 end
	if deckcount<Turn+difficultyguage then
	Duel.DiscardDeck(tp,deckcount,REASON_EFFECT)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	Duel.DiscardDeck(tp,Turn+difficultyguage-deckcount,REASON_EFFECT)
	else
	Duel.DiscardDeck(tp,Turn+difficultyguage,REASON_EFFECT) end
end