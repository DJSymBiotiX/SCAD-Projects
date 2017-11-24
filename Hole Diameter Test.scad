translate ([-5, -15, 0]) {
    difference () {
        // Outside Box
        translate([-5, -15, 0]) cube([20, 60, 2]);
        // DC Jack
        translate([5, 35, 0]) cylinder(h=2, d=7.65, $fn=100);
        // Pots
        translate([5, 15, 0]) cylinder(h=2, d=6.65, $fn=100);
        // LED
        translate([5, -5, 0]) cylinder(h=2, d=7.57, $fn=100);
    }   
    translate([-5, 44, 2]) cube([1, 1, 1]);
}