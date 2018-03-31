--Dummy Frame for event register
local btrack = CreateFrame("Frame", "btrackframe")
btrack:RegisterEvent("CHAT_MSG_TEXT_EMOTE")

--Create the tables
bonktrack = {}
bonktrackin = {}

--Store your own GUID
local ownguid = UnitGUID("player")

local emotetype, btname

local function btracker(token)
	emotetype = token
	--print(emotetype)
	btname = GetUnitName("target", true)
	tartype = UnitIsPlayer("target")
	--print(tartype)
	--print(btname)
	if tartype == true then
		if btname ~= nil then
			if emotetype == "BONK" then
				--print("Success")
				bonktrack[btname] = bonktrack[btname] and bonktrack[btname]+1 or 1
				print("BONKed " .. btname .. " " .. bonktrack[btname] .. " times")
			else
				print("BONK fail")
			end
		else
			print("btname fail")
		end
	else
		print("Not a player or no target")
	end
end
hooksecurefunc("DoEmote", btracker)

--track inbound bonks
--[[
local function btrackerin(self, event, ...)
	if event == "CHAT_MSG_TEXT_EMOTE" then
		etext, btname, _, _, _, _, _, _, _, _, _, pguid, _ = ...;
		if pguid == ownguid then
			return;
		else
			string.match(etext, 
	else

	end

end
]]
