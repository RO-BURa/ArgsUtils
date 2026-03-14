local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ArgsUtils = require(ReplicatedStorage.Packages.ArgsUtils)

local function setmetatable2<T, MT>(...): setmetatable<T, MT>
	local arguments = { ... }

	ArgsUtils.CheckArguments({
		{
			Value = (typeof(arguments[1]) == "table"),
			Name = "setmetatable2",
			Reason = `expected table, got {typeof(arguments[1])}`,
		},
	}, ...)

	local t: T, mt: MT = ...

	return setmetatable(t, mt)
end

local function safeCall<A..., R...>(f, ...: A...): R...
	local r = { pcall(f, ...) }

	if r[1] then
		return select(2, table.unpack(r))
	else
		warn(r[2])
	end
end

safeCall(setmetatable2, {}, {})
safeCall(setmetatable2, 30, 1650)
safeCall(setmetatable2)
safeCall(setmetatable2, nil)
safeCall(setmetatable2, {})
safeCall(setmetatable2, {}, nil)
