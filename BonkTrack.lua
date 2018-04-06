--Dummy Frame for event register
local btrack, events = CreateFrame("Frame", "btrackframe"), {}

--Create the tables
bonktrack = {}
bonktrackin = {}
bonktrackguild = {}

--Store your own GUID
--local ownguid = UnitGUID("player")

local emotetype, btname, btguild

local function btracker(token)
	emotetype = token
	--print(emotetype)
	btname = GetUnitName("target", true)
	btguild = GetGuildInfo("target")
	tartype = UnitIsPlayer("target")
	--print(tartype)
	--print(btname)
	if tartype == true then
		if btname ~= nil then
			if emotetype == "BONK" then
				--print("Success")
				bonktrack[btname] = bonktrack[btname] and bonktrack[btname]+1 or 1
				print("|cFFFFFF00BonkTrack:|r You have now bonked " .. btname .. " " .. bonktrack[btname] .. " times")
				if btguild ~= nil then					
					bonktrackguild[btguild] = bonktrackguild[btguild] and bonktrackguild[btguild]+1 or 1
					print("|cFFFFFF00BonkTrack:|r You have now bonked the " .. btguild .. " " .. bonktrackguild[btguild] .. " times")
				else
				end				
			else
				--print("BONK fail")
			end
		else
			--print("btname fail")
		end
	else
		--print("Not a player or no target")
	end
end
hooksecurefunc("DoEmote", btracker)

--Create a function to sort the chat output in descending order
local function spairs(t, order)
	local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end    
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end    
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end


--Create a Slash Command
SLASH_BONKTRACK1, SLASH_BONKTRACK2 = '/bonktrack', '/btrack'
function SlashCmdList.BONKTRACK(msg, editBox)
	local command, rest = msg:match("^(%S*)%s*(.-)$");
		if string.lower(command) == 'player' then
			print("|cFFFFFF00BonkTrack:|r |cFFFF0000Total Player Bonks!|r")
			for k,v in spairs(bonktrack, function(t,a,b) return t[b] < t[a] end) do 
				print("|cFFFFFF00BonkTrack:|r You have bonked " .. k .. " " .. v .. " times.") 			
			end
		elseif string.lower(command) == 'reset' then
			bonktrack = {}
			bonktrackin = {}
			print("|cFFFFFF00BonkTrack:|r All tracked bonks have been deleted.")
		elseif string.lower(command) == 'guild' then
			print("|cFFFFFF00BonkTrack:|r |cFFFF0000Total Guild Bonks!|r")
			for k,v in spairs(bonktrackguild, function(t,a,b) return t[b] < t[a] end) do 
				print("|cFFFFFF00BonkTrack:|r You have bonked the " .. k .. " " .. v .. " times.")
			end
		else
			print("|cFFFFFF00BonkTrack:|r Use the command 'player' to list the number of times you bonked individual players.")
			print("|cFFFFFF00BonkTrack:|r Use the command 'guild' to list the number of times you bonked individual guilds.")
			print("|cFFFFFF00BonkTrack:|r Use the command 'reset' to reset the tracked player and guild bonk counts. |cFFFF0000THERE IS NO UNDO!!|r")
		end
end


--Add Bonks to standard tooltip
local function bonktipnameadd(self)
	btmname = GetUnitName("mouseover", true)		
	if bonktrack[btmname] then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("Times you bonked " .. btmname .. ": " .. bonktrack[btmname])
		GameTooltip:Show()
	else
	end	
end

local function bonktipguildadd(self)
	btmguild = GetGuildInfo("mouseover")
	if bonktrackguild[btmguild] then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("Times you bonked the " .. btmguild .. " Guild: " .. bonktrackguild[btmguild])
		GameTooltip:Show()
	else
	end
end

GameTooltip:HookScript("OnShow", bonktipnameadd);
GameTooltip:HookScript("OnShow", bonktipguildadd);

--TRP3 Tooltips THE FUCK IF I CAN GET THIS TO WORK .... GODDAMMIT
--[[
local function trpbonktipnameadd(self)
    btmname = GetUnitName("mouseover", true)
	print(btmname)
	if bonktrack[btmname] then
		TRP3_CharacterTooltip:AddLine(" ")
		TRP3_CharacterTooltip:AddLine("Times you bonked " .. btmname .. ": " .. bonktrack[btmname])
		TRP3_CharacterTooltip:Show()
		TRP3_CharacterTooltip:GetTop()
	else
	end	
end

local function trpbonktipguildadd(self)
	btmguild = GetGuildInfo("mouseover")
	if bonktrackguild[btmguild] then
		TRP3_CharacterTooltip:AddLine(" ")
		TRP3_CharacterTooltip:AddLine("Times you bonked the " .. btmguild .. " Guild: " .. bonktrackguild[btmguild])
		TRP3_CharacterTooltip:Show()
		TRP3_CharacterTooltip:GetTop()
	else
	end
end
]]

--TRP Tooltips Attempt #2 NOPE GO FUCK YOURSELF
--[[
function AddTooltipName(tooltip, text)
    btmname = GetUnitName("mouseover", true)
	if bonktrack[btmname] then	
		tooltip:Addine("Times you bonked " .. btmname .. ": " .. bonktrack[btmname])
		tooltip:Show()
		tooltip:GetTop()
	else
	end
end

if TRP3_CharacterTooltip ~= nil then
    TRP3_CharacterTooltip:HookScript("OnShow", function(t)
        AddTooltipInfo(TRP3_CharacterTooltip, t.mouseover)
    end)
end
]]



--track inbound bonks  AHAHAHAHAHAHAHAHA IM TOO DUMB FOR THIS SHIT
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
