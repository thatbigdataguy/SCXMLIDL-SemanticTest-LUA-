package.path="./modules/lxsc-min-0.12.1.lua"
local LXSC = require"lxsc-min-12"
--Meta class

started = 0;
Interpreter = {name=0}
local currentstate
local CANCELLED, FINISHED, FAULTED, READY, INSTANTIATED, IDLE = -2, -1, 0, 1, 2, 3

-- Base class method new

function Interpreter:fromURI (o,nam)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  nam = nam or 0
  local scxml   = io.open(nam):read('*all')
  machine = LXSC:parse(scxml)
  self.name = machine
 -- machine:start()
  currentstate=INSTANTIATED
  return o
  
end

-- Base class method printName


function Interpreter:step()
   if started == 1 then 
     -- print("running")
      machine:step()
      if machine:isActive("done") then currentstate=FINISHED else currentstate=IDLE end 
   else
     started=1
    -- print("started")    
     machine:start()
     machine:step()
     if machine:isActive("done") then currentstate=FINISHED else currentstate=IDLE end 
   end

end


function Interpreter:recieveEvent(event)
  machine:fireEvent(event)
  currentstate=READY
end

function Interpreter:reset()
  machine:restart()
   if machine:isActive("done") then currentstate=FINISHED else currentstate=IDLE end 
end

function Interpreter:cancel()
  currentstate=CANCELLED
end




function Interpreter:isIn(stateId)
  return machine:isActive(stateId)
end

function Interpreter:getInterpreterState()
  return currentstate
end

function Interpreter:addMonitor(myMonitor)
  
  machine.onBeforeExit = function(stateId,stateKind,isAtomic)
  --  print("-------------onExit:",stateId .. "",stateKind .. "",isAtomic)
    myMonitor:onExit();
  end

  machine.onAfterEnter = function(stateId,stateKind,isAtomic)
  --  print("-------------onEnter:",stateId .. "",stateKind .. "",isAtomic)
     myMonitor:onEntry();
  end

  machine.onTransition = function(transitionTable)
  --  print("-------------onTransition")
     myMonitor:onTransition();
  end

  currentstate=currentstate


end

-- LSXC Profile Extended Monitor
function Interpreter:addLXSCMonitor()
  machine.onDataSet = function(dataid,newvalue)
    print("-------------onDataSet".."dataId:",dataid.." newValue:",newvalue)
  end

  machine.onEnteredAll = function()
    print("-------------onEnteredAll")
  end

  machine.onEventFired = function(evt)
    print("-------------onEventFired:",evt.name)
  end

  currentstate=INITIALIZED


end


