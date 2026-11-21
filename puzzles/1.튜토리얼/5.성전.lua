--Created using senpaizuri's Puzzle Maker (updated by Naim & Larry126)
--Partially rewritten by edo9300
--@aiLevel 4
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI,5)
Debug.SetPlayerInfo(0,8000,0,0)
Debug.SetPlayerInfo(1,8000,0,0)

--클레어
c=Debug.AddCard(10050113,0,0,LOCATION_MZONE,6,POS_FACEUP_ATTACK)
Debug.AddCard(10055212,0,0,LOCATION_MZONE,6,POS_FACEUP)
Debug.AddCard(10055212,0,0,LOCATION_MZONE,6,POS_FACEUP)
Debug.AddCard(10055212,0,0,LOCATION_MZONE,6,POS_FACEUP)
tc=Debug.AddCard(10050113,1,1,LOCATION_MZONE,6,POS_FACEUP_ATTACK)
Debug.AddCard(10055212,1,1,LOCATION_MZONE,6,POS_FACEUP)
Debug.AddCard(10055212,1,1,LOCATION_MZONE,6,POS_FACEUP)
Debug.AddCard(10055212,1,1,LOCATION_MZONE,6,POS_FACEUP)
Debug.AddCard(10055212,1,1,LOCATION_MZONE,6,POS_FACEUP)
Debug.AddCard(10055212,1,1,LOCATION_MZONE,6,POS_FACEUP)
Debug.AddCard(10055212,1,1,LOCATION_MZONE,6,POS_FACEUP)
Debug.AddCard(10055212,1,1,LOCATION_MZONE,6,POS_FACEUP)

