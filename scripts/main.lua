-- Meta class
CallBack = {area = 0}

-- Base class method new

function CallBack:new (o,side)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   side = side or 0
   self.area = side*side;
   return o
end

-- Base class method printArea

function CallBack:onExit ()
   print("")
end
function CallBack:onEntry ()
   print("")
end
function CallBack:onTransition ()
   print("")
end
-- Creating an object
myshape = CallBack:new(nil,10)
myshape:onExit()
myshape:onEntry()
myshape:onTransition()

CallBackImpl = CallBack:new()

-- Derived class method new

function CallBackImpl:new (o,side)
   o = o or CallBack:new(o,side)
   setmetatable(o, self)
   self.__index = self
   return o
end

-- Derived class method printArea

function CallBackImpl:onExit ()
   print("onExit From CallBackImpl ",self.area)
end
function CallBackImpl:onEntry ()
   print("onEntry From CallBackImpl ",self.area)
end
function CallBackImpl:onTransition ()
   print("onTransition From CallBackImpl ",self.area)
end

-- Creating an object
mysquare = CallBackImpl:new(nil,10)
mysquare:onExit()
mysquare:onEntry()
mysquare:onTransition()

-- Meta class
Caller = {area = 0}
function Caller:new (o,side)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   side = side or 0
   self.area = side*side;
   return o
end

function Caller:register (callBack)
    callBack:onExit();
    callBack:onEntry();
    callBack:onTransition();
end


caller = Caller:new(nil,10)
callBackImpl= CallBackImpl:new(nil,10)
caller:register(callBackImpl);


