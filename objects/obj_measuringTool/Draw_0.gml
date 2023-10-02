/// @description Insert description here
// You can write your code in this editor


if (x1 != -1) {
	draw_circle(x1, y1, 5, false);
	draw_circle(x2, y2, 5, false);
	
	draw_line(x1,y1,x2,y2);
	
	draw_text((x1+x2)/2, (y1+y2)/2, point_distance(x1,y1,x2,y2));
}