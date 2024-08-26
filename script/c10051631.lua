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
	e5:SetCost(Kirafan2.dottecost3)
	e5:SetTarget(Kirafan6.damtg)
	e5:SetOperation(s.damop)
	c:RegisterEffect(e5)
	Kirafan6.NoDotteEffcon3(c)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local dam=2
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
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
	dam=8 end end
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local g=tg:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=g:RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
	if c:GetCounter(0xb04)>0 then
	Duel.Damage(tp,1,REASON_EFFECT)
	hunger=c:GetOverlayGroup():RandomSelect(tp,1)
	Duel.Remove(hunger,POS_FACEUP,REASON_EFFECT) end
end