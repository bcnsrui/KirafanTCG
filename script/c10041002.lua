local s,id=GetID()
function s.initial_effect(c)
	Kirafan2.CreamateCharacter(c)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(EVENT_CHAIN_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(s.bossdamcon4)
	e4:SetTarget(s.damtg4)
	e4:SetOperation(s.damop4)
	c:RegisterEffect(e4)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_CHAIN_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(s.bossdamcon3)
	e3:SetTarget(s.damtg3)
	e3:SetOperation(s.damop3)
	c:RegisterEffect(e3)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_CHAIN_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(s.bossdamcon2)
	e2:SetTarget(s.damtg2)
	e2:SetOperation(s.damop2)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CHAIN_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(s.bossdamcon1)
	e1:SetTarget(s.damtg1)
	e1:SetOperation(s.damop1)
	c:RegisterEffect(e1)
end
function s.bossdamfilter(c)
	return c:IsAttackPos() and not c:IsLocation(LOCATION_EMZONE)
end
function s.bossdamcon1(e,tp,eg,ep,ev,re,r,rp)
	local ally=Duel.GetMatchingGroup(s.bossdamfilter,tp,LOCATION_MZONE,0,nil)
	return Duel.IsBattlePhase() and Duel.GetTurnPlayer()==tp and Duel.GetCurrentChain()==0
	and Duel.GetMatchingGroupCount(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)>0
	and Duel.GetMatchingGroupCount(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)>1 
	and #ally<2 and e:GetHandler():GetCounter(0xd01)<4
end
function s.damtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil) end
	local knight=Duel.GetMatchingGroup(Kirafan8.knightfilter,tp,0,LOCATION_MZONE,nil)
	local enemy=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	if #knight>0 then
	local sg=knight:GetFirst()
	Duel.SetTargetCard(sg)
	else
	local sg2=enemy:RandomSelect(tp,1)
	Duel.SetTargetCard(sg2) end
	
	local extraatk=Duel.GetRandomNumber(1,10)
	if (main:IsSetCard(0xd04) and extraatk>=6) or (main:IsSetCard(0xd03) and extraatk>=9) then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_CHAIN)
	e1:SetValue(2)
	c:RegisterEffect(e1)
	elseif (main:IsSetCard(0xd04) and extraatk<=5) or (main:IsSetCard(0xd03) and extraatk<=6)
	or (main:IsSetCard(0xd02) and extraatk<=5) then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_CHAIN)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	else end
	
	Duel.SetChainLimit(Kirafan8.mychainlimit)
end


function s.damop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local enemy=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	local attack=c:GetAttack()
	local dam=attack
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local g=tg:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=g:RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
	c:AddCounter(0xd01,1)
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end

function s.bossdamcon2(e,tp,eg,ep,ev,re,r,rp)
	local ally=Duel.GetMatchingGroup(s.bossdamfilter,tp,LOCATION_MZONE,0,nil)
	return Duel.IsBattlePhase() and Duel.GetTurnPlayer()==tp and Duel.GetCurrentChain()==0
	and Duel.GetMatchingGroupCount(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)>0
	and Duel.GetMatchingGroupCount(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)>2
	and #ally<2 and e:GetHandler():GetCounter(0xd01)<4
end
function s.damtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil) end
	local knight=Duel.GetMatchingGroup(Kirafan8.knightfilter,tp,0,LOCATION_MZONE,nil)
	local enemy=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	if #knight>0 then
	local sg=knight:GetFirst()
	Duel.SetTargetCard(sg)
	else
	local sg2=enemy:RandomSelect(tp,1)
	Duel.SetTargetCard(sg2) end
	
	local extraatk=Duel.GetRandomNumber(1,10)
	if (main:IsSetCard(0xd04) and extraatk>=6) or (main:IsSetCard(0xd03) and extraatk>=9) then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_CHAIN)
	e1:SetValue(2)
	c:RegisterEffect(e1)
	elseif (main:IsSetCard(0xd04) and extraatk<=5) or (main:IsSetCard(0xd03) and extraatk<=6)
	or (main:IsSetCard(0xd02) and extraatk<=5) then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_CHAIN)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	else end	
	
	Duel.SetChainLimit(Kirafan8.mychainlimit)
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(id,2))
end
function s.damop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local enemy=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	local attack=c:GetAttack()
	local dam=attack
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local g=tg:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=g:RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
	c:AddCounter(0xd01,1)
	local bg=Duel.GetDecktopGroup(tp,2)
	Duel.Overlay(c,bg)
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end

