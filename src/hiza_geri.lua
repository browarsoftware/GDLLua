require "GDL2/Engine"
function ReturnConclusions(ActualSkeletonData, TimePeriod)
PreReturnConclusions(ActualSkeletonData, TimePeriod)

a1 = angle(ShoulderRight(0) - ShoulderLeft(0), HipRight(0) - KneeRight(0))
a2 = angle(SpineShoulder(0) - SpineBase(0), HipRight(0) - KneeRight(0))
a3 = angle(CrossProduct(ShoulderRight(0) - ShoulderLeft(0), SpineShoulder(0) - SpineBase(0)), HipRight(0) - KneeRight(0))
a4 = angle(ShoulderRight(0) - ShoulderLeft(0), KneeRight(0) - AnkleRight(0))
a5 = angle(SpineShoulder(0) - SpineBase(0), KneeRight(0) - AnkleRight(0))
a6 = angle(CrossProduct(ShoulderRight(0) - ShoulderLeft(0), SpineShoulder(0) - SpineBase(0)), KneeRight(0) - AnkleRight(0))


if abs(angle(ShoulderRight(0) - ShoulderLeft(0), HipRight(0) - KneeRight(0)) / 180 -0.558887964562782) <= 0.0365248946412014 + 0.083 and abs(angle(SpineShoulder(0) - SpineBase(0), HipRight(0) - KneeRight(0)) / 180 -0.0924723581111579) <= 0.0497533767889454 + 0.083 and abs(angle(CrossProduct(ShoulderRight(0) - ShoulderLeft(0), SpineShoulder(0) - SpineBase(0)), HipRight(0) - KneeRight(0)) / 180 -0.537003492750285) <= 0.0320062834417816 + 0.083 and abs(angle(ShoulderRight(0) - ShoulderLeft(0), KneeRight(0) - AnkleRight(0)) / 180 -0.512728813909797) <= 0.0457078340726661 + 0.083 and abs(angle(SpineShoulder(0) - SpineBase(0), KneeRight(0) - AnkleRight(0)) / 180 -0.0848053068044186) <= 0.0467427831562205 + 0.083 and abs(angle(CrossProduct(ShoulderRight(0) - ShoulderLeft(0), SpineShoulder(0) - SpineBase(0)), KneeRight(0) - AnkleRight(0)) / 180 -0.556798869185888) <= 0.0599914580241479 + 0.083 then
	hiza_geri_0 = true
else
	hiza_geri_0 = false
end

if abs(angle(ShoulderRight(0) - ShoulderLeft(0), HipRight(0) - KneeRight(0)) / 180 -0.526697736298057) <= 0.0693992578941744 + 0.083 and abs(angle(SpineShoulder(0) - SpineBase(0), HipRight(0) - KneeRight(0)) / 180 -0.144992489587316) <= 0.0701015424319368 + 0.083 and abs(angle(CrossProduct(ShoulderRight(0) - ShoulderLeft(0), SpineShoulder(0) - SpineBase(0)), HipRight(0) - KneeRight(0)) / 180 -0.401721259582379) <= 0.0979458808737906 + 0.083 and abs(angle(ShoulderRight(0) - ShoulderLeft(0), KneeRight(0) - AnkleRight(0)) / 180 -0.573476878543146) <= 0.062966763004961 + 0.083 and abs(angle(SpineShoulder(0) - SpineBase(0), KneeRight(0) - AnkleRight(0)) / 180 -0.297372332656645) <= 0.117803618787621 + 0.083 and abs(angle(CrossProduct(ShoulderRight(0) - ShoulderLeft(0), SpineShoulder(0) - SpineBase(0)), KneeRight(0) - AnkleRight(0)) / 180 -0.739328075529368) <= 0.0645478491618071 + 0.083 then
	hiza_geri_1 = true
else
	hiza_geri_1 = false
end

if abs(angle(ShoulderRight(0) - ShoulderLeft(0), HipRight(0) - KneeRight(0)) / 180 -0.451818218457763) <= 0.06835900138575 + 0.083 and abs(angle(SpineShoulder(0) - SpineBase(0), HipRight(0) - KneeRight(0)) / 180 -0.497072565525162) <= 0.071241458276499 + 0.083 and abs(angle(CrossProduct(ShoulderRight(0) - ShoulderLeft(0), SpineShoulder(0) - SpineBase(0)), HipRight(0) - KneeRight(0)) / 180 -0.100815847013773) <= 0.0647356833509108 + 0.083 and abs(angle(ShoulderRight(0) - ShoulderLeft(0), KneeRight(0) - AnkleRight(0)) / 180 -0.578790507997041) <= 0.0753187398628326 + 0.083 and abs(angle(SpineShoulder(0) - SpineBase(0), KneeRight(0) - AnkleRight(0)) / 180 -0.223558543389471) <= 0.0657510770064054 + 0.083 and abs(angle(CrossProduct(ShoulderRight(0) - ShoulderLeft(0), SpineShoulder(0) - SpineBase(0)), KneeRight(0) - AnkleRight(0)) / 180 -0.674593221395958) <= 0.091797367956676 + 0.083 then
	hiza_geri_2 = true
else
	hiza_geri_2 = false
end

if hiza_geri_2 and sequenceexists("[hiza_geri_1,1][hiza_geri_0,1]") then
	hiza_geri = true
else
	hiza_geri = false
end

if hiza_geri and sequenceexists("[!hiza_geri,1]") then
	_hiza_geri_right = true
else
	_hiza_geri_right = false
end

PostReturnConclusions(st)
end