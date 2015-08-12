length = 134;
height = 52;
width = 1;

rotate([90, 0, 0]) {
	translate([1 - (length / 2), 0, 1 - (height / 2)]) {
		cube([length, width, height]);
	}
}