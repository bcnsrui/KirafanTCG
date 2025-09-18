--키라판 카드게임의 공통적인 임플란트
Kirafan6={}

--배틀 크리에메이트 돗테오키 발동조건
function Kirafan6.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_BATTLE_STEP and e:GetHandler():GetCounter(0xb03)==0
	and not e:GetHandler():IsDefensePos() and Duel.GetCurrentChain()==0
	and not (Duel.GetAttacker() and Duel.GetAttacker():IsControler(tp)) and Duel.GetTurnPlayer()==tp
end
--카운터 타이밍
function Kirafan6.spcreamatecon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetTurnPlayer()==tp and (Duel.IsMainPhase() or Duel.GetCurrentPhase()==PHASE_BATTLE_STEP)
	and not (Duel.GetAttacker() and Duel.GetAttacker():IsControler(tp)) and Duel.GetCurrentChain()==0) or
	(Duel.GetTurnPlayer()~=tp and (Duel.GetCurrentPhase()==PHASE_BATTLE_START or
	Duel.GetCurrentPhase()==PHASE_BATTLE_STEP or Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL))
end

--배틀 크리에메이트 돗테오키 발동조건(대상)
function Kirafan6.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050112,1))
	local g=Duel.SelectTarget(tp,Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,1,nil)
end
function Kirafan6.damtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetChainLimit(aux.FALSE)
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
	return not c:IsLocation(LOCATION_EMZONE)
end

