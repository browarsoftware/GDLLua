-------------------------------- 
-- Author: Tomasz Hachaj, 2016
-- CCI laboratory, Poland
-- tomekhachaj at o2.pl
-- http://gdl.org.pl/
-------------------------------- 

require "GDL2.ArrayList"
require "GDL2.StackToken"
require "GDL2.SkeletonData"
require "GDL2.SequenceToken"

--Engine Variables
GDLStack = ArrayList:new()
ExampleSkeletonData = SkeletonData:new()

-- Generate skeleton structure for hosting application
function GetExampleSkeletonData()
	return copy2(ExampleSkeletonData)
end

-- Copy object
function copy2(obj)
  if type(obj) ~= 'table' then return obj end
  local res = setmetatable({}, getmetatable(obj))
  for k, v in pairs(obj) do res[copy2(k)] = copy2(v) end
  return res
end

-- It has to be called at the beginning of GDL-Lua script
function PreReturnConclusions(ActualSkeletonData, TimePeriod)
	st = StackToken:new()
	st.Skeleton = ActualSkeletonData
	st.TimePeriod = TimePeriod
	GDLStack:addToken(st)
end

-- It has to be called at the end of GDL-Lua script
function PostReturnConclusions(st)
	Features = {}
	Conclusions = {}
	for n,v in pairs(_G) do
		if (type(v) == 'number') then
			Features[n] = v
		end
		if (type(v) == 'table' and n ~= 'Vector3D') then
			if (v.__class ~= nil) then
				if (v.__class == 'Vector3D') then
					Features[n] = v
				end
			end
		end
		if (type(v) == 'boolean') then
			Conclusions[n] = v
		end
	end
		
	st.Features = Features
	st.Conclusions = Conclusions
	GDLStack.StackTokens[1] = st
end

-- Split sequence in sequenceexists function
function splitSequence(inputstr)
	local t={}
	local sequence = {}
	local str = 'aaa'
	
	local splittedString = string.gmatch(inputstr, "%[[^%]]+")
	
	for str in splittedString do
		--now each sequence component is separate string
		--remove '['
		str = string.sub(str, 2)
		local Conclusions = {}
		local Prefixes = {}
		local splittedString2 = string.gmatch(str, "[^,]+")
		local str2 = 'aaa'
		for str2 in splittedString2 do
--	for str2 in splittedString2 do
			if (str2 ~= '') then
				if (string.sub(str2, 1, 1) == '!') then
					table.insert(Prefixes, true)
					table.insert(Conclusions, string.sub(str2, 2))
				else
					table.insert(Prefixes, false)
					table.insert(Conclusions, str2)
				end
			end
		end
		local TimeConstraintSeconds = tonumber(table.remove(Conclusions))
		table.remove(Prefixes)
		local st = SequenceToken:new()
		st.Conclusions = Conclusions
		st.Prefixes = Prefixes
		
		st.TimeConstraintSeconds = TimeConstraintSeconds
		table.insert(sequence, st)
	end

	return sequence
end

-- Debug function for sequence in sequenceexists function
function printSequence(sequence)
	local loopCount = 0
	local i = 0
	local j = 0
	for Index, Value in pairs( sequence ) do
		loopCount = loopCount + 1
	end

	for i=1,loopCount do
		local loopCount2 = 0
		for Index, Value in pairs( sequence[i].Conclusions ) do
			loopCount2 = loopCount2 + 1
		end
		for j=1,loopCount2 do
			print(sequence[i].Conclusions[j])
			print(sequence[i].Prefixes[j])
		end
		print(sequence[i].TimeConstraintSeconds)
	end
end

-- Implementation of function from GDL specification
function sequenceexists(inputstr)
	
	sequence = splitSequence(inputstr)
	local i = 0
	local j = 0
	
	local loopCount = 0
	for Index, Value in pairs( sequence ) do
		loopCount = loopCount + 1
	end
	
	local timePeriod = 0;
	local maxC = 1;
	local maxCTemp = 1
	local c = 1

	for i=1,loopCount do
		local loopCount2 = 0
		for Index, Value in pairs( sequence[i].Conclusions ) do
			loopCount2 = loopCount2 + 1
		end
		for j=1,loopCount2 do
			--Zero time period
			timePeriod = 0;
			--Start from stack position where the previous analysis stopped
			c = maxC
			local stringInArray = false
			repeat
				--End when greater than stack size
				local stackSize = 0
				for Index, Value in pairs( GDLStack.StackTokens ) do
					stackSize = stackSize + 1
				end
				
				--Take from the stack until the sequence is found or time constraints are reached
				if (c > stackSize) then
					timePeriod = sequence[i].TimeConstraintSeconds + 1;
				else
					stringInArray = GDLStack.StackTokens[c].Conclusions[sequence[i].Conclusions[j]]
					timePeriod = timePeriod + GDLStack.StackTokens[c].TimePeriod
					c = c + 1
				end
			until (stringInArray or timePeriod > sequence[i].TimeConstraintSeconds)
			-- If we did not find the conclusion that means that time constraints are overcome
			if ((not stringInArray) and (not sequence[i].Prefixes[j])) then
				return false
			end
			--If negation is present that means that when conclusions was found it should be negated
			if (stringInArray and sequence[i].Prefixes[j]) then
				return false
			end
			--We memorize the longest time period so far
			if (maxCTemp < c) then
				maxCTemp = c;
			end
		end
		--Set the starting position on the last +1 
		maxC = maxCTemp + 1
	end
	return true
