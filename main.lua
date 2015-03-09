--require "CiderDebugger";
require "input"
require "maingui"
require "tutorial"
require "ressources/fonts"
require "timersloop"
require "save"
require "events"
require "data"
require "investir"
require "money"
require "clientsystem"

local http;
local time = os.time()

Msg = io.write;

function include(file)
	return require(string.gsub(file, ".lua", ""))
end

function load_modules()
	local files =  love.filesystem.getDirectoryItems("modules")
	for k,v in ipairs(files) do
		include("modules/" .. v)
	end
	http = require("socket.http")
	require("save")
end


function love.load()
	love.graphics.setBackgroundColor( 255,245,217 )
	love.filesystem.setIdentity( "GLove-2D" )
	loveframes = require("gui")
	load_modules()
	love.graphics.setPointStyle('smooth')
	love.graphics.setLineStyle('smooth')
	love.graphics.setLineWidth(2)
	init_restore()


		local button = loveframes.Create("button" )
		button:SetWidth(200)
		button:SetText("Button")
		button:Center()
		button.OnClick = function(object, x, y)
			addMoney(4500)
		end
			
		CreatePopUp("lol","beat")


	local music = love.audio.newSource("ressources/theme.mp3", "static")
	music:setLooping( true )
	music:play()
		
end


function love.update()
	loveframes.update(dt)
	hook.Call("Think")
	timer.check()
	leftClick = love.mouse.isDown("l")
end

function love.draw()
	hook.Call("BackGroundDraw") -- wallpaper ?
	hook.Call("Draw")
	loveframes.draw()
	hook.Call("OverLayDraw") -- Menu echap, par exemple

end


hook.Add("MousePress", "MenuPress", function(x,y)
	 principalMenu(x,y)
	 print("MousePress Call")


end)

hook.Add("SaveRestored", "HUDPAINTRESTORED", function()
	hook.Add("BackGroundDraw", "Infos background", function()
		DrawDateBox()
		love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 700)
		love.graphics.print("Duree min: "..tostring(dureeInvestisseurMin) or "nul", 300, 700)
		love.graphics.print("Popularité:"..tostring(Popularity) or "nul", 600,700)
		--love.graphics.print('Memory actually used (in kB): ' .. math.Round(collectgarbage('count')), 900,700)
	end)
end)