--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ArgsUtils = require(ReplicatedStorage.Packages.ArgsUtils)

local function setmetatable2<T, MT>(...): setmetatable<T, MT>
	local arguments = { ... }

	ArgsUtils.CheckArguments(
		{
			{
				Value = (typeof(arguments[1]) == "table"),

				Name = "setmetatable2",

				Reason = `expected table, got {typeof(arguments[1])}`,
			},
			{
				Value = (typeof(arguments[2]) == "table"),

				Name = "setmetatable2",

				Reason = `expected table, got {typeof(arguments[2])}`,
			},
		} :: any, -- I REALLY HATE LUAU TYPE CHECKING REALLYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY
		...
	)

	local t: T, mt: MT = ...

	return setmetatable(t, mt) :: setmetatable<T, MT>
end

local function safe<A..., R...>(f: (A...) -> R..., ...: A...)
	local r = { pcall(f, ...) } :: { any }

	if r[1] then
		return select(2, table.unpack(r))
	else
		warn(r[2])
		return
	end
end

print(1)
safe(setmetatable2, {}, {})
print(2)
safe(setmetatable2, 30, 1650)
print(3)
safe(setmetatable2)
print(4)
safe(setmetatable2, nil)
print(5)
safe(setmetatable2, {})
print(6)
safe(setmetatable2, {}, nil)
