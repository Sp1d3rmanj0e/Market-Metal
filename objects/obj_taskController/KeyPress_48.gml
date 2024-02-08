/// @description Insert description here
// You can write your code in this editor

randomize();

var _id = instance_create_layer(mouse_x, mouse_y, "Instances", obj_employeeTop,
{
	profession : choose(PROF.NONE, PROF.ATTENDANT, PROF.WORKER)
});
ds_list_add(employee_ids, _id);