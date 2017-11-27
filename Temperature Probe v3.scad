cs = 256;

translate([-25, -10, 0]) {
    difference () {
        cube([20, 20, 5]);
        translate([-1, 10, 5]) rotate([90, 90, 90]) cylinder(h=22, d=7.5, $fn=cs);
    }
    translate([2, 2, 5]) cube([5,3,3]);
    translate([12, 15, 5]) cube([5,3,3]);

    /*rotate([180, 0, 0])*/ {
        /* translate([-30, -20, -15]) */ {
            difference () {
                translate([30, 0, 0]) cube([20, 20, 5]);
                translate([29, 10, 5]) rotate([90, 90, 90]) cylinder(h=22, d=7.5, $fn=cs);
                translate([41.8, 1.8, 2]) cube([5.4,3.4,4]);
                translate([31.8, 14.8, 2]) cube([5.4,3.4,4]);
            }
        }
    }
}