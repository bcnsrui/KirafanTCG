local s,id=GetID()
function s.initial_effect(c)
	Kirafan2.CreamateCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(s.atkcon)
	e1:SetOperation(s.atkop)
	c:RegisterEffect(e1)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(10050111,5))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(s.damcon)
	e5:SetCost(Kirafan2.dottecost2)
	e5:SetTarget(s.damtg)
	e5:SetOperation(s.damop)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(10050111,6))
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetCode(EVENT_FREE_CHAIN)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCondition(s.damcon)
	e6:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(Kirafan.NoEmzonefilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetChainLimit(aux.FALSE) end)
	c:RegisterEffect(e6)
end
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return (e:GetHandler():GetDefense()>=6 or e:GetHandler():GetAttack()>=3)
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(1)
	e:GetHandler():RegisterEffect(e1)
end
function s.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_BATTLE_STEP and e:GetHandler():GetCounter(0xb03)==0 and not e:GetHandler():IsDefensePos()
	and not (Duel.GetAttacker() and Duel.GetAttacker():IsControler(tp)) and Duel.GetTurnPlayer()==tp
	and Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,2,nil,tp)
end
function s.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan.NoEmzonefilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,Kirafan3.Nohealfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetChainLimit(s.chainlm)
end
function s.chainlm(e,ep,tp)
	return ep~=tp
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetFirstTarget()
	local sun=Duel.GetMatchingGroupCount(Card.IsAttribute,tp,LOCATION_ONFIELD,0,c,ATTRIBUTE_LIGHT)
	local moon=Duel.GetMatchingGroupCount(Card.IsAttribute,tp,LOCATION_ONFIELD,0,c,ATTRIBUTE_DARK)
	local sun1=Duel.GetMatchingGroupCount(Card.IsAttribute,tp,0,LOCATION_ONFIELD,nil,ATTRIBUTE_LIGHT)
	local moon1=Duel.GetMatchingGroupCount(Card.IsAttribute,tp,0,LOCATION_ONFIELD,nil,ATTRIBUTE_DARK)
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
end