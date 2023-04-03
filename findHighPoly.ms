/*
Tool to find objecs with higher polycount from the given number.
Works on selection.
 */


try (DestroyDialog findHighPoly) catch()
Rollout findHighPoly "Find high Poly" width:150 height:75
(
spinner spn_pCount "P-Count" 				pos:[10,15] width:130 height:25 scale:1000 range:[1,1000000,10000] type:#integer
button 	btn_select	"Pick From selection"  	pos:[10,35]	width:130 height:25
	on btn_select pressed do 
	(
		 if selection.count>=1 then 
		 (select (for o in selection where classOf o.baseObject == Editable_Poly AND  (getPolygonCount o)[2] >= spn_pCount.value collect o))
	)

)



CreateDialog findHighPoly pos:[100,200]
