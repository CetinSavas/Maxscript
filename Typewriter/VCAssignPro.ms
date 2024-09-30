--testDotNetButton.ms
-- close existing dialog
try (DestroyDialog rlBtnGui) catch()
-- load dotNet 
dotNet.loadAssembly "system.xml"
--Create an xml document object.
xmlDoc=dotNetObject "system.xml.xmlDocument"
totalNumber=3
-- create array of button texts 
global btnTxtAr=#()
global colorAr=#()
global mymultimat=Multimaterial()
( for i= 1 to totalNumber^2 do 
	(	btnName="Btn_"+ i as string 
		append btnTxtAr btnName 
)
)
theFile=undefined

-- create rolout 
rollout rlBtnGui "assign Color ID V1.1" 
(
	local toolTipObj
	dotNetControl btnRed "system.windows.forms.button" height:40 width:(50*3/3) pos:[5,5]
	dotNetControl btnBlue "system.windows.forms.button" height:40 width:(50*3/3) pos:[5+(50*3*1/3),5]
dotNetControl btnOrange "system.windows.forms.button" height:40 width:(50*3/3) pos:[5+(50*3*2/3),5]
 dotNetControl btnA1 "system.windows.forms.button"  height:40 width:50 pos:[(5+(50*(mod(1-1)3 ))),(45+(40* floor((floor(1-1)/3))))]

 dotNetControl btnA2 "system.windows.forms.button"  height:40 width:50 pos:[(5+(50*(mod(2-1)3 ))),(45+(40* floor((floor(2-1)/3))))]

 dotNetControl btnA3 "system.windows.forms.button"  height:40 width:50 pos:[(5+(50*(mod(3-1)3 ))),(45+(40* floor((floor(3-1)/3))))]

 dotNetControl btnA4 "system.windows.forms.button"  height:40 width:50 pos:[(5+(50*(mod(4-1)3 ))),(45+(40* floor((floor(4-1)/3))))]

 dotNetControl btnA5 "system.windows.forms.button"  height:40 width:50 pos:[(5+(50*(mod(5-1)3 ))),(45+(40* floor((floor(5-1)/3))))]

 dotNetControl btnA6 "system.windows.forms.button"  height:40 width:50 pos:[(5+(50*(mod(6-1)3 ))),(45+(40* floor((floor(6-1)/3))))]

 dotNetControl btnA7 "system.windows.forms.button"  height:40 width:50 pos:[(5+(50*(mod(7-1)3 ))),(45+(40* floor((floor(7-1)/3))))]

 dotNetControl btnA8 "system.windows.forms.button"  height:40 width:50 pos:[(5+(50*(mod(8-1)3 ))),(45+(40* floor((floor(8-1)/3))))]

 dotNetControl btnA9 "system.windows.forms.button"  height:40 width:50 pos:[(5+(50*(mod(9-1)3 ))),(45+(40* floor((floor(9-1)/3))))]
on rlBtnGui open do 
(
toolTipObj= dotNetObject "system.windows.forms.ToolTip"
(
		btnOrange.flatStyle=btnOrange.flatStyle.flat 
		btnOrange.backColor=(dotNetClass "system.drawing.color").fromArgb 100 100 100
		btnOrange.text="Toggle VColor"

		toolTipObj.SetToolTip btnOrange "Toggle Vertex Color"
		toolTipObj.Active=True

		)
(
			btnRed.flatStyle=btnRed.flatStyle.flat 	
			btnRed.backColor=(dotNetClass "system.drawing.color").fromArgb 100 100 100
			btnRed.text="Save Xml File"
			
			toolTipObj.SetToolTip btnRed "Save Xml file "
			toolTipObj.Active=True
		)
(
			btnBlue.flatStyle=btnBlue.flatStyle.flat 
			btnBlue.backColor=(dotNetClass "system.drawing.color").fromArgb 100 100 100
			btnBlue.text="Open Xml File"
			toolTipObj.SetToolTip btnBlue "Open Xml file"
			toolTipObj.Active=True 
		)
			(

						tempCol1=#()
						append tempCol1 255.0
						append tempCol1 0.0
						append tempCol1 0.0
						append colorAr tempCol1
						btnA1.flatStyle=btnA1.flatStyle.flat
						btnA1.backColor= (dotNetClass "system.drawing.color").fromArgb  255 255 255
						btnA1.text="Btn_1"
-- 						toolTipObj.SetToolTip btnA1 "Button_1"
					)
				(

						tempCol1=#()
						append tempCol1 205.0
						append tempCol1 40.1961
						append tempCol1 40.1961
						append colorAr tempCol1
						btnA2.flatStyle=btnA2.flatStyle.flat
						btnA2.backColor= (dotNetClass "system.drawing.color").fromArgb  255 0 0 
						btnA2.text="Btn_2"
-- 						toolTipObj.SetToolTip btnA2 "Button_2"
					)
		(

						tempCol1=#()
						append tempCol1 155.0
						append tempCol1 60.7843
						append tempCol1 60.7843
						append colorAr tempCol1
						btnA3.flatStyle=btnA3.flatStyle.flat
						btnA3.backColor= (dotNetClass "system.drawing.color").fromArgb  0 0 0 
						btnA3.text="Btn_3"
-- 						toolTipObj.SetToolTip btnA3 "Button_3"
					)
(

						tempCol1=#()
						append tempCol1 0.0
						append tempCol1 0.0
						append tempCol1 255.0
						append colorAr tempCol1
						btnA4.flatStyle=btnA4.flatStyle.flat
						btnA4.backColor= (dotNetClass "system.drawing.color").fromArgb  255 255 0
						btnA4.text="Btn_4"
-- 						toolTipObj.SetToolTip btnA4 "Button_4"
					)
(

						tempCol1=#()
						append tempCol1 40.1961
						append tempCol1 40.1961
						append tempCol1 205.0
						append colorAr tempCol1
						btnA5.flatStyle=btnA5.flatStyle.flat
						btnA5.backColor= (dotNetClass "system.drawing.color").fromArgb  0 120 0 
						btnA5.text="Btn_5"
-- 						toolTipObj.SetToolTip btnA5 "Button_5"
					)
(

						tempCol1=#()
						append tempCol1 60.7843
						append tempCol1 60.7843
						append tempCol1 155.0
						append colorAr tempCol1
						btnA6.flatStyle=btnA6.flatStyle.flat
						btnA6.backColor= (dotNetClass "system.drawing.color").fromArgb  0 0 255
						btnA6.text="Btn_6"
-- 						toolTipObj.SetToolTip btnA6 "Button_6"
					)
(

						tempCol1=#()
						append tempCol1 0.0
						append tempCol1 255.0
						append tempCol1 0.0
						append colorAr tempCol1
						btnA7.flatStyle=btnA7.flatStyle.flat
						btnA7.backColor= (dotNetClass "system.drawing.color").fromArgb  60 60 60 
						btnA7.text="Btn_7"
-- 						toolTipObj.SetToolTip btnA7 "Button_7"
					)
					(

						tempCol1=#()
						append tempCol1 40.1961
						append tempCol1 205.0
						append tempCol1 40.1961
						append colorAr tempCol1
						btnA8.flatStyle=btnA8.flatStyle.flat
						btnA8.backColor= (dotNetClass "system.drawing.color").fromArgb  135 135 135 
						btnA8.text="Btn_8"
-- 						toolTipObj.SetToolTip btnA8 "Button_8"
					)
					(

						tempCol1=#()
						append tempCol1 60.7843
						append tempCol1 155.0
						append tempCol1 60.7843
						append colorAr tempCol1
						btnA9.flatStyle=btnA9.flatStyle.flat
						btnA9.backColor= (dotNetClass "system.drawing.color").fromArgb  175 175 175  
						btnA9.text="Btn_9"
-- 						toolTipObj.SetToolTip btnA9 "Button_9"
					)

)

 on rlBtnGui close do 
		(
		--print "closed"

		)
		on btnRed mouseDown senderArg arg do 
	(

		if arg.button==arg.button.Left then 
		(
			--clear xml file 
			theFile=getSaveFileName  caption:"Save Xml File"  types:".Xml(*.xml)|*.xml|"
			
			if not theFile==undefined  do 
			(
			if doesFileExist theFile==true  do (deleteFile theFile; ) 
			 
			 xmlDoc2=dotNetObject "system.xml.xmlDocument"
			-- create "root" element to xml document
			root=xmlDoc2.createElement "Buttons"
			-- append "root" element to xml doc 
			xmlDoc2.appendChild root
				for j=1 to btnTxtAr.count do -- go through all of them 
				(
				
					local currentName=btnTxtAr[j] 
					local currentRed=colorAr[j][1] as string
					local currentGreen=colorAr[j][2] as string
					local currentBlue=colorAr[j][3] as string 
					colorName=xmlDoc2.createElement "colorName" 
					colorName.setAttribute "ColorID" 	currentName
					colorName.setAttribute "Red"	 	currentRed 
 					colorName.setAttribute "Green" 		currentGreen 
					colorName.setAttribute "Blue" 		currentBlue  

					root.appendChild colorName  
					--Names for elements can't include anything but alpha characters.
				)-- end j loop
			ff= createFile theFile
		  	close ff
			xmlDoc2.save theFile 
			 )
		)
	)
 on btnOrange mouseDown senderArg arg do 
		(
			if arg.button==arg.button.Left do 
			(			
			
			try ( 
			for o in selection do
				(
			if o.showVertexColors==false then 
					( o.showVertexColors = true
					redrawViews()
					)
		 	else 
					(
						o.showVertexColors=false
						redrawViews()
					)
				)
			)
			catch (messagebox "Warning : No Selection!")
	

			)	
		)
/*  on btnBlue mouseDown senderArg arg do 
	( 	

		fileOpen= getOpenFileName caption:"Open Xml File"  types:".Xml(*.xml)|*.xml|"
		if fileOpen!=undefined do 
		(	btnTxtAr=undefined
			btnTxtAr=#()

			
			print btnTxtAr.count
			if doesFileExist fileOpen then
			(
				--Load the XML file.
				xmlDoc.load fileOpen
				--Check to make sure the xmlDoc has a root element. 
				docEle=xmlDoc.documentElement
				
				--If the root element exists continue. 
				if docEle!=undefined and docEle.name=="Buttons" then
				(
					
						for k=0 to docEle.childNodes.count-1 do
						(
							
							btnColorVal=(docEle.childNodes.itemOf[k].GetAttributeNode "ColorID").value
							btnTxtAr[k+1]= btnColorVal as string	
							indColorValR=((docEle.childNodes.itemOf[k].GetAttributeNode "Red").value ) as float 
							
							indColorValG=((docEle.childNodes.itemOf[k].GetAttributeNode "Green").value ) as float    
							
							indColorValB=((docEle.childNodes.itemOf[k].GetAttributeNode "Blue").value )  as float 
							temp2ColAr=#()
							append temp2ColAr indColorValR
							append temp2ColAr indColorValG
							append temp2ColAr indColorValB
							colorAr[k+1]= temp2ColAr 

							
						)--

			(
							btnA1.text=btnTxtAr[1] 
							btnA1.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[1][1] colorAr[1][2]  colorAr[1][3] 
							toolTipObj.SetToolTip btnA1 btnTxtAr[1]
							)

			(
							btnA2.text=btnTxtAr[2] 
							btnA2.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[2][1] colorAr[2][2]  colorAr[2][3] 
							toolTipObj.SetToolTip btnA2 btnTxtAr[2]
							)

			(
							btnA3.text=btnTxtAr[3] 
							btnA3.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[3][1] colorAr[3][2]  colorAr[3][3] 
							toolTipObj.SetToolTip btnA3 btnTxtAr[3]
							)

			(
							btnA4.text=btnTxtAr[4] 
							btnA4.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[4][1] colorAr[4][2]  colorAr[4][3] 
							toolTipObj.SetToolTip btnA4 btnTxtAr[4]
							)

			(
							btnA5.text=btnTxtAr[5] 
							btnA5.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[5][1] colorAr[5][2]  colorAr[5][3] 
							toolTipObj.SetToolTip btnA5 btnTxtAr[5]
							)

			(
							btnA6.text=btnTxtAr[6] 
							btnA6.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[6][1] colorAr[6][2]  colorAr[6][3] 
							toolTipObj.SetToolTip btnA6 btnTxtAr[6]
							)

			(
							btnA7.text=btnTxtAr[7] 
							btnA7.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[7][1] colorAr[7][2]  colorAr[7][3] 
							toolTipObj.SetToolTip btnA7 btnTxtAr[7]
							)

			(
							btnA8.text=btnTxtAr[8] 
							btnA8.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[8][1] colorAr[8][2]  colorAr[8][3] 
							toolTipObj.SetToolTip btnA8 btnTxtAr[8]
							)

			(
							btnA9.text=btnTxtAr[9] 
							btnA9.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[9][1] colorAr[9][2]  colorAr[9][3] 
							toolTipObj.SetToolTip btnA9 btnTxtAr[9]
							)
			)


			)
			
			
		 )
	) */
	on btnA1 mouseDown sender arg do 
			(
			if arg.button==arg.button.left then 
			
			(	
		
		 		if subObjectLevel==0  then
				(	
					for o in selection do 
					(
						if classof o==Editable_Poly then
						(
						polyOp.SetFaceColor o 0 #{1..polyOp.getNumFaces o} (color 255 255 255) 
                        redrawViews()
						)
						else if classof o==Editable_Mesh then
						(
							meshop.setFaceColor o 0 #{1..meshop.getNumFaces o} (color 255 255 255 )
							redrawViews() 
						)
						
					)
				)
				 
				else
				(
					if classof $==Editable_Poly then
					(
						selection[1].SetFaceColor (color 255 255 255)  #VertexColor	
                        redrawViews()
					)
					else
					( 
						messageBox "Wrong Object Type"						
					)
				)
 		 		

				--$.SetFaceColor (color (colorAr[1][1])  (colorAr[1][2])  (colorAr[1][3]))  #VertexColor	
	 

						
			)
			else if arg.button==arg.button.Right then 
			(
				theNetObj=dotNetObject "MaxCustomControls.RenameInstanceDialog" btnTxtAr[1]
				theNetObj.text="Rename The Button"
				DialogResult= theNetObj.Showmodal()
				newStringEntered=theNetObj.InstanceName
				btnA1.text= newStringEntered 
				toolTipObj.SetTooltip rlBtnGui.btnA1 newStringEntered
				btnTxtAr[1]=newStringEntered
			)
			
			if arg.clicks == 2 then
			(	
				temp3Color=(color 255 0 0)
				temp3Color.r=colorAr[1][1] as float
				temp3Color.g=colorAr[1][2] as float
				temp3Color.b=colorAr[1][3] as float
				aPicker=colorPickerDlg temp3Color "Pick A Better Color:" alpha:false pos:[100,100]
				if aPicker!=undefined then 
				(
					aPickeColor=#()
					append aPickeColor aPicker.r 
					append aPickeColor aPicker.g 
					append aPickeColor aPicker.b 
					colorAr[1]=aPickeColor
					btnA1.backColor= (dotNetClass "system.drawing.color").fromArgb aPicker.r aPicker.g aPicker.b
				)
			)


	
		)
	on btnA2 mouseDown sender arg do 
			(
			if arg.button==arg.button.left then 
			
			(	
		
		 		if subObjectLevel==0  then
				(	
					for o in selection do 
					(
						if classof o==Editable_Poly then
						(
						polyOp.SetFaceColor o 0 #{1..polyOp.getNumFaces o} (color 255 0 0) 
                        redrawViews()
						)
						else if classof o==Editable_Mesh then
						(
							meshop.setFaceColor o 0 #{1..meshop.getNumFaces o} (color 255 0 0)
							redrawViews() 
						)
						
					)
				)
				 
				else
				(
					if classof $==Editable_Poly then
					(
						selection[1].SetFaceColor (color 255 0 0)  #VertexColor	
                        redrawViews()
					)
					else
					( 
						messageBox "Wrong Object Type"						
					)
				)
 		 		

				--$.SetFaceColor (color 255 0 0)  #VertexColor	
	 

						
			)
			else if arg.button==arg.button.Right then 
			(
				theNetObj=dotNetObject "MaxCustomControls.RenameInstanceDialog" btnTxtAr[2]
				theNetObj.text="Rename The Button"
				DialogResult= theNetObj.Showmodal()
				newStringEntered=theNetObj.InstanceName
				btnA2.text= newStringEntered 
				toolTipObj.SetTooltip rlBtnGui.btnA2 newStringEntered
				btnTxtAr[2]=newStringEntered
			)
			
			if arg.clicks == 2 then
			(	
				temp3Color=(color 255 0 0)
				temp3Color.r=colorAr[2][1] as float
				temp3Color.g=colorAr[2][2] as float
				temp3Color.b=colorAr[2][3] as float
				aPicker=colorPickerDlg temp3Color "Pick A Better Color:" alpha:false pos:[100,100]
				if aPicker!=undefined then 
				(
					aPickeColor=#()
					append aPickeColor aPicker.r 
					append aPickeColor aPicker.g 
					append aPickeColor aPicker.b 
					colorAr[2]=aPickeColor
					btnA2.backColor= (dotNetClass "system.drawing.color").fromArgb aPicker.r aPicker.g aPicker.b
				)
			)


	
		)
	on btnA3 mouseDown sender arg do 
			(
			if arg.button==arg.button.left then 
			
			(	
		
		 		if subObjectLevel==0  then
				(	
					for o in selection do 
					(
						if classof o==Editable_Poly then
						(
						polyOp.SetFaceColor o 0 #{1..polyOp.getNumFaces o} (color 0  0 0)
                        redrawViews()
						)
						else if classof o==Editable_Mesh then
						(
							meshop.setFaceColor o 0 #{1..meshop.getNumFaces o} (color 0  0 0)
							redrawViews() 
						)
						
					)
				)
				 
				else
				(
					if classof $==Editable_Poly then
					(
						selection[1].SetFaceColor (color 0  0 0) #VertexColor	
                        redrawViews()
					)
					else
					( 
						messageBox "Wrong Object Type"						
					)
				)
 		 		

				--$.SetFaceColor (color 0  0 0) #VertexColor	
	 

						
			)
			else if arg.button==arg.button.Right then 
			(
				theNetObj=dotNetObject "MaxCustomControls.RenameInstanceDialog" btnTxtAr[3]
				theNetObj.text="Rename The Button"
				DialogResult= theNetObj.Showmodal()
				newStringEntered=theNetObj.InstanceName
				btnA3.text= newStringEntered 
				toolTipObj.SetTooltip rlBtnGui.btnA3 newStringEntered
				btnTxtAr[3]=newStringEntered
			)
			
			if arg.clicks == 2 then
			(	
				temp3Color=(color 255 0 0)
				temp3Color.r=colorAr[3][1] as float
				temp3Color.g=colorAr[3][2] as float
				temp3Color.b=colorAr[3][3] as float
				aPicker=colorPickerDlg temp3Color "Pick A Better Color:" alpha:false pos:[100,100]
				if aPicker!=undefined then 
				(
					aPickeColor=#()
					append aPickeColor aPicker.r 
					append aPickeColor aPicker.g 
					append aPickeColor aPicker.b 
					colorAr[3]=aPickeColor
					btnA3.backColor= (dotNetClass "system.drawing.color").fromArgb aPicker.r aPicker.g aPicker.b
				)
			)


	
		)
	on btnA4 mouseDown sender arg do 
			(
			if arg.button==arg.button.left then 
			
			(	
		
		 		if subObjectLevel==0  then
				(	
					for o in selection do 
					(
						if classof o==Editable_Poly then
						(
						polyOp.SetFaceColor o 0 #{1..polyOp.getNumFaces o} (color 255 255 0)
                        redrawViews()
						)
						else if classof o==Editable_Mesh then
						(
							meshop.setFaceColor o 0 #{1..meshop.getNumFaces o} (color 255 255 0)
							redrawViews() 
						)
						
					)
				)
				 
				else
				(
					if classof $==Editable_Poly then
					(
						selection[1].SetFaceColor (color 255 255 0) #VertexColor	
                        redrawViews()
					)
					else
					( 
						messageBox "Wrong Object Type"						
					)
				)
 		 		

				--$.SetFaceColor (color 255 255 0) #VertexColor	
	 

						
			)
			else if arg.button==arg.button.Right then 
			(
				theNetObj=dotNetObject "MaxCustomControls.RenameInstanceDialog" btnTxtAr[4]
				theNetObj.text="Rename The Button"
				DialogResult= theNetObj.Showmodal()
				newStringEntered=theNetObj.InstanceName
				btnA4.text= newStringEntered 
				toolTipObj.SetTooltip rlBtnGui.btnA4 newStringEntered
				btnTxtAr[4]=newStringEntered
			)
			
			if arg.clicks == 2 then
			(	
				temp3Color=(color 255 0 0)
				temp3Color.r=colorAr[4][1] as float
				temp3Color.g=colorAr[4][2] as float
				temp3Color.b=colorAr[4][3] as float
				aPicker=colorPickerDlg temp3Color "Pick A Better Color:" alpha:false pos:[100,100]
				if aPicker!=undefined then 
				(
					aPickeColor=#()
					append aPickeColor aPicker.r 
					append aPickeColor aPicker.g 
					append aPickeColor aPicker.b 
					colorAr[4]=aPickeColor
					btnA4.backColor= (dotNetClass "system.drawing.color").fromArgb aPicker.r aPicker.g aPicker.b
				)
			)


	
		)
	on btnA5 mouseDown sender arg do 
			(
			if arg.button==arg.button.left then 
			
			(	
		
		 		if subObjectLevel==0  then
				(	
					for o in selection do 
					(
						if classof o==Editable_Poly then
						(
						polyOp.SetFaceColor o 0 #{1..polyOp.getNumFaces o} (color 0 125 0)
                        redrawViews()
						)
						else if classof o==Editable_Mesh then
						(
							meshop.setFaceColor o 0 #{1..meshop.getNumFaces o} (color 0 125 0)
							redrawViews() 
						)
						
					)
				)
				 
				else
				(
					if classof $==Editable_Poly then
					(
						selection[1].SetFaceColor (color 0 125 0) #VertexColor	
                        redrawViews()
					)
					else
					( 
						messageBox "Wrong Object Type"						
					)
				)
 		 		

				--$.SetFaceColor (color 0 125 0) #VertexColor	
	 

						
			)
			else if arg.button==arg.button.Right then 
			(
				theNetObj=dotNetObject "MaxCustomControls.RenameInstanceDialog" btnTxtAr[5]
				theNetObj.text="Rename The Button"
				DialogResult= theNetObj.Showmodal()
				newStringEntered=theNetObj.InstanceName
				btnA5.text= newStringEntered 
				toolTipObj.SetTooltip rlBtnGui.btnA5 newStringEntered
				btnTxtAr[5]=newStringEntered
			)
			
			if arg.clicks == 2 then
			(	
				temp3Color=(color 255 0 0)
				temp3Color.r=colorAr[5][1] as float
				temp3Color.g=colorAr[5][2] as float
				temp3Color.b=colorAr[5][3] as float
				aPicker=colorPickerDlg temp3Color "Pick A Better Color:" alpha:false pos:[100,100]
				if aPicker!=undefined then 
				(
					aPickeColor=#()
					append aPickeColor aPicker.r 
					append aPickeColor aPicker.g 
					append aPickeColor aPicker.b 
					colorAr[5]=aPickeColor
					btnA5.backColor= (dotNetClass "system.drawing.color").fromArgb aPicker.r aPicker.g aPicker.b
				)
			)


	
		)
	on btnA6 mouseDown sender arg do 
			(
			if arg.button==arg.button.left then 
			
			(	
		
		 		if subObjectLevel==0  then
				(	
					for o in selection do 
					(
						if classof o==Editable_Poly then
						(
						polyOp.SetFaceColor o 0 #{1..polyOp.getNumFaces o} (color 0 0 255 )
                        redrawViews()
						)
						else if classof o==Editable_Mesh then
						(
							meshop.setFaceColor o 0 #{1..meshop.getNumFaces o} (color 0 0 255 )
							redrawViews() 
						)
						
					)
				)
				 
				else
				(
					if classof $==Editable_Poly then
					(
						selection[1].SetFaceColor (color 0 0 255) #VertexColor	
                        redrawViews()
					)
					else
					( 
						messageBox "Wrong Object Type"						
					)
				)
 		 		

				--$.SetFaceColor (color 255 0 0) #VertexColor	
	 

						
			)
			else if arg.button==arg.button.Right then 
			(
				theNetObj=dotNetObject "MaxCustomControls.RenameInstanceDialog" btnTxtAr[6]
				theNetObj.text="Rename The Button"
				DialogResult= theNetObj.Showmodal()
				newStringEntered=theNetObj.InstanceName
				btnA6.text= newStringEntered 
				toolTipObj.SetTooltip rlBtnGui.btnA6 newStringEntered
				btnTxtAr[6]=newStringEntered
			)
			
			if arg.clicks == 2 then
			(	
				temp3Color=(color 255 255 255)
				temp3Color.r=colorAr[6][1] as float
				temp3Color.g=colorAr[6][2] as float
				temp3Color.b=colorAr[6][3] as float
				aPicker=colorPickerDlg temp3Color "Pick A Better Color:" alpha:false pos:[100,100]
				if aPicker!=undefined then 
				(
					aPickeColor=#()
					append aPickeColor aPicker.r 
					append aPickeColor aPicker.g 
					append aPickeColor aPicker.b 
					colorAr[6]=aPickeColor
					btnA6.backColor= (dotNetClass "system.drawing.color").fromArgb aPicker.r aPicker.g aPicker.b
				)
			)


	
		)
	on btnA7 mouseDown sender arg do 
			(
			if arg.button==arg.button.left then 
			
			(	
		
		 		if subObjectLevel==0  then
				(	
					for o in selection do 
					(
						if classof o==Editable_Poly then
						(
						polyOp.SetFaceColor o 0 #{1..polyOp.getNumFaces o} (color 120 120 120) 
                        redrawViews()
						)
						else if classof o==Editable_Mesh then
						(
							meshop.setFaceColor o 0 #{1..meshop.getNumFaces o} (color 120 120 120)
							redrawViews() 
						)
						
					)
				)
				 
				else
				(
					if classof $==Editable_Poly then
					(
						selection[1].SetFaceColor (color 120 120 120)  #VertexColor	
                        redrawViews()
					)
					else
					( 
						messageBox "Wrong Object Type"						
					)
				)
 		 		

				--$.SetFaceColor (color 60 60 60)  #VertexColor	
	 

						
			)
			else if arg.button==arg.button.Right then 
			(
				theNetObj=dotNetObject "MaxCustomControls.RenameInstanceDialog" btnTxtAr[7]
				theNetObj.text="Rename The Button"
				DialogResult= theNetObj.Showmodal()
				newStringEntered=theNetObj.InstanceName
				btnA7.text= newStringEntered 
				toolTipObj.SetTooltip rlBtnGui.btnA7 newStringEntered
				btnTxtAr[7]=newStringEntered
			)
			
			if arg.clicks == 2 then
			(	
				temp3Color=(color 255 0 0)
				temp3Color.r=colorAr[7][1] as float
				temp3Color.g=colorAr[7][2] as float
				temp3Color.b=colorAr[7][3] as float
				aPicker=colorPickerDlg temp3Color "Pick A Better Color:" alpha:false pos:[100,100]
				if aPicker!=undefined then 
				(
					aPickeColor=#()
					append aPickeColor aPicker.r 
					append aPickeColor aPicker.g 
					append aPickeColor aPicker.b 
					colorAr[7]=aPickeColor
					btnA7.backColor= (dotNetClass "system.drawing.color").fromArgb aPicker.r aPicker.g aPicker.b
				)
			)


	
		)
	on btnA8 mouseDown sender arg do 
			(
			if arg.button==arg.button.left then 
			
			(	
		
		 		if subObjectLevel==0  then
				(	
					for o in selection do 
					(
						if classof o==Editable_Poly then
						(
						polyOp.SetFaceColor o 0 #{1..polyOp.getNumFaces o} (color 150 150 150) 
                        redrawViews()
						)
						else if classof o==Editable_Mesh then
						(
							meshop.setFaceColor o 0 #{1..meshop.getNumFaces o} (color 150 150 150)
							redrawViews() 
						)
						
					)
				)
				 
				else
				(
					if classof $==Editable_Poly then
					(
						selection[1].SetFaceColor (color 150 150 150)  #VertexColor	
                        redrawViews()
					)
					else
					( 
						messageBox "Wrong Object Type"						
					)
				)
 		 		

				--$.SetFaceColor (color 125 125 125)  #VertexColor	
	 

						
			)
			else if arg.button==arg.button.Right then 
			(
				theNetObj=dotNetObject "MaxCustomControls.RenameInstanceDialog" btnTxtAr[8]
				theNetObj.text="Rename The Button"
				DialogResult= theNetObj.Showmodal()
				newStringEntered=theNetObj.InstanceName
				btnA8.text= newStringEntered 
				toolTipObj.SetTooltip rlBtnGui.btnA8 newStringEntered
				btnTxtAr[8]=newStringEntered
			)
			
			if arg.clicks == 2 then
			(	
				temp3Color=(color 255 0 0)
				temp3Color.r=colorAr[8][1] as float
				temp3Color.g=colorAr[8][2] as float
				temp3Color.b=colorAr[8][3] as float
				aPicker=colorPickerDlg temp3Color "Pick A Better Color:" alpha:false pos:[100,100]
				if aPicker!=undefined then 
				(
					aPickeColor=#()
					append aPickeColor aPicker.r 
					append aPickeColor aPicker.g 
					append aPickeColor aPicker.b 
					colorAr[8]=aPickeColor
					btnA8.backColor= (dotNetClass "system.drawing.color").fromArgb aPicker.r aPicker.g aPicker.b
				)
			)


	
		)
	on btnA9 mouseDown sender arg do 
			(
			if arg.button==arg.button.left then 
			
			(	
		
		 		if subObjectLevel==0  then
				(	
					for o in selection do 
					(
						if classof o==Editable_Poly then
						(
						polyOp.SetFaceColor o 0 #{1..polyOp.getNumFaces o} (color 175 175 175) 
                        redrawViews()
						)
						else if classof o==Editable_Mesh then
						(
							meshop.setFaceColor o 0 #{1..meshop.getNumFaces o} (color 175 175 175)
							redrawViews() 
						)
						
					)
				)
				 
				else
				(
					if classof $==Editable_Poly then
					(
						selection[1].SetFaceColor (color 175 175 175)  #VertexColor	
                        redrawViews()
					)
					else
					( 
						messageBox "Wrong Object Type"						
					)
				)
 		 		

				--$.SetFaceColor (color 175 175 175)  #VertexColor	
	 

						
			)
			else if arg.button==arg.button.Right then 
			(
				theNetObj=dotNetObject "MaxCustomControls.RenameInstanceDialog" btnTxtAr[9]
				theNetObj.text="Rename The Button"
				DialogResult= theNetObj.Showmodal()
				newStringEntered=theNetObj.InstanceName
				btnA9.text= newStringEntered 
				toolTipObj.SetTooltip rlBtnGui.btnA9 newStringEntered
				btnTxtAr[9]=newStringEntered
			)
			
			if arg.clicks == 2 then
			(	
				temp3Color=(color 255 0 0)
				temp3Color.r=colorAr[9][1] as float
				temp3Color.g=colorAr[9][2] as float
				temp3Color.b=colorAr[9][3] as float
				aPicker=colorPickerDlg temp3Color "Pick A Better Color:" alpha:false pos:[100,100]
				if aPicker!=undefined then 
				(
					aPickeColor=#()
					append aPickeColor aPicker.r 
					append aPickeColor aPicker.g 
					append aPickeColor aPicker.b 
					colorAr[9]=aPickeColor
					btnA9.backColor= (dotNetClass "system.drawing.color").fromArgb aPicker.r aPicker.g aPicker.b
				)
			)


	
		)
/* on rlBtnGui open do 
			(
				----------------
				--Load the XML file.
				xmlDoc.load @"E:\Prog\ThePyDocker\TypeWriter\TypeWriterColors.xml"
				--Check to make sure the xmlDoc has a root element. 
				docEle=xmlDoc.documentElement
				
				--If the root element exists continue. 
				if docEle!=undefined and docEle.name=="Buttons" then
				(
					
						for k=0 to docEle.childNodes.count-1 do
						(
							
							btnColorVal=(docEle.childNodes.itemOf[k].GetAttributeNode "ColorID").value
							btnTxtAr[k+1]= btnColorVal as string	
							indColorValR=((docEle.childNodes.itemOf[k].GetAttributeNode "Red").value ) as float 
							
							indColorValG=((docEle.childNodes.itemOf[k].GetAttributeNode "Green").value ) as float    
							
							indColorValB=((docEle.childNodes.itemOf[k].GetAttributeNode "Blue").value )  as float 
							temp2ColAr=#()
							append temp2ColAr indColorValR
							append temp2ColAr indColorValG
							append temp2ColAr indColorValB
							colorAr[k+1]= temp2ColAr 

							
						)--

				(
				btnA1.text=btnTxtAr[1] 
				btnA1.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[1][1] colorAr[1][2]  colorAr[1][3] 
-- 				toolTipObj.SetToolTip btnA1 btnTxtAr[1]
				)

				(
				btnA2.text=btnTxtAr[2] 
				btnA2.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[2][1] colorAr[2][2]  colorAr[2][3] 
-- 				toolTipObj.SetToolTip btnA2 btnTxtAr[2]
				)

				(
				btnA3.text=btnTxtAr[3] 
				btnA3.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[3][1] colorAr[3][2]  colorAr[3][3] 
-- 				toolTipObj.SetToolTip btnA3 btnTxtAr[3]
				)

				(
				btnA4.text=btnTxtAr[4] 
				btnA4.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[4][1] colorAr[4][2]  colorAr[4][3] 
-- 				toolTipObj.SetToolTip btnA4 btnTxtAr[4]
				)

				(
				btnA5.text=btnTxtAr[5] 
				btnA5.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[5][1] colorAr[5][2]  colorAr[5][3] 
-- 				toolTipObj.SetToolTip btnA5 btnTxtAr[5]
				)

				(
				btnA6.text=btnTxtAr[6] 
				btnA6.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[6][1] colorAr[6][2]  colorAr[6][3] 
-- 				toolTipObj.SetToolTip btnA6 btnTxtAr[6]
				)

				(
				btnA7.text=btnTxtAr[7] 
				btnA7.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[7][1] colorAr[7][2]  colorAr[7][3] 
-- 				toolTipObj.SetToolTip btnA7 btnTxtAr[7]
				)

				(
				btnA8.text=btnTxtAr[8] 
				btnA8.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[8][1] colorAr[8][2]  colorAr[8][3] 
-- 				toolTipObj.SetToolTip btnA8 btnTxtAr[8]
				)

				(
				btnA9.text=btnTxtAr[9] 
				btnA9.backColor= (dotNetClass "system.drawing.color").fromArgb colorAr[9][1] colorAr[9][2]  colorAr[9][3] 
-- 				toolTipObj.SetToolTip btnA9 btnTxtAr[9]
				)
			) 
				----------------
			)*/

)
CreateDialog rlBtnGui (10+(50*3)) (10+(40*4))
