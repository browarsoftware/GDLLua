require "GDL2.Vector3D"
SkeletonData = {}
SkeletonData.__index = SkeletonData
SkeletonData.__class = 'SkeletonData'

function SkeletonData:new()
	local obj = {
		SpineBase = Vector3D:new(0,0,0),
		SpineMid = Vector3D:new(0,0,0),
		Neck = Vector3D:new(0,0,0),
		Head = Vector3D:new(0,0,0),
		ShoulderLeft = Vector3D:new(0,0,0),
		ElbowLeft = Vector3D:new(0,0,0),
		WristLeft = Vector3D:new(0,0,0),
		HandLeft = Vector3D:new(0,0,0),
		ShoulderRight = Vector3D:new(0,0,0),
		ElbowRight = Vector3D:new(0,0,0),
		WristRight = Vector3D:new(0,0,0),
		HandRight = Vector3D:new(0,0,0),
		HipLeft = Vector3D:new(0,0,0),
		KneeLeft = Vector3D:new(0,0,0),
		AnkleLeft = Vector3D:new(0,0,0),
		FootLeft = Vector3D:new(0,0,0),
		HipRight = Vector3D:new(0,0,0),
		KneeRight = Vector3D:new(0,0,0),
		AnkleRight = Vector3D:new(0,0,0),
		FootRight = Vector3D:new(0,0,0),
		
		SpineShoulder = Vector3D:new(0,0,0),
		HandTipLeft = Vector3D:new(0,0,0),
		ThumbLeft = Vector3D:new(0,0,0),
		HandTipRight = Vector3D:new(0,0,0),
		ThumbRight = Vector3D:new(0,0,0)
	}
	setmetatable(obj, self) -- This makes obj inherit from HUD
	return obj
end

--skel = SkeletonData:new()
--print(skel.HipCenter.x)

--[[
        SpineBase = 0,
        SpineMid = 1,
        Neck = 2,
        Head = 3,
        ShoulderLeft = 4,
        ElbowLeft = 5,
        WristLeft = 6,
        HandLeft = 7,
        ShoulderRight = 8,
        ElbowRight = 9,
        WristRight = 10,
        HandRight = 11,
        HipLeft = 12,
        KneeLeft = 13,
        AnkleLeft = 14,
        FootLeft = 15,
        HipRight = 16,
        KneeRight = 17,
        AnkleRight = 18,
        FootRight = 19,
        SpineShoulder = 20,
        HandTipLeft = 21,
        ThumbLeft = 22,
        HandTipRight = 23,
        ThumbRight = 24,]]