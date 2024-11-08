local s,id=GetID()
function s.initial_effect(c)
	Kirafan3.SpCreamateSgHeal(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050113,4))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan6.spcreamatecon)
	e1:SetCost(Kirafan3.dottecost2)
	e1:SetTarget(Kirafan6.nodamtg)
	e1:SetOperation(s.dotteop)
	c:RegisterEffect(e1)
	Kirafan3.SpCreamateCharacter(c)
end
function s.dotteop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local enemy=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	local ag=enemy:GetFirst()
	for ag in aux.Next(enemy) do
	if ag:GetCounter(0xb04)==0 then ag:AddCounter(0xb04,2)
	elseif ag:GetCounter(0xb04)==1 then ag:AddCounter(0xb04,1)
	else end end
end