--enemy
Debug.AddCard(10051631,1,1,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
Debug.AddCard(10051631,1,1,LOCATION_MZONE,0,POS_FACEUP)
Debug.AddCard(10051631,1,1,LOCATION_MZONE,0,POS_FACEUP)

Debug.AddCard(10051631,1,1,LOCATION_MZONE,4,POS_FACEUP_ATTACK)
Debug.AddCard(10051631,1,1,LOCATION_MZONE,4,POS_FACEUP)
Debug.AddCard(10051631,1,1,LOCATION_MZONE,4,POS_FACEUP)

Debug.AddCard(10051631,1,1,LOCATION_MZONE,2,POS_FACEUP_ATTACK)
Debug.AddCard(10051631,1,1,LOCATION_MZONE,2,POS_FACEUP)
Debug.AddCard(10051631,1,1,LOCATION_MZONE,2,POS_FACEUP)

Debug.AddCard(10052431,0,0,LOCATION_EXTRA,0,POS_FACEUP)
Debug.AddCard(10051331,0,0,LOCATION_EXTRA,0,POS_FACEUP)
Debug.AddCard(10051621,0,0,LOCATION_EXTRA,0,POS_FACEUP)
Debug.AddCard(10052121,0,0,LOCATION_EXTRA,0,POS_FACEUP)
Debug.AddCard(10051311,0,0,LOCATION_EXTRA,0,POS_FACEUP)

Debug.AddCard(10051631,1,1,LOCATION_EXTRA,0,POS_FACEUP)

sharo1=Debug.AddCard(10052531,1,1,LOCATION_DECK,0,POS_FACEDOWN)
hemo=Debug.AddCard(10052521,1,1,LOCATION_DECK,0,POS_FACEDOWN)
sharo2=Debug.AddCard(10052531,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,1,1,LOCATION_DECK,0,POS_FACEDOWN)


shinobu=Debug.AddCard(10051521,0,0,LOCATION_DECK,0,POS_FACEDOWN)
miyako=Debug.AddCard(10051531,0,0,LOCATION_DECK,0,POS_FACEDOWN)
hiro=Debug.AddCard(10054523,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)
Debug.AddCard(10054621,0,0,LOCATION_DECK,0,POS_FACEDOWN)

Debug.AddCard(10052421,0,0,LOCATION_MZONE,0,POS_FACEUP_ATTACK)
Debug.AddCard(10052421,0,0,LOCATION_MZONE,0,POS_FACEUP)
Debug.AddCard(10052421,0,0,LOCATION_MZONE,0,POS_FACEUP)
Debug.AddCard(10052421,0,0,LOCATION_MZONE,0,POS_FACEUP)
Debug.AddCard(10052421,0,0,LOCATION_MZONE,0,POS_FACEUP)
Debug.AddCard(10052421,0,0,LOCATION_MZONE,0,POS_FACEUP)

tamaki=Debug.AddCard(10052331,0,0,LOCATION_MZONE,4,POS_FACEUP_ATTACK)
Debug.AddCard(10052331,0,0,LOCATION_MZONE,4,POS_FACEUP)
Debug.AddCard(10052331,0,0,LOCATION_MZONE,4,POS_FACEUP)
Debug.AddCard(10052331,0,0,LOCATION_MZONE,4,POS_FACEUP)
Debug.AddCard(10052331,0,0,LOCATION_MZONE,4,POS_FACEUP)
Debug.AddCard(10052331,0,0,LOCATION_MZONE,4,POS_FACEUP)

Debug.AddCard(10052321,0,0,LOCATION_MZONE,2,POS_FACEUP_ATTACK)
Debug.AddCard(10052321,0,0,LOCATION_MZONE,2,POS_FACEUP)
Debug.AddCard(10052321,0,0,LOCATION_MZONE,2,POS_FACEUP)
Debug.AddCard(10052321,0,0,LOCATION_MZONE,2,POS_FACEUP)
Debug.AddCard(10052321,0,0,LOCATION_MZONE,2,POS_FACEUP)
Debug.AddCard(10052321,0,0,LOCATION_MZONE,2,POS_FACEUP)

yuno=Debug.AddCard(10054521,0,0,LOCATION_HAND,0,POS_FACEDOWN)
Debug.AddCard(10051511,0,0,LOCATION_HAND,0,POS_FACEDOWN)

Debug.ReloadFieldEnd()

-- 상대 배틀 크리에메이트: 통상 공격 불가 (돗테오키·스킬만)
local eNoAtk=Effect.GlobalEffect()
eNoAtk:SetType(EFFECT_TYPE_FIELD)
eNoAtk:SetCode(EFFECT_CANNOT_ATTACK)
eNoAtk:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
eNoAtk:SetTargetRange(0,LOCATION_MZONE)
eNoAtk:SetTarget(function(e,c) return Kirafan6.NoEmFzonefilter(c) end)
Duel.RegisterEffect(eNoAtk,0)

local e1=Effect.CreateEffect(tc)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_CANNOT_TRIGGER)
tc:RegisterEffect(e1)

local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnCount()==1 end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
Duel.SkipPhase(tp,PHASE_DRAW,RESET_PHASE+PHASE_END,0)
Duel.SkipPhase(tp,PHASE_STANDBY,RESET_PHASE+PHASE_END,0)
Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,0)
Debug.ShowHint[[★클레어
자! 이제 게임에서 승리하는 법이에요
상대 크리에메이트를 계속 성전으로 보내다보면
상대의 성전 레벨이 10 이상이 되는 순간이 올거에요!]]
Debug.ShowHint[[★클레어
상대의 성전 레벨이 10 이상인 상태에서
자신 배틀 페이즈를 종료하면 진실의 손의 시간이 시작돼요!]]
Debug.ShowHint[[★클레어
자! 이제 배틀 페이즈에 들어갈테니 통상 공격만으로
상대의 성전 레벨을 10 이상으로 만들고
배틀 페이즈를 종료하세요!]]
local g2=Duel.GetMatchingGroup(Kirafan6.NoEmFzonefilter,tp,LOCATION_MZONE,0,nil)
local tc2=g2:GetFirst()
	for tc2 in aux.Next(g2) do
