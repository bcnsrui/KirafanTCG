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
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(Kirafan6.damcon)
	e5:SetCost(Kirafan2.dottecost2)
	e5:SetTarget(Kirafan6.damtg)
	e5:SetOperation(s.damop)
	c:RegisterEffect(e5)
	Kirafan6.NoDotteEffcon2(c)
end
function s.earthfilter(c)
	return c:IsAttribute(ATTRIBUTE_EARTH) and not c:IsLocation(LOCATION_EMZONE)
end
function s.atklimit(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	local ct=Duel.GetMatchingGroupCount(s.earthfilter,tp,LOCATION_ONFIELD,0,nil)
	if ct>3 then ct=3 end
	if deckcount<ct then
	Duel.DiscardDeck(tp,deckcount,REASON_EFFECT)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	Duel.DiscardDeck(tp,ct-deckcount,REASON_EFFECT)
	else
	Duel.DiscardDeck(tp,ct,REASON_EFFECT) end
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local dam=Duel.GetMatchingGroupCount(s.earthfilter,tp,LOCATION_ONFIELD,0,nil)
	Duel.Damage(1-tp,dam+1,REASON_EFFECT)
	local g=tg:GetOverlayGroup()
	if #g<=dam+1 then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=g:RandomSelect(1-tp,dam+1)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end