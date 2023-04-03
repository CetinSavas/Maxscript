/* 
Converts Physical Material to Standar material.
Currently only keeps diffuse channel.
*/
for o in scenematerials do 
(	
	if classof o== PhysicalMaterial then
		(
		theCol=o.base_color
		theMap=o.base_color_map
		theStandMat=Standard()
		theStandMat.diffuse=theCol
		theStandMat.name=o.name
		if theMap!=undefined do theStandMat.diffuseMap=theMap

		replaceInstances o theStandMat
		)

	else if classof o==Multimaterial then
	(
	for k=1 to o.materialList.count do 
		(
			if classof o.materialList[k]==PhysicalMaterial then 
			(
				theCol=o.materialList[k].base_color
				theMap=o.materialList[k].base_color_map
				theStandMat=Standard()
				theStandMat.diffuse=TheCol 
				theStandMat.name=o.materialList[k].name
				if theMap!=undefined do theStandMat.diffuseMap=theMap 
				replaceInstances o.materialList[k] theStandMat
			)
		)
	)
	
)