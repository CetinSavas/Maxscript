/* 
Imports multiple Step files in selected directory
 */

thePath=getSavePath ()
if thePath!=undefined do 
(
	theFiles= getFiles (thePath+"\\*.stp")
	for f in theFiles do 
	(
		ATF_STEP_importer.UpAxis = #z
		ATF_STEP_importer.ConvertToMesh= True
		ATF_STEP_importer.MeshResolution =-10
		ATF_STEP_importer.PreserveLayers =True
		ATF_STEP_importer.HierarchyMode =#UsingLayer

		importFile f  #noPrompt --using:ATF_STEP_importer

	)
)