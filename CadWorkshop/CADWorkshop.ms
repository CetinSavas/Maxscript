/* 
A tool for faster processing of cad files.

*/

try (DestroyDialog rlCADWorkshop) catch()

-- polygon cleaner function
fn fnPolyCleaner =
(
	if selection.count>=1 do 
	(
		undo on
		(	
			for o in selection where superclassof o== geometryClass do 
			(
				toPoly=Turn_to_Poly ()
				addModifier o toPoly
				toPoly.requirePlanar = on
				maxOps.CollapseNodeTo o 1 off
				o.buttonOp #RemoveIsoVerts 
			
				o.weldThreshold=0.0001
				polyop.weldVertsByThreshold o  #{1..polyOp.getNumVerts o}
			
			)
		)
	)
)

-- align pivot to selected faces' normal.
fn fnAlignTwoNormal node face1:1 face2:2 face3:3 = if  (isKindOf node Editable_Poly) or (isKindOf node Editable_mesh) do 
(	
-- 	get face normals
	if isKindOf node Editable_Poly do 
	(
	n1=polyOp.getFaceNormal node face1
	p1=polyOp.getFaceCenter node face1
	p2=polyOp.getFaceCenter node face2 
	n3=polyOp.getFaceNormal node face3
	)
	if isKindOf node Editable_mesh do 
	(
	n1=getFaceNormal node face1
	p1=meshOp.getFaceCenter node face1
	p2=meshOp.getFaceCenter node face2 
	n3=getFaceNormal node face3
	)
-- 	calculate pivot direction
	zV=normalize n1 
	yV=normalize n3
	xV=normalize (cross yV zV )
	yV=normalize (cross zV xV )
-- 	calculate pivot position
	thePos=(p1+p2)/2
-- 	create matric from normals and position
	theMatrix=Matrix3 xV Yv Zv thePos

	itm = theMatrix* (inverse node.transform)
	node.transform=theMatrix 
	node.objectOffsetPos*= inverse itm
	node.objectOffsetRot*= inverse itm.rotation

	node.transform

) 
-- align pivots to two selected face normals and positions
fn fnAlignPivotToSelCenter node type:#z_up= if (isKindOf node Editable_Poly )Or (isKindOf node Editable_mesh )do 
(

-- 	get face normals	
	if isKindOf node Editable_Poly do 
	(
	aBitAr=node.getSelection #face 
	num_faces=polyop.getNumFaces node
	theCenter=[0,0,0]
	counter=0
	firstIndex=1
	for i=1 to num_faces do 
	(
		if (findItem aBitAr i)!=0  do 
		(
			theCenter+=polyop.getFaceCenter node i 
			if counter==0 do 
			(
				counter=1
				firstIndex=i 
			)
		)
	)

	c=theCenter/(aBitAr.numberSet as float)
	n=polyOp.getFaceNormal node firstIndex 
	)

	if isKindOf node Editable_mesh do 
	(
		aBitAr= getFaceSelection node
		num_faces=getNumFaces node
		theCenter=[0,0,0]
		counter=0
		firstIndex=1 
		for i=1 to num_faces do 
		(
			if (findItem aBitAr i)!=0 do 
			(	
				theCenter+=meshOp.getFaceCenter node i 
				if counter==0 do 
				(
					counter=1
					firstIndex=i 
				)
			)
		)
		c=theCenter/(aBitAr.numberSet as float)
		n=getFaceNormal node firstIndex
	)
-- 	calculate pivot orientation
	ftm=translate (MatrixFromNormal n) c 
	case of 
	(
		#x_up: PreRotateY ftm -90
		#y_up: PreRotateX ftm 90
	) 

	itm = ftm* (inverse node.transform)
	node.transform=ftm 
	node.objectOffsetPos*= inverse itm 
	node.objectOffsetRot*= inverse itm.rotation

	node.transform
)

fn fnAlignPivotToFaceNormal node face1:1 face2:2 type:#z_up = if isKindOf node Editable_Poly do 
(
	faceCenter1=polyOp.getFaceCenter node face1
	faceCenter2=polyOp.getFaceCenter node face2
	c=(faceCenter1+faceCenter2)/2
	n=polyOp.getFaceNormal node face1 
	ftm=translate (MatrixFromNormal n) c 
	case of 
	(
		#x_up: PreRotateY ftm -90
		#y_up: PreRotateX ftm 90
	)

	itm = ftm* (inverse node.transform)
	node.transform=ftm 
	node.objectOffsetPos*= inverse itm 
	node.objectOffsetRot*= inverse itm.rotation

	node.transform
)
--replace instances
fn fnReplaceIns sel1 ar1 =
(
 for i in ar1 do 
	(
		 	instanceReplace i sel1 
		 	i.wirecolor=(color 213 154 229)
	)
)
-- reset Xform function 
	fn fnResetXformPlus selar=
