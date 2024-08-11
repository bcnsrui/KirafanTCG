--키라판은 일러스트 어플이다
Kirafan2={}

--크리에메이트 유틸
function Kirafan2.CreamateCharacter(c)
	c:EnableCounterPermit(0xb01)
	c:EnableCounterPermit(0xb02)
	c:EnableCounterPermit(0xb03)
	c:EnableCounterPermit(0xc02)
	Kirafan2.SummonCreamate(c)
	Kirafan2.CreamateEff(c)
	Kirafan2.CreamateBattle(c)
	Kirafan2.Creamaterecovery(c)
end


--크리에메이트 소환
function Kirafan2.SummonCreamate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	e1:SetCondition(Kirafan2.callcon)
	e1:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e1)
end
function Kirafan2.callcon(e,c)
    if c==nil then return true end
	local tp=c:GetControler()
	local tc=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	local CreamateLv=Duel.GetMatchingGroup(nil,tp,LOCATION_ONFIELD,0,nil):GetSum(Card.GetLevel)
    return (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and tc:GetDefense()-CreamateLv>=c:GetLevel())
	or tc:IsCode(10050110)
end

--유희왕과 다른 룰(1표시형식변경불가,2~3통상소환불가,4체력은수비력,5수비공격가능,6공격선언시1돗테,7hp채우기)
function Kirafan2.CreamateEff(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_MSET)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_SET_DEFENSE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(Kirafan2.hpval)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCode(EFFECT_DEFENSE_ATTACK)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
    e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e6:SetCode(EVENT_ATTACK_ANNOUNCE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetCountLimit(1)
    e6:SetOperation(Kirafan2.AttackDotteop)
    c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_SPSUMMON_SUCCESS)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetOperation(Kirafan2.hpop)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetCode(EFFECT_DESTROY_REPLACE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetTarget(Kirafan2.NoBtDestroy)
	c:RegisterEffect(e8)
end
function Kirafan2.AttackDotteop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsSetCard(0xb01) then return end
    Duel.DiscardDeck(tp,1,REASON_EFFECT)
end
function Kirafan2.hpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local hp=c:GetBaseDefense()
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	local bg=Duel.GetDecktopGroup(tp,hp)
	if deckcount<hp then
	local bg1=Duel.GetDecktopGroup(tp,deckcount)
	Duel.Overlay(c,bg1)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	local bg2=Duel.GetDecktopGroup(tp,hp-deckcount)
	Duel.Overlay(c,bg2)
	else
	Duel.Overlay(c,bg) end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_ADJUST)
	e1:SetCondition(Kirafan2.hp0con)
	e1:SetOperation(Kirafan2.hp0op)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	Duel.RegisterEffect(e1,tp)
end
function Kirafan2.hp0con(e)
	return e:GetHandler():GetDefense()==0
end
function Kirafan2.hp0op(e,tp,eg,ep,ev,re,r,rp)
	return Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function Kirafan2.hpval(e,c)
	return c:GetOverlayGroup():GetCount()
end
function Kirafan2.NoBtDestroy(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
		and c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	return true
end

--데미지처리(1단일공격,2광역공격)
function Kirafan2.CreamateBattle(c)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCondition(Kirafan2.battlecon)
	e1:SetOperation(Kirafan2.battleop)
    c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCondition(Kirafan2.Allbattlecon)
	e2:SetOperation(Kirafan2.Allbattleop)
    c:RegisterEffect(e2)
end
function Kirafan2.battlecon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsSetCard(0xa02) and Duel.GetAttacker():IsControler(tp)
end
function Kirafan2.battleop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local enemy=c:GetBattleTarget()
	local dam=c:GetAttack()
	if enemy==nil then return end
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local g=enemy:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=enemy:GetOverlayGroup():RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function Kirafan2.Allbattlecon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSetCard(0xa02) and Duel.GetAttacker():IsControler(tp)
end
function Kirafan2.Allbattleop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local enemy=Duel.GetMatchingGroup(Kirafan.NoEmzonefilter,tp,0,LOCATION_MZONE,nil)
	if enemy==nil then return end
	local dam=math.floor(c:GetAttack()/2)
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local ag=enemy:GetFirst()
	for ag in aux.Next(enemy) do
	local g=ag:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=ag:GetOverlayGroup():RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end end
end

--리커버리
function Kirafan2.Creamaterecovery(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(Kirafan2.recoverycon2)
	e1:SetOperation(Kirafan2.recoveryop2)
	c:RegisterEffect(e1)
end
function Kirafan2.recoverycon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0xc02)>0
end
function Kirafan2.recoveryop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ahp=c:GetDefense()
	local bhp=c:GetBaseDefense()
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	recoveryheal=2
	if bhp<=ahp then recoveryheal=0
	elseif bhp-ahp<recoveryheal then recoveryheal=bhp-ahp end
	local bg=Duel.GetDecktopGroup(tp,recoveryheal)
	if deckcount<recoveryheal then
	local bg1=Duel.GetDecktopGroup(tp,deckcount)
	Duel.Overlay(c,bg1)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	local bg2=Duel.GetDecktopGroup(tp,recoveryheal-deckcount)
	Duel.Overlay(c,bg2)
	else
	local bg=Duel.GetDecktopGroup(tp,recoveryheal)
	Duel.Overlay(c,bg) end
end

--코스트
function Kirafan2.dottecost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,1,nil,tp) end
	Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE)	
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)
	local last=g:GetFirst()
	local tc=g:GetNext()
	for tc in aux.Next(g) do
		if tc:GetSequence()<last:GetSequence() then last=tc end
	end
	Duel.Remove(last,POS_FACEUP,REASON_EFFECT)
end

function Kirafan2.dottecost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,2,nil,tp) end
	Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE)	
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
end

function Kirafan2.dottecost3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,3,nil,tp) end
	Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE)	
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
end

function Kirafan2.dottecost4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,4,nil,tp) end
	Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE)	
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
	local g4=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)
	local last4=g4:GetFirst()
	local tc4=g4:GetNext()
	for tc4 in aux.Next(g4) do
		if tc4:GetSequence()<last4:GetSequence() then last4=tc4 end
	end
	Duel.Remove(last4,POS_FACEUP,REASON_EFFECT)
end
