--!strict
--!optimize 2
--!native

local check = require("./Check")
local deltaError = require(script.Parent.Parent.DeltaError)

export type SingleArgumentCheckParamsExcludeOrder<T> = {
	Value: T,
	Name: string?,
	Reason: string?,
}

export type MultipleArgumentCheckParams = { SingleArgumentCheckParamsExcludeOrder<any> } & {
	Level: number?,
}

-- export type MultipleArgumentCheckParams =
-- 	{ SingleArgumentCheckParamsExcludeOrder<any> }
-- 	| ({ SingleArgumentCheckParamsExcludeOrder<any> } & {
-- 		Level: number?,
-- 	})

local delta1Error = deltaError(1)

local function checkArguments<A...>(multipleArgumentCheckParams: MultipleArgumentCheckParams, ...: A...)
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
		}, multipleArgumentCheckParams.Level)
	end
end

return checkArguments
