fragments = 256;
disk_diameter = 120;
inner_diameter = 40;
outer_diameter = 50;
outer_hole_diameter = 3;
inner_hole_diameter = 2;
fin_size = (outer_diameter - inner_diameter) / 2;

module make_filament_holes(ta, tb, tz, h, d, fn) {
    translate([ta, tb, tz]) cylinder(h=h, d=d, $fn=fn);
    translate([-ta, tb, tz]) cylinder(h=h, d=d, $fn=fn);

    translate([ta, -tb, tz]) cylinder(h=h, d=d, $fn=fn);
    translate([-ta, -tb, tz]) cylinder(h=h, d=d, $fn=fn);

    translate([tb, ta, tz]) cylinder(h=h, d=d, $fn=fn);
    translate([tb, -ta, tz]) cylinder(h=h, d=d, $fn=fn);

    translate([-tb, ta, tz]) cylinder(h=h, d=d, $fn=fn);
    translate([-tb, -ta, tz]) cylinder(h=h, d=d, $fn=fn);
}    

module make_inner_filament_holes(ta, h, d, fn) {
    translate([ta - 2.5, 0, 15]) rotate([0, 90, 0]) cylinder(h=h, d=d, $fn=fn);
    translate([-ta - 1.5, 0, 15]) rotate([0, 90, 0]) cylinder(h=h, d=d, $fn=fn);
    translate([0, -ta + 2.5, 15]) rotate([90, 0, 0]) cylinder(h=h, d=d, $fn=fn);
    translate([0, ta + 1.5, 15]) rotate([90, 0, 0]) cylinder(h=h, d=d, $fn=fn);
}

module make_fins(ta, tb, tz, x, y, z) {  
    rotate([0, 0, 22.5]) translate([0,ta, tz]) cube([x, y, z]);
    rotate([0, 0, 22.5]) translate([0,tb, tz]) cube([x, y, z]);
    rotate([0, 0, 22.5]) translate([ta,0, tz]) cube([y, x, z]);
    rotate([0, 0, 22.5]) translate([tb,0, tz]) cube([y, x, z]);

    rotate([0, 0, 67.5]) translate([0,ta, tz]) cube([x, y, z]);
    rotate([0, 0, 67.6]) translate([0,tb, tz]) cube([x, y, z]);
    rotate([0, 0, 67.5]) translate([ta,0, tz]) cube([y, x, z]);
    rotate([0, 0, 67.5]) translate([tb,0, tz]) cube([y, x, z]);
}

// Main Thing
difference() {
    union() {
        // Main Disk
        cylinder(h=2, d=disk_diameter, $fn=fragments);
        // Outer Inside Cylinder
        translate([0, 0, 2]) cylinder(h=15, d=outer_diameter, $fn=fragments);
    }

    // Outer Inside Cylinder Cutout
    translate([0, 0, -1]) cylinder(h=19, d=outer_diameter - 2, $fn=fragments);

    // Outer filament holes
    make_filament_holes(4, (disk_diameter / 2) - 5, -1, 4, outer_hole_diameter, fragments);
    
    // Inner filament holes
    make_inner_filament_holes(outer_diameter / 2, 4, inner_hole_diameter, fragments);
}

difference() {
    // Inner Cylinder Cutout
    translate([0, 0, 0]) cylinder(h=17, d=inner_diameter, $fn=fragments);
    translate([0, 0, -1]) cylinder(h=19, d=inner_diameter - 1, $fn=fragments);
}

// Fins
make_fins(inner_diameter / 2, -((inner_diameter / 2) + fin_size), 0, 1, fin_size, 17);