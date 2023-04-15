/* This script will export your non-hierarchical meshes for Unreal Engine .
	"To Origin" checkbox will move the objects to scene center before export and carry them back after the export.
	"SM_ Name" checkbox will rename fbx files with prefix "SM_".
	Works on selection.
*/

try (DestroyDialog rlExport) catch()

-- fbx parameters
AxisTxt="FBXExporterSetParam \"UpAxis\" \"Z\""
AnimTxt="FBXExporterSetParam \"Animation\" True"
EmbedTxt="FBXExporterSetParam \"EmbedTextures\" True"
TriTxt="FBXExporterSetParam \"Triangulate\"  False"
SmoothTxt="FBXExporterSetParam \"SmoothingGroups\"  True"
NameTxt="theSavePath=thePath+"+"\"\\\\\""+"+\"SM_\"+o.name+\".fbx\" "



rollout rlExport "Export" width:140 height:190
(
	radiobuttons rbAxis "Axis" labels:#("Y","Z") default:2 collumns:2 tooltip:"UpAxis Select"
  	checkbox 	 cbAnim "Animations" checked:true tooltip:"Export Animations"
	checkbox  	 cbTextures "Embed Textures" checked:true tooltip:"Embed textures"
	checkbox  	 cbTri "Triangulate" checked:false tooltip:"Textures"
	checkbox     cbSmooth "Smoothing Groups" checked:True tooltip:"SmoothingGroups"
	checkbox     cbName "\"SM_ Name\"" checked:True tooltip:"Naming"
	checkbox     cbOrigin "To Origin" checked:True tooltip:"Move to origin"
	button 		 btnExport	"Export"  width:120 height:20


	on rbAxis changed state do
	(
	 if state==2 then
	 (AxisTxt="FBXExporterSetParam \"UpAxis\" \"Z\" ")
	 else
	 (AxisTxt="FBXExporterSetParam \"UpAxis\" \"Y\" ")
	)
	on cbAnim changed state do
	(
	 if cbAnim.state then 
	 	(
	 	 AnimTxt="FBXExporterSetParam \"Animation\" True"
	 	)
	 else 
	 	(
	 	 AnimTxt="FBXExporterSetParam \"Animation\" False"
	 	)
 	)


	on cbOrigin changed state do
	(
		if cbOrigin.state then 
		(
			OriginTxt="o.pos=[0,0,0]\n"
		 )

		else 
		(
			OriginTxt="\n"
		)
	)


 	on cbName changed state do 
 	(
 	 	if cbName.state then 
 	 	(NameTxt="theSavePath=thePath+"+"\"\\\\\""+"+\"SM_\"+o.name+\".fbx\" ")
 	 	else 
 	 	(NameTxt="theSavePath=thePath+"+"\"\\\\\""+"+o.name+\".fbx\" ")
 	)
 	on cbTextures changed state do
	(
	 if cbTextures.state then 
	 	(
	 	 EmbedTxt="FBXExporterSetParam \"EmbedTextures\" True"
	 	)
	 else 
	 	(
	 	 EmbedTxt="FBXExporterSetParam \"EmbedTextures\" False"
	 	)
 	)
	on cbTri changed state do 
	(
	 if cbTri.state then 
	 	(
	 	 TriTxt="FBXExporterSetParam \"Triangulate\"  True"
	 	)
	 else 
	 	(
	 	 TriTxt="FBXExporterSetParam \"Triangulate\"  False"
	 	)
 	)
	on cbSmooth changed state do
	(
	 if cbSmooth.state then 
	 	(
	 	SmoothTxt="FBXExporterSetParam \"SmoothingGroups\"  True"
	 	)
	 else 
	 	(
	 	SmoothTxt="FBXExporterSetParam \"SmoothingGroups\"  False"
	 	)
 	)
	on btnExport pressed do 
	(
	theTxt="thePath=getSavePath()\n"
	theTxt+="if selection.count!=0 do\n(\n" 
	theTxt+="if thePath!= undefined do\n(\n" 
	theTxt+="theAr=selection as array \n"
	theTxt+="deselect selection\n"				
	theTxt+="for o in theAr where superClassOf o==GeometryClass do\n(\n"
	theTxt+="select o \n"
	theTxt+="theObjectMatrix=o.transform\n"
-- 	theTxt+="theObjectPos=o.pos\n"

	theTxt+=OriginTxt+"\n"
	theTxt+=fixRotateTxt+"\n"
	theTxt+=ChildTxt+"\n"
	theTxt+="--o.rotation=(quat 0 0 0 1)\n"
	theTxt+=NameTxt+"\n"
	theTxt+=AxisTxt+"\n"
	theTxt+=AnimTxt+"\n"
 	theTxt+=EmbedTxt+"\n"
	theTxt+=TriTxt+"\n"
	theTxt+=SmoothTxt+"\n"
	theTxt+="exportFile theSavePath #noPrompt SelectedOnly:true using:fbxexp EmbedTextures:true \n"
	theTxt+=reFixRotateTxt+"\n"
	theTxt+="o.transform=theObjectMatrix\n"
-- 	theTxt+="o.pos=theObjectPos\n"
-- 	theTxt+="freeze o\n"
	theTxt+="deselect selection\n"
	theTxt+=")\n)\n)\n"
		

	
	execute theTxt

 	)


)
CreateDialog rlExport