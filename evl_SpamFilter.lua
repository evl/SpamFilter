
-- http://www.wowwiki.com/WoW_Constants/Errors
local blacklist = {
	[ERR_ABILITY_COOLDOWN] = true,
	--[ERR_OUT_OF_RANGE] = true,
	[ERR_NO_ATTACK_TARGET] = true,
	[ERR_ITEM_COOLDOWN] = true,
	[ERR_SPELL_COOLDOWN] = true,
	[OUT_OF_ENERGY] = true,
	[SPELL_FAILED_NO_COMBO_POINTS] = true,
	[SPELL_FAILED_SPELL_IN_PROGRESS] = true,
	--[SPELL_FAILED_TARGETS_DEAD] = true,
}

local originalOnEvent = UIErrorsFrame:GetScript("OnEvent")
UIErrorsFrame:SetScript("OnEvent", function(self, event, message, ...)
	if event == "UI_ERROR_MESSAGE" and not blacklist[message] then
		originalOnEvent(self, event, message, ...)
	end	
end
)

local soundCVar = "Sound_EnableSFX"
local soundEnabled
SlashCmdList['EVL_SOUND'] = function(text, editBox)
	if text == "0" then
		soundEnabled = GetCVar(soundCVar)
		SetCVar(soundCVar, 0)
	elseif text == "1" and soundEnabled ~= nil then
		SetCVar(soundCVar, soundEnabled)
	end
end

SLASH_EVL_SOUND1 = "/sound"
