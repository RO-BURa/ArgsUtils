--!strict
--!optimize 2
--!native

local errorByDelta = {} :: { [number]: typeof(error) }
local metatable = {}

function metatable:__index(delta: number): typeof(error)
	self[delta] = function<T>(message: T, level: number?): never
		level = level or 1
		if 0 < level then
			level += delta + 1
		end

		error(message, level)
	end :: typeof(error)

	return self[delta]
end

setmetatable(errorByDelta, metatable)

--[=[
    Returns a cached error function that applies a specific stack level delta.
]=]
local function deltaError(delta: number): typeof(error)
	return errorByDelta[delta] :: typeof(error)
end

return deltaError
