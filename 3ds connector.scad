male_dim = [18, 5, 8];
switch_dim = [9, 2, 5];
box = [24, 16, 12];
box_cutout = [22, 14, 16];

// Remove overhang by making it the bottom part
rotate([0, 180, 0]) {
	// Put in the middle of the axis
	translate([-12, -8, -12]) {
		difference() {
			cube(box);
			translate([1, 1, -5]) cube(box_cutout);
			translate([3, 3, 5]) cube(male_dim);
			translate([8, 11, 8]) cube(switch_dim);
		}
	}
}

