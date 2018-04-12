translate([10, 0, 0])
difference() {
    rotate([90, 0, 0]) color("White") import("/Users/fchorney/Downloads/fillside.stl");
    translate([7, -25, 0]) make_tab(7, 1.5, height=4, diff=true, rev=true);
    translate([7, 20, 0]) make_tab(7, 1.5, height=4, diff=true, rev=true);
    translate([-100, -35, -1]) cube([100, 70, 4]);
}

translate([-10, 0, 0])
union () {
    difference() {
        rotate([90, 0, 0]) color("White") import("/Users/fchorney/Downloads/fillside.stl");
        translate([0, -35, -1]) cube([100, 70, 4]);
    }
    translate([7, -25, 0]) make_tab(7, 1.5, height=2, rev=true);
    translate([7, 20, 0]) make_tab(7, 1.5, height=2, rev=true);
}

module make_tab(long, cut, height=2, diff=false, rev=false) {
    translate([0, 0, diff ? -1 : 0])
    translate([0, 0, rev ? height : 0])
    rotate([0, rev ? 180 : 0, 0])
        linear_extrude(height) 
        polygon([[0, 0], [0, long], [long, long - cut], [long, cut]]);
}