--자신 돗테오키 게이지 줄이기
function Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp,dotte)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)
	local consumedotte=0
	local dotte2=(math.min(#g,dotte))
	while consumedotte<dotte2 do
	local last=g:GetFirst()
	local tc=g:GetNext()
	for tc in aux.Next(g) do
		if tc:GetSequence()<last:GetSequence() then last=tc end
	end
	Duel.Remove(last,POS_FACEUP,REASON_EFFECT)
	consumedotte=consumedotte+1 end
end

--상대 돗테오키 게이지 줄이기
function Kirafan6.consumeenemydotte(e,tp,eg,ep,ev,re,r,rp,dotte)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,0,LOCATION_GRAVE,nil)
	local consumeenemydotte=0
	local dotte2=(math.min(#g,dotte))
	while consumeenemydotte<dotte2 do
	local last=g:GetFirst()
	local tc=g:GetNext()
	for tc in aux.Next(g) do
		if tc:GetSequence()<last:GetSequence() then last=tc end
	end
	Duel.Remove(last,POS_FACEUP,REASON_EFFECT)
	consumeenemydotte=consumeenemydotte+1 end
end

--배고픔시 데미지
function Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetCounter(0xb04)>0 then
	Duel.Damage(tp,1,REASON_EFFECT)
	hunger=e:GetHandler():GetOverlayGroup():RandomSelect(tp,1)
	Duel.Remove(hunger,POS_FACEUP,REASON_EFFECT) end
end

--드로우 트리거
function Kirafan6.drawtrigger(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetOperation(Kirafan6.drawtriggerop)
	c:RegisterEffect(e1)
end
function Kirafan6.drawtriggerop(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.kirafandrawop(e,tp,eg,ep,ev,re,r,rp,1)
end

--돗테오키 트리거
function Kirafan6.guagetrigger(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetOperation(Kirafan6.guagetriggerop)
	c:RegisterEffect(e1)
end
function Kirafan6.guagetriggerop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
end

--돗테오키 발동안하기
function Kirafan6.NoDotteEffcon(c,cost)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050111,6))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(Kirafan6.damcon)
	e1:SetCost(function(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,cost,nil,tp) end end)
	e1:SetTarget(Kirafan6.damtg2)
	c:RegisterEffect(e1)
end

--키라판드로우
function Kirafan6.kirafandrawop(e,tp,eg,ep,ev,re,r,rp,draw)
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	if deckcount<=draw then
	Duel.Draw(tp,deckcount,REASON_RULE)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	Duel.Draw(tp,draw-deckcount,REASON_RULE)
	else Duel.Draw(tp,draw,REASON_RULE) end
end

--키라판돗테오키게이지
function Kirafan6.firafandotteop(e,tp,eg,ep,ev,re,r,rp,dotte)
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	if deckcount<=dotte then
	Duel.DiscardDeck(tp,deckcount,REASON_EFFECT)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	Duel.DiscardDeck(tp,dotte-deckcount,REASON_EFFECT)
	else Duel.DiscardDeck(tp,dotte,REASON_EFFECT) end
end

--크리에메이트 체력 채우기
function Kirafan6.hpaddop(e,tp,eg,ep,ev,re,r,rp,hg,hp)
	local c=e:GetHandler()
	local heal=0
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	local bg=Duel.GetDecktopGroup(tp,hp)
	if deckcount<hp then
	local bg1=Duel.GetDecktopGroup(tp,deckcount)
	Duel.Overlay(hg,bg1)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	local bg2=Duel.GetDecktopGroup(tp,hp-deckcount)
	Duel.Overlay(hg,bg2)
	else Duel.Overlay(hg,bg) end
end

--크리에메이트 데미지 주기
function Kirafan6.damageeff(e,tp,eg,ep,ev,re,r,rp,ag,dam)
	local c=e:GetHandler()
	local typ=type(ag)
	if ag==nil then return end
	if typ=="Card" then tg=ag
	elseif typ=="Group" then tg=ag:GetFirst() end
	local g=tg:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else tc=g:RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT) end
	if tg:GetOverlayCount()==0 and tg:IsLocation(LOCATION_MZONE) then Duel.Destroy(tg,REASON_RULE) end
	if tg:GetOverlayCount()==1 and tg:GetCounter(0xb01)>0 and tg:IsLocation(LOCATION_MZONE) then Duel.Destroy(tg,REASON_RULE) end
end

--크리에메이트 상태이상 부여
function Kirafan6.statuseff(e,tp,eg,ep,ev,re,r,rp,g,sort,turn)
	local typ=type(g)
	if typ=="Card" then
	g:AddCounter(sort,turn-g:GetCounter(sort))
	elseif typ=="Group" then
	for tc in g:Iter() do
	tc:AddCounter(sort,turn-tc:GetCounter(sort)) end end
end

--크리에메이트 상태이상 해제
function Kirafan6.statusreset(e,tp,eg,ep,ev,re,r,rp,g)
	local typ=type(g)
	if typ=="Card" then
	g:RemoveCounter(tp,0xb01,g:GetCounter(0xb01),REASON_EFFECT)
	g:RemoveCounter(tp,0xb02,g:GetCounter(0xb02),REASON_EFFECT)
	g:RemoveCounter(tp,0xb03,g:GetCounter(0xb03),REASON_EFFECT)
	g:RemoveCounter(tp,0xb04,g:GetCounter(0xb04),REASON_EFFECT)
	g:RemoveCounter(tp,0xb05,g:GetCounter(0xb05),REASON_EFFECT)
	g:RemoveCounter(tp,0xb06,g:GetCounter(0xb06),REASON_EFFECT)	
	elseif typ=="Group" then
	for tc in g:Iter() do
	tc:RemoveCounter(tp,0xb01,tc:GetCounter(0xb01),REASON_EFFECT)
	tc:RemoveCounter(tp,0xb02,tc:GetCounter(0xb02),REASON_EFFECT)
	tc:RemoveCounter(tp,0xb03,tc:GetCounter(0xb03),REASON_EFFECT)
	tc:RemoveCounter(tp,0xb04,tc:GetCounter(0xb04),REASON_EFFECT)
	tc:RemoveCounter(tp,0xb05,tc:GetCounter(0xb05),REASON_EFFECT)
	tc:RemoveCounter(tp,0xb06,tc:GetCounter(0xb06),REASON_EFFECT) end end
end

--서포트 크리에메이트 힌트
function Kirafan6.supporthint(e,tp,eg,ep,ev,re,r,rp,hint)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10050115,hint))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end

--공격력 증가
function Kirafan6.atkchange(e,tp,eg,ep,ev,re,r,rp,reset1,reset2,g,atk)
	local typ=type(g)
	if typ=="Card" then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+reset1,reset2)
	g:RegisterEffect(e1)
	elseif typ=="Group" then
	for tc in g:Iter() do
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+reset1,reset2)
	tc:RegisterEffect(e1) end end	
end

--다음 공격의 공격력 증가
function Kirafan6.nextatkchange(e,tp,eg,ep,ev,re,r,rp,g,atk)
	for tc in g:Iter() do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_NO_TURN_RESET)
		e2:SetCode(EVENT_DAMAGE_STEP_END)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCountLimit(1)
		e2:SetCondition(function(_,tp) return Duel.GetTurnPlayer()==tp end)
		e2:SetOperation(Kirafan6.nextatkchangeop(atk))
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
	end
end
function Kirafan6.nextatkchangeop(atk)
	return function(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-atk)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e:GetHandler():RegisterEffect(e1) end
end