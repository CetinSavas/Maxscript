/* 
Script Resets the scale of selected object while preseerving hierarchy.
For max versions that are prior to introduction of  "keep normals" function in xform modifier, this one uses multiple mirror modifiers to keep object normals.
If you want to fix scales of a hierarchy select the root object and press "Shift/Ctrl(older versions)+PageDown" then run the script.

*/	
	if selection.count >=  1 then 
	(

		( 
-- 			define arrays
			selar=#()
			selmst=#()
			mirsel=#()
			selar= $selection as array
-- 		explode groups 		
		for j=1 to selar.count do 
		(
			try
	 		(
			if (isGroupHead selar[j]) then
					(
						
						explodeGroup selar[j]
						deleteItem selar j
					)
			)
			catch ()
		

		)
--  create array for selection parents and unparent all the selection
		for k=1 to selar.count do
				(
					 
					append selmst selar[k].parent
					selar[k].parent=undefined
				)
			
		
		for i=1 to selar.count do
			(	if NOT isGroupMember selar[i] then 
				(			
-- 					 check if transform mirror applied
							if selar[i].transform[1][1]<0 or selar[i].transform[2][2]<0 or selar[i].transform[3][3]<0 then 
							(
								
								MirX=false
								MirY=false
								MirZ=false
								sx=1
								sy=1
								sz=1
								theRotation=selar[i].rotation
			
								selar[i].rotation=(quat 0 0 0 1)
			
								if selar[i].transform[1][1]<0 do
								(
									sx=-1
									 MirX=true
								) 
								
			
								if selar[i].transform[2][2]<0 do
								(
								sy=-1 
								MirY=true
								)
								 
			
								if selar[i].transform[3][3]<0 do
								(
								sz=-1 
								MirZ=true
								)
								
-- 								correct transforms
								thePos=selar[i].pos
								selar[i].transform=selar[i].transform * (Matrix3 [sx,0,0] [0,sy,0] [0,0,sz] [0,0,0] )
								selar[i].pos=[0,0,0]
							  	resetxform selar[i]
								selar[i].pos=thePos
-- 								apply mirror modifier per negative transformed axis
								if MirX==true do 
								(
									theMirrorX=mirror ()
									theMirrorX.mirror_axis=0
									addModifier selar[i] theMirrorX
								)
								if MirY==true do 
								(
									theMirrorY=mirror()
									theMirrorY.mirror_axis=1
									addModifier selar[i] theMirrorY
								) 
								if MirZ==true do 
								(
									theMirrorZ=mirror ()
									theMirrorZ.mirror_axis=2
									addModifier selar[i] theMirrorZ 
								)
			
								selar[i].rotation=theRotation
								selar[i].parent=selmst[i]
			
							)
-- 							if there is no mirror transform
							else
								(
								tempObj=selar[i]
												
								PTnew= PointHelperObj()
								PTnew.transform = tempObj.transform
-- 								correct placeholder point scale
								PTnew.scale= [1,1,1]
-- 								move the object to origin and fix rotation before reset xform
								in coordsys world tempObj.pos= [0,0,0]
								in coordsys world tempObj.rotation= (quat 0 0 0 1)
								resetxform tempObj
								
								tempObj.transform =  PTnew.transform
								
								PTnew.wirecolor = red
								
								
								
								clearUndoBuffer()
								selar[i].parent=selmst[i]
								delete PTnew
								)
				)
				else
			(append mirsel selar[i])
			)

		select mirsel	
		)
	)