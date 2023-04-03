/* 
This Script Creates Sockets Per object in the scene.
Each Socket is named with "SOCKET_"+corresponding object name

 */


masterArray=#()
childHiearchy=#()
sockeyHiearchy=#()

theLayerName="SOCKETS"
LayerManager.newLayerFromName theLayerName
theNewLayer=LayerManager.getLayerFromName theLayerName
theNewLayer.current=true
	 fn getRoot node = (
  --Check if the node passed to the function is a valid node.
  if isvalidnode node do 
  (
    --Loop through the hierarchy until the current node's parent is undefined (i.e. rootnode)
    while node.parent != undefined do node = node.parent; 
    --Return the rootnode
    node
  )
)



for o in objects do 
(

	theParrent= getRoot o 
	appendIfUnique masterArray theParrent

)
deselect
for m=1 to masterArray.count do 
(
	selectmore masterArray[m]
)

for i in selection do
(
selectmore i.children
)

childHiearchy= $selection as array
deselect

for o in childHiearchy do 
(
	Socket=Point()
	theNewLayer.addnode Socket
	Socket.size=length(o.max-o.min) 
	Socket.Box=on 
	Socket.name="SOCKET_"+o.name
	Socket.wireColor=o.wireColor 
	tempParent=o.parent
	o.parent=undefined
	Socket.transform=o.transform
-- 	Socket.position=o.position
-- 	Socket.rotation=o.rotation
	o.parent=tempParent

	Append sockeyHiearchy Socket
	
)

for i=1 to childHiearchy.count do
(
	if childHiearchy[i].parent!=undefined then 
	(
		indexItem=findItem childHiearchy childHiearchy[i].parent
		sockeyHiearchy[i].parent= sockeyHiearchy[indexItem]
	)

)