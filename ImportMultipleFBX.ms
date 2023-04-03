/* Imports multiple fbx files in selected directory */

thePath=getSavePath ()
if thePath!=undefined do 
(
	theFiles= getFiles (thePath+"\\*.fbx")
	for f in theFiles do 
	(
		importFile f #noPrompt 

	)
)