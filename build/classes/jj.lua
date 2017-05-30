-------------------------------- 
-- Author: Tomasz Hachaj, 2016
-- CCI laboratory, Poland
-- tomekhachaj at o2.pl
-- http://gdl.org.pl/
-------------------------------- 
require "GDL/Engine"
function ReturnConclusions(ActualSkeletonData, TimePeriod)
PreReturnConclusions(ActualSkeletonData, TimePeriod)

---------------------------------------
-- INIRIAL FEATURES
---------------------------------------
RightElbow = angle(ShoulderRight(0) - ElbowRight(0),  WristRight(0) - ElbowRight(0)) / 180
LeftElbow = angle(ShoulderLeft(0) - ElbowLeft(0),  WristLeft(0) - ElbowLeft(0)) / 180

RightShoulder = angle(ShoulderCenter(0) - ShoulderRight(0),  ElbowRight(0) - ShoulderRight(0)) / 180
LeftShoulder = angle(ShoulderCenter(0) - ShoulderLeft(0),  ElbowLeft(0) - ShoulderLeft(0)) / 180

BetweenWrists = angle(ShoulderRight(0) - ElbowRight(0),  ShoulderLeft(0) - ElbowLeft(0)) / 180

BetweenLegs = angle(KneeLeft(0) - HipLeft(0),  KneeRight(0) - HipRight(0)) / 180

dupsko = HipLeft(0)
dupsko2 = Vector3D:new(5,6,7)

---------------------------------------
-- R-GDL FEATURES
---------------------------------------
BetweenLegs_EPS = 0.083
BetweenWrists_EPS = 0.083
RightShoulder_EPS = 0.083
LeftElbow_EPS = 0.083
RightElbow_EPS = 0.083
LeftShoulder_EPS = 0.083

BetweenLegs_MEAN_0 = 0.100429939214373
BetweenLegs_DEV_0 = 0.0519681617883684
BetweenWrists_MEAN_0 = 0.765308158053066
BetweenWrists_DEV_0 = 0.1210957745562
RightShoulder_MEAN_0 = 0.774714599030828
RightShoulder_DEV_0 = 0.0999209861120779
LeftElbow_MEAN_0 = 0.851841795379086
LeftElbow_DEV_0 = 0.096053692837809
RightElbow_MEAN_0 = 0.84165857791497
RightElbow_DEV_0 = 0.0855950118395471
LeftShoulder_MEAN_0 = 0.757646036189177
LeftShoulder_DEV_0 = 0.103154247209596

BetweenLegs_MEAN_1 = 0.0287836936653485
BetweenLegs_DEV_1 = 0.019323359182823
BetweenWrists_MEAN_1 = 0.458054911094811
BetweenWrists_DEV_1 = 0.147239581712147
RightShoulder_MEAN_1 = 0.884593127462514
RightShoulder_DEV_1 = 0.0550175067964968
LeftElbow_MEAN_1 = 0.875718409950979
LeftElbow_DEV_1 = 0.071813580562789
RightElbow_MEAN_1 = 0.890430500189691
RightElbow_DEV_1 = 0.0536208145099949
LeftShoulder_MEAN_1 = 0.901063326436491
LeftShoulder_DEV_1 = 0.0499154545518123

BetweenLegs_MEAN_2 = 0.0798547845370103
BetweenLegs_DEV_2 = 0.067403108378886
BetweenWrists_MEAN_2 = 0.199446875983023
BetweenWrists_DEV_2 = 0.119693060666488
RightShoulder_MEAN_2 = 0.661443773888935
RightShoulder_DEV_2 = 0.119599286801556
LeftElbow_MEAN_2 = 0.839675673516652
LeftElbow_DEV_2 = 0.062481095147361
RightElbow_MEAN_2 = 0.841702484761536
RightElbow_DEV_2 = 0.0733147900666605
LeftShoulder_MEAN_2 = 0.651910008433307
LeftShoulder_DEV_2 = 0.128529857597182

---------------------------------------
-- R-GDL RULES
---------------------------------------
if abs(BetweenLegs -BetweenLegs_MEAN_0) <= BetweenLegs_DEV_0 + BetweenLegs_EPS 
and abs(BetweenWrists -BetweenWrists_MEAN_0) <= BetweenWrists_DEV_0 + BetweenWrists_EPS 
and abs(RightShoulder -RightShoulder_MEAN_0) <= RightShoulder_DEV_0 + RightShoulder_EPS 
and abs(LeftElbow -LeftElbow_MEAN_0) <= LeftElbow_DEV_0 + LeftElbow_EPS 
and abs(RightElbow -RightElbow_MEAN_0) <= RightElbow_DEV_0 + RightElbow_EPS 
and abs(LeftShoulder -LeftShoulder_MEAN_0) <= LeftShoulder_DEV_0 + LeftShoulder_EPS 
then 
	my_rule0 = true 
else
	my_rule0 = false 
end
if abs(BetweenLegs -BetweenLegs_MEAN_1) <= BetweenLegs_DEV_1 + BetweenLegs_EPS 
and abs(BetweenWrists -BetweenWrists_MEAN_1) <= BetweenWrists_DEV_1 + BetweenWrists_EPS 
and abs(RightShoulder -RightShoulder_MEAN_1) <= RightShoulder_DEV_1 + RightShoulder_EPS 
and abs(LeftElbow -LeftElbow_MEAN_1) <= LeftElbow_DEV_1 + LeftElbow_EPS 
and abs(RightElbow -RightElbow_MEAN_1) <= RightElbow_DEV_1 + RightElbow_EPS 
and abs(LeftShoulder -LeftShoulder_MEAN_1) <= LeftShoulder_DEV_1 + LeftShoulder_EPS 
then 
	my_rule1 = true 
else
	my_rule1 = false 
end
if abs(BetweenLegs -BetweenLegs_MEAN_2) <= BetweenLegs_DEV_2 + BetweenLegs_EPS 
and abs(BetweenWrists -BetweenWrists_MEAN_2) <= BetweenWrists_DEV_2 + BetweenWrists_EPS 
and abs(RightShoulder -RightShoulder_MEAN_2) <= RightShoulder_DEV_2 + RightShoulder_EPS 
and abs(LeftElbow -LeftElbow_MEAN_2) <= LeftElbow_DEV_2 + LeftElbow_EPS 
and abs(RightElbow -RightElbow_MEAN_2) <= RightElbow_DEV_2 + RightElbow_EPS 
and abs(LeftShoulder -LeftShoulder_MEAN_2) <= LeftShoulder_DEV_2 + LeftShoulder_EPS 
then 
	my_rule2 = true 
else
	my_rule2 = false 
end

---------------------------------------

if my_rule1 and sequenceexists("[my_rule0,0.5][my_rule2,1][my_rule0,0.5]") then 
	GESTURE_4GRAMS = true
else
	GESTURE_4GRAMS = false 
end

---------------------------------------
-- Action to be detected
---------------------------------------
if GESTURE_4GRAMS and sequenceexists("[!GESTURE_4GRAMS,0.5]") then
	_JumpingJack = true
else
	_JumpingJack = false
end

---------------------------------------
-- END ReturnConclusions
---------------------------------------

PostReturnConclusions(st)

end
