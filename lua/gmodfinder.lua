require 'winapi'
k,err = winapi.open_reg_key [[HKEY_CURRENT_USER\Software\Valve\Steam]]
if not k then return print('bad key',err) end

SteamPath=k:get_value("SteamPath")
print("SteamPath",SteamPath)
k:close()

config_vdf = io.open(SteamPath.."/Config/config.vdf")
data = config_vdf:read('*all')
config_vdf:close()


local folders = {SteamPath}

data:gsub([[BaseInstallFolder_%d"%s*"([^"]+)]],function(a) table.insert(folders,(a:gsub("\\","/"):gsub("//","/"))) end)
local GarrysModPath
for k,v in next,folders do
	local path = v.."/SteamApps/common/GarrysMod/garrysmod/garrysmod.ver"
	local f = io.open(path,'rb')
	if f then 
		print("GMod:",(f:read("*all"):gsub("\r?\n"," ")))
		GarrysModPath = v.."/SteamApps/common/GarrysMod"
		break
	end

end

print("GarrysModPath",GarrysModPath)
