-------------------------------- 
-- Author: Tomasz Hachaj, 2016
-- CCI laboratory, Poland
-- tomekhachaj at o2.pl
-- http://gdl.org.pl/
-------------------------------- 

--This class is equivalent of ArrayList from JAVA and C#
ArrayList = {}
ArrayList.__index = ArrayList
ArrayList.__class = 'ArrayList'

function ArrayList:new()
	obj = {
		StackTokens = {},
		maxSize = 300
	}
	setmetatable(obj, self) -- This makes obj inherit from HUD
	return obj
end

--Get data at stackPosition or from the bottom of the stack
function ArrayList:Level(stackPosition)
	stackPosition = stackPosition + 1
	
	local ArraySize = 0
	for Index, Value in pairs( self.StackTokens ) do
		ArraySize = ArraySize + 1
	end
	
	if (ArraySize > 0) then
		stackPosition = math.min(stackPosition, ArraySize)
		return self.StackTokens[stackPosition]
	end
	return nil
end

--Add token to the top of the list
function ArrayList:addToken(token)
	local loopCount = 0
	local ArraySize = 0
	for Index, Value in pairs( self.StackTokens ) do
		ArraySize = ArraySize + 1
	end
	
	if (ArraySize > 0) then
		loopCount = math.min(self.maxSize, ArraySize + 1)
	end
	for i=loopCount,2,-1 do
		self.StackTokens[i] = self.StackTokens[i-1]
	end
	self.StackTokens[1] = token
end
