local originalOnEvent = UIErrorsFrame:GetScript("OnEvent")
local lastMessage
local supress
local whitelist = {
	"/",
	"Requires",
	"full",
	"fish"
}

UIErrorsFrame:SetScript("OnEvent", function(self, event, message, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	if message == lastMessage then
		return
	end

	lastMessage = message
	supress = false
	
	if event == "UI_ERROR_MESSAGE" then
		supress = true
		
		for key, value in pairs(whitelist) do
			if string.find(message, value) then
				supress = false
				break
			end
		end
	end
	
	if supress then
		ChatFrame2:AddMessage(string.format('|cff%s%s|r', "ff0000", message))
	else
		originalOnEvent(self, event, message, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	end	
end
)