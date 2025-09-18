local s,id=GetID()
function s.initial_effect(c)
	Kirafan4.ATKUPDotteTrigger(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan6.spcreamatecon)
	e1:SetCost(Kirafan2.spcost(3))
	e1:SetTarget(s.tg)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1)
	Kirafan3.SpCreamateCharacter(c)
end
function s.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local con=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,LOCATION_MZONE,0,nil)
	local att=con:GetClassCount(Card.GetAttribute)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return #con==att and
	Duel.IsExistingMatchingCard(Kirafan6.NoEmFzonefilter,tp,LOCATION_MZONE,0,2,nil) end
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,LOCATION_MZONE,0,nil)
	Kirafan6.atkchange(e,tp,eg,ep,ev,re,r,rp,PHASE_END,1,g,1)
	Kirafan6.guagetrigger(c)
end