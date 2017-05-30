-------------------------------- 
-- Author: Tomasz Hachaj, 2016
-- CCI laboratory, Poland
-- tomekhachaj at o2.pl
-- http://gdl.org.pl/
-------------------------------- 
SequenceToken = {}
SequenceToken.__index = SequenceToken
SequenceToken.__class = 'SequenceToken'

--GDL-Lua sequence token
function SequenceToken:new(TimeConstraintSeconds, y, z)
	obj = {TimeConstraintSeconds = TimeConstraintSeconds, Conclusions = Conclusions, Prefixes = Prefixes}
	setmetatable(obj, self) -- This makes obj inherit from HUD
	return obj
end
