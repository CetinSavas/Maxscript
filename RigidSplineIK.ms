/* 
creates splineIK with rigid bones 
 */
fn customsplineik bct  nspline=
(
		ndist = (curvelength nspline)/bct
		arpt=#()
		bnar=#()
		myl = nspline

		for i= 1 to bct+1 do
		(
			pt=point ()
			pt.size=3
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
						Newbone.width=0.5
						Newbone.height=0.5
						Newbone.name= UniqueName "bnmyn"
						Newbone.boneFreezeLength=false
						Newbone.boneScaleType=#scale
						append bnar Newbone
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
				sfc.AddNode "master" arpt[1]
				sfc.AddNode "spl" 	myl
				--txt1="("+i as String+"-1)/("+ arpt.count as string +"-1) as float"
				txt1=("((master.position.controller[2].percent)/100)+("+ndist as string+"*("+i as string +"-1)/((curvelength spl )))")
				--print txt1 
				--print "*******************"
				arpt[i].position.controller[2].percent.controller = sfc
				sfc.SetExpression txt1
				
			)
	
)


customsplineik  10 $
