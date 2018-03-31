--Dummy Frame for event register
local btrack, events = CreateFrame("Frame", "btrackframe"), {}

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
	etext, btname, _, _, _, _, _, _, _, _, _, pguid, _ = ...;
	if pguid == ownguid then
		return;
	else
		local namedump, bonkdump = string.match(etext, "^(%S*)%s*(.-)$")
		if bonkdump == "bonks" then
			print("bonkdump success")
		else
			print("bonkdump fail")
		end
	end		
end

function events:CHAT_MSG_TEXT_EMOTE(...)
	btrackerin(self)
end

btrack:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); 
end);

for k, v in pairs(events) do
 btrack:RegisterEvent(k);
end
]]
