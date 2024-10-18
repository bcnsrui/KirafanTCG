--키라판 알케미스트
Kirafan4={}

--덱에서 돗테오키 존으로 보내졌을 때
function Kirafan4.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_DECK+LOCATION_HAND)
end

--이번 턴 아군 단일의 공격력+1
function Kirafan4.ATKUPDotteTrigger(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(Kirafan4.atkcon)
	e1:SetTarget(Kirafan6.spdamtg)
	e1:SetOperation(Kirafan4.atkop)
	c:RegisterEffect(e1)
end
function Kirafan4.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e1)
end

--아군 단일의 체력+1
function Kirafan4.HPDotteTrigger(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(Kirafan4.atkcon)
	e1:SetTarget(Kirafan6.spdamtg)
	e1:SetOperation(Kirafan4.hpop)
	c:RegisterEffect(e1)
end
function Kirafan4.hpop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local bg=Duel.GetDecktopGroup(tp,1)
	Duel.Overlay(tc,bg)
end

--돗테오키 게이지+1
function Kirafan4.DOTTEDotteTrigger(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(Kirafan4.atkcon)
	e1:SetTarget(Kirafan6.nospcondamtg)
	e1:SetOperation(Kirafan4.dotteop)
	c:RegisterEffect(e1)
end
function Kirafan4.dotteop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
end

--드로우+1 패를 1장 마을로 보낸다.
function Kirafan4.DrawDotteTrigger(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(Kirafan4.atkcon)
	e1:SetTarget(Kirafan6.nospcondamtg)
	e1:SetOperation(Kirafan4.drawop)
	c:RegisterEffect(e1)
end
function Kirafan4.drawop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10050111,9))
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,1,1,nil)
	local tg=g:GetFirst()
	Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)	
end