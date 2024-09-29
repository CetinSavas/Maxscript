/* 
Exports layers as seperate fbx files.
 */

 fn getRoot node = if isvalidnode node do (while node.parent != undefined do node = node.parent; node)
 theDir = getSavePath()
if theDir!=undefined do 
( 		
-- 	omit layer0
 		undo off with redraw off for k=1 to LayerManager.count-1 do 
 		(
		-- get each layer	
 		layer = LayerManager.getLayer k
 		--for each layer select nodes of layer
 		layer.nodes &theNodes
 		--if layer is not empty
 		if theNodes.count > 0 do
 			(
 			--get layer name
 			layerName = layer.name

 			--exclude layers that names starting with "a_"
 			if (substring layerName 1 2 != "a_"  ) do 
	 			(
 			

	 				select theNodes


	 				fileName = layerName 

	 				FBXExporterSetParam "EmbedTextures" True
					FBXExporterSetParam "Animation" False
					FBXExporterSetParam "Triangulate"  False
					FBXExporterSetParam "SmoothingGroups"  True
					FBXExporterSetParam "UpAxis" "Z"
				
	 				exportFile (theDir + "\\" + fileName + ".fbx") #noprompt selectedOnly:true using:fbxexp 
	 				
	 			)
 			)
 		free theNodes
 		)
)