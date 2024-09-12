local s,id=GetID()
function s.initial_effect(c)
	Kirafan5.KnCreamateCharacter(c)
	Kirafan5.Aggroknight(c)
	Kirafan5.KnightDotte1(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_REMOVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(s.kncon)
	e1:SetOperation(s.knop)
	c:RegisterEffect(e1)
end
function s.knconfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_OVERLAY)
end
function s.kncon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.knconfilter,1,nil,tp) and Duel.GetTurnPlayer()~=tp
end
function s.knop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	if deckcount==1 then
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
	else
	Duel.DiscardDeck(tp,2,REASON_EFFECT) end
end