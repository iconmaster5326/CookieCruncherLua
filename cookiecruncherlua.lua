function getCost(item)
	local cps = item.cps
	if item.gma then
		for i,v in ipairs(items) do
			if v.bought > 0 then
				cps = cps + v.bonus
			end
		end
	end
	return (item.cost*1.1^(item.bought+1))/item.cps
end

function calcCps()
	local cps = 0
	for i,v in ipairs(items) do
		cps = cps + v.cps * v.bought
		if v.gma then
			for ii,vv in ipairs(items) do
				if vv.bought > 0 then
					cps = cps + vv.bonus * v.bought
				end
			end
		end
	end
	return cps
end

items = {{name="Cursor",cost=15,cps=.2,bonus=0},
{name="Grandma",cost=100,cps=1,bonus=0,gma = true},
{name="Factory",cost=500,cps=4,bonus=.2},
{name="Mine",cost=2000,cps=10,bonus=.4},
{name="Shipment",cost=7000,cps=20,bonus=.6},
{name="Alchemy Lab",cost=100000,cps=100,bonus=.8},
{name="Portal",cost=1000000,cps=666,bonus=1},
{name="Time Mahcine",cost=123456789,cps=24691.2,bonus=0}}

for i,v in ipairs(items) do
	v.bought = 0
end

print("Hello. Welcome to LuaCruncher!")
print("This program is currently only for Cookie Clicker Classic, and ignores the benefits of the Elder Pledge.")
print("How many buildings do you want me to calculate the most optimal startegy up to? ")
maxv = io.read("*l")
print("")
maxv = tonumber(maxv)
if not maxv then
	print("That wasn't a number! Please restart the program and actually put in a number, please.")
	os.exit()
end

for iter=1,maxv do
	best = nil
	bestPrice = math.huge
	for i,v in ipairs(items) do
		if getCost(v) < bestPrice then
			best = v
			bestPrice = getCost(v)
		end
	end
	best.bought = best.bought + 1
	print(iter .. ") Buy "..best.name..". CPS of "..calcCps())
	iter = iter + 1
end

print("")
print("All done! Press ENTER to close.")
io.read()
