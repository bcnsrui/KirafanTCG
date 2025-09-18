local s,id=GetID()
function s.initial_effect(c)
	Kirafan2.CreamateCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(s.fccondition)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(10050111,5))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(Kirafan6.damcon)
	e5:SetCost(Kirafan2.dottecost(2))
	e5:SetTarget(Kirafan6.damtg)
	e5:SetOperation(s.damop)
	c:RegisterEffect(e5)
	Kirafan6.NoDotteEffcon(c,2)
end
function s.fccondition(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetMatchingGroupCount(s.lightfilter,tp,LOCATION_ONFIELD,0,nil)>=3
end
function s.filter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT|ATTRIBUTE_DARK) and not c:IsLocation(LOCATION_EMZONE)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local ally=Duel.GetMatchingGroupCount(s.filter,tp,LOCATION_ONFIELD,0,c)
	local enemy=Duel.GetMatchingGroupCount(s.filter,tp,0,LOCATION_ONFIELD,c)
	if ally>0 and enemy>0 then dam=4
	elseif enemy>0 then dam=3
	elseif ally>0 then dam=2
	else dam=1 end
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	Kirafan6.damageeff(e,tp,eg,ep,ev,re,r,rp,tg,dam)
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end