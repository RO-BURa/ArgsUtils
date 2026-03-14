--!strict
--!optimize 2
--!native

export type ArgumentErrorMessageParams = {
	Type: "missing" | "invalid" | string,
	Order: number,
	Name: string?,
	Reason: string?,
}

--[=[
	Generates a standardized error message string for function arguments.
	Used to notify when an argument is either missing or does not meet the expected criteria.
]=]
local function getArgumentErrorMessage(argumentErrorMessageParams: ArgumentErrorMessageParams): string
	local errorMessage = `{argumentErrorMessageParams.Type} argument #{argumentErrorMessageParams.Order}`
	if argumentErrorMessageParams.Name then
		errorMessage ..= ` to '{argumentErrorMessageParams.Name}'`
	end
	if argumentErrorMessageParams.Reason then
		errorMessage ..= ` ({argumentErrorMessageParams.Reason})`
	end

	return errorMessage
end

return getArgumentErrorMessage
