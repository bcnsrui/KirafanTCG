local s,id=GetID()
function s.initial_effect(c)
	Kirafan3.SpCreamateCharacter(c)
	Kirafan3.SpCreamateSgHeal(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050113,4))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(s.dottecost3)
	e1:SetTarget(s.dottetg)
	e1:SetOperation(s.dotteop)
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
end
function s.dotteop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	main:RemoveCounter(tp,0xa05,1,REASON_EFFECT)
	local g=Duel.GetMatchingGroup(s.NoEmzonefilter,tp,LOCATION_MZONE,0,nil)
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(main:GetCounter(0xc03))
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
	end
end

function s.battlefilter(c)
	return c:IsAttackPos() and not c:IsLocation(LOCATION_EMZONE)
end
function s.dottecost3(e,tp,eg,ep,ev,re,r,rp,chk)
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	if chk==0 then return Duel.IsExistingMatchingCard(s.battlefilter,tp,LOCATION_MZONE,0,1,nil)
	and Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,2,nil,tp) end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	main:AddCounter(0xa05,1)
	main:AddCounter(0xc03,1)
	
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)
	local last=g:GetFirst()
	local tc=g:GetNext()
	for tc in aux.Next(g) do
		if tc:GetSequence()<last:GetSequence() then last=tc end
	end
	Duel.Remove(last,POS_FACEUP,REASON_EFFECT)
	local g2=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)
	local last2=g2:GetFirst()
	local tc2=g2:GetNext()
	for tc2 in aux.Next(g2) do
		if tc2:GetSequence()<last2:GetSequence() then last2=tc2 end
	end
	Duel.Remove(last2,POS_FACEUP,REASON_EFFECT)
	local g3=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)
	local last3=g3:GetFirst()
	local tc3=g3:GetNext()
	for tc3 in aux.Next(g3) do
		if tc3:GetSequence()<last3:GetSequence() then last3=tc3 end
	end
	Duel.Remove(last3,POS_FACEUP,REASON_EFFECT)
	
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050115,0))
	local ag=Duel.SelectMatchingCard(tp,s.battlefilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.ChangePosition(ag:GetFirst(),POS_FACEUP_DEFENSE)
end