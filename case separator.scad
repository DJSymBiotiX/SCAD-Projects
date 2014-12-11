base_length = 38;
base_width = 2;
base_height = 26;
base = [base_length, base_width, base_height];
base_bottom = [base_length, base_width + 4, 1];

corner_length = 6;
corner_width = 3;
corner_height = 6;
corner = [corner_length, corner_width, corner_height];

buff_length = 32;
buff_width = 2;
buff_height = 1;
buff = [buff_length, buff_width, buff_height];

translate([-1 * (base_length / 2), 0, 0]) {
	difference() {
		cube(base);
		translate([-5, -1, 27]) {
			rotate([0, 50, 0]) {
				cube(corner);
			}
		}
		translate([38.5, -1, 23]) {
			rotate([0, -50, 0]) {
				cube(corner);
			}
		}
	}
	
	//translate([3, -.5, base_height - buff_height]) cube(buff);
	translate([0, -2, 0]) cube(base_bottom);
}