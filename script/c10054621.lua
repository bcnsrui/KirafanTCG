local s,id=GetID()
function s.initial_effect(c)
	Kirafan3.SpCreamateSgHeal(c,4)	
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050113,4))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan6.spcreamatecon)
	e1:SetCost(Kirafan2.spdotterestcost(1,1,5))
	e1:SetTarget(s.dottetg)
	e1:SetOperation(s.dotteop)
	c:RegisterEffect(e1)
	Kirafan3.SpCreamateCharacter(c)
end
function s.dottetg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingMatchingCard(Kirafan6.NoEmFzonefilter,tp,LOCATION_MZONE,0,2,nil) end
end
function s.dotteop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,LOCATION_MZONE,0,nil)
	local ct=g:GetClassCount(Card.GetOriginalAttribute)
	if ct==1 then Kirafan6.atkchange(e,tp,eg,ep,ev,re,r,rp,PHASE_END,1,g,2)
	else Kirafan6.atkchange(e,tp,eg,ep,ev,re,r,rp,PHASE_END,1,g,1) end
end