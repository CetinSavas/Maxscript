/* Creates Lightmap channel in secondary UVW channel */
theArray=$selection as array
for i=1 to theArray.count do
(	
-- 	add object edit poly modifier
	select theArray[i]
	myTPoly=Turn_to_Poly()
	addModifier theArray[i] myTPoly
	myTPoly.selectionConversion = 1
	myTPoly.selectionLevel = 1

-- add unwrap_UVW modifier
	MyUnwrap=unwrap_UVW ()
	MyUnwrap.name="LightMap"
	addModifier theArray[i] MyUnwrap
-- set uvw channel to 2	
	MyUnwrap.selectFaces #{1..(polyop.getNumFaces theArray[i])}
	MyUnwrap.unwrap.setMapChannel 2
-- 	 flatten uvw
	MyUnwrap.flattenMap 30.0 #([1,0,0], [-1,0,0], [0,1,0], [0,-1,0], [0,0,1], [0,0,-1]) 0.01 true  0 true true
	MyUnwrap.pack 0  0.02 true true true
	
	
)
