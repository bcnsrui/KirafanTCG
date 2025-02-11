local s,id=GetID()
function s.initial_effect(c)
	Kirafan5.KnCreamateCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_DECK)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(10050111,5))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(Kirafan6.damcon)
	e5:SetCost(Kirafan2.dottecost3)
	e5:SetTarget(Kirafan6.nodamtg)
	e5:SetOperation(s.damop)
	c:RegisterEffect(e5)
	Kirafan6.NoDotteEffcon3(c)
end
function s.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsLocation(LOCATION_EXTRA)
	and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsPreviousControler(tp)
	and Duel.GetCurrentPhase()~=PHASE_STANDBY
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local main=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	local CreamateLv=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_ONFIELD,0,nil):GetSum(Card.GetLevel)
	if not (main:GetDefense()-CreamateLv>=e:GetHandler():GetLevel() or main:IsCode(10050110)) then
	return Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(id,0)) end
	Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP_ATTACK)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetValue(0xb02)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e:GetHandler():RegisterEffect(e1)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local enemy=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,nil)
	local dam=1
	if c:IsSetCard(0xb02) then dam=2 end
	Duel.Damage(1-tp,dam,REASON_EFFECT)
	local ag=enemy:GetFirst()
	for ag in aux.Next(enemy) do
	local g=ag:GetOverlayGroup()
	if #g<=dam then Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	else
	tc=ag:GetOverlayGroup():RandomSelect(1-tp,dam)
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end end
	Kirafan6.hungerop(e,tp,eg,ep,ev,re,r,rp)
	if c:IsSetCard(0xb02) then Duel.Draw(tp,1,REASON_RULE) end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetOperation(s.dottetrigger)
	c:RegisterEffect(e1)
end
function s.dottetrigger(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=c:GetOverlayGroup()
	tg:Merge(c)
	Duel.Remove(tg,POS_FACEUP,REASON_RULE)
	Duel.SendtoDeck(c,nil,-2,REASON_RULE)
	local sonobe=Duel.CreateToken(tp,10053531)
	Duel.Remove(sonobe,POS_FACEUP,REASON_RULE)
	local sonobe2=Duel.SelectMatchingCard(tp,Card.IsRace,tp,LOCATION_REMOVED,0,1,1,nil,RACE_FAIRY)
	Duel.SpecialSummon(sonobe2,0,tp,tp,false,false,POS_FACEUP_ATTACK)
end