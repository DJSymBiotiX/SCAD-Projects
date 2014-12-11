peg_radius = 0.8;
peg_height = 3;
peg_faces = 50;

module create_peg (x, y, h) {
	translate([x, y, h]) cylinder(h = peg_height, r = peg_radius, $fn = peg_faces);
}


module top() {

	height = 20;
	peg_depth = height - 1.5;

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
		create_peg(1, 8, peg_depth);
		create_peg(1, 28, peg_depth);
		create_peg(25, 8, peg_depth);
		create_peg(25, 28, peg_depth);
	}	
}

module bottom() {
	
	height = 4;
	peg_depth = -1.5;

	difference() {
		// Base cube with cutout
		cube([26, 36, height]);
		translate([2, 2, -1]) cube([22, 32, height]);

		// Cylindrical peg holes
		create_peg(1, 8, peg_depth);
		create_peg(1, 28, peg_depth);
		create_peg(25, 8, peg_depth);
		create_peg(25, 28, peg_depth);
	}
}


top();
bottom();


