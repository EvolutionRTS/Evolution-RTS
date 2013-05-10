include("keysym.h.lua")

function widget:GetInfo()
  return {
    name = "QueueCopypasta",
    desc = "Copy-paste queues. Press spacebar + alt + number to copy queue, press spacebar + number to load queue.",
    author = "dizekat",
    date = "2008",
    license = "GNU GPL, v2 or later",
    layer = 5,
    enabled = true
  }
end

local queues = {}

local function GetQueue(unit_id)
  return Spring.GetCommandQueue(unit_id)
end

local function SetQueue(unit_id , queue, shift)
  for i,command in ipairs(queue) do
    Spring.GiveOrderToUnit(unit_id, command.id, command.params, {"shift"})
  end
end

function widget:KeyPress(key, modifier, is_repeat)
    if not modifier.meta then return end
    local units=Spring.GetSelectedUnits()
    local saving=modifier.alt
    local buffer_id=key-KEYSYMS.N_0
    if buffer_id<0 or buffer_id>9 then return end
    if saving then
      queues[buffer_id]={}
      for i, unit_id in ipairs(units) do
        queues[buffer_id][i]=GetQueue(unit_id)
      end
    else
      if queues[buffer_id]==nil then return end
      local n=table.getn(queues[buffer_id])
      if n==0 then return end
      for i,unit_id in ipairs(units) do --- todo: more intelligently distribute individual unit queues based on unit def ids
        SetQueue(unit_id,queues[buffer_id][1+(i%n)])
      end
    end
end

function widget:GetConfigData() 
  return queues
end
function widget:SetConfigData(data) 
  if (data ~= nil) then
    queues = data
  end
end