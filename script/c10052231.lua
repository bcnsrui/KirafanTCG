local s,id=GetID()
function s.initial_effect(c)
	Kirafan2.CreamateCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(s.atklimit)
	c:RegisterEffect(e1)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(10050111,5))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(Kirafan6.damcon)
	e5:SetCost(Kirafan2.dottecost(2))
	e5:SetTarget(Kirafan6.nodamtg)
	e5:SetOperation(s.damop)
	c:RegisterEffect(e5)
	Kirafan6.NoDotteEffcon(c,2)
end
function s.atklimit(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
	Kirafan6.kirafandrawop(e,tp,eg,ep,ev,re,r,rp,1)
	Kirafan6.firafandotteop(e,tp,eg,ep,ev,re,r,rp,2)
	Duel.Draw(1-tp,1,REASON_EFFECT)
	else Kirafan6.kirafandrawop(e,tp,eg,ep,ev,re,r,rp,1) end
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local enemy=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	local dam=1
	if Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>=3 then dam=2 end
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	for wg in enemy:Iter() do
	Kirafan6.damageeff(e,tp,eg,ep,ev,re,r,rp,wg,dam) end
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end