try (DestroyDialog rlSplineDivide) catch()

-- function to draw a new and Divided spline from previous spline; inputs :(spline)  (tIndividual linear segment length)
fn AdvancedDivideSpl t_Spline Normval = 
(
	-- create a master point  
	origObj = Point Box:on size:5 axistripod:off cross:off wirecolor:red name:"Normpt"()
	-- create array to hold points on the spline
	irray=#()
	-- create array to hold  corrected points of the new spline
	corarray=#()
	
		-- find number of points, necassary to create the normalized spline
		k = floor (curvelength(t_Spline)/Normval)
		-- find interval of points on the spline
		pos = curvelength(t_Spline)/Normval
	
	-- first create helpers that are evenly distributed on the spline (with Path constraint)
		for i = 0 to k do 
		(
			
			percentState = 100.0/pos * i
				if (percentState <= 100) and (percentState >= 0) do
			(	
				new_copy = instance origObj 											--instance the object
				new_copy.name = uniquename origObj.name 					--rename it
				append irray new_copy											-- add to instance array
				
				new_copy.pos.controller = Path_Constraint follow:false path:t_Spline constantVel:true percent:percentState allowUpsideDown:on		-- align/follow path 
				
				deleteKeys new_copy #allKeys -- delete animations of the  created point
			)
		) -- end for
		
	-- then create second set of points to hold path constrainted points' position in cartesian space
		for i=1 to irray.count do
		(
			corpt=Point name:(uniquename "del_pt") ()
			append corarray corpt
			corpt.transform= irray[i].transform
						
		)
	-- normalize the castesian poisitons of second set of points relative, to first of the group, so that any the distance between any of two is equals to the track length in 3d sapace coordinates
			for i=2 to corarray.count do
		(
			-- if the index of point is odd, the points position will be twice the length of the previous even indexed point relative to previous odd indexed point, so that when animation is done, the points new position will create two equas 30-60-90 special  triangles with its previous position and  the two points near it
			if (mod i 2)==1 then 
			(
				myv=corarray[i-1].pos-corarray[i-2].pos
				nv=normalize myv
				lenv= Normval *nv
				corarray[i].pos=corarray[i-2].pos+(2*lenv)
			)
			-- if the position of the point is even it will assume its relative position to the previous point.
			else 
			(
				myv=corarray[i].pos-corarray[i-1].pos
				nv=normalize myv
				lenv= Normval *nv
				corarray[i].pos= corarray[i-1].pos+lenv
				
			)
			corarray[i].wirecolor=red
			
		)
	-- start creatte a new normalized spline 
	  ss = SplineShape pos:corarray[1].pos () 
	  -- create normalized spline using position corrected points' positions
	  addNewSpline ss
	  for i=1 to corarray.count do
	  (   
		  
		  addKnot ss 1 #corner #line corarray[i].position 
		  
	  )
	  
	  -- cahnge newly created spline's properties
	  ss.wirecolor=Orange
	  ss.vertexticks=on
	  ss.name="normspl"
	 
	  
	  -- freeze  the cast spline for normalization
	  --t_Spline.isFrozen=true
	  -- delete unnecassary points from scene
	  delete (origObj)
	  OrigObj=undefined
	  
	  for f=1 to irray.count do 
	  (
		delete irray[f]
		)
	  for f=1 to corarray.count do
	  (
		delete corarray[f]  
		)
	--end delete	
		-- return the new spline
	  return ss
) --end fn


-- create GUI

rollout rlSplineDivide "Divide by length" width:90 height:50 
(
	spinner spnSegment	"Segment" pos:[5,5] range:[0.1,100000,5] width:80 height:20
	pickButton pbtnSpline "Pick Shape" pos:[5,25] width:80 height:20 

	on pbtnSpline picked obj do 
	(
		if superclassof obj==Shape do AdvancedDivideSpl obj spnSegment.value

	)

)
CreateDialog rlSplineDivide 