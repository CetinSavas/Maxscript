/* selects objecs below certain size */
dist_Var=10
sel_Ar=#()
fn distanceSelect selAr distVar =

(
	
	--define an  empty arrray to collect small objects
	ArDel=#()
	--proccess selAr
	for i=1 to selAr.count do
	(
		if superclassof selAr[i]== GeometryClass then
			(	
			tempObj=selAr[i]
				-- define array to hold dimensions of object and find maximum dimension
			dist_ar=#()
			-- proccess and append each dimension to dist_ar array
			tx=abs (tempObj.max.x-tempObj.min.x)
			append  dist_ar tx
			ty=abs (tempObj.max.y-tempObj.min.y)
			append  dist_ar ty
			tz=abs (tempObj.max.z-tempObj.min.z)
			append  dist_ar tz
			-- sort dist_ar to find maximum dimension
			sort dist_ar
			-- find maximum dimension	
			tempdist = (dist_ar[1]) as float
				-- if maximum dimension is less then or equal to certain number append current object to ArDel array
			if tempdist<=distVar then append ArDel selAr[i]
			)
	)
	-- when for loop ends select members of ArDel arrray
	return ArDel
)

try (DestroyDialog selBySize) catch ()

rollout selBySize "Select By Size" width:100 height:75
(
	spinner spn_Size 	"Size" 	pos:[10,15] width:80 height:25 scale:0.01 range:[0.0,1000.0,10.0] type:#float
	button 	btn_Sel		"select"	pos:[10,35]	width:80 height:25

	on spn_Size changed val do 
	(
		dist_Var=spn_Size.value
	)
	on btn_Sel pressed do 
	(
		if selection.count>1 then 
		(
			sel_Ar=(distanceSelect selection dist_Var)
			select sel_Ar
		)
	)
)
CreateDialog selBySize pos:[100,200]