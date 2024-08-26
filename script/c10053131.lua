local s,id=GetID()
function s.initial_effect(c)
	Kirafan5.KnCreamateCharacter(c)
	Kirafan5.Aggroknight(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_REMOVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(s.kncon)
	e1:SetOperation(s.knop)
	c:RegisterEffect(e1)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(10050111,5))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(Kirafan6.damcon)
	e5:SetCost(Kirafan2.dottecost2)
	e5:SetTarget(Kirafan6.nodamtg)
	e5:SetOperation(s.damop)
	c:RegisterEffect(e5)
	Kirafan6.NoDotteEffcon2(c)
end
function s.knconfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_OVERLAY)
end
function s.kncon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.knconfilter,1,nil,tp) and Duel.GetTurnPlayer()~=tp
end
function s.knop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,LOCATION_MZONE,0,nil)
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_NO_TURN_RESET)
		e2:SetCode(EVENT_DAMAGE_STEP_END)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCountLimit(1)
		e2:SetCondition(s.chiyacon)
		e2:SetOperation(s.chiyaop)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
	end
end
function s.chiyacon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function s.chiyaop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e:GetHandler():RegisterEffect(e1)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local enemy=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	local dam=1
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local ag=enemy:GetFirst()
	for ag in aux.Next(enemy) do
	local g=ag:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=ag:GetOverlayGroup():RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end end
	if c:GetCounter(0xb04)>0 then
	Duel.Damage(tp,1,REASON_EFFECT)
	hunger=c:GetOverlayGroup():RandomSelect(tp,1)
	Duel.Remove(hunger,POS_FACEUP,REASON_EFFECT) end
end