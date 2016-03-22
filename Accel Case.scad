// Device
module draw_LIS3DH() {
    color([0.0, 1.0, 0.0, 1.0]) {
        cube([0.8, 0.8, 0.1]);
    }
}

// Bottom
module bottom() {
    color ([0.0, 0.0, 1.0, 1.0]) {
        difference() {
            cube([1.2, 1.2, 0.3]);
            translate([0.15, 0.15, 0.15]) cube([0.9, 0.9, 0.15]);
        }
    }
}

// Top
module top() {
    color([1.0, 0.0, 0.0, 1.0]) {
        difference() {
            cube([1.2, 1.2, 0.6]);
            translate([0.15, 0.15, 0]) cube([0.9, 0.9, 0.4]);
            translate([0.6, 0.6, 0.0]) cylinder(h = .7, d = 0.5, $fn = 20);
        }
    }
}

BUILD = 0;
TOGETHER = 1;
PRINT = 2;

STATE = BUILD;

if (STATE == BUILD) {
    translate([0.2, 0.2, 0.5]) draw_LIS3DH();
    bottom();
    translate([0, 0, 1]) top();
}

if (STATE == TOGETHER) {
    bottom();
    translate([0, 0, .3]) top();
}

if (STATE == PRINT) {
    bottom();
    translate([0, -1.2, 0.6]) rotate([0, 180, 0]) top();
}