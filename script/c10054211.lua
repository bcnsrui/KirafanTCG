local s,id=GetID()
function s.initial_effect(c)
	Kirafan3.SpCreamateCharacter(c)
	Kirafan3.SpCreamateSgHeal(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(s.dottetg)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(s.dottecon)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetCondition(s.dottecon2)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(10050113,4))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_HAND)
	e4:SetCost(Kirafan2.dottecost1)
	e4:SetTarget(s.dottetg)
	e4:SetOperation(s.dotteop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetCondition(s.dottecon)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetCode(EVENT_CHAINING)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e6:SetCondition(s.dottecon2)
	c:RegisterEffect(e6)
end
function s.dottecon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function s.dottecon2(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and Duel.IsBattlePhase() and Duel.GetTurnPlayer()~=tp
end
function s.NoEmzonefilter(c)
	return not c:IsLocation(LOCATION_EMZONE)
end
function s.dottetg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
	and Duel.IsExistingTarget(s.NoEmzonefilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetChainLimit(aux.FALSE)
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local enemy=Duel.GetMatchingGroup(Kirafan.NoEmzonefilter,tp,LOCATION_MZONE,0,nil)
	if c and c:IsRelateToEffect(e) then
	local tc=enemy:GetFirst()
	for tc in aux.Next(enemy) do
	tc:RemoveCounter(tp,0xb01,tc:GetCounter(0xb01),REASON_EFFECT)
	tc:RemoveCounter(tp,0xb02,tc:GetCounter(0xb02),REASON_EFFECT)
	tc:RemoveCounter(tp,0xb03,tc:GetCounter(0xb03),REASON_EFFECT) end
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true) end
end
function s.dotteop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local enemy=Duel.GetMatchingGroup(Kirafan.NoEmzonefilter,tp,LOCATION_MZONE,0,nil)
	if c and c:IsRelateToEffect(e) then
	local tc=enemy:GetFirst()
	for tc in aux.Next(enemy) do
	tc:RemoveCounter(tp,0xb01,tc:GetCounter(0xb01),REASON_EFFECT)
	tc:RemoveCounter(tp,0xb02,tc:GetCounter(0xb02),REASON_EFFECT)
	tc:RemoveCounter(tp,0xb03,tc:GetCounter(0xb03),REASON_EFFECT) end
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true) end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EFFECT_CANNOT_PLACE_COUNTER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	c:RegisterEffect(e1)
end