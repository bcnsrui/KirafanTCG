local s,id=GetID()
function s.initial_effect(c)
	Kirafan3.SpCreamateCharacter(c)
	Kirafan3.SpCreamateSgHeal(c)
	Kirafan3.SpCreamateAllHeal(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050113,4))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(Kirafan3.dottecost2)
	e1:SetTarget(Kirafan6.nodamtg)
	e1:SetOperation(s.dotteop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(Kirafan6.dottecon)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetCondition(Kirafan6.dottecon2)
	c:RegisterEffect(e3)
end
function s.dotteop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	main:RemoveCounter(tp,0xa05,1,REASON_EFFECT)
	local con=Duel.GetMatchingGroupCount(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	if con>2 then
	if deckcount==1 then
	Duel.Draw(tp,1,REASON_RULE)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	Duel.Draw(tp,1,REASON_RULE)
	Duel.DiscardDeck(tp,con-2,REASON_EFFECT)
	else
	Duel.Draw(tp,2,REASON_RULE)
	Duel.DiscardDeck(tp,con-2,REASON_EFFECT) end
	elseif con==2 then
	if deckcount==1 then
	Duel.Draw(tp,1,REASON_RULE)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	Duel.Draw(tp,1,REASON_RULE)
	else
	Duel.Draw(tp,2,REASON_RULE) end
	else
	Duel.Draw(tp,1,REASON_RULE) end
end