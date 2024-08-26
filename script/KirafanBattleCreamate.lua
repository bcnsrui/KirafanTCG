--키라판 카드게임의 공통적인 임플란트
Kirafan6={}

--배틀 크리에메이트 돗테오키 발동조건
function Kirafan6.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_BATTLE_STEP and e:GetHandler():GetCounter(0xb03)==0
	and not e:GetHandler():IsDefensePos() and Duel.GetCurrentChain()==0
	and not (Duel.GetAttacker() and Duel.GetAttacker():IsControler(tp)) and Duel.GetTurnPlayer()==tp
end

--배틀 크리에메이트 돗테오키 발동조건(대상)
function Kirafan6.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050112,1))
	local g=Duel.SelectTarget(tp,Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,1,nil)
end
--배틀 크리에메이트 돗테오키 발동조건(비대상)
function Kirafan6.nodamtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingMatchingCard(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil) end
end
--서포트 크리에메이트 발동 조건 없음
function Kirafan6.nospcondamtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return true end
end
--서포트 크리에메이트 돗테오키 발동조건(대상)
function Kirafan6.spdamtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050112,2))
	local g=Duel.SelectTarget(tp,Kirafan6.NoEmFzonefilter,tp,LOCATION_MZONE,0,1,1,nil)
end
--서포트 크리에메이트 돗테오키 발동조건(비대상)
function Kirafan6.nospdamtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingMatchingCard(Kirafan6.NoEmFzonefilter,tp,LOCATION_MZONE,0,1,nil) end
end

--추가로 경직하기
function Kirafan6.loadfactorfilter(c)
	return c:IsAttackPos() and not c:IsLocation(LOCATION_EMZONE)
end
function Kirafan6.NoEmFzonefilter(c)
	return not c:IsLocation(LOCATION_EMZONE+LOCATION_FZONE)
end

--상대턴
function Kirafan6.dottecon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
--상대 돗테오키 발동시
function Kirafan6.dottecon2(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and Duel.IsBattlePhase() and Duel.GetTurnPlayer()~=tp
end

--돗테오키 발동안하기
function Kirafan6.NoDotteEffcon1(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050111,6))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(Kirafan6.damcon)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil)
	and Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetChainLimit(aux.FALSE) end)
	c:RegisterEffect(e1)
end
function Kirafan6.NoDotteEffcon2(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050111,6))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(Kirafan6.damcon)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil)
	and Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.SetChainLimit(aux.FALSE) end)
	c:RegisterEffect(e1)
end
function Kirafan6.NoDotteEffcon3(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050111,6))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(Kirafan6.damcon)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil)
	and Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,3,nil) end
	Duel.SetChainLimit(aux.FALSE) end)
	c:RegisterEffect(e1)
end
function Kirafan6.NoDotteEffcon4(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050111,6))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(Kirafan6.damcon)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil)
	and Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,4,nil) end
	Duel.SetChainLimit(aux.FALSE) end)
	c:RegisterEffect(e1)
end