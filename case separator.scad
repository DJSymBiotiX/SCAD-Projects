base_length = 40;
base_width = 2;
base_height = 27;
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

		translate([-2, -1, 24]) {
			rotate([0, 0, 0]) {
				cube(corner);
			}
		}
		translate([36, -1, 24]) {
			rotate([0, 0, 0]) {
				cube(corner);
			}
		}
	}
	
	//translate([3, -.5, base_height - buff_height]) cube(buff);
	translate([0, -2, 0]) cube(base_bottom);
}