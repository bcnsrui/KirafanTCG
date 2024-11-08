local s,id=GetID()
function s.initial_effect(c)
	Kirafan3.SpCreamateAllHeal(c)	
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050113,4))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan6.spcreamatecon)
	e1:SetCost(Kirafan3.dottecost1)
	e1:SetTarget(Kirafan6.nospcondamtg)
	e1:SetOperation(s.dotteop)
	c:RegisterEffect(e1)
	Kirafan3.SpCreamateCharacter(c)
end
function s.dotteop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	if deckcount==1 then
	Duel.Draw(tp,1,REASON_RULE)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	Duel.Draw(tp,1,REASON_RULE)
	else
	Duel.Draw(tp,2,REASON_RULE) end
end