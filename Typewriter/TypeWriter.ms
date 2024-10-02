/* 
Savas Cetin 2024
https://www.artstation.com/savascetin
 */
try(DestroyDialog rlPlaneOnSurface ) catch()
--  Create character set and widths
col1=#("A","B","C","Ç","D","E","F","G","Ğ","H")
w1  =#(1,1,1,1,1,1,1,1,1,1)
col2=#("I","İ","J","K","L","M","N","O","Ö","P")
w2  =#(0.4,0.4,0.6,0.8,0.8,0.8,0.8,0.8,0.8,0.8)
col3=#("Q","R","S","Ş","T","U","Ü","V","W","X")
w3  =#(.8,.8,.8,.8,.8,.8,.8,.8,1,1)
col4=#("Y","Z","a","b","c","ç","d","e","f","g")
w4  =#(0.8,0.6,0.6,0.6,0.6,0.6,0.6,0.6,0.7,0.7)
col5=#("ğ","h","ı","i","j","k","l","m","n","o")
w5  =#(0.6,0.6,0.4,0.4,0.6,0.6,0.4,0.9,0.6,0.7)
col6=#("ö","p","q","r","s","ş","t","u","ü","v")
w6  =#(.6,.6,.6,0.6,0.6,0.6,0.6,0.6,0.6,0.6)
col7=#("w","x","y","z","!","*"," ","\%","&","(")
w7  =#(1.0,0.8,0.6,0.8,0.8,0.8,0.6,0.8,0.8,0.8)
col8=#("_","=","+",";",":","'","\\",".","?","/")
w8  =#(1.0,0.8,0.8,0.4,0.4,0.4,0.6,0.4,0.8,0.8)
Col9=#("|",")","-","\"","#","\n","","\t",",","*")
w9  =#(0.4,0.8,0.6,0.8,0.8,0.1,0.1,0.8,0.4,0.8)
col10=#("0","1","2","3","4","5","6","7","8","9")
w10  =#(0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8)
--  Define Array for  widths and characters
mainBlock=#(col10,col9,col8,col7,col6,col5,col4,col3,col2,col1)
widthBlock=#(w10,w9,w8,w7,w6,w5,w4,w3,w2,w1)

-- Get Script Path
mainPath=getFilenamePath(getThisScriptFilename())
-- Set vertex color assign script path
secondaryScript= mainPath+"VCAssignPro.ms"

-- Get or create material for typewriter fonts
fn getMaterialFromName matName =
(   
    newMat=undefined
    if sceneMaterials.count!=0 then
    ( 
        for mat in sceneMaterials do 
        ( 
            if mat.name==matName then 
            (newMat= mat)

        else 
    		(
    		   newMat=PhysicalMaterial()
               newMat.name=matName
               -- Use  enclosed image next to this script
    		   newBitmap=Bitmaptexture fileName: (mainPath+"TypeWriter.png")
    		   newBitmap.monoOutput =1 
    		   newBitmap.alphaSource= 0
    		   newBitmap.rgbOutput=1
    		   newMat.cutout_map=newBitmap

    		)
    	)
    )
    else 
    (
       newMat=PhysicalMaterial()
       newMat.name=matName
       newBitmap=Bitmaptexture fileName: (mainPath+"TypeWriter.png")
       newBitmap.monoOutput =1 
       newBitmap.alphaSource= 0
       newBitmap.rgbOutput=1
       newMat.cutout_map=newBitmap

    )

    return newMat
)

mainMat= getMaterialFromName "M_TypeWriter"
--  run Vertex color Assign Script
try (filein secondaryScript) catch ()

--  Assign uvs to individual planes and combine them
fn uvAssign arrayofPlanes arrayofPositions=
(   
max modify mode
 for i=1 to arrayofPlanes.count do
 (
    
    select arrayofPlanes[i]
    obj=selection
    theMod=Unwrap_UVW()
    addModifier obj theMod
    theMod.setTVSubObjectMode 3
    theMod.selectFaces #{1}
    theMod.mappingMode 1 
    theMod.mappingAlign 3 
    theMod.mappingMode 0 
    widthLoc=arrayofPositions[i]
    theMod.scaleSelectedXY 0.1 0.1 [0.0,0.0,0.0]
    theMod.scaleSelectedXY  (widthBlock[widthLoc[2]][widthLoc[1]]) 1.0 [0.05,0.05,0]
    uv_position_x = ((arrayofPositions[i][1] as integer)-1) as float * 0.1 
    uv_position_y = ((arrayofPositions[i][2] as integer)-1) as float * 0.1
    theMod.moveSelected [uv_position_x,uv_position_y,0.0]
    theMod.faceToVertSelect()
    sumX=0.0
    Sumy=0.0
    count=0.0
    selectedVerts=theMod.getSelectedVertices()

    theMod.setTVSubObjectMode 0

 ) 
 convertToPoly arrayofPlanes[1]
 for i=arrayofPlanes.count to 2 by-1 do 
 (
    polyop.attach arrayofPlanes[1] arrayofPlanes[i]
 )
--   Uncomment newx two lines if you want to merge character planes
--   arrayofPlanes[1].weldThreshold=0.001
--   polyOp.weldVertsByThreshold (arrayofPlanes[1]) #{1..polyop.getNumVerts arrayofPlanes[1]}
 
    arrayofPlanes[1].material=mainMat
    return arrayofPlanes[1]

)

