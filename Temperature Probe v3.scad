cs = 256;

translate([-25, -10, 0]) {
    difference () {
        cube([20, 20, 5]);
        translate([-1, 10, 5]) rotate([90, 90, 90]) cylinder(h=22, d=7.2, $fn=cs);
        translate([9, -2, 4]) cube([2,3,3]);
        translate([9, 19, 4]) cube([2,3,3]);
    }
    translate([2, 2, 5]) cube([5,3,3]);
    translate([12, 15, 5]) cube([5,3,3]);

    /*rotate([180, 0, 0])*/ {
         /*translate([-30, -20, -15])*/ {
            difference () {
                translate([30, 0, 0]) cube([20, 20, 5]);
                translate([29, 10, 5]) rotate([90, 90, 90]) cylinder(h=22, d=7.2, $fn=cs);
                translate([41.9, 1.9, 2]) cube([5.2,3.2,4]);
                translate([31.9, 14.9, 2]) cube([5.2,3.2,4]);
                translate([39, 19, 4]) cube([2,3,3]);
                translate([39, -2, 4]) cube([2,3,3]);
            }
        }
    }
}