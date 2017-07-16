    local M={};
     
      _G.CallBackType = {
  onExit = "onExit",
  onEntry = "onEntry",
  onTransition ="onTransition"
}
     
     local queue = {}

function M.checkCallBackType(CallBackType)
head = table.remove(queue,1)
--print("Queue Head= ",head," CallBackType= ",CallBackType)
if head==nil then print("Empty Queue") 
else 
--table.insert(queue,head)  
--print("Not Empty Queue") 
--print(table.remove(queue,1)) -- a
if head==CallBackType then 
--print("Queue Head=",head,"CallBackType=",CallBackType,"checkCallBackType Result: True")
print("checkCallBackType Type:",CallBackType," Result: True")
else
--print("Queue Head=",head,"CallBackType=",CallBackType,"checkCallBackType Result: False")
print("checkCallBackType Result: True")
end
end
end

  
     
    function M.addToQueue(value) 
         table.insert(queue,value)  
    end
     
    
    return M;