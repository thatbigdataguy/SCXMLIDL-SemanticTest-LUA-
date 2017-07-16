local scriptTest = require("scripts.mainTest")
local scxmlApi = require("ScxmlApi")
local test = require"LXSCProfile"
local util = require("scripts.util")

print("--------------------------Test Life Cycle------------------------------")

local function test2()
  print("Test 2")

  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onExit)
  util.addToQueue(CallBackType.onTransition)
  
   -- event s2
  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onExit)
  util.addToQueue(CallBackType.onTransition)
  
   -- event s3
  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onExit)
  util.addToQueue(CallBackType.onTransition)
  
   -- event s4
  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onExit)
  util.addToQueue(CallBackType.onTransition)
  
   --entering final state
  util.addToQueue(CallBackType.onEntry)


  scxmlInterpreter = Interpreter:fromURI(nil,"resources/test2.xml")
  print("Interpreter State After fromURI(): ","INSTANTIATED",scxmlInterpreter:getInterpreterState()==2)

  callBackImpl= CallBackImpl:new(nil,10)
  scxmlInterpreter:addMonitor(callBackImpl)
  print("Interpreter State After addMonitor(): ","INSTANTIATED",scxmlInterpreter:getInterpreterState()==2)
  scxmlInterpreter:step()
  print("Interpreter State After step(): ","IDLE",scxmlInterpreter:getInterpreterState()==3)
  scxmlInterpreter:recieveEvent("s2")
  print("Interpreter State After recieveEvent(s2): ","READY",scxmlInterpreter:getInterpreterState()==1)
  scxmlInterpreter:step()
  print("Interpreter State After step(): ","IDLE",scxmlInterpreter:getInterpreterState()==3)
  scxmlInterpreter:recieveEvent("s3")
  print("Interpreter State After recieveEvent(s3): ","READY",scxmlInterpreter:getInterpreterState()==1)
  scxmlInterpreter:step()
  print("Interpreter State After step(): ","IDLE",scxmlInterpreter:getInterpreterState()==3)
  scxmlInterpreter:recieveEvent("s4")
  print("Interpreter State After recieveEvent(s4): ","READY",scxmlInterpreter:getInterpreterState()==1)
  scxmlInterpreter:step()
  print("Interpreter State After step(): ","FINISHED",scxmlInterpreter:getInterpreterState()==-1)

end


test2()