/// @description Insert description here
// You can write your code in this editor

global.numCarts++;

instance_create_layer(x,obj_trainCart.y,"Instances",obj_trainCart,{trainNumber:global.numCarts});

instance_destroy();