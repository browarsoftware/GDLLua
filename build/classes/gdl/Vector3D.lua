-------------------------------- 
-- Author: Tomasz Hachaj, 2016
-- CCI laboratory, Poland
-- tomekhachaj at o2.pl
-- http://gdl.org.pl/
-------------------------------- 
Vector3D = {}
Vector3D.__index = Vector3D
Vector3D.__class = 'Vector3D'
--Implementation of three-dimensional vector
function Vector3D:new(x, y, z)
	local obj = {x = x, y = y, z = z}
	setmetatable(obj, self) -- This makes obj inherit from HUD
	return obj
end

--Add vector to vector
function Vector3D:__add(value)
	if type(value) == 'number' then
		return Vector3D:new(self.x + value, self.y + value, self.z + value)
	else
		return Vector3D:new(self.x + value.x, self.y + value.y, self.z + value.z)
	end
end
--Subtract vector from vector
function Vector3D:__sub(value)
	if type(value) == 'number' then
		return Vector3D:new(self.x - value, self.y - value, self.z - value)
	else
		return Vector3D:new(self.x - value.x, self.y - value.y, self.z - value.z)
	end
end
--Divide vector by numeric value
function Vector3D:__djv(value)
	if type(value) == 'number' then
		return Vector3D:new(self.x / value, self.y / value, self.z / value)
	end
end
--Multiply vector by numeric value
function Vector3D:__mul(value)
	if type(value) == 'number' then
		return Vector3D:new(self.x * value, self.y * value, self.z * value)
	end
end
--Vector negation
function Vector3D:__unm()
	return Vector3D:new(-1 * self.x, -1 * self.y, -1 * self.z)
end
--Vector normalization
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

--Change radians to degrees
function RadiansToDegrees(radians)
	return radians * 57.2957795130823
end
--Vector dot product
function DotProduct(vector1, vector2)
    return ((vector1.x * vector2.x) + (vector1.y * vector2.y) + (vector1.z * vector2.z))
end
--Vector cross product
function CrossProduct(vector1, vector2)
    return (Vector3D:new(vector1.y * vector2.z - vector1.z * vector2.y,
      vector1.z * vector2.x - vector1.x * vector2.z,
      vector1.x * vector2.y - vector1.y * vector2.x))
end
--Length of the vector
function Length(vector)
    return math.sqrt((vector.x * vector.x) + (vector.y * vector.y) + (vector.z * vector.z))
end
--Angle on the plane between two vectors
function angle(vector1, vector2)
	local v1 = Normalize(vector1)
	local v2 = Normalize(vector2)
	if (DotProduct(v1, v2) >= 0.0) then
		return RadiansToDegrees(2.0 * math.asin(Length(v1 - v2) / 2.0))
	else
		return RadiansToDegrees(3.1415926535 - (2.0 * math.asin(Length(-v1 - v2) / 2.0)))
	end
end
