local After = C_Timer.After
local LSM = LibStub("LibSharedMedia-3.0")

LSM:Register("sound", "RageLeading: Arachnid", [[Interface\AddOns\DBM-RageLeading\sounds\arachnid.ogg]])
LSM:Register("sound", "RageLeading: Move From The Ice", [[Interface\AddOns\DBM-RageLeading\sounds\move.ogg]])
LSM:Register("sound", "RageLeading: Spread", [[Interface\AddOns\DBM-RageLeading\sounds\spread.ogg]])
LSM:Register("sound", "RageLeading: Succ Inc", [[Interface\AddOns\DBM-RageLeading\sounds\succ.ogg]])
LSM:Register("sound", "RageLeading: Up The Stairs", [[Interface\AddOns\DBM-RageLeading\sounds\stairs.ogg]])
LSM:Register("sound", "RageLeading: Webbers On The Floor", [[Interface\AddOns\DBM-RageLeading\sounds\webbers.ogg]])

local function OnModLoaded()
	local mod = DBM:GetModByName(2482)
	-- Move - unused

	-- Spread - Chilling Blast
	mod.Options["SpecWarn371976moveawaySWSound"] = [[Interface\AddOns\DBM-RageLeading\sounds\spread.ogg]]

	-- Succ - Gossamer Burst
	mod.Options["SpecWarn373405spellSWSound"] = [[Interface\AddOns\DBM-RageLeading\sounds\succ.ogg]]

	-- Webbers - Enveloping Webs
	mod.Options["SpecWarn372082youposSWSound"] = [[Interface\AddOns\DBM-RageLeading\sounds\webbers.ogg]]
end

-- Archanid - Frostbreath Arachnid
DBM:RegisterCallback("DBM_Announce", function(event, message, icon, type, spellID, modID)
	if spellID == "ej24899" then -- Arachnid - Frostbreath Arachnid
		After(0.25, function()
			DBM:PlaySoundFile([[Interface\AddOns\DBM-RageLeading\sounds\arachnid.ogg]], true)
		end)
	end
end)

-- Stairs - Phase Timer
DBM:RegisterCallback("DBM_SetStage", function(event, mod, modID, phase)
	if modID == 2482 and (phase == 1.25 or phase == 1.5 or phase == 1.75) then
		DBM:PlaySoundFile([[Interface\AddOns\DBM-RageLeading\sounds\stairs.ogg]], true)
	end
end)

-- Wait for module to load, so we can modify options.
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if event ~= "ADDON_LOADED" then return end
	if addon == "DBM-RageLeading" then
		-- Check if DBM is pre-loaded
		local _, isLoaded = IsAddOnLoaded("DBM-VaultoftheIncarnates")
		if isLoaded then
			OnModLoaded()
		end
	elseif addon == "DBM-VaultoftheIncarnates" then
		OnModLoaded()
	end
end)