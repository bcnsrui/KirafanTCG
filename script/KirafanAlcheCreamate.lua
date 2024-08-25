--키라판 알케미스트
Kirafan4={}

-- 알케미스트 크리에메이트 유틸
function Kirafan4.AlcheCreamateCharacter(c)
	Kirafan4.SpCreamateEff(c)
end

--유희왕과 다른 룰(1마을로가면게임제외)
function Kirafan4.SpCreamateEff(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_REMOVED+LOCATION_GRAVE)
	e1:SetCode(EVENT_ADJUST)
	e1:SetOperation(Kirafan4.Alcheop)
	c:RegisterEffect(e1)
end
function Kirafan4.Alcheop(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.SendtoDeck(e:GetHandler(),nil,-2,REASON_RULE)
end