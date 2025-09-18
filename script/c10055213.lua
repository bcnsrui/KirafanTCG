local s,id=GetID()
function s.initial_effect(c)
	Kirafan4.HPDotteTrigger(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050113,4))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan6.spcreamatecon)
	e1:SetCost(Kirafan2.spdottecost(1,5))
	e1:SetTarget(s.dottetg)
	e1:SetOperation(s.dotteop)
	c:RegisterEffect(e1)
	Kirafan3.SpCreamateCharacter(c)
end
function s.dottetg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingMatchingCard(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_ONFIELD,1,nil)end
end
function s.dotteop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local con=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_ONFIELD,nil)
	local race=con:GetClassCount(Card.GetRace)
	if race>2 then
	Kirafan6.kirafandrawop(e,tp,eg,ep,ev,re,r,rp,2)
	Kirafan6.firafandotteop(e,tp,eg,ep,ev,re,r,rp,1)
	elseif race==2 then Kirafan6.kirafandrawop(e,tp,eg,ep,ev,re,r,rp,2)
	else Kirafan6.kirafandrawop(e,tp,eg,ep,ev,re,r,rp,1) end
end