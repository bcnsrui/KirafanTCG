local s,id=GetID()
function s.initial_effect(c)
	Kirafan5.KnCreamateCharacter(c)
	Kirafan5.Aggroknight(c)
	Kirafan5.KnightDotte2(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_REMOVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(s.kncon)
	e1:SetOperation(s.knop)
	c:RegisterEffect(e1)
end
function s.knconfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_OVERLAY)
end
function s.kncon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.knconfilter,1,nil,tp) and Duel.GetTurnPlayer()~=tp
	and Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,0,LOCATION_GRAVE,1,nil)
	and Duel.GetFieldGroupCount(tp,0,LOCATION_GRAVE)>0
end
function s.knop(e,tp,eg,ep,ev,re,r,rp)
	Kirafan6.consumeenemydotte(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_GRAVE)>0 then
	Kirafan6.consumeenemydotte(e,tp,eg,ep,ev,re,r,rp) end
end