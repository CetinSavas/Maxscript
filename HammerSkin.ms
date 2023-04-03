/* Enables usage of "Hammer Skin" function */

theSkin =$.modifiers[#Skin]
if theSkin!=undefined do
(
verts=skinOps.getSelectedVertices theSkin 
skinOps.Hammer theSkin verts
)