local s,id=GetID()
function s.initial_effect(c)
	Kirafan3.SpCreamateCharacter(c)
	Kirafan3.SpCreamateOvSgHeal(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(s.cost1)
	e1:SetTarget(Kirafan6.nospcondamtg)
	e1:SetOperation(s.op1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(Kirafan6.dottecon)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetCondition(Kirafan6.dottecon2)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,1))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_HAND)
	e4:SetCost(s.cost2)
	e4:SetTarget(Kirafan6.nospcondamtg)
	e4:SetOperation(s.op2)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetCondition(Kirafan6.dottecon)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetCode(EVENT_CHAINING)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e6:SetCondition(Kirafan6.dottecon2)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(10050113,4))
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_HAND)
	e7:SetCost(s.dottecost2)
	e7:SetTarget(Kirafan6.nospdamtg)
	e7:SetOperation(s.dotteop1)
	c:RegisterEffect(e7)
	local e8=e7:Clone()
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e8:SetCode(EVENT_ATTACK_ANNOUNCE)
	e8:SetCondition(Kirafan6.dottecon)
	c:RegisterEffect(e8)
	local e9=e7:Clone()
	e9:SetType(EFFECT_TYPE_QUICK_O)
	e9:SetCode(EVENT_CHAINING)
	e9:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e9:SetCondition(Kirafan6.dottecon2)
	c:RegisterEffect(e9)
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(10050113,5))
	e10:SetType(EFFECT_TYPE_IGNITION)
	e10:SetRange(LOCATION_HAND)
	e10:SetCost(s.dottecost22)
	e10:SetTarget(Kirafan6.nospdamtg)
	e10:SetOperation(s.dotteop2)
	c:RegisterEffect(e10)
	local e11=e10:Clone()
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e11:SetCode(EVENT_ATTACK_ANNOUNCE)
	e11:SetCondition(Kirafan6.dottecon)
	c:RegisterEffect(e11)
	local e12=e10:Clone()
	e12:SetType(EFFECT_TYPE_QUICK_O)
	e12:SetCode(EVENT_CHAINING)
	e12:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e12:SetCondition(Kirafan6.dottecon2)
	c:RegisterEffect(e12)
end
function s.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	main:AddCounter(0xa03,1)
end
function s.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	main:AddCounter(0xa04,1)
end
function s.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	main:RemoveCounter(tp,0xa03,1,REASON_EFFECT)
    Duel.DiscardDeck(tp,2,REASON_EFFECT)
end
function s.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	main:RemoveCounter(tp,0xa04,1,REASON_EFFECT)
    Duel.Draw(tp,1,REASON_EFFECT)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	e2:SetOperation(s.dottetrigger)
	c:RegisterEffect(e2)
end
function s.dottetrigger(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
end
function s.dotteop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	main:RemoveCounter(tp,0xa05,1,REASON_EFFECT)
	Kirafan3.ovallhealop(e,tp,eg,ep,ev,re,r,rp)
end
function s.dotteop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	main:RemoveCounter(tp,0xa06,1,REASON_EFFECT)
	local g=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,LOCATION_MZONE,0,nil)
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,3)
		tc:RegisterEffect(e1)
	end
end

function s.dottecost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and
	Duel.IsExistingMatchingCard(Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,1,nil)
	and Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,2,nil,tp) end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	main:AddCounter(0xa05,1)
	
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)
	local last=g:GetFirst()
	local tc=g:GetNext()
	for tc in aux.Next(g) do
		if tc:GetSequence()<last:GetSequence() then last=tc end
	end
	Duel.Remove(last,POS_FACEUP,REASON_EFFECT)
	local g2=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)
	local last2=g2:GetFirst()
	local tc2=g2:GetNext()
	for tc2 in aux.Next(g2) do
		if tc2:GetSequence()<last2:GetSequence() then last2=tc2 end
	end
	Duel.Remove(last2,POS_FACEUP,REASON_EFFECT)
	local g3=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)
	local last3=g3:GetFirst()
	local tc3=g3:GetNext()
	for tc3 in aux.Next(g3) do
		if tc3:GetSequence()<last3:GetSequence() then last3=tc3 end
	end
	Duel.Remove(last3,POS_FACEUP,REASON_EFFECT)
	
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050115,0))
	local ag=Duel.SelectMatchingCard(tp,Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.ChangePosition(ag:GetFirst(),POS_FACEUP_DEFENSE)
end
function s.dottecost22(e,tp,eg,ep,ev,re,r,rp,chk)
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and
	Duel.IsExistingMatchingCard(Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,1,nil)
	and Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,2,nil,tp) end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	main:AddCounter(0xa06,1)
	
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)
	local last=g:GetFirst()
	local tc=g:GetNext()
	for tc in aux.Next(g) do
		if tc:GetSequence()<last:GetSequence() then last=tc end
	end
	Duel.Remove(last,POS_FACEUP,REASON_EFFECT)
	local g2=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)
	local last2=g2:GetFirst()
	local tc2=g2:GetNext()
	for tc2 in aux.Next(g2) do
		if tc2:GetSequence()<last2:GetSequence() then last2=tc2 end
	end
	Duel.Remove(last2,POS_FACEUP,REASON_EFFECT)
	local g3=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)
	local last3=g3:GetFirst()
	local tc3=g3:GetNext()
	for tc3 in aux.Next(g3) do
		if tc3:GetSequence()<last3:GetSequence() then last3=tc3 end
	end
	Duel.Remove(last3,POS_FACEUP,REASON_EFFECT)
	
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050115,0))
	local ag=Duel.SelectMatchingCard(tp,Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.ChangePosition(ag:GetFirst(),POS_FACEUP_DEFENSE)
end