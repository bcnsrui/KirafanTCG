local s,id=GetID()
function s.initial_effect(c)
	Kirafan2.CreamateCharacter(c)
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
function s.lightfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and not c:IsLocation(LOCATION_EMZONE)
end
function s.darkfilter(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and not c:IsLocation(LOCATION_EMZONE)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local sun=Duel.GetMatchingGroupCount(s.lightfilter,tp,LOCATION_ONFIELD,0,c)
	local moon=Duel.GetMatchingGroupCount(s.darkfilter,tp,LOCATION_ONFIELD,0,c)
	local sun1=Duel.GetMatchingGroupCount(s.lightfilter,tp,0,LOCATION_ONFIELD,nil)
	local moon1=Duel.GetMatchingGroupCount(s.darkfilter,tp,0,LOCATION_ONFIELD,nil)
	if sun+moon>0 and sun1+moon1>0 then dam=4
	elseif sun1+moon1>0 then dam=3
	elseif sun+moon>0 then dam=2
	else dam=1 end
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local g=tg:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=g:RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end