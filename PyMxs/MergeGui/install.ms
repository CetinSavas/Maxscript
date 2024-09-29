
try (DestroyDialog rl_install_MergeUI) catch()




	fn merge_gui_install =
(
	try(uiaccessor.closedialog (windows.getChildHWND #max "Viewport Layout Tabs")[1]) catch()
	sourcePath= pathConfig.getDir #temp+"\\Savas"
	try (makeDir (pathConfig.getDir #userScripts+"\\Savas") ) catch ()
	targetPath=pathConfig.GetDir #userScripts+"\\Savas"
	targetFile=targetPath+"\\PyMergeGui.py"
	sourceFile=sourcePath+"\\PyMergeGui.py"

		 if not (copyFile  sourceFile targetFile) do 
			(
				deleteFile targetFile
				copyFile sourceFile targetFile 
		)
 
	 python.executeFile targetFile

	theMacro="MacroScript MergeGui\n"
	theMacro+="category:\"Savas\"\n"
	theMacro+="buttonText:\"Start MergeUI\"\n"
	theMacro+="toolTip:\"Start MergeUI\"\n"
	theMacro+="(\n"
	theMacro+="try (Python.executeFile @\""+targetFile as string+"\") catch (messageBox \"Script Error(PyMergeGui.py)\")\n"
	theMacro+="\n)"

	execute theMacro
	messageBox "The MergeUI macro is now under \"Savas\" Category" 
 )

	


rollout rl_install_MergeUI "Install MergeUI" width:160 height:50
(

	button btn_Install "Install MergeUI"				width:150 height:30 toolTip:"Install Merge Gui"

	
	-- assign buttons
	on btn_Install pressed do
	(
		
		merge_gui_install()

	)	

)
CreateDialog rl_install_MergeUI
