local s,id=GetID()
function s.initial_effect(c)
	Kirafan2.CreamateCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(s.atkcon)
	e1:SetOperation(s.atkop)
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
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_MZONE,0,nil,RACE_SPELLCASTER)
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local enemy=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	local dam=1
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local ag=enemy:GetFirst()
	for ag in aux.Next(enemy) do
	local g=ag:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=ag:GetOverlayGroup():RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end end
	Duel.Draw(tp,1,REASON_EFFECT)
	if c:GetCounter(0xb04)>0 then
	Duel.Damage(tp,1,REASON_EFFECT)
	hunger=c:GetOverlayGroup():RandomSelect(tp,1)
	Duel.Remove(hunger,POS_FACEUP,REASON_EFFECT) end
end