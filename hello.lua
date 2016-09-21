-- globals.lua
-- show all global variables

local seen={}

function dump(t,i)
	seen[t]=true
	local s={}
	local n=0  --isso é um misterio
	for k in pairs(t) do
		n=n+1 s[n]=k
	end
	table.sort(s)  --o s eh apra
	for k,v in ipairs(s) do
		print(i,v)
		v=t[v]
		if type(v)=="table" and not seen[v] then
			--[[--

			dfgdfgd
			dfgdfg
			dfg                   dfgdfg
			fg
			--]]--
			dump(v,i.."\t")
		end
	end
end

dump(_G,"")
