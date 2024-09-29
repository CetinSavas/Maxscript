from PySide2.QtWidgets import *
from PySide2.QtCore import *
from PySide2.QtGui import *
import qtmax
import os
from pymxs import runtime as rt
# from configparser import ConfigParser
from pathlib import Path
import xml.etree.ElementTree as ET

# rt.execute('try(uiaccessor.closedialog (windows.getChildHWND #max "Viewport Layout Tabs")[1]) catch()')

try:

#try closing previusly opened dialog
	((qtmax.GetQMaxMainWindow()).findChild(QtWidgets.QDockWidget, "ImportGui")).setParent(None)
	((qtmax.GetQMaxMainWindow()).findChild(QtWidgets.QDockWidget, "ImportGui")).deleteLater()
except:
	pass

# Define global node  object for distribution
nodeObj=rt.undefined
# Mouse TrackCallback function
def trackmousecallback(msg, ir, obj, facenum, shift, ctrl, alt):

    # Access node object to distribute
    global nodeObj
    if msg == rt.name("mousePoint"):
        # If selection is not empty put object on it
        if obj != None:
            
            # Generate a ray from the screen to the world
            rayToSurface = rt.mapScreenToWorldRay(rt.mouse.pos)
            hit = rt.intersectRay(obj, rayToSurface)

            if hit != rt.undefined:
                posHit = hit.position  # Get the hit position on the object
                
                # Define the direction vectors for the local coordinate system
                Zvec = hit.dir  # The direction of the hit (Z-axis)
                Yvec = rt.point3(0, 0, 1)  # Y-axis is the world up vector
                
                # Calculate X and Y axes by using the cross product
                Xvec = rt.normalize(rt.cross(Yvec, Zvec))
                Yvec = rt.normalize(rt.cross(Zvec, Xvec))  # Adjust Y axis
                
                # Create a an instance of node object and set the transformation matrix
                pt = rt.instance(nodeObj)
                
                pt.transform = rt.Matrix3(Xvec, Yvec, Zvec, posHit)  # Create the W transform
                
                # Offset the position slightly in the hit direction to avoid Z-fighting
                pt.position = pt.position + (hit.dir * 0.5)
                rt.format("Hit position=% \n", pt.position)
                
        else:
        	# if  Object to draw on is not selected then put node object on ground where mouse is clicked
        	if ir!=rt.undefined:
        		rt.format("Mouse clicked at %\n", ir.pos)
        		pt=rt.instance(nodeObj)
        		pt.position=ir.pos
        	else:
        		return rt.name("stop")

    elif msg == rt.name("mouseMove"):
        rt.format("Mouse dragged at %\n", ir.pos)
    elif msg == rt.name("mouseAbort"):
    	# Abort on Right Click
        rt.format("Mouse tracking aborted\n")
        return rt.name("stop")
    
    return rt.name("continue")


def import_max_file(max_file):
    # Import .max file in 3ds Max
    rt.mergeMaxFile(max_file ,rt.name('select'), rt.name('autoRenameDups'),  rt.name('useSceneMtlDups'))

def align_imported(max_file):
	global nodeObj
	# Get current selection to draw on assign it to objectA
	objectA=rt.getCurrentSelection()
	# Use max Merge Function
	import_max_file(max_file)
	# Assign first selected object to node object
	nodeObj=rt.getCurrentSelection()[0]
	# Reselect ojectA
	rt.select(objectA)
	# Call mouseTrack function if objectA is defined  it will put instances on selected object
	rt.mouseTrack(on=objectA, snap=rt.name("3D"), trackcallback=trackmousecallback)
	# Clean object a and delete first instance of node object
	objectA=rt.undefined 
	rt.select(nodeObj)
	rt.delete(rt.selection)
	nodeObj=rt.undefined

