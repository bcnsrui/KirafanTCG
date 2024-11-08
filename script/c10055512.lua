local s,id=GetID()
function s.initial_effect(c)
	Kirafan4.DOTTEDotteTrigger(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan6.spcreamatecon)
	e1:SetCost(s.cost)
	e1:SetTarget(Kirafan6.spdamtg)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1)
	Kirafan3.SpCreamateCharacter(c)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and
	Duel.IsExistingMatchingCard(Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Kirafan6.summonhint(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050115,0))
	local ag=Duel.SelectMatchingCard(tp,Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.ChangePosition(ag:GetFirst(),POS_FACEUP_DEFENSE)
end
function s.lffilter(c)
	return c:IsDefensePos() and not c:IsLocation(LOCATION_EMZONE)
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	tc:AddCounter(0xc01,1)
	Kirafan6.guagetrigger(c)
end