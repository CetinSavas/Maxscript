/* 
Exports layers as seperate fbx files.
 */

 fn getRoot node = if isvalidnode node do (while node.parent != undefined do node = node.parent; node)
 theDir = getSavePath()
if theDir!=undefined do 
( 
 		undo off with redraw off for k=1 to LayerManager.count-1 do 
 		(
	 	theMarray =#()
 		layer = LayerManager.getLayer k
 		layer.nodes &theNodes
 		if theNodes.count > 0 do
 			(
 			layerName = layer.name
 			namePos = substring layerName (layerName.count-1) 2
 			--exclude layers that names starting with "a_"
 			if (substring layerName 1 2 != "a_"  ) do 
	 			(
 			

	 				select theNodes
	 				for o in theMarray do 
		 			(o.parent=thePt)

	 				--selectmore thePt

	 				fileName = layerName 

	 				FBXExporterSetParam "EmbedTextures" True
					FBXExporterSetParam "Animation" False
					FBXExporterSetParam "Triangulate"  False
					FBXExporterSetParam "SmoothingGroups"  True
					FBXExporterSetParam "UpAxis" "Z"
				
	 				exportFile (theDir + "\\" + fileName + ".fbx") #noprompt selectedOnly:true using:fbxexp EmbedTextures:true
	 				
	 			)
 			)
 		free theNodes
 		)
)