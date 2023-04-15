# Maxscript
Various Maxscript files
 AdvancedDivideSpline.ms: Creates a new shape from selected shape object which is divided on equal lengthed linear segments, on close approximation with the original shape.. Just like the normalize spline modifier but more precise on divident lengths.
 
 ![image](https://user-images.githubusercontent.com/99070284/232242065-b5b797b6-93f8-4b34-b1c1-cfe71fbed744.png)

 
 ExportLayers.ms: Exports all layers on file to separate .fbx files. Zero Layer and Layers whose names starts with "a_" are ommited. "Embed textures", "Smoothing groups" are enabled, "Animations" and "Triangulate options are disabled. Exports with Up axis "Z". exports on selected folder. No GUI
 
 ExportSelectionForUE: Exports each selected object on separate .fbx file with the name of the object.
 
 ![image](https://user-images.githubusercontent.com/99070284/232242016-745c2344-9845-4863-8fa8-7c03eb6d5401.png)
 
 HammerSkin.ms: Maya like "Hammer Skin"  functionalty exposed for 3ds max. No GUI
 
 HierarchicalSockets.ms: Creates a socket helper per each object in the scene, preserving the object hieararchy. No GUI
 
 ImportMultipleFBX.ms: Imports all the .fbx files in the selected folder. No GUI
 
 ImportMultipleSTP.ms: Imports all the .stp files in the selected folder. No GUI
 
 PhysicalToStandard.ms: Converts Physical Material to Standard material. Currently only keeps diffuse channel. No GUI
 
 RenameCat.ms: Renames Cat hiearchy as close to Unreal Engine Mannequin. Works on selected skelethon part.
 
 ![image](https://user-images.githubusercontent.com/99070284/232243799-a86555ef-7a9a-4a90-b507-f3f626344aee.png)
 
 ResetXformPlus.ms: Script Resets the scale of selected object while preseerving hierarchy and orientation. For max versions that are prior to introduction of  "keep normals" function in xform modifier, this one uses multiple mirror modifiers to keep object normals. If you want to fix scale data of a hierarchy select the root object and press "Shift/Ctrl(older versions)+PageDown" then run the script. No GUI

 SplineToXML.ms: Creates xml file for  spline points. Spline point type must be bezier. Works on selected object. No GUI
 
 StretchySplineIK.ms: Creates a stretchy spline ik on selected spline with given number of bones. There is an option for creating scale bones for baking stretch animation on scale.
 
 ![image](https://user-images.githubusercontent.com/99070284/232244901-04017b80-5af7-48e3-b634-a6586ecf2486.png)

  MaterialNone.ms: Deletes material of the object. No GUI

  SelectBySize.ms: Selects objects with bounding box distance smaller then the given value. Works on selected geometry.
  
 ![image](https://user-images.githubusercontent.com/99070284/232245135-22b44457-4791-452d-8a47-0f617e07dafe.png)
 
  FindHighPoly.ms: Tool to find objecs with higher polycount from the given number. Works on selection and objects have to be editable poly.
  
  ![image](https://user-images.githubusercontent.com/99070284/232245222-6149a646-e590-4973-a826-c5265df361f4.png)

  CADWorkshop.ms. A tool for processing CAD files imported to max. Shortcuts for selecting objects with same number of vertices, Intance selection, pivot alignment, ResetingForm with orientation preserverd after pivot alignemnt. Shortcuts for quadrifying correcting non plananr polygons, and material removal. and other group of tools for instance replacement. A toolset for  converting pipe models to spline objects (Process modifes the topology, so it is always good practice to backup the original pipe.). spline conversion works on Editable Poly object. last group is freezing and unfreezing the object.
  


 
 


