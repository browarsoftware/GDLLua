-------------------------------- 
-- Author: Tomasz Hachaj, 2016
-- CCI laboratory, Poland
-- tomekhachaj at o2.pl
-- http://gdl.org.pl/
-------------------------------- 
require "GDL.Vector3D"
SkeletonData = {}
SkeletonData.__index = SkeletonData
SkeletonData.__class = 'SkeletonData'

--GDL-Lua skeleton data, depends on tracking hardware
--This one is for Microsoft Kinect SDK 1.8
function SkeletonData:new()
	local obj = {
		HipCenter = Vector3D:new(0,0,0),
		Spine = Vector3D:new(0,0,0),
		ShoulderCenter = Vector3D:new(0,0,0),
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
	}
	setmetatable(obj, self) -- This makes obj inherit from HUD
	return obj
end
