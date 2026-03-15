--!strict
--!optimize 2
--!native

local check = require("./Check")
local deltaError = require(script.Parent.Parent.DeltaError)

-- type function Newindex(t: type, i: type, v: type)
-- 	t:setproperty(i, v)
-- 	return t
-- end

-- local a:Newindex<typeof({}), "asdf", "dddd"> = {
-- 	asdf = "dddd"
-- }
-- local b: typeof({}) = {}

-- b.asdf = "dddd" :: "dddd"
-- b.dfdfdfdf = 30

export type SingleArgumentCheckParamsExcludeOrder<T> = {
	Value: T,
	Name: string?,
	Reason: string?,
}

local levelTemplete = {}

levelTemplete.Level = 1234

-- export type MultipleArgumentCheckParams =
-- 	{ SingleArgumentCheckParamsExcludeOrder<any> }
-- 	& Newindex<typeof({}), "Level", number>

export type MultipleArgumentCheckParams = { SingleArgumentCheckParamsExcludeOrder<any> } & typeof({}) & {
	Level: number?,
}

-- export type MultipleArgumentCheckParams = { [number|"Level"]: SingleArgumentCheckParamsExcludeOrder<any>|number }

-- export type MultipleArgumentCheckParams =
-- 	{ SingleArgumentCheckParamsExcludeOrder<any> }
-- 	| ({ SingleArgumentCheckParamsExcludeOrder<any> } & {
-- 		Level: number?,
-- 	})

local delta1Error = deltaError(1)

local function checkArguments<A...>(multipleArgumentCheckParams: MultipleArgumentCheckParams, ...: A...)
	local level = multipleArgumentCheckParams.Level or 2

	if 0 < level then
		level += 1
	end

	local numberOfArguments = select("#", ...)
	for argumentOrder, singleArgumentCheckParams in ipairs(multipleArgumentCheckParams) do
		if numberOfArguments < argumentOrder then
			local message = `missing argument #{argumentOrder}`
			if singleArgumentCheckParams.Name then
				message ..= ` to '{singleArgumentCheckParams.Name}'`
			end

			delta1Error(message, multipleArgumentCheckParams.Level)
		end

		check({
			Value = singleArgumentCheckParams.Value,
			Order = argumentOrder,
			Name = singleArgumentCheckParams.Name,
			Reason = singleArgumentCheckParams.Reason,
		}, level)
	end
end

return checkArguments