class ImportFileGui(QtWidgets.QDockWidget):
	def __init__(self, parent=None):
		super(ImportFileGui, self).__init__(parent)
		self.setWindowFlags(QtCore.Qt.Tool)
		self.setObjectName('ImportGui')
		self.setWindowTitle('Merge Gui')
		self.setAllowedAreas(QtCore.Qt.LeftDockWidgetArea)
		self.setAttribute(QtCore.Qt.WA_DeleteOnClose)
		self.layout=QGridLayout()
		self.setMinimumWidth(370)
		self.resize(370,600)
		self.setSizePolicy(QSizePolicy.Expanding,QSizePolicy.Expanding)
		self.initUI()
		self.setAttribute(QtCore.Qt.WA_DeleteOnClose)
	def initUI(self):
		# Define layout
		layout = QtWidgets.QGridLayout()
		
		# Add  main buttons
		refresh_button=QPushButton("Refresh")
		refresh_button.clicked.connect(lambda: self.refresh_tabs())
		layout.addWidget(refresh_button,0,0)

		folder_button = QPushButton("Select Folder")
		folder_button.clicked.connect(lambda: self.get_subfolders_and_max_files("None"))
		layout.addWidget(folder_button,0,1)

		screengrab_button=QPushButton("Export Selected")
		screengrab_button.clicked.connect(self.isolate_and_capture)
		layout.addWidget(screengrab_button,0,2)

		# Set Main tab properties add to main widget
		self.maintab=QtWidgets.QTabWidget()
		self.maintab.setMinimumWidth(370)
		self.maintab.layout=QGridLayout()
		self.maintab.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
		self.maintab.setTabPosition(QtWidgets.QTabWidget.West)
		layout.addWidget(self.maintab,1,0,1,3)
		
		### Load xml file
		self.xml_path=os.path.join(rt.PathConfig.getDir(rt.name("userScripts")),"MergeGuiData.xml")
		
		# Assign buttons and tabs
		if os.path.exists(self.xml_path):
			self.assign_buttons_tabs()
		
		widget = QtWidgets.QWidget()
		widget.setLayout(layout)
		self.setWidget(widget)

	# Refresh tabs function 	
	def refresh_tabs(self):
		# Get main folder from .XML file
		xml_file_path=self.xml_path
		tree=ET.parse(xml_file_path)
		root=tree.getroot()
		parent_folder_elem=root.find("ParentFolder")
		parent_folder_path=parent_folder_elem.get("name")
	 	# Re-create Tabs and buttons from root folder of .xml file with new folders as tabs
		self.get_subfolders_and_max_files(parent_folder_path)
			

	def assign_buttons_tabs(self):
		#  check xml path
		xml_file_path= self.xml_path
		tree = ET.parse(xml_file_path)
		root = tree.getroot()
		parent_folder_elem=root.find("ParentFolder")

		tab_index=0
		# Starting from 0 do for each tab name them with folder name stored in xml
		for subdir_elem in parent_folder_elem.findall("Subfolder"):
			subdir_name = subdir_elem.get("name")
			tab=QtWidgets.QScrollArea()
			tab.setSizePolicy(QSizePolicy.Expanding,QSizePolicy.Expanding)
			tab_grid=QtWidgets.QWidget()
			tab_grid.layout=QtWidgets.QGridLayout()
			

			button_index=0
			# starting from 0 do for each button name them wit max file stored in xml
			for file_elem in subdir_elem.findall("File"):
				file_path=file_elem.text
				button_string=self.create_button_string(file_path,tab_index,button_index)
				exec(button_string)
				button_index+=1
			tab_index+=1
			tab_grid.setSizePolicy(QSizePolicy.Expanding,QSizePolicy.Expanding)
			tab_grid.setLayout(tab_grid.layout)
			tab.setWidget(tab_grid)
			
			self.maintab.addTab(tab,str(subdir_name))

	# function for creating buttons  as string to be used later 
	def create_button_string(self,file_path, tab_index,button_index):
		file_name = Path(file_path).stem
		png_file = os.path.splitext(file_path)[0] + '.png'
		png_path = os.path.dirname(os.path.abspath(file_path))
		button_string =  f"button{tab_index}_{button_index}= QPushButton(\"\")\n"
		button_string +=  f"button{tab_index}_{button_index}.setToolTip(\"{file_name}\")\n"
		button_string += f"button{tab_index}_{button_index}.setIcon(QIcon(r\"{png_file}\"))\n"
		button_string += f"button{tab_index}_{button_index}.setIconSize(QSize(150, 150))\n"
		button_string += f"button{tab_index}_{button_index}.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)\n"
		button_string += f"button{tab_index}_{button_index}.clicked.connect(lambda : align_imported(r\"{file_path}\"))\n"
		button_string += f"tab_grid.layout.addWidget(button{tab_index}_{button_index},{int(button_index/2)},{int(button_index%2)})\n"
		return button_string

	def get_subfolders_and_max_files(self,the_path):
		if  os.path.isdir(the_path)==False:
			the_path = QFileDialog.getExistingDirectory(self, "Select Folder")
		if os.path.isdir(the_path):
			# Remove existing tabs
			for i in range(self.maintab.count() - 1, -1, -1):
				self.maintab.removeTab(i)
			root_folder=the_path
			# Create XML element tree and add root element
			root = ET.Element("Data")
			
			# Create parent folder element and add to root
			parent_folder_elem = ET.SubElement(root, "ParentFolder")
			parent_folder_elem.set("name", root_folder)
			
			# Iterate over subdirectories
			for subdir in os.listdir(root_folder):
				subdir_path = os.path.join(root_folder, subdir)
				if os.path.isdir(subdir_path):
					# Create subdirectory element and add to parent folder element
					subdir_elem = ET.SubElement(parent_folder_elem, "Subfolder")
					subdir_elem.set("name", subdir)
					
					# Iterate over max files in subdirectory
					for file in os.listdir(subdir_path):
						if file.endswith(".max"):
							# Create file element and add to subdirectory element
							file_elem = ET.SubElement(subdir_elem, "File")
							file_elem.text = os.path.join(subdir_path, file)
			
			# Write XML to file
			tree = ET.ElementTree(root)
			xml_file_path =os.path.join(rt.PathConfig.getDir(rt.name("userScripts")),  "MergeGuiData.xml")
			tree.write(xml_file_path)
			self.assign_buttons_tabs()

	
	

	def isolate_and_capture(self):

		# Get the currently selected object
		selected_obj = rt.selection[0]

		# store its rotation and position
		first_pos=selected_obj.position
		first_rot=selected_obj.rotation

		# move and rotate it so it is at center vith no rotation
		selected_obj.position=rt.Point3(0,0,0)
		selected_obj.rotation=rt.EulerAngles(0,0,0)
		

		
	   # Open a floating window
		rt.ViewPanelManager.SetFloatingViewPanelVisibility(1, True)
		rt.redrawViews()
		# Isolate the selected object
		rt.IsolateSelection.EnterIsolateSelectionMode()
		rt.execute("max tool zoomextents all")
		rt.redrawViews()
		rt.execute("viewport.setGridVisibility #all false")

		rt.clearSelection()
		# Export the object as .max to the user-selected directory
		export_dir = QtWidgets.QFileDialog.getExistingDirectory(None, "Select Export Directory")
		if export_dir:
			export_path = os.path.join(export_dir, (selected_obj).name + ".max")
			rt.saveNodes (selected_obj, export_path, quiet=True) # Use the appropriate export format options here
		
		# Save the screenshot to the same directory as .png with the same name as the object
		# Capture a screenshot of the isolated object	
		screenshot_name = (selected_obj).name + ".png"
		view_size = rt.getViewSize()
		# Create bitmap for preview
		img=rt.bitmap (view_size.x, view_size.y, filename=(os.path.join(export_dir, screenshot_name)))
		# Capture scene view
		dib=rt.viewport.getViewportDib()
		rt.copy(dib,img)
		# Save and close image
		rt.save(img)
		rt.close (img)
		# Select the object and send it to original position and rotation
		rt.select(selected_obj)
		selected_obj.rotation=first_rot
		selected_obj.position=first_pos
		# Close floatin panel  and exit isolation
		rt.ViewPanelManager.SetFloatingViewPanelVisibility(1, False)
		rt.execute("viewport.setGridVisibility #all true")
		rt.IsolateSelection.ExitIsolateSelectionMode()
		rt.execute("max tool zoomextents all")

def main():
	main_window = qtmax.GetQMaxMainWindow()
	w = ImportFileGui(parent=main_window)
	main_window.addDockWidget(QtCore.Qt.LeftDockWidgetArea,w)
	w.setFloating(True)
	w.show()
if __name__ == '__main__':
	main()