(	if selar.count >=  1 then 
	(
		( 
			
			
			selmst=#()
			mirsel=#()
			
			
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

		for k=1 to selar.count do
				(
					 
					append selmst selar[k].parent
					selar[k].parent=undefined
				)
			
		
		for i=1 to selar.count do
			(	if NOT isGroupMember selar[i] then 
				(
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
								
			
								thePos=selar[i].pos
								selar[i].transform=selar[i].transform * (Matrix3 [sx,0,0] [0,sy,0] [0,0,sz] [0,0,0] )
								selar[i].pos=[0,0,0]
							  	resetxform selar[i]
								selar[i].pos=thePos
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
							else
								(
								tempObj=selar[i]
												
								PTnew= PointHelperObj()
								PTnew.transform = tempObj.transform
			
								PTnew.scale= [1,1,1]
								in coordsys world tempObj.pos= [0,0,0]
								in coordsys world tempObj.rotation= (quat 0 0 0 1)
								resetxform tempObj
								--maxOps.CollapseNode tempObj off
								tempObj.transform =  PTnew.transform
								
								PTnew.wirecolor = red
								--delete PTnew
								
								Print (i*100.0/selar.count)
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
)	

rollout rlCADWorkshop "CAD Workshop" width:170 height:680
(
	group "Selection Tools" (
	    -- Group body.
	button btnSelSame			"Pick By Vertices"			pos:[25,20]	width:120 height:20	tooltip:"Select meshes with same vertex count with the selection"
	button btnSelInst 			"Select Instances"			pos:[25,45]	width:120 height:20	tooltip:"Select meshes with same vertex count with the selection"


	)

	group "Pivot Tools" (
	    -- Group body.
	button 	btnFace1			"Get Face1"					pos:[10,90]			width:80 height:20 tooltip:"Get first face of the face pair"
	spinner spnFirstFace 		"ID" 						pos:[80,90] 		width:80 height:20 type:#integer range:[1,9999999,1] fieldWidth:40
	button 	btnFace2			"Get Face2"					pos:[10,115]			width:80 height:20 tooltip:"get second face of the face pair"
	spinner spnSecondFace 		"ID" 						pos:[80,115] 		width:80 height:20 type:#integer range:[1,9999999,1] fieldWidth:40
	checkBox chkThirdFace		"Enable 2nd Axis"			pos:[25,140]
	button 	btnFace3			"Get Face3"					pos:[10,165]		width:80 height:20 tooltip:"Get third face for axis alignment"
	spinner spnThirdFace		"ID"						pos:[80,165]		width:80 height:20 type:#integer range:[1,9999999,1] fieldWidth:40 enabled:false
	button 	btnAlign			"Align to Faces"			pos:[25,190]		width:120 height:20 tooltip:"Operates on polygon face id's"
	button 	btnAlignSel			"Align to Selected Faces"	pos:[25,215]		width:120 height:20 tooltip:"Operates on polygon face selections"
	button 	btnResetPlus 		"ResetXForm+"				pos:[25,240] 	width:120 height:20	tooltip:"Reset Xform Without Loosing Orientation"
	)
	group "Polygon Tools" (
	    -- Group body.
	    	button 	btnPolyClean		"PolyCleaner"				pos:[25,285]	width:120 height:20 tooltip:"Run polyCleaner on selection set"
	    	button 	btnQuad				"Quadrify"					pos:[25,310]	width:120 height:20 tooltip:"Quadrify selected polygon objects"
	    	button 	btnRemoveMat		"Clean Materials"					pos:[25,335]	width:120 height:20 tooltip:"remove materials from objects"

	)
	group "Instance Tools" (
	    -- Group body.
    pickbutton pbtnInsMaster	"Pick Instance Target"				pos:[25,380]	width:120 height:20 tooltip:"Pick an object as instance template"
	button btnReplace			"Replace Selection" 		pos:[25,410]	width:120 height:20 tooltip:"Replace selection with instances"
	)

	group "SplineExtras"
		(
			timer tick_tock interval:50 active:false 
			button btnSlice "Slice"						pos:[25,455] 	width:120 height:20 tooltip:"Start slicing cable geometry"
			button btnInSlice "Slice Sub-Object"		pos:[25,485] 	width:120 height:20 tooltip:"Start slicing cable geometry"
			button btnMakeSpline "Make Spline" 			pos:[25,515]	width:120 height:20 tooltip:"Complete slicing and create spline"
			button btnCMid		"Create on Pivots"		pos:[25,545]	width:120 height:20 tooltip:"Create spline from pivot positions of selected objects"
			button btnClrResidue "Clean Residue"		pos:[25,575]	width:120 height:20 tooltip:"Clean spline creation helpers "
		)  	
	group "Freeze/Unfreeze"
		(
			button btnUnFreeze "Unfreeze By Hit"	pos:[25,625]	width:120	height:20 tooltip:"Unfreeze by hit"
			button btnFreeze "Freeze Selected"		pos:[25,650]	width:120	height:20 tooltip:"Unfreeze by hit"
		)

	on btnSelInst pressed do 
	(

		InstanceMgr.GetInstances $ &instances 
		select instances
	)

	on btnRemoveMat pressed do 
	(
		for o in selection do 
		(
		if o.material!= undefined then (o.material=none)

		)
		redrawViews()
	)

	on btnFreeze pressed do 
	(max freeze selection)	
	on btnUnFreeze pressed do 
	(Max unfreeze by hit	)	

	on chkThirdFace changed state do 
	(
		if state then spnThirdFace.enabled=true
		else spnThirdFace.enabled=false
	)
	
	on  btnFace1 pressed do 
	(
		if selection.count==1 then 
		(
			spnFirstFace.value=((((getFaceSelection $) as array)[1]) as integer)
			--print ((((getFaceSelection $) as array)[1]) as integer) 
		)
	) 
	
	on  btnFace2 pressed do 
	(
		if selection.count==1 then 
		(
			spnSecondFace.value=((((getFaceSelection $) as array)[1]) as integer)
			--print ((((getFaceSelection $) as array)[1]) as integer) 
		)
	) 
	
	on  btnFace3 pressed do 
	(
		if selection.count==1 then 
		(
			spnThirdFace.value=((((getFaceSelection $) as array)[1]) as integer)
			--print ((((getFaceSelection $) as array)[1]) as integer) 
		)
	) 

	on btnAlignSel pressed do 
	(
		if selection.count==1 AND ((isKindOf selection[1] Editable_Poly) OR (isKindOf selection[1] Editable_mesh) )  then 
		(	
			if isKindOf selection[1] Editable_Poly do  aBitAry=$.getSelection #face
			if isKindOf selection[1] Editable_mesh do  aBitAry=getFaceSelection $
			
			try (if aBitAry.numberSet>=1 then (fnAlignPivotToSelCenter $)
						else (messageBox "Select Some Polygon or Mesh Faces")
				)
			catch ()
		)
		else
		(
			messageBox "Select a Polygon Object"
		) 
	)
	on btnAlign pressed do 
	(	
		if chkThirdFace.checked==false then 
		(
			undo on 
				(
					for o in selection do 
						(	
							turnToPoly=Turn_to_Poly ()
							addModifier o turnToPoly 
							maxOps.CollapseNodeTo o 1 off
							try (fnAlignPivotToFaceNormal o face1:(spnFirstFace.value) face2:(spnSecondFace.value) type:#z_up) catch ()
							o.wireColor=yellow
						)
				)
		)
		else 
		(	--print "false"
			undo on 
			(
				for o in selection do 
				(	if spnThirdFace.value!=spnFirstFace.value OR spnThirdFace.value!=spnSecondFace.value then 
					(
						try (fnAlignTwoNormal o face1:(spnFirstFace.value) face2:(spnSecondFace.value) face3:(spnThirdFace.value)  ) catch()
						o.wireColor=yellow
					)
					else messageBox "Check the 3rd Face ID"
				)
			)
		)
	)
	on btnResetPlus pressed do 
	(
		fnResetXformPlus (selection as array)
	)
	on pbtnInsMaster picked obj do 
	(
		pbtnInsMaster.text=obj.name
	)
	on pbtnInsMaster rightClick do 
	(
		pbtnInsMaster.text="{---Instance master---}" 
		pbtnInsMaster.object=undefined
	)

	on btnSelSame pressed do 
	(
		 
		try (if selection.count==1 then (select (for o in geometry where (classOf o==Editable_mesh or classOf o ==Editable_Poly )and((getNumVerts o)==(getNumVerts selection[1])) AND (getNumFaces o == getNumFaces selection[1]) collect o))
				else messageBox "Please select a geometry object!")
		catch(messageBox "Try Catch Failed")
	)

	on btnPolyClean pressed do 
	(
		fnPolyCleaner ()
	)

	on btnQuad pressed do 
	(
		selArray=selection as array 
		for o  in selArray where isKindOf o Editable_Poly do 
		(	
			select o 
			try (PolyToolsModeling.Quadrify false false) catch (messageBox "NOPE!")
		)
		select selArray
	)
	on btnReplace pressed do 
	(
		selection_Array=$selection as array 
			if selection_Array.count>=1 AND pbtnInsMaster.object!=undefined then 
			(
				undo on
				(try (fnReplaceIns (pbtnInsMaster.object) selection_Array) catch() )

			)
			else 
			(messageBox "Select some objects")

	)


	on btnCMid pressed do 

	(
		try
		(
			sp=SplineShape ()
			sp.name=uniqueName "NewSpline_"
			sp.wireColor= (Color 0 200 255)
			addNewSpline sp 

			if selection.count >=2 do 	
				(
						for o in selection do 
						(
							addKnot sp 1 #smooth #curve o.position 
			
						)
				)
			updateShape sp
			sp.pivot=getKnotPoint sp 1 1

		)
		catch 
		(
			messageBox "opps!"
		)
	)

-- slice Polygons for creating mid points
	on btnSlice pressed do 
	(	tick_tock.active=false
		if selection.count==1 and (isKindOf $ Editable_Poly OR isKindOf $ Editable_mesh) then 
		(	
			max modify mode
			try(convertTo $ PolyMeshObject) catch()
			--subObjectLevel=4
			polyOp.setVertSelection $ #{}
			$.ToggleCommandMode #QuickSlice
			tick_tock.active=true

		)
		else (messageBox "Select a Polygon or Mesh Object")
	)
--  slice selected polygons	
	on btnInSlice pressed do 
	(	tick_tock.active=false
		if selection.count==1 and (isKindOf $ Editable_Poly OR isKindOf $ Editable_mesh) then 
		(	
			max modify mode
			try(convertTo $ PolyMeshObject) catch()
			subObjectLevel=4
			polyOp.setVertSelection $ #{}
			$.ToggleCommandMode #QuickSlice
			tick_tock.active=true

		)
		else (messageBox "Select a Polygon or Mesh Object")
	)

-- create a new spline from cut created points
	on btnMakeSpline pressed do 
	(	
		
		(
		tick_tock.active=false 
		thePointCollection=$theCablePos*
		thePointArray=thePointCollection as array
		if thePointArray.count>=2 do
			(	

			
					try (	
							with undo off
							(
							sp=SplineShape()
							sp.name=uniqueName "NewSpline_"
							sp.wirecolor=(Color 0 200 255)
							addNewSpline sp 
							for t=1 to thePointArray.count do 
								(
		
									 addKnot sp 1 #smooth #curve thePointArray[t].pos
		
								)
							updateShape sp 
							sp.pivot= getKnotPoint sp 1 1
							sp.render_renderable=true
							sp.render_displayRenderMesh=true
							sp.render_mapcoords=true
							sp.render_sides=8
							sp.render_auto_smooth=true
							sp.render_threshold=60
							sp.steps=3
							sp.optimize=true
							-- use real world map size
							sp.realWorldMapSize=true
							)
							undo on 
								(
								for o in thePointArray do (delete o)
								thePointArray=#()
								)
							undo on 
							try (freeze $) catch()
							select sp
							)
						catch (messageBox "Something went wrong!")
			)
		)
	)

-- 	timer for checking cuts
	on tick_tock tick do 
	(	
		if isKindOf $ Editable_Poly do
		(
				theCurrentBits=polyop.getVertSelection $
				theCurrentSel=theCurrentBits as array 
				thePos=[0,0,0]
		
				if theCurrentSel.count!=0 then 
				(
					for i=1 to theCurrentSel.count do 
					(
						thePos+=polyop.getVert $ theCurrentSel[i]
					)
				undo on 	(
							thePos=thePos/theCurrentSel.count 
							thePoint=Point pos:thePos Box:on size:3.0 wirecolor:orange ()
		
							thePoint.name=uniqueName "theCablePos"
							redrawViews()
					)	
				theCurrentSel=#()
				polyOp.setVertSelection $ #{}
			
		
				)
		)
	)
-- clean the unused point heplers if procedure fails
	on btnClrResidue pressed do 
	(

			cleanTheCollected=$theCablePos*
			cleanTheArray=cleanTheCollected as array
		with undo on 
		(
			for o in cleanTheArray do 
			(delete o)
			cleanTheArray=#()
		)

	)
)
CreateDialog rlCADWorkshop 