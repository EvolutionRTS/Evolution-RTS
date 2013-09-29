function widget:GetInfo()
   return {
      name      = "PrintCam",
      desc      = "Print GetCameraState()",
      author    = "zwzsg",
      version   = "1",
      date      = "Dec, 2009",
      license   = "Free",
      layer     = 1,
      enabled   = false,
   }
end


function widget:MousePress(mx, my, button)
	local txt=nil
	for k,v in pairs(Spring.GetCameraState()) do
		txt=(txt and (txt..", ") or "")..tostring(k).."="..tostring(v)
	end
	txt="ViewPoint={\""..txt.."}\";"
	Spring.Echo(txt)
end