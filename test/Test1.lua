local scriptTest = require("scripts.mainTest")
local scxmlApi = require("ScxmlApi")
local test = require"LXSCProfile"
local util = require("scripts.util")

print("--------------------------Test Life Cycle------------------------------")

local function test1()
  print("Test 1")

  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onExit)
  util.addToQueue(CallBackType.onTransition)

  -- event s1
  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onEntry)
  util.addToQueue(CallBackType.onExit)
  util.addToQueue(CallBackType.onTransition)
  util.addToQueue(CallBackType.onEntry)



  scxmlInterpreter = Interpreter:fromURI(nil,"resources/test1.xml")
  print("Interpreter State After fromURI(): ","INSTANTIATED",scxmlInterpreter:getInterpreterState()==2)
  callBackImpl= CallBackImpl:new(nil,10)
  scxmlInterpreter:addMonitor(callBackImpl)
  --scxmlInterpreter:reset()
  print("Interpreter State After addMonitor(): ","INSTANTIATED",scxmlInterpreter:getInterpreterState()==2)
  scxmlInterpreter:step()
  print("Test isIn(done): ",scxmlInterpreter:isIn("done")==1)
  scxmlInterpreter:recieveEvent("touch")

  --check if interpreter is in FINISHED state
  print("Interpreter State After step(): ","FINISHED",scxmlInterpreter:getInterpreterState()==-1)
  scxmlInterpreter:reset()

  --check if interpreter is in INSTANTIATED state
  print("Interpreter State After reset(): ",scxmlInterpreter:getInterpreterState()==-1)



end




--print("",CallBackType.onExit)
--print("",CallBackType.onEntry)
--print("",CallBackType.onTransition)

--local queue = {}



--table.insert(queue,CallBackType.onEntry)


--table.insert(callBackSeq,'sajjad')
--table.insert(callBackSeq,'sarwar')
--table.insert(callBackSeq,'c')

--print(table.remove(callBackSeq,1)) -- a
--print(table.remove(callBackSeq,1)) -- b
--print(table.remove(callBackSeq,1)) -- c
--print(table.remove(callBackSeq,1)==nil) -- true

--scxmlInterpreter:start()




test1()
  
  
  