end

-- Implementation of function from GDL specification
function rulepersists(conclusion, persistaceTime, persistancePercentage)

	if type(conclusion) ~= 'string' then
		error("Conclusion in rulepersists is not a string")
	end

	local c = 1
	local tm = nil
	local timePeriod = 0
	local stringInArray = false;
	local conclusionsCount = 0;
	repeat
		local stackSize = 0
		for Index, Value in pairs( GDLStack.StackTokens ) do
			stackSize = stackSize + 1
		end
		--End when greater than stack size
		if (c > stackSize) then
			timePeriod = persistaceTime + 1;
		else
			---Take from the stack until the sequence is found or time constraints are reached
			timePeriod = timePeriod + GDLStack.StackTokens[c].TimePeriod
			stringInArray = GDLStack.StackTokens[c].Conclusions[conclusion]
			if (stringInArray) then
				conclusionsCount = conclusionsCount + 1
			end
			c = c + 1
		end
	until (timePeriod >= persistaceTime);
	local percentageResult = conclusionsCount / (c - 1)
	if (percentageResult >= persistancePercentage) then
		return true
	end
	return false
end

-- Below functions are used to simplify access to body joints from GDL-Lua code

function SpineBase(level)
	return GDLStack:Level(level).Skeleton.SpineBase
end

function SpineMid(level)
	return GDLStack:Level(level).Skeleton.SpineMid
end

function Neck(level)
	return GDLStack:Level(level).Skeleton.Neck
end

function Head(level)
	return GDLStack:Level(level).Skeleton.Head
end

function ShoulderLeft(level)
	return GDLStack:Level(level).Skeleton.ShoulderLeft
end

function ElbowLeft(level)
	return GDLStack:Level(level).Skeleton.ElbowLeft
end

function WristLeft(level)
	return GDLStack:Level(level).Skeleton.WristLeft
end

function HandLeft(level)
	return GDLStack:Level(level).Skeleton.HandLeft
end

function ShoulderRight(level)
	return GDLStack:Level(level).Skeleton.ShoulderRight
end

function ElbowRight(level)
	return GDLStack:Level(level).Skeleton.ElbowRight
end

function WristRight(level)
	return GDLStack:Level(level).Skeleton.WristRight
end

function HandRight(level)
	return GDLStack:Level(level).Skeleton.HandRight
end

function HipLeft(level)
	return GDLStack:Level(level).Skeleton.HipLeft
end

function KneeLeft(level)
	return GDLStack:Level(level).Skeleton.KneeLeft
end

function AnkleLeft(level)
	return GDLStack:Level(level).Skeleton.AnkleLeft
end

function FootLeft(level)
	return GDLStack:Level(level).Skeleton.FootLeft
end

function HipRight(level)
	return GDLStack:Level(level).Skeleton.HipRight
end

function KneeRight(level)
	return GDLStack:Level(level).Skeleton.KneeRight
end

function AnkleRight(level)
	return GDLStack:Level(level).Skeleton.AnkleRight
end

function FootRight(level)
	return GDLStack:Level(level).Skeleton.FootRight
end

function SpineShoulder(level)
	return GDLStack:Level(level).Skeleton.SpineShoulder
end

function HandTipLeft(level)
	return GDLStack:Level(level).Skeleton.HandTipLeft
end

function ThumbLeft(level)
	return GDLStack:Level(level).Skeleton.ThumbLeft
end

function HandTipRight(level)
	return GDLStack:Level(level).Skeleton.HandTipRight
end

function ThumbRight(level)
	return GDLStack:Level(level).Skeleton.ThumbRight
end


function abs(value)
	return math.abs(value)
end
