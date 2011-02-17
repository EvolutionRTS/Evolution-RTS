
function HSLfromRGB(Red,Green,Blue)
	local iR=Red
	local iG=Green
	local iB=Blue
	fR = iR/255
	fG = iG/255
	fB = iB/255
	local fL,fH,fS
	local iL,iH,iS

	local minRGB=math.min(fR,math.min(fG,fB))
	local maxRGB=math.max(fR,math.max(fG,fB))
	local deltaRGB=maxRGB - minRGB

	local deltaR = (((maxRGB-fR)/6)+(deltaRGB/2))/deltaRGB
	local deltaG = (((maxRGB-fG)/6)+(deltaRGB/2))/deltaRGB
	local deltaB = (((maxRGB-fB)/6)+(deltaRGB/2))/deltaRGB

	fL = (minRGB+maxRGB)/2

	if deltaRGB==0 then
		fH=0
		fS=0
	else

		if fL<0.5 then
			fS = deltaRGB/(minRGB+maxRGB)
		else
			fS = deltaRGB/(2.0-minRGB-maxRGB)
		end

		if fR==maxRGB then
			fH = deltaB - deltaG
		elseif fG==maxRGB then
			fH = (1.0/3)+deltaR-deltaB
		elseif fB==maxRGB then
			fH = (2.0/3)+deltaG-deltaR
		else
			fH=0
		end

		if fH<0 then
			fH=fH+1
		end
		if fH>1 then
			fH=fH-1
		end

	end

	iH=fH*255
	iS=fS*255
	iL=fL*255

	return iH,iS,iL
end


local function SubFunForRGBfromHSL(v1,v2,v3)
	local vH=v3
	if vH<0 then
		vH=vH+1
	end
	if vH>1 then
		vH=vH-1
	end
	if (6*vH)<1.0 then
		return v1+(v2-v1)*6*vH
	end
	if (2*vH)<1 then
		return v2
	end
	if (3*vH)<2.0 then
		return v1+(v2-v1)*((2.0/3)-vH)*6
	end
	return v1
end


function RGBfromHSL(Hue,Saturation,Lightness)
	local iH=Hue
	local iS=Saturation
	local iL=Lightness
	local fH = iH/255
	local fS = iS/255
	local fL = iL/255
	local v1,v2
	local fR,fG,fB
	local iR,iG,iB

	if fS==0 then
		fR=fL
		fG=fL
		fB=fL
	else
		if fL<0.5 then
			v2=fL*(1.0+fS)
		else
			v2=(fL+fS)-(fS*fL)
		end
		v1=2*fL-v2
		fR=SubFunForRGBfromHSL(v1,v2,fH+(1.0/3))
		fG=SubFunForRGBfromHSL(v1,v2,fH)
		fB=SubFunForRGBfromHSL(v1,v2,fH-(1.0/3))
	end

	iR=fR*255
	iG=fG*255
	iB=fB*255

	return iR,iG,iB
end

function PickRandomColors(TeamList)-- Add a color attribute to each element of TeamList
	local Hue,Saturation,Lightness
	local RandOrder={}
	local ListAvailable={}
	local HueOffset=math.random(0,255)
	local Red,Green,Blue
	for p=1,#TeamList do
		ListAvailable[p]=p
	end
	for p=1,#TeamList do
		local g=1+math.random(0,#TeamList-p)
		RandOrder[p]=ListAvailable[g]
		for k=g,#TeamList-1 do
			ListAvailable[k]=ListAvailable[k+1]
		end
	end
	for p,_ in ipairs(TeamList) do
		Hue=(HueOffset+(((p-1)*256)/#TeamList))%256
		Saturation=255
		Lightness=math.random(96,192) -- Change here if you want different brightness range (0-255,0-255)
		Red,Green,Blue=RGBfromHSL(Hue,Saturation,Lightness)
		TeamList[p].color={Red/255,Green/255,Blue/255}
	end
end
