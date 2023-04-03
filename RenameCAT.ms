 /* Renames Cat Bones
 	Select the bone And press corresponding button*/

try (DestroyDialog rlRenameCAT) catch ()


rollout rlRenameCAT "CAT Rename" width:120 height:355
(

 button  btnPelvic 		"Pelvis"					pos:[5,5] 		width:110 	height:20
 button  btnSpine 		"Spine(On Pelvis)"  		pos:[5,30] 		width:110 	height:20
 button  btnRibcage		"Ribcage" 			 		pos:[5,55]		width:110 	height:20
 button  btnNeck		"Neck(On RibCage)" 			pos:[5,80] 		width:110 	height:20
 button  btnHead		"Head" 						pos:[5,105] 	width:110 	height:20
 button  btnShoulder	"Shoulder" 					pos:[5,130] 	width:110 	height:20
 button  btnUpperArm	"UpperArm" 					pos:[5,155] 	width:110 	height:20
 button  btnForeARm		"ForeArm" 					pos:[5,180] 	width:110 	height:20
 button  btnHand		"Hand" 						pos:[5,205] 	width:110 	height:20
 button  btn5Digits		"Fingers(On Hand)"			pos:[5,230] 	width:110 	height:20
 button  btnTigh		"Tigh"						pos:[5,255] 	width:110 	height:20
 button  btnCalf		"Calf"						pos:[5,280] 	width:110 	height:20
 button  btnFoot		"Foot"						pos:[5,305] 	width:110 	height:20
 button  btnBall		"Ball/Fingers(On Feet)"		pos:[5,330] 	width:110 	height:20



		on btnPelvic pressed do 
	(

	 	if selection.count==1 do 
		(
		 try ($.HubTrans.Name="Pelvis") catch(messageBox "Select Pelvis")
		)
	)

		on btnSpine pressed do 
	(

	 	if selection.count==1 do 
		(
		 try ($.HubTrans.Spines[1].Name="Spine") catch(messageBox "Select Pelvis")
		)
	)

		on btnRibcage pressed do
	(
	 	if selection.count==1 do 
		(
		 try ($.HubTrans.Name="RibCage") catch(messageBox "Select RigCage")
		)

	)

		on btnNeck pressed do
	(
	 	if selection.count==1 do 
		(
		 try ($.HubTrans.Spines[1].name="Neck") catch(messageBox "Select RigCage")
		)
	)

		on btnHead pressed do
	(
	 	if selection.count==1 do 
		(
		 try ($.HubTrans.Name="Head") catch(messageBox "Select Head")
		)

	)

		on btnShoulder pressed do 
	(
	 if selection.count==2 then 
	 (
	  	for o in selection do 
	  	(try (o.DigitData.Name="Shoulder") catch (messageBox "Select Shoulders")
  	 	)
	 )
	 else 
	 	(	
	 	 messageBox "Select both Shoulders"
  		)
	)

		on btnUpperArm pressed do 
	(
	 	if selection.count==2 then 
	 	(
	 	 for o in selection do 
	 	 	(
	 	 	 try (o.DigitData.Bone.Name="UpperArm")	catch(messageBox "Select UpperArms")	
	 	 	)
	 	)
	 	else 
	 	(	
	 	 messageBox "Select both UpperArms"
  		)

 	)

		on btnForeARm pressed do 
	(
	 	if selection.count==2 then 
	 	(
	 	 for o in selection do 
	 	 	(
	 	 	 try (o.DigitData.Bone.Name="ForeArm")	catch(messageBox "Select ForeArms")	
	 	 	)
	 	)
	 	else 
	 	(	
	 	 messageBox "Select both ForeArms"
  		)
 	)

 		on btnHand pressed do 
	(
	 	if selection.count==2 then 
	 	(
	 	 for o in selection do 
	 	 	(
	 	 	 try (o.DigitData.Name="Hand")	catch(messageBox "Select Hands")	
	 	 	)
	 	)
	 	else 
	 	(	
	 	 messageBox "Select both Hands"
  		)
 	)

		on btn5Digits pressed do 
	(
	  if selection.count==2 then 
	  (
	   for o in selection do 
	   	(
	   	 	for i=1 to o.DigitData.NumDigits do 
	   	 	(
	   	 	 if i==1 do (o.DigitData.Digits[i].Name="Thumb")
	   	 	 if i==2 do (o.DigitData.Digits[i].Name="Index")
	   	 	 if i==3 do (o.DigitData.Digits[i].Name="Middle")
	   	 	 if i==4 do (o.DigitData.Digits[i].Name="Ring")
	   	 	 if i==5 do (o.DigitData.Digits[i].Name="Pinky")
	   	 	 if i>=6 do (o.DigitData.Digits[i].Name=("Extra"+ (i-5) as string))
	   	 	 

   	 	 	)
   	 	)
	  )
	  else 
	  (messageBox "Select Both Hands")
 	)

		 on btnTigh pressed do 
	(
	 if selection.count==2 then 
 	(
		for o in selection do 
		(
		 try (o.DigitData.Bone.Name="Tigh") catch(messageBox "Select both Tigh")
		) 	
 	)
	 else 
	 (messageBox "Select both Tigh")

 	)

		 on btnTigh pressed do 
	(
	 if selection.count==2 then 
 	(
		for o in selection do 
		(
		 try (o.DigitData.Bone.Name="Tigh") catch(messageBox "Select both Tigh")
		) 	
 	)
	 else 
	 (messageBox "Select both Tigh")

 	)

		 on btnCalf pressed do 
	(
	 if selection.count==2 then 
 	(
		for o in selection do 
		(
		 try (o.DigitData.Bone.Name="Calf") catch(messageBox "Select both Calf")
		) 	
 	)
	 else 
	 (messageBox "Select both Calf")

 	)
 	
 	on btnFoot pressed do 
	(
	 	if selection.count==2 then 
	 	(
	 	 for o in selection do 
	 	 	(
	 	 	 try (o.DigitData.Name="Foot")	catch(messageBox "Select Feet")	
	 	 	)
	 	)
	 	else 
	 	(	
	 	 messageBox "Select both Feet"
  		)
 	)

	on btnball pressed do 

	(
	  if selection.count==2 then 
	  (	

	   for o in selection do 
	   	(	
	   	 	if o.DigitData.NumDigits==1 then 
			(o.DigitData.Digits[1].Name="Ball")	
	   	 	else 
	   	 	(
		   	 	for i=1 to o.DigitData.NumDigits do 
		   	 	(
		   	 	 if i==1 do (o.DigitData.Digits[i].Name="Thumb")
		   	 	 if i==2 do (o.DigitData.Digits[i].Name="Index")
		   	 	 if i==3 do (o.DigitData.Digits[i].Name="Middle")
		   	 	 if i==4 do (o.DigitData.Digits[i].Name="Ring")
		   	 	 if i==5 do (o.DigitData.Digits[i].Name="Pinky")
		   	 	 if i>=6 do (o.DigitData.Digits[i].Name=("Extra"+ (i-5) as string))
		   	  	)
		   	)  	
   	 	)

	  )
	  else 
	  (messageBox "Select Both Feet")
 	)
 	

)




CreateDialog rlRenameCAT