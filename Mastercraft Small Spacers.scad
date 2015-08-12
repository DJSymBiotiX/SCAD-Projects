width = 1.25;

t_length = 45;
t_height = 28;
top = [t_length, width, t_height];

b_length = 50;
b_height = 11; 
bottom = [b_length, width, b_height];

rotate([90, 0, 0]) {
	translate([1 - (b_length / 2), 0, 1 - (t_height / 2)]) {
		cube(bottom);
		translate([2.5, 0, 0]) cube(top);
	}
}