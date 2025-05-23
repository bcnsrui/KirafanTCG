local s,id=GetID()
function s.initial_effect(c)
	c:SetUniqueOnField(1,0,id)
	Kirafan2.CreamateCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(s.atkcon)
	e1:SetOperation(s.atkop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetOperation(s.atklimit)
	c:RegisterEffect(e2)
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
	return e:GetHandler():IsDefensePos()
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangePosition(e:GetHandler(),POS_FACEUP_ATTACK)
end
function s.atklimit(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
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
	end	end
	if Duel.IsExistingMatchingCard(Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,1,c)
	and Duel.SelectYesNo(tp,aux.Stringid(10050111,3)) then
	local ag=Duel.SelectMatchingCard(tp,Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,1,1,c)
	Duel.ChangePosition(ag,POS_FACEUP_DEFENSE)
	c:AddCounter(0xc01,1) end
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end