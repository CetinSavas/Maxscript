Notes:

Tested on 3ds Max 2023 and 2024. Previous versions are not fully supported.

This version of the script does not support 3ds Max 2025 and above. Instructions for 3ds Max 2025 support are provided in the header of the script file.

The script creates a macro upon installation, from which you can add a shortcut to the 3ds Max UI.

Usage:
Install using MergeGui.mzp.

Select a folder using the "Select Folder" button the first time you use the script.

The folder may contain subfolders, provided the subfolders do not have any child folders. Secondary child folders will not be displayed.

Export the selected geometry object, selecting only one object at each export, using the "Export Selected" button to a subfolder of your choice.It is recommended that the exported object’s pivot Z-axis be aligned upwards for proper placement.Each folder is represented as a tab in the GUI. Once you have finished the export process, you can import objects into your new scene by following these steps:

* Select the object you want to place your imported objects on. If nothing is selected, the imported objects will be placed on the active grid.
* Click on the thumbnail of the object you want to import and place.
* Click on either your selected object or anywhere in the scene to create instances of the imported object.
* Right-click to abort the instance creation. If you haven’t clicked anywhere, the imported object will be placed at the coordinates (0, 0, 0) with no rotation.
* Whenever you put some text at the text area labeled search Gui will filter out buttons and tabs that have search string in it. Make sure that text area is empty after you done your search.

 ![image](https://github.com/user-attachments/assets/7d6e84a0-3783-43f2-b390-b8207e3937b5)
