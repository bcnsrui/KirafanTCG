local s,id=GetID()
function s.initial_effect(c)
	Kirafan4.AlcheCreamateCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_FZONE)
	e1:SetCost(s.cost)
	e1:SetTarget(Kirafan3.allhealtg)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCondition(Kirafan6.spcreamatecon)
	c:RegisterEffect(e2)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_RULE)
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Kirafan6.allhealhint(e,tp,eg,ep,ev,re,r,rp)
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Kirafan3.allhealop(e,tp,eg,ep,ev,re,r,rp)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	e2:SetCondition(s.alicecon)	
	e2:SetOperation(s.alicetrigger)
	c:RegisterEffect(e2)
end
function s.alicecon(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,1,nil,tp)
end
function s.alicetrigger(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDeck(c,nil,-2,REASON_RULE)
	local alice=Duel.CreateToken(tp,10055112)
	Duel.MoveToField(alice,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.SendtoDeck(alice,nil,0,REASON_RULE) end
end