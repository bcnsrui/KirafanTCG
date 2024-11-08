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
	Kirafan6.NoDotteEffcon3(c)
end
function s.filter(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsRace(RACE_WARRIOR+RACE_FAIRY) and c:IsAbleToHand()
end
function s.atklimit(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_REMOVED,0,1,nil) then
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050111,9))
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,1,1,nil)
	local tg=g:GetFirst()
	Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
	end
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local dam=2
	local g=Duel.GetMatchingGroupCount(Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,nil)
	if g==0 then
	elseif Duel.IsExistingMatchingCard(Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,1,c)
	and Duel.SelectYesNo(tp,aux.Stringid(10050111,3)) then
	local ag=Duel.SelectMatchingCard(tp,Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,1,1,c)
	Duel.ChangePosition(ag:GetFirst(),POS_FACEUP_DEFENSE)
	dam=4
	if Duel.IsExistingMatchingCard(Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,1,c)
	and Duel.SelectYesNo(tp,aux.Stringid(10050111,3)) then
	local ag=Duel.SelectMatchingCard(tp,Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,1,1,c)
	Duel.ChangePosition(ag:GetFirst(),POS_FACEUP_DEFENSE)
	dam=6 end end
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local g=tg:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=g:RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end