local e2=Effect.CreateEffect(tc2)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_CANNOT_TRIGGER)
e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
e2:SetReset(RESET_EVENT+RESETS_STANDARD+EVENT_PHASE+PHASE_END)
tc2:RegisterEffect(e2)
local e3=Effect.CreateEffect(tc2)
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetCode(EFFECT_MUST_ATTACK)
e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
e3:SetReset(RESET_EVENT+RESETS_STANDARD+EVENT_PHASE+PHASE_END)
tc2:RegisterEffect(e3)
end
end)
Duel.RegisterEffect(e1,0)

local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetCountLimit(1)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnCount()==1 end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetMatchingGroupCount(nil,tp,0,LOCATION_MZONE,nil)>1 then
Debug.ShowHint[[★클레어
아... 이러면 상대의 성전 레벨이 10 이상이 되지 않았어요
다시 한 번 해볼까요?]]
Duel.SetLP(tp,0)
end
end)
Duel.RegisterEffect(e1,0)

local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_DRAW)
	e2:SetCountLimit(1)
	e2:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnCount()==2 end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)	
Debug.ShowHint[[★쿠죠 카렌
아옷치!]]
Debug.ShowHint[[★클레어
자 이제 진실의 손의 시간이 왔어요!
이번 턴만 잘 넘기면 승리할 수 있어요!]]
Duel.SendtoHand(sharo1,nil,REASON_EFFECT)
Duel.SendtoHand(sharo2,nil,REASON_EFFECT)
Duel.SendtoHand(hemo,nil,REASON_EFFECT)
Duel.SpecialSummon(hemo,0,1-tp,1-tp,false,false,POS_FACEUP_ATTACK)
Debug.ShowHint[[★미도리 헤모
이노 선배♡ 어디 계신가요?]]
Duel.SpecialSummon(sharo1,0,1-tp,1-tp,false,false,POS_FACEUP_ATTACK)
Duel.SpecialSummon(sharo2,0,1-tp,1-tp,false,false,POS_FACEUP_ATTACK)
Debug.ShowHint[[★키리마 샤로
괴도 라팡 등장!]]
Debug.ShowHint[[★클레어
아앗! 이건 좀 어렵겠는데요?]]
Debug.ShowHint[[★유노
위험해! 지금 돗테오키 스킬을...!!]]
Debug.ShowHint[[★클레어
아니예요! 헤모 씨의 불행 효과가 있어서
지금은 사용하지 않고 넘어가는게 좋을 것 같아요]]
Duel.SkipPhase(1-tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,0)
-- AI 돗테오키용 게이지 (헤모·샤로×2, 각 2)
Duel.DiscardDeck(1-tp,6,REASON_EFFECT)
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_CANNOT_TRIGGER)
e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
e1:SetReset(RESET_EVENT+RESETS_STANDARD+EVENT_PHASE+PHASE_END)
c:RegisterEffect(e1)
end)
Duel.RegisterEffect(e2,0)

local e6=Effect.GlobalEffect()
e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e6:SetCode(EVENT_PHASE+PHASE_END)
e6:SetCountLimit(1)
e6:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnCount()==2 end)
e6:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetMatchingGroupCount(nil,tp,LOCATION_MZONE,0,nil)<2 then
Debug.ShowHint[[★타츠미 콘
여우신님? 여우신님!!]]	
Debug.ShowHint[[★혼다 타마키
아저씨가 부족하당께...]]	
Debug.ShowHint[[★카타세 마요이
마지막으로 이 말은 해야겠습니다
콘.. 특 이쁨...]]
Debug.ShowHint[[★클레어
아앗! 저희의 성전 레벨이 더 높아져 버렸어요!
이러면 다음 턴을 봐야겠어요
제발 좋은 크리에메이트가 나오길 기도하죠!]]	
end end)
Duel.RegisterEffect(e6,0)

