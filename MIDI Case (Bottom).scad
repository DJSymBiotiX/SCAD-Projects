peg_radius = 0.8;
peg_height = 1.5;
peg_faces = 50;

module create_peg (x, y, h) {
	translate([x, y, h]) cube([2, 1.80, peg_height]);

// cylindar(h = peg_height, r = peg_radius, $fn= peg_faces);
}

module create_peg2(x, y, h) {
	translate([x, y, h]) cube([1.25, 2.25, peg_height]);
}

module top() {

	height = 21.5;
	peg_depth = height;

	translate([2, 0, -23]) cube([2, 2.5, 19.5]);
	translate([22, 3, -23]) cube([2, 2, 19.5]);

	translate([0, 0, -25]) {
		 difference() {
			// Base cube with cutout
			cube([26, 37, height]);
			translate([2, 2, 2]) cube([22, 33, height]);

			// MIDI Cutout
			translate([2, 0, 2]) cube([22, 2, height]);

			// Pin Curout
			translate([9, 34, 14.5]) cube([8, 3, 7]);
		}

		// Cylindrical pegs
		create_peg2(0.75, 6.82, peg_depth);
		create_peg2(0.75, 26.82, peg_depth);
		create_peg2(23.75, 6.82, peg_depth);
		create_peg2(23.75, 26.82, peg_depth);
	}	
}

module bottom() {
	
	height = 4;
	peg_depth = 0;

	translate([9, 0, -2]) cube([8, 2, 2]);
	
	difference() {
		// Base cube with cutout
		cube([26, 37, height]);
		translate([2, 2, -1]) cube([22, 33, height]);

		// Cylindrical peg holes
		create_peg(0.75, 8.12, peg_depth);
		create_peg(0.75, 28.12, peg_depth);
		create_peg(23.25, 8.12, peg_depth);
		create_peg(23.25, 28.12, peg_depth);
	}

	
}


translate([0, 0, 25]) top();
//rotate ([180, 0, 0]) translate([-30, -37, -4]) bottom();


