--Create the table
bonktrack = {}

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
