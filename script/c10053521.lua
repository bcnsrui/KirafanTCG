local s,id=GetID()
function s.initial_effect(c)
	Kirafan5.KnCreamateCharacter(c)
	Kirafan5.Aggroknight(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(s.dottecost1)
	e1:SetTarget(Kirafan3.sghealtg)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(Kirafan6.spcreamatecon)
	c:RegisterEffect(e2)
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	local ahp=tc:GetDefense()
	local bhp=tc:GetBaseDefense()
	local deckcount=Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_REMOVED,0,nil)
	sgheal=1
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

function s.dottecost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetCounter(0xb03)==0 and not c:IsDefensePos() and
	Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,1,nil,tp) end
	Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE)
	Kirafan6.consumedotte(e,tp,eg,ep,ev,re,r,rp)
end