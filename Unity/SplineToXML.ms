/* 
creates xml file for  spline points.
point type must be bezier.
works on selected object.
 */
-- call .Net xml parser
dotNet.loadAssembly "system.xml"
xmldoc=dotNetObject "system.xml.xmlDocument"

root=xmldoc.createElement "Spline"
xmldoc.AppendChild root 

thePath=GetSavePath()
-- work for the selected line
theLine=$

if thePath!=undefined do 
(
	for i=1 to numKnots theLine do 
	(
		thePoint= xmldoc.createElement "Point"
		thePoint.SetAttribute "Index" ((i-1) as string)
		root.AppendChild  thePoint
		-- X,Y,Z coordinates for the spline point
		thePos=xmldoc.createElement "Position"
		thePos.SetAttribute "X_Position" (((getKnotPoint  theLine 1 i)[1]) as string )
		thePos.SetAttribute "Y_Position" (((getKnotPoint  theLine 1 i)[2]) as string )
		thePos.SetAttribute "Z_Position" (((getKnotPoint  theLine 1 i)[3]) as string )
		thePoint.AppendChild thePos
		-- X,Y,Z coordinates for the spline poinnt in vector
		theInVec=xmldoc.createElement "InVector"
		
		theInVec.SetAttribute 	"X_Position" (((getInVec  theLine 1 i)[1]) as string )
		theInVec.SetAttribute	"Y_Position" (((getInVec  theLine 1 i)[2]) as string )
		theInVec.SetAttribute	"Z_Position" (((getInVec  theLine 1 i)[3]) as string )
		thePoint.AppendChild theInVec 
		-- X,Y,Z coordinates for the spline point out vector
		theOutVec=xmldoc.createElement "OutVector"

		theOutVec.SetAttribute 	"X_Position" (((getOutVec theLine  1 i)[1]) as string )
		theOutVec.SetAttribute	"Y_Position" (((getOutVec theLine  1 i)[2]) as string )
		theOutVec.SetAttribute	"Z_Position" (((getOutVec theLine  1 i)[3]) as string ) 
		thePoint.AppendChild theOutVec
	)
	-- get selected spline name
	theDocName=$.name as string
	-- save xml document
	xmldoc.Save (thePath+"\\"+theDocName+".xml")
)