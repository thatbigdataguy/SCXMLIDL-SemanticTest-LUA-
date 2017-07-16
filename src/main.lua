local scriptTest = require("scripts.main")
local scxmlApi = require("ScxmlApi")
local test = require"LXSCProfile"
print("After Import--------------------------------")

scxmlInterpreter = Interpreter:fromURL(nil,"resources/test2.xml")
print("After fromURL: ",scxmlInterpreter:getInterpreterState())

--caller = Caller:new(nil,10)
--callBackImpl= CallBackImpl:new(nil,10)
--caller:register(callBackImpl);
callBackImpl= CallBackImpl:new(nil,10)

scxmlInterpreter:addMonitor(callBackImpl)
print("After addMonitor(): ",scxmlInterpreter:getInterpreterState())

--scxmlInterpreter:start()
scxmlInterpreter:recieveEvent("s1")
print("After recieveEvent(): ",scxmlInterpreter:getInterpreterState())
scxmlInterpreter:step()
print("After step(): ",scxmlInterpreter:getInterpreterState())


scxmlInterpreter:recieveEvent("s2")
scxmlInterpreter:step()
print("After step(): ",scxmlInterpreter:getInterpreterState())

scxmlInterpreter:recieveEvent("s3")
scxmlInterpreter:step()
print("After step(): ",scxmlInterpreter:getInterpreterState())

scxmlInterpreter:recieveEvent("s4")
scxmlInterpreter:step()
print("After step(): ",scxmlInterpreter:getInterpreterState())



for stateId,_ in pairs(scxmlInterpreter:allStateIds()) do
  print("One of the states has this id:",stateId)
end

print("Is the foo-bar state active?", scxmlInterpreter:isActiveState('stopped'))

for stateId,_ in pairs(machine:activeStateIds()) do
  print("This state is currently active:",stateId)
end


--LXSC Extended Monitor Profile
scxmlInterpreter:addLXSCMonitor()
scxmlInterpreter:addEventToQueue("watch.start")
scxmlInterpreter:addEventToQueue("watch.stop")

scxmlInterpreter:triggerEvents()
print("After triggerEvents(): ",scxmlInterpreter:getInterpreterState())

for stateId,_ in pairs(machine:activeStateIds()) do
  print("This state is currently active:",stateId)
end


