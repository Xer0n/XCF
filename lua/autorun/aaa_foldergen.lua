AddCSLuaFile("autorun/aaa_foldergen.lua")

aaa_debug = false

function aaa_IncludeHere(dir)
	//print("hi from "..dir)
	local files, folders = file.Find(dir.."/*", "LUA")

	for k,v in pairs(file.Find(dir.."/*.lua", "LUA")) do
		if aaa_debug then Msg("XCF: including file \""..dir.."/"..v.."\"!\n") end
		include(dir.."/"..v)
	end
	
	for _, fdir in pairs(folders) do
		aaa_IncludeHere(dir.."/"..fdir)
	end
 
end



function aaa_IncludeClient(dir)
	
	local files, folders = file.Find(dir.."/*", "LUA")
	
	for k,v in pairs(file.Find(dir.."/*.lua", "LUA")) do
		if aaa_debug then Msg("XCF: adding client file \""..dir.."/"..v.."\"!\n") end
		AddCSLuaFile(dir.."/"..v)
	end
	
	for _, fdir in pairs(folders) do
		aaa_IncludeClient(dir.."/"..fdir)
	end
 
end



function aaa_IncludeClientPrint(dir)
	
	local files, folders = file.Find(dir.."/*", "LUA")
	
	for k,v in pairs(file.Find(dir.."/*.lua", "LUA")) do
		print("AddCSLuaFile(\"" ..dir.."/"..v.. "\")")
	end
	
	for _, fdir in pairs(folders) do
		aaa_IncludeClientPrint(dir.."/"..fdir)
	end
 
end



function aaa_IncludeShared(dir)
	
	local files, folders = file.Find(dir.."/*", "LUA")
	
	for k,v in pairs(file.Find(dir.."/*.lua", "LUA")) do
		if aaa_debug then Msg("XCF: adding client file \""..dir.."/"..v.."\"!\n") end
		include(dir.."/"..v)
		AddCSLuaFile(dir.."/"..v)
	end
	
	for _, fdir in pairs(folders) do
		aaa_IncludeShared(dir.."/"..fdir)
	end
 
end



local comment = 
[[/*
	Autogenerated folder includes for %s
*/

if not aaa_foldergen_wasloaded then include("autorun/aaa_foldergen.lua") end

// Requires manual sorting.]]


local noinclude = {}
noinclude["aaa_folder.lua"] = true
//noinclude["xcf_includes_cl.lua"] = true
//noinclude["xcf_includes_sv.lua"] = true
//noinclude["xcf_includes_svcl.lua"] = true
//noinclude["xcf_includes_sh.lua"] = true


local function findaaas(base, dirs)
	local ret = {}

	for k, folder in pairs(dirs) do
		local files = file.Find(base.."/"..folder.."/aaa_folder.lua", "LUA")
		for k, file in pairs(files) do
			ret[folder] = true
		end
	end
	
	return ret
end



function aaa_foldergen_here(dir)

	print(string.format(comment, dir))
	
	local files, folders = file.Find(dir.."/*", "LUA")

	for k, v in pairs(file.Find(dir.."/*.lua", "LUA")) do
		if !noinclude[v] then
			print("include(\"".. dir.."/"..v .. "\")")
		end
	end
	
	print("")
	
	local aaalookup = findaaas(dir, folders)
	
	for k, folder in pairsByName(folders) do
		if aaalookup[folder] then
			print("include(\"".. dir.."/"..folder.."/aaa_folder.lua\")")
		else
			print("aaa_IncludeHere(\"".. dir.."/"..folder .."\")")
		end
	end
 
end




function aaa_foldergen_svcl(dir)

	print(string.format(comment, dir))
	
	local files, folders = file.Find(dir.."/*", "LUA")

	for k, v in pairs(file.Find(dir.."/*.lua", "LUA")) do
		if !noinclude[v] then
			print("AddCSLuaFile(\"".. dir.."/"..v .. "\")")
		end
	end
	
	print("")
	
	local aaalookup = findaaas(dir, folders)
	
	for k, folder in pairsByName(folders) do
		/*
		if aaalookup[folder] then
			print("AddCSLuaFile(\"".. dir.."/"..folder.."/aaa_folder.lua\")")
		else
			print("aaa_IncludeClient(\"".. dir.."/"..folder .."\")")
			
		end
		//*/
		aaa_IncludeClientPrint(dir.."/"..folder)
	end
 
end




function aaa_foldergen_sh(dir)

	print(string.format(comment, dir))
	
	local files, folders = file.Find(dir.."/*", "LUA")

	for k, v in pairs(file.Find(dir.."/*.lua", "LUA")) do
		print("AddCSLuaFile(\"".. dir.."/"..v .. "\")")
		if !noinclude[v] then
			print("include(\"".. dir.."/"..v .. "\")")
		end
		print("")
	end
	
	print("")
	
	local aaalookup = findaaas(dir, folders)
	
	for k, folder in pairsByName(folders) do
		if aaalookup[folder] then
			print("include(\"".. dir.."/"..folder.."/aaa_folder.lua\")")
			print("AddCSLuaFile(\"".. dir.."/"..folder.."/aaa_folder.lua\")")
		else
			print("aaa_IncludeShared(\"".. dir.."/"..folder .."\")")
		end
	end
 
end