function s.bossdamcon3(e,tp,eg,ep,ev,re,r,rp)
	local ally=Duel.GetMatchingGroup(s.bossdamfilter,tp,LOCATION_MZONE,0,nil)
	return Duel.IsBattlePhase() and Duel.GetTurnPlayer()==tp and Duel.GetCurrentChain()==0
	and Duel.GetMatchingGroupCount(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)>1
	and Duel.GetMatchingGroupCount(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,nil)>4
	and #ally<2 and e:GetHandler():GetCounter(0xd01)<4
end
function s.damtg3(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetChainLimit(Kirafan8.mychainlimit)
	
	local extraatk=Duel.GetRandomNumber(1,10)
	if (main:IsSetCard(0xd04) and extraatk>=6) or (main:IsSetCard(0xd03) and extraatk>=9) then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_CHAIN)
	e1:SetValue(2)
	c:RegisterEffect(e1)
	elseif (main:IsSetCard(0xd04) and extraatk<=5) or (main:IsSetCard(0xd03) and extraatk<=6)
	or (main:IsSetCard(0xd02) and extraatk<=5) then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_CHAIN)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	else end
	
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(id,3))
end
function s.damop3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local enemy=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
	local attack=c:GetAttack()
	local dam=attack
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local ag=enemy:GetFirst()
	for ag in aux.Next(enemy) do
	local g=ag:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=ag:GetOverlayGroup():RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end end
	c:AddCounter(0xd01,1)
	local bg=Duel.GetDecktopGroup(tp,2)
	Duel.Overlay(c,bg)
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end

function s.bossdamcon4(e,tp,eg,ep,ev,re,r,rp)
	local ally=Duel.GetMatchingGroup(s.bossdamfilter,tp,LOCATION_MZONE,0,nil)
	return Duel.IsBattlePhase() and Duel.GetTurnPlayer()==tp and Duel.GetCurrentChain()==0
	and Duel.GetMatchingGroupCount(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)>0
	and #ally<2 and e:GetHandler():GetCounter(0xd01)>3
end
function s.damtg4(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetChainLimit(Kirafan8.mychainlimit)
	
	local extraatk=Duel.GetRandomNumber(1,10)
	if (main:IsSetCard(0xd04) and extraatk>=6) or (main:IsSetCard(0xd03) and extraatk>=9) then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_CHAIN)
	e1:SetValue(2)
	c:RegisterEffect(e1)
	elseif (main:IsSetCard(0xd04) and extraatk<=5) or (main:IsSetCard(0xd03) and extraatk<=6)
	or (main:IsSetCard(0xd02) and extraatk<=5) then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_CHAIN)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	else end
	
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(id,4))
end
function s.damop4(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local enemy=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	c:RemoveCounter(tp,0xd01,c:GetCounter(0xd01),REASON_EFFECT)
	local attack=c:GetAttack()
	local dam=attack
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local ag=enemy:GetFirst()
	for ag in aux.Next(enemy) do
	local g=ag:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	if ag:GetCounter(0xb04)==0 then ag:AddCounter(0xb04,3)
	elseif ag:GetCounter(0xb04)==1 then ag:AddCounter(0xb04,2)
	elseif ag:GetCounter(0xb04)==2 then ag:AddCounter(0xb04,1)
	else end
	tc=ag:GetOverlayGroup():RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end end
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
end