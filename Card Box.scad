length = 100;
width = 80;
height = 50;

thickness = 4;

fn = 64;

minkowski () {
    union () {
        difference() {
            cube([length, width, height]);
            translate([thickness, thickness, thickness])
                cube([length - (thickness * 2), width - (thickness * 2), height]);
        }
        translate([thickness + 4, 0, 0]) cube([thickness, width, height]);
        translate([thickness + 30, 0, 0]) cube([thickness, width, height]);
        translate([thickness + 60, 0, 0]) cube([thickness, width, height]);
        translate([thickness + 4, 0, 0]) cube([thickness, width, height]); 
    }
    sphere(r=1, $fn=fn);
} 