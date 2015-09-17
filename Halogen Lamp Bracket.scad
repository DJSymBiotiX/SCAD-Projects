translate([-8.5, -2.5, -7]) {
	translate([0, 0, 2]) {
		cube([17, 5, 1]);
		difference() {
			translate([0, 2.5, 0]) cylinder(h = 5, d = 5, $fn = 20);
			translate([0, 2.5, 1]) cylinder(h = 5, d = 2.6, $fn = 50);
		}
	
		difference() {
			translate([17, 2.5, 0]) cylinder(h = 5, d = 5, $fn = 20);
			translate([17, 2.5, 1]) cylinder(h = 5, d = 2.6, $fn = 50);
		}
	}
	
	translate([6, -3.5, 0]) {
		translate([0, 0, 2]) cube([5, 12, 1]);	
		difference() {
			translate([2.5, 0, -2]) cylinder(h = 5, d = 5, $fn = 20);
			translate([2.5, 0, -3]) cylinder(h = 5, d = 2.6, $fn = 50);
		}
	
		difference() {
			translate([2.5, 12, -2]) cylinder(h = 5, d = 5, $fn = 20);
			translate([2.5, 12, -3]) cylinder(h = 5, d = 2.6, $fn = 50);
		}
	}
}