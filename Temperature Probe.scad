
translate ([-1.5, 0, 15]) {
    difference () {
        translate([0, 0, 4]) rotate([90, 90, 90]) cylinder(h=3, d=8, $fn=10);
        translate([-1, 0, 4]) rotate([90, 90, 90]) cylinder(h=5, d=6, $fn=10);
        translate([0, -5, 3.5]) cube([3, 10, 6]);    
    }
    
    translate([0.5, -1, -14]) cube([2, 2, 15]);
    translate([-3.5, -5, -15]) cube([10, 10, 1]);
}