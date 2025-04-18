local s,id=GetID()
function s.initial_effect(c)
	Kirafan2.CreamateCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(s.fccondition)
	c:RegisterEffect(e1)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(10050111,5))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(Kirafan6.damcon)
	e5:SetCost(Kirafan2.dottecost2)
	e5:SetTarget(Kirafan6.damtg)
	e5:SetOperation(s.damop)
	c:RegisterEffect(e5)
	Kirafan6.NoDotteEffcon2(c)
end
function s.fccondition(e,c)
	local g=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,c:GetControler(),LOCATION_ONFIELD,0,nil)
	local tc=g:GetFirst()
	local attr=0
	for tc in aux.Next(g) do
		attr=(attr|tc:GetAttribute())
	end
	return Duel.GetMatchingGroupCount(Card.IsAttribute,e:GetHandler():GetControler(),0,LOCATION_ONFIELD,nil,attr)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	
	local ag=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,c:GetControler(),LOCATION_ONFIELD,0,nil)
	local ta=ag:GetFirst()
	local attr=0
	for ta in aux.Next(ag) do
		attr=(attr|ta:GetAttribute())
	end
	
	local dam=Duel.GetMatchingGroupCount(Card.IsAttribute,c:GetControler(),0,LOCATION_ONFIELD,nil,attr)+1
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local g=tg:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=g:RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end