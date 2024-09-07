--키라판 카드게임의 공통적인 임플란트
Kirafan8={}

--배틀 크리에메이트 돗테오키 발동조건
function Kirafan8.knightfilter(c)
	return c:IsRace(RACE_FAIRY) and c:IsHasEffect(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
end
function Kirafan8.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
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
	Duel.SetChainLimit(Kirafan8.mychainlimit)
end
function Kirafan8.damtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Kirafan6.NoEmFzonefilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetChainLimit(Kirafan8.mychainlimit)
end
function Kirafan8.mychainlimit(e,rp,tp)
	return tp~=rp
end

function Kirafan8.difficulthint1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10041001,3))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end
function Kirafan8.difficulthint2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10041001,5))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end
function Kirafan8.difficulthint3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10041001,7))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end
function Kirafan8.difficulthint4(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10041001,9))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end