local scriptTest = require("scripts.mainTest")
local scxmlApi = require("ScxmlApi")
local test = require"LXSCProfile"
local util = require("scripts.util")

print("--------------------------Test Life Cycle------------------------------")

local function test2()
  print("StopWatch")

  -- Callback sequence expected while processing the state machine

  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onExit)
  util.addToQueue(CallBackType.onTransition)

  -- event watch.start

  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onExit)
  util.addToQueue(CallBackType.onTransition)

  -- event watch.stop

  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onExit)
  util.addToQueue(CallBackType.onTransition)

  -- event watch.reset

  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onExit)
  util.addToQueue(CallBackType.onTransition)
  -- util.addToQueue(CallBackType.onEntry)


  scxmlInterpreter = Interpreter:fromURI(nil,"resources/StopWatch.scxml")
  print("Interpreter State After fromURI(): ","INSTANTIATED",scxmlInterpreter:getInterpreterState()==2)

  -- checking interpreter states after processing events
  
  callBackImpl= CallBackImpl:new(nil,10)
  scxmlInterpreter:addMonitor(callBackImpl) -- INSTANTIATED
  print("Interpreter State After addMonitor(): ","INSTANTIATED",scxmlInterpreter:getInterpreterState()==2)
  scxmlInterpreter:step() -- IDLE 
  print("StopWatch isIn(reset): ",scxmlInterpreter:isIn("reset")==1)
  print("Interpreter State After step(): ","IDLE",scxmlInterpreter:getInterpreterState()==3)
  scxmlInterpreter:recieveEvent("watch.start") -- READY
  print("Interpreter State After recieveEvent(watch.start): ","READY",scxmlInterpreter:getInterpreterState()==1)
  scxmlInterpreter:step() -- IDLE
  print("Interpreter State After step(): ","IDLE",scxmlInterpreter:getInterpreterState()==3)
  print("StopWatch isIn(running): ",scxmlInterpreter:isIn("running")==1)
  scxmlInterpreter:recieveEvent("watch.stop") -- READY
  print("Interpreter State After recieveEvent(watch.stop): ","READY",scxmlInterpreter:getInterpreterState()==1)
  scxmlInterpreter:step() -- IDLE
  print("Interpreter State After step(): ","IDLE",scxmlInterpreter:getInterpreterState()==3)
  print("StopWatch isIn(stopped): ",scxmlInterpreter:isIn("stopped")==1)
  scxmlInterpreter:recieveEvent("watch.reset") -- READY
  print("Interpreter State After recieveEvent(watch.reset): ","READY",scxmlInterpreter:getInterpreterState()==1)
  scxmlInterpreter:step() -- IDLE
  print("Interpreter State After step(): ","FINISHED",scxmlInterpreter:getInterpreterState()==-1)
  print("StopWatch isIn(reset): ",scxmlInterpreter:isIn("reset")==1)


end


test2()
