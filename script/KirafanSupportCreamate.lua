--키라판 유일신 유노
Kirafan3={}

--서포트 크리에메이트 유틸
function Kirafan3.SpCreamateCharacter(c)
	Kirafan3.SpCreamateEff(c)

--	Kirafan3.HintUnit(c)
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
	and not main:IsCode(10050110)
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

--(공통 효과에서 제외)일반 스킬 단일 회복 효과
function Kirafan3.SpCreamateSgHeal(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050113,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan6.spcreamatecon)
	e1:SetCost(Kirafan3.sghealcost)
	e1:SetTarget(Kirafan3.sghealtg)
	e1:SetOperation(Kirafan3.sghealop)
	c:RegisterEffect(e1)
end
function Kirafan3.sghealcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Kirafan6.sghealhint(e,tp,eg,ep,ev,re,r,rp)
end
function Kirafan3.Nohealfilter(c)
	return not c:IsLocation(LOCATION_EMZONE) and c:GetCounter(0xb02)==0
end
function Kirafan3.sghealtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050112,0))
	local g=Duel.SelectTarget(tp,Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function Kirafan3.sghealop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	local ahp=tc:GetDefense()
	local bhp=tc:GetBaseDefense()
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	if c:IsCode(10054110) then sgheal=3
	else sgheal=4 end
	if bhp<=ahp then sgheal=0
	elseif bhp-ahp<sgheal then sgheal=bhp-ahp end
	local bg=Duel.GetDecktopGroup(tp,sgheal)
	if deckcount<sgheal then
	local bg1=Duel.GetDecktopGroup(tp,deckcount)
	Duel.Overlay(tc,bg1)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	local bg2=Duel.GetDecktopGroup(tp,sgheal-deckcount)
	Duel.Overlay(tc,bg2)
	else
	local bg=Duel.GetDecktopGroup(tp,sgheal)
	Duel.Overlay(tc,bg) end
end

--(공통 효과에서 제외)일반 스킬 전체 회복 효과
function Kirafan3.SpCreamateAllHeal(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050113,1))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan6.spcreamatecon)
	e1:SetCost(Kirafan3.allhealcost)
	e1:SetTarget(Kirafan3.allhealtg)
	e1:SetOperation(Kirafan3.allhealop)
	c:RegisterEffect(e1)
end
function Kirafan3.allhealcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Kirafan6.allhealhint(e,tp,eg,ep,ev,re,r,rp)
end
function Kirafan3.allhealtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingMatchingCard(Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function Kirafan3.allhealop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local hg=Duel.GetMatchingGroup(Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,nil)
	local tc=hg:GetFirst()
	for tc in aux.Next(hg) do
	local ahp=tc:GetDefense()
	local bhp=tc:GetBaseDefense()
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	if c:IsCode(10055113) then allheal=1
	else allheal=2 end
	if bhp<=ahp then allheal=0
	elseif bhp-ahp<allheal then allheal=bhp-ahp end
	local bg=Duel.GetDecktopGroup(tp,allheal)
	if deckcount<allheal then
	local bg1=Duel.GetDecktopGroup(tp,deckcount)
	Duel.Overlay(tc,bg1)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	local bg2=Duel.GetDecktopGroup(tp,allheal-deckcount)
	Duel.Overlay(tc,bg2)
	else
	local bg=Duel.GetDecktopGroup(tp,allheal)
	Duel.Overlay(tc,bg) end	end
end

--(공통 효과에서 제외)일반 스킬 단일 오버힐 효과
function Kirafan3.SpCreamateOvSgHeal(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050113,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan6.spcreamatecon)
	e1:SetCost(Kirafan3.sghealcost)
	e1:SetTarget(Kirafan3.ovsghealtg)
	e1:SetOperation(Kirafan3.ovsghealop)
	c:RegisterEffect(e1)
end
function Kirafan3.ovsghealtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050112,0))
	local g=Duel.SelectTarget(tp,Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function Kirafan3.ovsghealop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	if c:IsCode(10054520) then sgheal2=4
	else sgheal2=3 end
	local bg=Duel.GetDecktopGroup(tp,sgheal2)
	if deckcount<sgheal2 then
	local bg1=Duel.GetDecktopGroup(tp,deckcount)
	Duel.Overlay(tc,bg1)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	local bg2=Duel.GetDecktopGroup(tp,sgheal2-deckcount)
	Duel.Overlay(tc,bg2)
	else
	local bg=Duel.GetDecktopGroup(tp,sgheal2)
	Duel.Overlay(tc,bg) end
end

--(공통 효과에서 제외)일반 스킬 전체 오버힐 효과
function Kirafan3.SpCreamateOvAllHeal(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050113,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Kirafan6.spcreamatecon)
	e1:SetCost(Kirafan3.allhealcost)
	e1:SetTarget(Kirafan3.ovallhealtg)
	e1:SetOperation(Kirafan3.ovallhealop)
	c:RegisterEffect(e1)
end
function Kirafan3.ovallhealtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingMatchingCard(Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function Kirafan3.ovallhealop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local hg=Duel.GetMatchingGroup(Kirafan3.Nohealfilter,tp,LOCATION_MZONE,0,nil)
	local tc=hg:GetFirst()
	for tc in aux.Next(hg) do
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	if c:IsCode(10054110) then allheal2=4
	else allheal2=2 end
	local bg=Duel.GetDecktopGroup(tp,allheal2)
	if deckcount<allheal2 then
	local bg1=Duel.GetDecktopGroup(tp,deckcount)
	Duel.Overlay(tc,bg1)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	local bg2=Duel.GetDecktopGroup(tp,allheal2-deckcount)
	Duel.Overlay(tc,bg2)
	else
	local bg=Duel.GetDecktopGroup(tp,allheal2)
	Duel.Overlay(tc,bg) end	end
end

--코스트
function Kirafan3.dottecost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and
	Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,1,nil,tp) end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Kirafan6.dottehint(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
end

function Kirafan3.dottecost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and
	Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,2,nil,tp) end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Kirafan6.dottehint(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
end

function Kirafan3.dottecost3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and
	Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,3,nil,tp) end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Kirafan6.dottehint(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
end

function Kirafan3.dottecost4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and
	Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,4,nil,tp) end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Kirafan6.dottehint(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
end
