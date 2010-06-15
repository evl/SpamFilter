evl_SpamFilterDB = evl_SpamFilterDB or {}

local lastMessage
local originalOnEvent = UIErrorsFrame:GetScript("OnEvent")

UIErrorsFrame:SetScript("OnEvent", function(self, event, message, ...)
	if event == "UI_ERROR_MESSAGE" and evl_SpamFilterDB[message] then
		return
	end
	
	lastMessage = message
	
	return originalOnEvent(self, event, message, ...)
end
)

SlashCmdList["EVL_SPAMFILTER"] = function(text)
	if text == "reset" then
		evl_SpamFilterDB = {}
		print("SpamFilter: Database reset")
	elseif #text > 0 then
		if evl_SpamFilterDB[text] then
	    evl_SpamFilterDB[text] = nil
	    print("SpamFilter: Removed", text, "from database")
		else
			if text == "last" or text == "previous" then
				text = lastMessage
			end
			
	    evl_SpamFilterDB[text] = true
	    print("SpamFilter: Added", text, "to database")
		end
	else
		if next(evl_SpamFilterDB) then
    	print("SpamFilter:")

	    for value in pairs(evl_SpamFilterDB) do
				print("    ", value)
	    end
		else
	    print("SpamFilter: Database is empty")
		end
	end
end

SLASH_EVL_SPAMFILTER1 = "/spamfilter"
SLASH_EVL_SPAMFILTER2 = "/sf"

local soundCVar = "Sound_EnableSFX"
local soundEnabled
SlashCmdList["EVL_SOUND"] = function(text)
	if text == "0" then
		soundEnabled = GetCVar(soundCVar)
		SetCVar(soundCVar, 0)
	elseif text == "1" and soundEnabled ~= nil then
		SetCVar(soundCVar, soundEnabled)
	end
end

SLASH_EVL_SOUND1 = "/sound"
SLASH_EVL_SOUND2 = "/sfx"
