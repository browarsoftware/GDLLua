StackToken = {}
StackToken.__index = StackToken
StackToken.__class = 'StackToken'
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