-- find poosition of character in mainBlock character array
 fn findCharInBlock charsample =

 (
    Xpos
    YPos
    posArray=#()
  for i=1 to mainBlock.count do 
    (
    YPos= findItem mainBlock[i] charsample
    if YPos!=0 then 
        (
            Xpos=i
            posArray=#(YPos,Xpos)
            exit
        )
        else 
        (
            PosArray=#(7,2)
        )
    )


    return PosArray
)




-- mouse tool: ask Paul Neale if you have any questions. He is the master of this.
struct PlaneOnMouseHit 
(
    targetNode=undefined, 
    planeSize=10.0,
    plMAr=#(),
    plM= Plane lengthsegs:1 widthsegs:1  length:(planeSize) width:(planeSize) wireColor:red name:(uniqueName "MasterPlane"),
    -- put a plane on hit location
    fn putPlane hit=
	(	
		if hit!= undefined do 
		(
			posHit=hit.position 
		
			
			Zv=hit.dir 
			Yv=[0,0,1]
			Xv=normalize (cross Yv Zv)
			yV=normalize (cross Zv Xv)
			plM.transform= Matrix3 Xv Yv Zv hit.pos 
			plM.pos=plM.pos+(hit.dir*0.5)
			append plMAr plM 

				
		)


	),
    
    fn runMouseTool=
	(
		tool mousePick 
		(
			on mousePoint clickNo do 
			(
				format "%" clickNo
				if clickNo>1 do 
				(
					ray1= (mapScreenToWorldRay mouse.pos)
					hit=intersectRay targetNode ray1 
					putPlane hit
					--Format "%" clickNo 
                    #stop
				)
                -- end if clickNo==2
                

			)

			 on mouseAbort clickNo do 
			(
				#stop
			)-- end on mouseAbort
		)--end tool mousePick
		startTool mousePick
	)-- end fn runMouseTool

    
)

-- create main rollout
rollout rlPlaneOnSurface "Typewriter" width:180 height:245 
(
    PickButton pbtnPick  "pick object  to draw on"  pos:[5,5] width:170 height:30
    spinner spnSize "PlaneSize" range:[0.01,1000,10] filedWidth:100 pos:[5,50] width:170 height:30 type:#float
    button  btndo "Draw on surface"  pos:[5,75] width:170 height:30
    edittext etxt "write text here" text:"Change The Text" filedWidth:180 height:100 labelOnTop:true readonly:false multilLine:false
    on pbtnPick picked obj  do 
    (
        pbtnPick.text=obj.name
    )
    on spnSize changed val do 
    (
        print val
    )
    on btndo pressed do 
    (   -- if there is an object to draw on
         if pbtnPick.object!=undefined then 
        (
            masterPicker=PlaneOnMouseHit()
            masterPicker.targetNode=pbtnPick.object
            masterPicker.runMouseTool()
            
            objectA=masterPicker.plMAr[1]
            YPos=0.0
            posList=#()
            mainString=etxt.text

            -- Create an UVW position for each character on the text field
            for i=1 to mainString.count do 
            (
                    thePos=findCharInBlock (mainString[i])
                    append posList thePos
            )
            -- Define character height and base width
            theLength=(spnSize.value)
            objectA.length=theLength
            textArray=#()
            append textArray objectA

           
            offsetAmount=theLength
            totalOffset=0.0
            -- Create and place each character to its position. Supports new line character
            for i=1 to posList.count do 
            (  
                if posList[i][1]==6 and posList[i][2]==2 then 
                (
                    YPos-=theLength
                       
                    totalOffset=-(theLength/2) 
                    currentWidth=widthBlock[posList[i][2]][posList[i][1]]

                    if yPos!=0.0 then 
                    (
                        newObj=copy objectA 
                        newObj.width=(offsetAmount*currentWidth)
                        in coordsys local move newObj [totalOffset,yPos,0] 
                        append textArray newObj
                    )

                )

                else 
                (
                    currentWidth=(widthBlock[posList[i][2]][posList[i][1]])

                  if i==1  then 
                    (
                        
                    objectA.width=currentWidth*offsetAmount
             
                    )
                  else 
                    (
                        prevWidth=(widthBlock[posList[i-1][2]][posList[i-1][1]])
                        totalOffset+=(offsetAmount*((prevWidth+currentWidth)/2.0))
                        newObj=Copy objectA 
                        
                        newObj.width=(offsetAmount*currentWidth)
                        in coordsys local move newObj [totalOffset,YPos,0]
                        append textArray newObj
                    )
                )
            )
            finalObj = uvAssign textArray posList 
            select finalObj    
        )
        else
        (
            messageBox "pick a geometry object to draw on"
        )
    )

)
CreateDialog rlPlaneOnSurface
