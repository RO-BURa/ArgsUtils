--!strict
--!optimize 2
--!native

local ArgsUtils = {}

ArgsUtils.Check = require("@self/Check")
ArgsUtils.CheckArguments = require("@self/CheckArguments")
ArgsUtils.GetArgumentErrorMessage = require("@self/GetArgumentErrorMessage")

return ArgsUtils
