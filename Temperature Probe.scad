
translate ([-1.5, 0, 7]) {
    difference () {
        translate([-0.5, 0, 4]) rotate([90, 90, 90]) cylinder(h=4, d=8, $fn=100);
        translate([-1.45, 0, 4]) rotate([90, 90, 90]) cylinder(h=5, d=6, $fn=100);
        translate([-0.51, -5, 3.5]) cube([5, 10, 6]);    
    }
    
    translate([-0.5, -2, -5]) cube([4, 4, 6]);
    translate([-3.5, -5, -7]) cube([10, 10, 2]);
}