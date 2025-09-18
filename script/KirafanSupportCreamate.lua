--키라판 유일신 유노
Kirafan3={}

--서포트 크리에메이트 유틸
function Kirafan3.SpCreamateCharacter(c)
	Kirafan3.SpCreamateEff(c)
end

--유희왕과 다른 룰(1~2통상소환불가,3발동제약,4-6발동안하기)
function Kirafan3.SpCreamateEff(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_MSET)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EFFECT_CANNOT_TRIGGER)
	e3:SetCondition(Kirafan3.triggercon)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(10050111,8))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetHintTiming(TIMING_BATTLE_STEP_END)
	e4:SetRange(LOCATION_HAND)
	e4:SetCondition(Kirafan6.spcreamatecon)
	e4:SetTarget(Kirafan3.noeffecttg)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	c:RegisterEffect(e5)
end
function Kirafan3.triggercon(e)
	local c=e:GetHandler()
	local tp=e:GetHandlerPlayer()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	local CreamateLv=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_ONFIELD,0,nil):GetSum(Card.GetLevel)
    return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and main:GetDefense()-CreamateLv<c:GetLevel()
	and not main:IsCode(10050110) and c:IsLocation(LOCATION_HAND)
end
function Kirafan3.noeffecttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local code=c:GetOriginalCode()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return c:GetFlagEffect(code)==0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	c:RegisterFlagEffect(code,RESET_EVENT|RESETS_STANDARD|RESET_CHAIN,0,1)
	Duel.SetChainLimit(Kirafan3.noeffectchainlm)
end
function Kirafan3.noeffectchainlm(te,rp,tp)
	return not te:GetHandler():IsCode(10051321)
end

--불행 제외
function Kirafan3.Nohealfilter(c)
	return not c:IsLocation(LOCATION_EMZONE) and c:GetCounter(0xb02)==0
end

--(공통 효과에서 제외)일반 스킬 단일 회복 효과
function Kirafan3.SpCreamateSgHeal(c,heal)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050113,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan6.spcreamatecon)
	e1:SetCost(Kirafan2.spcost(1))
	e1:SetTarget(Kirafan3.sghealtg)
	e1:SetOperation(Kirafan3.sghealop(heal))
	c:RegisterEffect(e1)
end
function Kirafan3.sghealtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050112,0))
	local g=Duel.SelectTarget(tp,Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function Kirafan3.sghealop(heal)
	return function(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	local hp=tc:GetBaseDefense()-tc:GetDefense()
	local heal2=math.max(0,(math.min(heal,hp)))
	Kirafan6.hpaddop(e,tp,eg,ep,ev,re,r,rp,tc,heal2) end
end

--(공통 효과에서 제외)일반 스킬 전체 회복 효과
function Kirafan3.SpCreamateAllHeal(c,heal)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050113,1))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan6.spcreamatecon)
	e1:SetCost(Kirafan2.spcost(2))
	e1:SetTarget(Kirafan3.allhealtg)
	e1:SetOperation(Kirafan3.allhealop(heal))
	c:RegisterEffect(e1)
end
function Kirafan3.allhealtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingMatchingCard(Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function Kirafan3.allhealop(heal)
	return function(e,tp,eg,ep,ev,re,r,rp)
	local hg=Duel.GetMatchingGroup(Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,nil)
	local c=e:GetHandler()
	for tc in hg:Iter() do
	local hp=tc:GetBaseDefense()-tc:GetDefense()
	local heal2=math.max(0,(math.min(heal,hp)))
	Kirafan6.hpaddop(e,tp,eg,ep,ev,re,r,rp,tc,heal2) end end
end

--(공통 효과에서 제외)일반 스킬 단일 오버힐 효과
function Kirafan3.SpCreamateOvSgHeal(c,heal)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050113,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan6.spcreamatecon)
	e1:SetCost(Kirafan2.spcost(1))
	e1:SetTarget(Kirafan3.ovsghealtg)
	e1:SetOperation(Kirafan3.ovsghealop(heal))
	c:RegisterEffect(e1)
end
function Kirafan3.ovsghealtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050112,0))
	local g=Duel.SelectTarget(tp,Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function Kirafan3.ovsghealop(heal)
	return function(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	Kirafan6.hpaddop(e,tp,eg,ep,ev,re,r,rp,tc,heal) end
end

--(공통 효과에서 제외)일반 스킬 전체 오버힐 효과
function Kirafan3.SpCreamateOvAllHeal(c,heal)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050113,1))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan6.spcreamatecon)
	e1:SetCost(Kirafan2.spcost(2))
	e1:SetTarget(Kirafan3.ovallhealtg)
	e1:SetOperation(Kirafan3.ovallhealop(heal))
	c:RegisterEffect(e1)
end
function Kirafan3.ovallhealtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingMatchingCard(Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function Kirafan3.ovallhealop(heal)
	return function(e,tp,eg,ep,ev,re,r,rp)
	local hg=Duel.GetMatchingGroup(Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,nil)
	local c=e:GetHandler()
	for tc in hg:Iter() do
	Kirafan6.hpaddop(e,tp,eg,ep,ev,re,r,rp,tc,heal) end end
end