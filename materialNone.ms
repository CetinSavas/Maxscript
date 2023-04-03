/* Clean material from selected objects */

for o in selection do 
(
if o.material!= undefined then (o.material=none)
)
redrawViews()