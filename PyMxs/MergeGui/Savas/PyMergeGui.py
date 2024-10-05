"""
Savas Cetin 2024.
https://artstation.com/savascetin
tested on 3ds max 2024.2 .
does not support max 2025.
replace PySide2 with PySide6 .
Use it on your own risk.
"""
import subprocess
from PySide2 import QtWidgets, QtCore, QtGui
from PySide2.QtCore import Qt
from PySide2.QtWidgets import *
from PySide2.QtCore import *
from PySide2.QtGui import *
import qtmax
import os
from pymxs import runtime as rt
import pymxs
from pathlib import Path
import xml.etree.ElementTree as ET


try:

#try closing previusly opened dialog
	((qtmax.GetQMaxMainWindow()).findChild(QtWidgets.QDockWidget, "Run_MergeGui")).setParent(None)
	((qtmax.GetQMaxMainWindow()).findChild(QtWidgets.QDockWidget, "Run_MergeGui")).deleteLater()
except:
	pass


class RunMergeGui(QtWidgets.QDockWidget):
	def __init__(self, parent=None):
		super(RunMergeGui, self).__init__(parent)
		self.setWindowFlags(QtCore.Qt.Tool)
		self.setObjectName('Run_MergeGui')
		self.setWindowTitle('Merge Gui')
		self.setAllowedAreas(QtCore.Qt.LeftDockWidgetArea)
		self.setAttribute(QtCore.Qt.WA_DeleteOnClose)
		# set size
		self.setMinimumWidth(380)
		self.setMinimumHeight(400)
		self.resize(380,600)
		self.setSizePolicy(QSizePolicy.Expanding,QSizePolicy.Expanding)
		self.initUI()
		self.setAttribute(QtCore.Qt.WA_DeleteOnClose)
	def initUI(self):
		# define main layout
		self.layout = QtWidgets.QGridLayout()
		self.layout.setAlignment(QtCore.Qt.AlignTop| QtCore.Qt.AlignHCenter)
		
		# start click counter
		self.click_count=0
		# define object to draw on 
		self.nodeObj=rt.undefined

		# add refresh button
		self.refresh_button=QPushButton("Refresh")
		self.refresh_button.clicked.connect(lambda: self.refresh_tabs())
		self.layout.addWidget(self.refresh_button,0,0)
		#  add  select folder button
		self.folder_button = QPushButton("Select Folder")
		self.folder_button.clicked.connect(lambda: self.get_subfolders_and_max_files("None"))
		self.layout.addWidget(self.folder_button,0,1)
		# screengrab button
		self.screengrab_button=QPushButton("Export Selected")
		self.screengrab_button.clicked.connect(self.isolate_and_capture)
		self.layout.addWidget(self.screengrab_button,0,3)
		# Text area (QTextEdit)
		self.label=QLabel("Search")
		self.label.setAlignment(QtCore.Qt.AlignCenter)
		self.layout.addWidget(self.label,1,0)
		self.text_area = QLineEdit()
		self.text_area.textChanged.connect(self.filter_tabs)
		self.layout.addWidget(self.text_area,1,1)
		# address buttons
		self.tabs_buttons={}

		self.maintab=QtWidgets.QTabWidget()
		self.maintab.setMinimumWidth(150)
		self.maintab.layout=QGridLayout()
		self.maintab.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
		self.maintab.setTabPosition(QtWidgets.QTabWidget.West)


		self.layout.addWidget(self.maintab,2,0,1,4)
		
		### load xml file
		
		# define xml
		self.xml_path=os.path.join(rt.PathConfig.getDir(rt.name("userScripts")),"MergeGuiData2.xml")
		if os.path.exists(self.xml_path):
			try:
				self.assign_buttons_tabs()
			except:
				None
		# self.head_widget.addWidget(head_grid)	
		
		widget = QtWidgets.QWidget()
		widget.setLayout(self.layout)
		self.setWidget(widget)
		
	def import_max_file(self, max_file):
	    # Import .max file in 3ds Max
	    rt.mergeMaxFile(max_file ,rt.name('select'), rt.name('autoRenameDups'),  rt.name('useSceneMtlDups'))	


	# align imported max files on click using trackcallback function 
	def align_imported(self,max_file):
		# get current selection to draw on assign it to objectA
		objectA=rt.getCurrentSelection()
		# use max Merge Function
		self.import_max_file(max_file)
		# assign first selected object to node object
		self.nodeObj=rt.getCurrentSelection()[0]
		# reselect ojectA
		rt.select(objectA)
		# call mouseTrack function if objectA is defined  it will put instances on selected object
		self.click_count=0
		rt.mouseTrack(on=objectA, snap=rt.name("3D"), trackcallback=self.trackmousecallback)
		# clean object a and delete first instance of node object
		objectA=rt.undefined 
		rt.select(self.nodeObj)
		#  if aborted on creation of first object leave it there
		if self.click_count!=0:
			rt.delete(rt.selection)
		self.nodeObj=rt.undefined

	def handle_mouse_click(self,event, target_file):
		# 	left click
		if event.button()== Qt.LeftButton:
			self.align_imported(target_file)
		#  right click
		elif event.button()==Qt.RightButton:
			self.open_asset_folder(target_file)

	#  mouse callback function
	def trackmousecallback(self, msg, ir, obj, facenum, shift, ctrl, alt):
		if msg == rt.name("mousePoint"):
			# If selection is not empty put object on it
			if obj != None:   
			    # Generate a ray from the screen to the world
				rayToSurface = rt.mapScreenToWorldRay(rt.mouse.pos)
				hit = rt.intersectRay(obj, rayToSurface)	
				if hit != rt.undefined:
					with pymxs.undo(True, "Undo Place Objects"):
						posHit = hit.position  # Get the hit position on the object
						
						# Define the direction vectors for the local coordinate system
						Zvec = hit.dir  # The direction of the hit (Z-axis)
						Yvec = rt.point3(0, 0, 1)  # Y-axis is the world up vector
						
						# Calculate X and Y axes by using the cross product
						Xvec = rt.normalize(rt.cross(Yvec, Zvec))
						Yvec = rt.normalize(rt.cross(Zvec, Xvec))  # Adjust Y axis
						
						# Create a an instance of node object and set the transformation matrix
						cloned_node = rt.instance(self.nodeObj)
						
						cloned_node.transform = rt.Matrix3(Xvec, Yvec, Zvec, posHit)  # Create the W transform
						
						# Offset the position slightly in the hit direction to avoid Z-fighting
						cloned_node.position = cloned_node.position + (hit.dir * 0.01)
						rt.format("Hit position=% \n", cloned_node.position)
						self.click_count+=1
						rt.format("\nclick count=% \n",str(self.click_count))
				    
			else:
				# if  Object to draw on is not selected then put node object on ground where mouse is clicked
				if ir!=rt.undefined:
					with pymxs.undo(True, "Undo Place Objects"):
						self.click_count+=1
						rt.format("\nclick count=% \n",str(self.click_count))
						rt.format("Mouse clicked at %\n", ir.pos)
						cloned_node=rt.instance(self.nodeObj)
						cloned_node.position=ir.pos
				else:
					return rt.name("stop")

		elif msg == rt.name("mouseMove"):
			rt.format("Mouse dragged at %\n", ir.pos)
		elif msg == rt.name("mouseAbort"):
			# Abort on Right Click
			rt.format("Mouse tracking aborted\n")
			return rt.name("stop")
	    
		return rt.name("continue")




	def open_asset_folder(self,target_file):
		# print("Middle Mouse Event")
		target_path=rt.getFileNamePath(target_file)
		os.startfile(os.path.dirname(target_path))
		# subprocess.run(["explorer", target_file], shell=False)

	def refresh_tabs(self):
		xml_file_path=self.xml_path
		tree=ET.parse(xml_file_path)
		root=tree.getroot()
		parent_folder_elem=root.find("ParentFolder")
		parent_folder_path=parent_folder_elem.get("name")
		self.get_subfolders_and_max_files(parent_folder_path)
			

	def assign_buttons_tabs(self):	
		xml_file_path= self.xml_path
		tree = ET.parse(xml_file_path)
		root = tree.getroot()
		parent_folder_elem=root.find("ParentFolder")
		self.tabs_buttons={}
		tab_index=0
		# starting from 0 do for each tab, name them with folder name stored in xml File
		for subdir_elem in parent_folder_elem.findall("Subfolder"):
			subdir_name = subdir_elem.get("name")
			tab=QtWidgets.QScrollArea()
			tab.setSizePolicy(QSizePolicy.Expanding,QSizePolicy.Expanding)
			tab_grid=QtWidgets.QWidget()
			tab_grid.layout=QtWidgets.QGridLayout()
			tab_grid.layout.setAlignment(QtCore.Qt.AlignTop| QtCore.Qt.AlignLeft)
			button_list=[]
			button_index=0
			for file_elem in subdir_elem.findall("File"):
				file_path=file_elem.text
				button=self.create_button(file_path,tab_index,button_index)
				tab_grid.layout.addWidget(button,int(button_index/2),int(button_index%2))
				button_list.append(button)
				button_index+=1
			tab_index+=1
			self.tabs_buttons[subdir_name]=(button_list)
			tab_grid.setSizePolicy(QSizePolicy.Expanding,QSizePolicy.Expanding)
			tab_grid.setLayout(tab_grid.layout)
			tab.setWidget(tab_grid)
			
			self.maintab.addTab(tab,str(subdir_name))



	def create_button(self,file_path,tab_index, button_index):
		file_name = Path(file_path).stem
		png_file = os.path.splitext(file_path)[0] + '.png'
		png_path = os.path.dirname(os.path.abspath(file_path))
		button_icon=QPushButton()
		button_icon.setToolTip(str(file_name))
		button_icon.setIcon(QIcon(png_file))
		button_icon.setIconSize(QSize(150, 150))
		button_icon.setSizePolicy(QSizePolicy.Fixed, QSizePolicy.Fixed)
		button_icon.setContextMenuPolicy(Qt.CustomContextMenu)
		button_icon.mousePressEvent=lambda event: self.handle_mouse_click(event,file_path)
		return button_icon

	def get_subfolders_and_max_files(self,the_path):
		if  os.path.isdir(the_path)==False:
			the_path = QFileDialog.getExistingDirectory(self, "Select Folder")
		if os.path.isdir(the_path):
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
						if file.endswith(".max") or file.endswith(".fbx"):
							# Create file element and add to subdirectory element
							file_elem = ET.SubElement(subdir_elem, "File")
							file_elem.text = os.path.join(subdir_path, file)
			
			# Write XML to file
			tree = ET.ElementTree(root)
			xml_file_path =os.path.join(rt.PathConfig.getDir(rt.name("userScripts")),  "MergeGuiData2.xml")
			tree.write(xml_file_path)
			self.assign_buttons_tabs()
	
	def filter_tabs(self):
        # Get the text from the text area
		filter_text = str(self.text_area.text())

		# Iterate over each tab and its buttons
		for i in range(self.maintab.count()):
			tab_title = self.maintab.tabText(i)
			tab_buttons = self.tabs_buttons[tab_title]

			# Check if any button in the tab matches the filter text
			match_button =False
			match_found = False
			# match_found = False
			for button in tab_buttons:
				if filter_text in button.toolTip().lower():
				# if filter_text in button.text().lower():
					match_found = True
					match_button= True
				else:
					match_button = False
					
				#  hide and disable buttons  that does not have the text
				button.setVisible(match_button)
				button.setEnabled(match_button)


            # Hide or show the tab based on whether a match was found
			# self.maintab.setTabEnabled(i, match_found)
			self.maintab.setTabVisible(i, match_found)
			self.maintab.setTabEnabled(i, match_found)

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
		self.refresh_tabs()



def main():
	main_window = qtmax.GetQMaxMainWindow()
	w = RunMergeGui(parent=main_window)
	main_window.addDockWidget(QtCore.Qt.LeftDockWidgetArea,w)
	w.setFloating(True)
	w.show()
if __name__ == '__main__':
	main()


