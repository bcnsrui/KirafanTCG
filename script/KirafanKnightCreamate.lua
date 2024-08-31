--키라판 나이트
Kirafan5={}

--나이트 크리에메이트 유틸
function Kirafan5.KnCreamateCharacter(c)
	Kirafan2.CreamateCharacter(c)
	c:SetUniqueOnField(1,0,aux.FilterBoolFunction(Card.IsRace,RACE_FAIRY),LOCATION_MZONE)
end

--통상 공격 유도
function Kirafan5.Aggroknight(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(Kirafan5.atlimit)
	c:RegisterEffect(e1)
end
function Kirafan5.atlimit(e,c)
	return c~=e:GetHandler()
end
--돗테오키 효과 유도
function Kirafan5.SkillAggroknight(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(Kirafan5.atlimit)
	e1:SetValue(Kirafan5.atval)
	c:RegisterEffect(e1)
end
function Kirafan5.atval(e,re,rp)
	if re:GetActivateLocation()==LOCATION_MZONE then return true end
end

--나이트 1뎀 돗테오키
function Kirafan5.KnightDotte1(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050111,5))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(Kirafan6.damcon)
	e1:SetCost(Kirafan2.dottecost1)
	e1:SetTarget(Kirafan6.damtg)
	e1:SetOperation(Kirafan5.Knightdamop1)
	c:RegisterEffect(e1)
	Kirafan6.NoDotteEffcon1(c)
end
function Kirafan5.Knightdamop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local dam=1
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local g=tg:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=g:RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end

--나이트 2뎀 돗테오키
function Kirafan5.KnightDotte2(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050111,5))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(Kirafan6.damcon)
	e1:SetCost(Kirafan2.dottecost2)
	e1:SetTarget(Kirafan6.damtg)
	e1:SetOperation(Kirafan5.Knightdamop2)
	c:RegisterEffect(e1)
	Kirafan6.NoDotteEffcon2(c)
end
function Kirafan5.Knightdamop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local dam=2
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local g=tg:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=g:RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end