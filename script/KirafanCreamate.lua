--키라판은 일러스트 어플이다
Kirafan2={}

--크리에메이트 유틸
function Kirafan2.CreamateCharacter(c)
	c:EnableCounterPermit(0xb01)
	c:EnableCounterPermit(0xb02)
	c:EnableCounterPermit(0xb03)
	c:EnableCounterPermit(0xb04)
	c:EnableCounterPermit(0xb05)
	c:EnableCounterPermit(0xb06)
	c:EnableCounterPermit(0xc01)
	c:EnableCounterPermit(0xc02)
	c:EnableCounterPermit(0xc04)
	c:EnableCounterPermit(0xd01)
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
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	local CreamateLv=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_ONFIELD,0,nil):GetSum(Card.GetLevel)
    return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and (main:GetDefense()-CreamateLv>=c:GetLevel()
	or main:IsCode(10050110))
end

--유희왕과 다른 룰(1표시형식변경불가,2~3통상소환불가,4체력은수비력,5수비공격가능,6공격선언시1돗테,7hp채우기,9성전유지)
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
    e6:SetCode(EVENT_DAMAGE_STEP_END)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetCountLimit(1)
	e6:SetCondition(function(_,tp) return Duel.GetTurnPlayer()==tp end)
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
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e9:SetCode(EVENT_TO_DECK)
	e9:SetCondition(Kirafan2.hp0con2)
	e9:SetOperation(Kirafan2.hp0op2)
	c:RegisterEffect(e9)
end
function Kirafan2.AttackDotteop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsSetCard(0xb01) then return end
    Kirafan6.firafandotteop(e,tp,eg,ep,ev,re,r,rp,1)
end
function Kirafan2.hpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local hp=c:GetBaseDefense()
	Kirafan6.hpaddop(e,tp,eg,ep,ev,re,r,rp,c,hp)
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
function Kirafan2.hp0con2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	return main:GetOverlayGroup():GetCount()>0 and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
	and c:IsLocation(LOCATION_EXTRA) and Duel.GetCurrentPhase()~=PHASE_STANDBY
end
function Kirafan2.hp0op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	local g=main:GetOverlayGroup()
	tc=g:RandomSelect(tp,1)
	Duel.Remove(tc,POS_FACEUP,REASON_RULE)
end

--데미지처리(1무량공격,2카운터필요,3단일공격,4광역공격,5히로)
function Kirafan2.CreamateBattle(c)
	local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetCode(EFFECT_EXTRA_ATTACK)
    e1:SetValue(100)
    c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetCondition(Kirafan2.atkcon)
	c:RegisterEffect(e2)
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCondition(Kirafan2.battlecon)
	e3:SetOperation(Kirafan2.battleop)
    c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e4:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCondition(Kirafan2.Allbattlecon)
	e4:SetOperation(Kirafan2.Allbattleop)
    c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e5:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCondition(Kirafan2.battlecon2)
	e5:SetOperation(Kirafan2.battleop2)
    c:RegisterEffect(e5)
end
function Kirafan2.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0xc01)==0
end
function Kirafan2.battlecon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsSetCard(0xa02) and Duel.GetAttacker():IsControler(tp) and c:GetCounter(0xc04)==0
end
function Kirafan2.battleop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local enemy=c:GetBattleTarget()
	local dam=c:GetAttack()
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	Kirafan6.damageeff(e,tp,eg,ep,ev,re,r,rp,enemy,dam)
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
	c:RemoveCounter(tp,0xc01,1,REASON_EFFECT)
end
function Kirafan2.Allbattlecon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSetCard(0xa02) and Duel.GetAttacker():IsControler(tp)
end
function Kirafan2.Allbattleop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local dam=math.floor(c:GetAttack()/2)
	local g=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	for tc in g:Iter() do
	Kirafan6.damageeff(e,tp,eg,ep,ev,re,r,rp,tc,dam) end
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
	c:RemoveCounter(tp,0xc01,1,REASON_EFFECT)
end
function Kirafan2.battlecon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsSetCard(0xa02) and Duel.GetAttacker():IsControler(tp) and c:GetCounter(0xc04)>0
end
function Kirafan2.battleop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local dam=c:GetAttack()
	local g=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	for tc in g:Iter() do
	Kirafan6.damageeff(e,tp,eg,ep,ev,re,r,rp,tc,dam) end
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
	c:RemoveCounter(tp,0xc01,1,REASON_EFFECT)
	c:RemoveCounter(tp,0xc04,1,REASON_EFFECT)
end

--1리커버리,2수면,3고립
function Kirafan2.Creamaterecovery(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(Kirafan2.recoverycon2)
	e1:SetOperation(Kirafan3.sghealop(2))
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(Kirafan2.sleepcon)
	e2:SetValue(-1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_SET_ATTACK_FINAL)
	e3:SetCondition(Kirafan2.alonecon)
	e3:SetValue(Kirafan2.alonevalue)
	c:RegisterEffect(e3)
end
function Kirafan2.recoverycon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0xc02)>0
end
function Kirafan2.sleepcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0xb05)>0
end
function Kirafan2.alonecon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0xb06)>0
end
function Kirafan2.alonevalue(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBaseAttack()
end

--배틀 코스트
function Kirafan2.dottecost(dotte)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,dotte,nil,tp) end
	Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp,dotte) end
end

--배틀 코스트(레스트)
function Kirafan2.dotterestcost(dotte,rest)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,dotte,nil,tp)
	and Duel.IsExistingMatchingCard(Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,rest,e:GetHandler()) end
	Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp,dotte)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050115,0))
	local ag=Duel.SelectMatchingCard(tp,Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,rest,rest,e:GetHandler())
	Duel.ChangePosition(ag,POS_FACEUP_DEFENSE) end
end

--서포트 코스트(등장)
function Kirafan2.spcost(hint)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Kirafan6.supporthint(e,tp,eg,ep,ev,re,r,rp,hint) end
end

--서포트 코스트
function Kirafan2.spdottecost(dotte,hint)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and
	Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,dotte,nil,tp) end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Kirafan6.supporthint(e,tp,eg,ep,ev,re,r,rp,hint)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp,dotte) end
end

--서포트 코스트(레스트만)
function Kirafan2.sprestcost(rest,hint)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and
	Duel.IsExistingMatchingCard(Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,rest,nil) end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Kirafan6.supporthint(e,tp,eg,ep,ev,re,r,rp,hint)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050115,0))
	local ag=Duel.SelectMatchingCard(tp,Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,rest,rest,nil)
	Duel.ChangePosition(ag,POS_FACEUP_DEFENSE) end
end

--서포트 코스트(레스트)
function Kirafan2.spdotterestcost(dotte,rest,hint)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and
	Duel.IsExistingMatchingCard(Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,rest,nil) and
	Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,dotte,nil,tp) end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Kirafan6.supporthint(e,tp,eg,ep,ev,re,r,rp,hint)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp,dotte)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050115,0))
	local ag=Duel.SelectMatchingCard(tp,Kirafan6.loadfactorfilter,tp,LOCATION_MZONE,0,rest,rest,nil)
	Duel.ChangePosition(ag,POS_FACEUP_DEFENSE) end
end