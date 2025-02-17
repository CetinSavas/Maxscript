/* 
Converts Physical Material to Standard material.

*/

fn toStandardMat mat=
(

	theBaseColor=mat.base_color
	theBaseMap=mat.base_color_map
	theRoughVal=mat.roughness
	theRoughMap=mat.Roughness_map
	theMetalVal=mat.metalness
	theMetalMap=mat.metalness_map 
	theBumpMap=mat.bump_map
	theOpMap=mat.cutout_map
	theEmitColor=mat.emit_color
	theStandardmat=Standardmaterial()

	theStandardmat.diffuse=theBaseColor
	theStandardmat.name=mat.name 
	if theBaseMap !=undefined do theStandardmat.diffuseMap= theBaseMap



	theStandardmat.specularLevel=theMetalVal*100
	if  theMetalMap!=undefined do  theStandardmat.specularLevelMap=theMetalMap

	theStandardmat.glossiness=(1-theRoughVal)*100
	if theRoughMap != undefined do  theStandardmat.glossinessMap=theRoughMap

	if theBumpMap != undefined do theStandardmat.bumpMap=theBumpMap

	if theOpMap != undefined do  theStandardmat.opacityMap= theOpMap
-- 	replaceInstances map theStandardmat 

	if theEmitColor != black do 
	( 
		theStandardmat.useSelfIllumColor = on
		theStandardmat.selfIllumColor=theEmitColor				
	)

	return theStandardMat



)

for o in scenematerials do 
(	
	if classof o== PhysicalMaterial then
	(
		replaceInstances o (toStandardMat o)
	)
		
	else if classof o==Multimaterial then
	(
	for k=1 to o.materialList.count do 
		
		(
			if classof o.materialList[k]==PhysicalMaterial then 
			( 
				replaceInstances  o.materialList[k] (toStandardMat o.materialList[k]) 
				
			)
		)
		
	)
	
)