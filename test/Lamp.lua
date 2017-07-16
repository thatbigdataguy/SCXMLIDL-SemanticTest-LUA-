local scriptTest = require("scripts.mainTest")
local scxmlApi = require("ScxmlApi")
local test = require"LXSCProfile"
local util = require("scripts.util")

print("--------------------------Test Life Cycle------------------------------")

local function test2()
  print("Lamp")

  -- Callback sequence expected while processing the state machine
  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onExit)
  util.addToQueue(CallBackType.onTransition)

  -- event "touch"

  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onExit)
  util.addToQueue(CallBackType.onTransition)

  -- event "touch"

  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onExit)
  util.addToQueue(CallBackType.onTransition)

  -- event "touch"

  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onExit)
  util.addToQueue(CallBackType.onTransition)
  -- util.addToQueue(CallBackType.onEntry)


  scxmlInterpreter = Interpreter:fromURI(nil,"resources/Lamp.scxml")
  print("Interpreter State After fromURI(): ","INSTANTIATED",scxmlInterpreter:getInterpreterState()==2)

  -- add monitor to interperter
  callBackImpl= CallBackImpl:new(nil,10)
  scxmlInterpreter:addMonitor(callBackImpl) -- INSTANTIATED
  print("Interpreter State After addMonitor(): ","INSTANTIATED",scxmlInterpreter:getInterpreterState()==2)

  scxmlInterpreter:step()

  -- Check if interperter is in On state
  print("Lamp isIn(on): ",scxmlInterpreter:isIn("on")==1)
  print("Interpreter State After step(): ","IDLE",scxmlInterpreter:getInterpreterState()==3)
  scxmlInterpreter:recieveEvent("touch") -- READY
  print("Interpreter State After recieveEvent(touch): ","READY",scxmlInterpreter:getInterpreterState()==1)
  scxmlInterpreter:step() -- IDLE
  print("Interpreter State After step(): ","IDLE",scxmlInterpreter:getInterpreterState()==3)

  -- Check if interperter is in On state
  print("Lamp isIn(off): ",scxmlInterpreter:isIn("off")==1)
  scxmlInterpreter:recieveEvent("touch") -- READY
  print("Interpreter State After recieveEvent(touch): ","READY",scxmlInterpreter:getInterpreterState()==1)
  scxmlInterpreter:step() -- IDLE
  print("Interpreter State After step(): ","IDLE",scxmlInterpreter:getInterpreterState()==3)

  -- Check if interperter is in On state
  print("Lamp isIn(on): ",scxmlInterpreter:isIn("on")==1)
  scxmlInterpreter:recieveEvent("touch") -- READY 
  print("Interpreter State After recieveEvent(touch): ","READY",scxmlInterpreter:getInterpreterState()==1)
  scxmlInterpreter:step() -- IDLE
  print("Interpreter State After step(): ","FINISHED",scxmlInterpreter:getInterpreterState()==-1)

  -- Check if interperter is in On state
  print("Lamp isIn(off): ",scxmlInterpreter:isIn("off")==1)


end


test2()
