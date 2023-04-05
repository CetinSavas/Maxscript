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
-- get root node function
	 fn getRoot node = (
  if isvalidnode node do 
  (
    while node.parent != undefined do node = node.parent; 
    node
  )
)


--  collect roots of scene
for o in objects do 
(

	theParrent= getRoot o 
	appendIfUnique masterArray theParrent

)

deselect
--  select root nodes
for m=1 to masterArray.count do 
(
	selectmore masterArray[m]
)
-- alseo select children of roots
for i in selection do
(
selectmore i.children
)
-- store object hiearrchy in array for later use
childHiearchy= $selection as array
deselect
-- create socket per object in child hiearchy
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
	o.parent=tempParent

	Append sockeyHiearchy Socket
	
)
-- recreate same  hiearchy in scene for "childHiearcy" for sockets
for i=1 to childHiearchy.count do
(
	if childHiearchy[i].parent!=undefined then 
	(
		indexItem=findItem childHiearchy childHiearchy[i].parent
		sockeyHiearchy[i].parent= sockeyHiearchy[indexItem]
	)

)