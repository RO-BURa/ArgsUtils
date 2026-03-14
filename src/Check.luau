--!strict
--!optimize 2
--!native

local getArgumentErrorMessage = require("./GetArgumentErrorMessage")
local deltaError = require(script.Parent.Parent.DeltaError)

export type SingleArgumentCheckParams<T> = {
	Value: T,
	Order: number,
	Name: string?,
	Reason: string?,
}

local delta1Error = deltaError(1)

--[=[
    Validates a single argument. 
    If the value is nil or false, it throws an error with a formatted message using the specified stack level.
]=]
local function check<T>(singleArgumentCheckParams: SingleArgumentCheckParams<T>, level: number?)
	if singleArgumentCheckParams.Value then
		return
	end

	delta1Error(
		getArgumentErrorMessage({
			Type = "invalid",
			Order = singleArgumentCheckParams.Order,
			Name = singleArgumentCheckParams.Name,
			Reason = singleArgumentCheckParams.Reason,
		}),
		level
	)
end

return check
