/* Creates a stretchy spline ik on selected spline with given number of bones */

RnCnt=1
try (DestroyDialog rollStretchIK) catch()
fn Spl_filt obj = superclassof obj == shape


fn stretchSplineIK bct  nspline bSize RunCount bBool =
(
		ndist = (curvelength nspline)/bct
		arpt=#()
		bnar=#()
		strBnAr=#()
		myl = nspline
		for i= 1 to bct+1 do
		(
			pt=point ()
			pt.name=uniqueName "dellMe_Small_"
			pt.size=bSize*2
			append arpt pt
			if i!=1 then
			(
			pt.position= arpt[i-1].position+[0,ndist,0]	
			)
		)


			
		for i=1 to arpt.count do
			(
			
				if i != arpt.count then
					(
						Newbone=BoneSys.createBone arpt[i].transform.position arpt[i+1].transform.position [0,0,1]
						Newbone.width=bSize
						Newbone.height=bSize
						Newbone.name= UniqueName "BNStretch"
						Newbone.Taper=90.0
						Newbone.boneFreezeLength=false
						
						if bBool then  (Newbone.boneScaleType=#squash)
						else (Newbone.boneScaleType=#scale)
						append bnar Newbone

						newStBone=BoneSys.createBone arpt[i].transform.position arpt[i+1].transform.position [0,0,1]
						newStBone.width=bSize
						newStBone.height=bSize
						
						newStBone.name= UniqueName "BnScale"
						newStBone.boxmode = on
						newStBone.Taper=0.0
						orScon=Orientation_Constraint ()
						newStBone.rotation.controller=orScon 
						orScon.appendTarget Newbone 100.0
						posScon=Position_Constraint ()
						newStBone.position.controller=posScon
						posScon.appendTarget Newbone 100.0
						scaleSscr= scale_script ()
						newStBone.scale.controller=scaleSscr
						scaleSscr.AddNode "Master" Newbone
						txtSscr="[Master.stretchTM[1][1],Master.stretchTM[2][2],Master.stretchTM[3][3]]"
						scaleSscr.SetExpression txtSscr

						append strBnAr  newStBone


						if i == 1 then 
							(
								Newbone.parent=none
								Newbone.position.controller=position_List ()
								pcon= Position_Constraint ()
								Newbone.position.controller.Available.controller= pcon
								pcon.appendTarget arpt[i] 100
								Newbone.position.controller.setActive 2
								
								Newbone.rotation.controller = Rotation_List ()
								lcon=Lookat_Constraint ()
								lcon.viewline_length_abs=false
								lcon.upnode_world=false
								lcon.pickUpNode=arpt[i]
								lcon.upnode_ctrl=0
								lcon.StoUP_axis = 0
								Newbone.rotation.controller.Available.controller=lcon
								lcon.appendTarget arpt[i+1] 100
								

								Newbone.rotation.controller.setActive 2
							) 
							
							else 
							(
								Newbone.parent =bnar[i-1]
								
								Newbone.position.controller=position_List ()
								pcon= Position_Constraint ()
								Newbone.position.controller.Available.controller= pcon
								pcon.appendTarget arpt[i] 100
								Newbone.position.controller.setActive 2								

								Newbone.rotation.controller=Rotation_List ()
								lcon=Lookat_Constraint ()
								lcon.viewline_length_abs=false
								lcon.upnode_world=false
								lcon.pickUpNode=arpt[i]
								lcon.upnode_ctrl=0
								lcon.StoUP_axis = 0
								

								Newbone.rotation.controller.Available.controller=lcon
								lcon.appendTarget arpt[i+1] 100
								
								Newbone.rotation.controller.setActive 2
							)
						
					)


				else
		    		(
				 	  
						parentBone  = bnar[bnar.count]
						parentTrans = parentBone.transform
						parentPos   = parentTrans.translation
													
						nBone=BoneSys.createBone parentPos (parentPos+6) parentBone.dir
						nBone.transform = parentTrans
						nBone.Name=UniqueName "BNStretch-End"
						in coordSys Local move nBone [parentBone.length,0,0]

						nBone.parent	= parentBone
						nBone.width	 = parentBone.width
						nBone.height	= parentBone.height
						nBone.taper	 = 90
						nBone.length	= (parentBone.width+parentBone.height)/2
						nBone.wirecolor = parentBone.wirecolor

						nBone.position.controller=position_List ()
						pcon= Position_Constraint ()
						nBone.position.controller.Available.controller= pcon
						pcon.appendTarget arpt[i] 100
						nBone.position.controller.setActive 2							

						i+=1
				 	)
				
				
			)
			
		selSetName="ScaleBones"+ RunCount as string 	
		NamedSelectionSetManager.AddNewNamedSelSet strBnAr selSetName


			for i=1 to arpt.count do
		(
			arpt[i].position.controller= position_List()
			patcon=Path_Constraint Loop:false ()
			arpt[i].position.controller.Available.controller= patcon
			patcon.appendTarget myl 100
			if i!=1 OR i!= arpt.count then (patcon.follow = on)
			arpt[i].position.controller.setActive 2
			deleteKeys arpt[i] #allKeys
		)

		for i= 2 to arpt.count do
			(
				sfc=float_script () 
				--sfc.AddNode "master" arpt[1]
				--sfc.AddNode "spl" 	myl
				txt1="("+i as String+"-1)/("+ arpt.count as string +"-1) as float"
				print txt1 
				print "*******************"
				arpt[i].position.controller[2].percent.controller = sfc
				sfc.SetExpression txt1
				
			)
	
)

-- (function call) (bone count) ( selected spline)

rollout rollStretchIK "Stretchy IK" width:200 height:115
	(
		pickButton  pBtn_selSpline "Select Spline"	pos:[10,5] width:180 height:25 filter:Spl_filt
		spinner 	spn_BnCnt 		"Set Bone Count" pos:[10,35] width:180 height:25 range:[1,500,5] type:#integer
		spinner 	spn_Size 		"Set Bone size" pos:[10,60] width:180 height:25 scale:0.1  range:[0.001,500,0.02] type:#float
		checkbox 	chk_Squash 		"Squash/Scale" pos:[10,85] width:180 height:25 checked:true
		on pBtn_selSpline picked spl_Obj do 
		(
			undo on 
			(
			stretchSplineIK (spn_BnCnt.value) spl_Obj (spn_Size.value) RnCnt (chk_Squash.checked)

			modSplineIKControl = Spline_IK_Control()
        	modSplineIKControl.linkTypes = 2
       		modSplineIKControl.noLinking()
        	addModifier spl_Obj modSplineIKControl
			modSplineIKControl.createHelper (numKnots spl_Obj )
			modSplineIKControl.helper_size=spn_Size.value*4
			helperList=modSplineIKControl.helper_list
			for i=1 to helperList.count   do 
			(helperList[i].name=UniqueName "dellMe_Big_")
			RnCnt=RnCnt+1
			)
		)
	)

CreateDialog rollStretchIK