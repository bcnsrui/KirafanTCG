local s,id=GetID()
function s.initial_effect(c)
	Kirafan2.CreamateCharacter(c)
	-- [패시브] 상대 필드에 수면 상태의 크리에메이트가 있으면 공격력+1
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(s.atkcon)
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
function s.sleepfilter(c)
	return Kirafan6.NoEmFzonefilter(c) and c:GetCounter(0xb05)>0
end
function s.atkcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(s.sleepfilter,tp,0,LOCATION_ONFIELD,1,nil)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local dam=2
	if tg:GetCounter(0xb05)>0 then dam=5 end
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	Kirafan6.damageeff(e,tp,eg,ep,ev,re,r,rp,tg,dam)
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end