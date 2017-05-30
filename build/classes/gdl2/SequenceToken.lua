SequenceToken = {}
SequenceToken.__index = SequenceToken
SequenceToken.__class = 'SequenceToken'

function SequenceToken:new(TimeConstraintSeconds, y, z)
	obj = {TimeConstraintSeconds = TimeConstraintSeconds, Conclusions = Conclusions, Prefixes = Prefixes}
	setmetatable(obj, self) -- This makes obj inherit from HUD
	return obj
end
