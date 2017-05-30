Vector3D = {}
Vector3D.__index = Vector3D
Vector3D.__class = 'Vector3D'

function Vector3D:new(x, y, z)
	local obj = {x = x, y = y, z = z}
	setmetatable(obj, self) -- This makes obj inherit from HUD
	return obj
end

function Vector3D:__add(value)
	if type(value) == 'number' then
		return Vector3D:new(self.x + value, self.y + value, self.z + value)
	else
		return Vector3D:new(self.x + value.x, self.y + value.y, self.z + value.z)
	end
end

function Vector3D:__sub(value)
	if type(value) == 'number' then
		return Vector3D:new(self.x - value, self.y - value, self.z - value)
	else
		return Vector3D:new(self.x - value.x, self.y - value.y, self.z - value.z)
	end
end

function Vector3D:__djv(value)
	if type(value) == 'number' then
		return Vector3D:new(self.x / value, self.y / value, self.z / value)
	end
end

function Vector3D:__mul(value)
	if type(value) == 'number' then
		return Vector3D:new(self.x * value, self.y * value, self.z * value)
	end
end

function Vector3D:__unm()
	return Vector3D:new(-1 * self.x, -1 * self.y, -1 * self.z)
end

function Normalize(vector)
	local num1 = math.abs(vector.x)
	local num2 = math.abs(vector.y)
	local num3 = math.abs(vector.z)
	if (num2 > num1) then
		num1 = num2
	end
	if (num3 > num1) then
		num1 = num3
	end
	vector.x = vector.x / num1
	vector.y = vector.y / num1
	vector.z = vector.z / num1

	local factor = math.sqrt((vector.x * vector.x) + (vector.y * vector.y) + (vector.z * vector.z))
	return Vector3D:new(vector.x / factor, vector.y / factor, vector.z / factor)
end

function RadiansToDegrees(radians)
	return radians * 57.2957795130823
end

function DotProduct(vector1, vector2)
    return ((vector1.x * vector2.x) + (vector1.y * vector2.y) + (vector1.z * vector2.z))
end

function CrossProduct(vector1, vector2)
    return (Vector3D:new(vector1.y * vector2.z - vector1.z * vector2.y,
      vector1.z * vector2.x - vector1.x * vector2.z,
      vector1.x * vector2.y - vector1.y * vector2.x))
end

function Length(vector)
    return math.sqrt((vector.x * vector.x) + (vector.y * vector.y) + (vector.z * vector.z))
end

function angle(vector1, vector2)
	local v1 = Normalize(vector1)
	local v2 = Normalize(vector2)
	--print(v1.x)
	--print(v1.y)
	--print(v1.z)
	--dddd = DotProduct(v1, v2)
	--xxxxx = 2.0 * math.asin(Length(v1 - v2) / 2.0)
	if (DotProduct(v1, v2) >= 0.0) then
		return RadiansToDegrees(2.0 * math.asin(Length(v1 - v2) / 2.0))
	else
		return RadiansToDegrees(3.1415926535 - (2.0 * math.asin(Length(-v1 - v2) / 2.0)))
	end
end

--[[
i = Vector3D:new(4,-17,5)
j = Vector3D:new(-20,1,3)
print(CrossProduct(i,j).x, CrossProduct(i,j).y, CrossProduct(i,j).z)


i = Vector3D:new(1,2,3)
j = Vector3D:new(2,3,4)
k = i - j
k = k + k
k = -k
print(k.x)]]
