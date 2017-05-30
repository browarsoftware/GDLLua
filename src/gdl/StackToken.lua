-------------------------------- 
-- Author: Tomasz Hachaj, 2016
-- CCI laboratory, Poland
-- tomekhachaj at o2.pl
-- http://gdl.org.pl/
-------------------------------- 
StackToken = {}
StackToken.__index = StackToken
StackToken.__class = 'StackToken'
--GDL-Lua stack token
function StackToken:new()
	local obj = {
        TimePeriod = 0,
        Skeleton = nil;
        Conclusions = {};
        Features = {};
	}
	setmetatable(obj, self) -- This makes obj inherit from HUD
	return obj
end
