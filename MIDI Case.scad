peg_radius = 0.8;
peg_height = 3;
peg_faces = 50;

module create_peg (x, y, h) {
	translate([x, y, h]) cube([2, 2, peg_height]);

// cylindar(h = peg_height, r = peg_radius, $fn = peg_faces);
}


module top() {

	height = 20;
	peg_depth = height;

	translate([0, 0, -25]) {
		 difference() {
			// Nase cube with cutout
			cube([26, 36, height]);
			translate([2, 2, 2]) cube([22, 32, height]);

			// MIDI Cutout
			translate([2, 0, 2]) cube([22, 2, height]);

			// Pin Curout
			translate([7, 34, height / 1.5]) cube([12, 2, height]);
		}

		// Cylindrical pegs
		create_peg(0, 8, peg_depth);
		create_peg(0, 28, peg_depth);
		create_peg(24, 8, peg_depth);
		create_peg(24, 28, peg_depth);
	}	
}

module bottom() {
	
	height = 4;
	peg_depth = 0;

	difference() {
		// Base cube with cutout
		cube([26, 36, height]);
		translate([2, 2, -1]) cube([22, 32, height]);

		// Cylindrical peg holes
		create_peg(0, 8, peg_depth);
		create_peg(0, 28, peg_depth);
		create_peg(24, 8, peg_depth);
		create_peg(24, 28, peg_depth);
	}
}


translate([0, 0, 25]) top();
rotate ([180, 0, 0]) translate([-30, 0, -4]) bottom();