-- 상대 턴 종료 시 패를 전부 마을로 (PHASE_END보다 TURN_END가 확실함)
local e6h=Effect.GlobalEffect()
e6h:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e6h:SetCode(EVENT_TURN_END)
e6h:SetCountLimit(1)
e6h:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnCount()==2 end)
e6h:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
local oh=Duel.GetMatchingGroup(nil,tp,0,LOCATION_HAND,nil)
if oh:GetCount()>0 then Duel.Remove(oh,POS_FACEUP,REASON_RULE) end
end)
Duel.RegisterEffect(e6h,0)


local e9=Effect.CreateEffect(tamaki)
e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e9:SetCode(EVENT_LEAVE_FIELD)
e9:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_END,0)
Duel.SetLP(1-tp,5000)
Duel.SetLP(tp,1000)
Duel.SkipPhase(1-tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,0)
end)
tamaki:RegisterEffect(e9)

local e4=Effect.GlobalEffect()
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PREDRAW)
	e4:SetCountLimit(1)
	e4:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnCount()==3 end)
	e4:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
Duel.SkipPhase(tp,PHASE_DRAW,RESET_PHASE+PHASE_END,0)
Duel.SendtoHand(shinobu,nil,REASON_EFFECT)
Duel.SendtoHand(miyako,nil,REASON_EFFECT)
Duel.SendtoHand(hiro,nil,REASON_EFFECT)
Debug.ShowHint[[★미야코
어 뭐야!
싸움이야? 나도 껴줘!]]
Debug.ShowHint[[★히로
어떻게 된거야?
다들 다치진 않았니?]]
Debug.ShowHint[[★오오미야 시노부
어머, 다들 너덜너덜 해졌네요
금발 마물에게 당하신건가요?]]
Debug.ShowHint[[★클레어
아! 미야코 씨랑 히로 씨 시노부 씨에요!
지금 상황을 설명 드릴게요!]]
Debug.ShowHint[[★클레어
지금 저희의 성전 레벨은 18 상대는 12
상대 쪽의 샤로 씨를 두분 쓰러뜨리더라도
성전 레벨이 같은채로 턴을 종료하면 저희가 지게 돼요!]]
Debug.ShowHint[[★클레어
따라서 상대 필드를 전부 정리해야만 해요!
하지만 모두의 힘이 모인다면 이길 수 있을거에요!]]
Debug.ShowHint[[★미야코
그래? 좋아 해보자고!]]
Debug.ShowHint[[★오오미야 시노부
맞아요! 금발만 있다면 뭐든지 가능해요!]]
local sg=Duel.GetDecktopGroup(tp,2)
Duel.Overlay(c,sg)
end)
Duel.RegisterEffect(e4,0)

local e5=Effect.GlobalEffect()
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e5:SetCountLimit(1)
	e5:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnCount()==4 end)
	e5:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)	
Debug.ShowHint[[★후다 유미네
아! 여기가 아닌가 보네요
좋은 시간 보내세요~]]
local refill=Duel.GetMatchingGroup(nil,tp,0,LOCATION_HAND,nil)
Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
Debug.ShowHint[[★클레어
유미네 씨는 승려고 드로우 효과가 없어서
상대는 배틀 존에 낼 크리에메이트가 없어요
대단해요! 저희가 이겼어요!]]
Debug.ShowHint[[★클레어
수고하셨습니다 여러분
멋진 만남이 있었군요...!
또 기다리고 있을게요!]]
Debug.ShowHint[[★클레어
이제 노말모드 퍼즐에서 다른 크리에메이트의 효과 타입을 배우고
Ai대전에서 실전 경험을 쌓으실 수 있어요]]
Debug.ShowHint[[★클레어
그러면 서버 대전에서 다른 소환사들과 게임을 하거나
하드모드 퍼즐에 도전해 보실 수 있어요!
막히는 일이 생길 때면 언제든지 다시 이곳으로 와주세요!]]
Debug.ShowHint[[★클레어
즐거운 시간 되시길 바랄게요!]]
Duel.SetLP(1-tp,0)
end)
Duel.RegisterEffect(e5,0)
