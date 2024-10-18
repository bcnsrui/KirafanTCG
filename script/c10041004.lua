local s,id=GetID()
function s.initial_effect(c)
	Kirafan2.CreamateCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CHAIN_END)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(s.damcon1)
	e1:SetTarget(s.damtg1)
	e1:SetOperation(s.damop1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CHAIN_END)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(s.damcon2)
	e2:SetTarget(s.damtg2)
	e2:SetOperation(s.damop2)
	c:RegisterEffect(e2)
end
function s.damcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsBattlePhase() and not e:GetHandler():IsDefensePos() and Duel.GetTurnPlayer()==tp
	and Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_MZONE,0,nil,10041002)~=0
end
function s.damtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil) end
	local aggromiss=Duel.GetRandomNumber(1,5)
	local knight=Duel.GetMatchingGroup(Kirafan8.knightfilter,tp,0,LOCATION_MZONE,nil)
	local enemy=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	if aggromiss==5 and #knight>0 then
	local sg=knight:GetFirst()
	Duel.SetTargetCard(sg)
	else
	local sg2=enemy:RandomSelect(tp,1)
	Duel.SetTargetCard(sg2) end
	
	local extraatk=Duel.GetRandomNumber(1,10)
	if (main:IsSetCard(0xd04) and extraatk<=8) or (main:IsSetCard(0xd03) and extraatk<=5)
	or (main:IsSetCard(0xd02) and extraatk<=2) then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_CHAIN)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	else end
	
	Duel.SetChainLimit(Kirafan8.mychainlimit)
end
function s.damop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local attack=c:GetAttack()
	local dam=attack
	Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local g=tg:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=g:RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
	c:AddCounter(0xd01,1)
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end
function s.damcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsBattlePhase() and Duel.GetTurnPlayer()==tp and e:GetHandler():GetCounter(0xd01)>2
	and Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_MZONE,0,nil,10041002)~=0
end
function s.damtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil) end
	local aggromiss=Duel.GetRandomNumber(1,5)
	local knight=Duel.GetMatchingGroup(Kirafan8.knightfilter,tp,0,LOCATION_MZONE,nil)
	local enemy=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	if aggromiss==5 and #knight>0 then
	local sg=knight:GetFirst()
	Duel.SetTargetCard(sg)
	else
	local sg2=enemy:RandomSelect(tp,1)
	Duel.SetTargetCard(sg2) end
	
	local extraatk=Duel.GetRandomNumber(1,10)
	if (main:IsSetCard(0xd04) and extraatk<=8) or (main:IsSetCard(0xd03) and extraatk<=5)
	or (main:IsSetCard(0xd02) and extraatk<=2) then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_CHAIN)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	else end
	
	Duel.SetChainLimit(Kirafan8.mychainlimit)
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(id,0))
end
function s.damop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	c:RemoveCounter(tp,0xd01,c:GetCounter(0xd01),REASON_EFFECT)
	local attack=c:GetAttack()
	local dam=attack
	Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local g=tg:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=g:RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
	c:AddCounter(0xd01,1)
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end