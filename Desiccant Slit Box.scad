base_size = 70;
base_height = 80;
thickness = 4;

slit_count = 18;
slit_width = 1.75;
support_count = 5;

// Gap Calculations
usable_space = base_size - (thickness * 2);
slit_space = slit_count * slit_width;
slit_spacing = (usable_space - slit_space) / (slit_count - 1);

usable_height = base_height - (thickness * 2) + (slit_width * 2);
support_space = (support_count + 2) * slit_width;
support_spacing = (usable_height - support_space) / (support_count + 1);

module wall() {  
    difference () {
        cube([thickness, base_size, base_height]);
    
        translate([-1, 0, thickness]) {
            for (y_pos = [
                thickness :
                slit_width + slit_spacing :
                base_size - thickness
            ]) {
                translate([0, y_pos, 0])
                    cube([thickness + 2, slit_width, base_height - (thickness * 2)]);
            }
        }
    }
    
    translate([0, thickness, 0]) {
        for (z_pos = [
            thickness + support_spacing :
            slit_width + support_spacing :
            base_height - thickness - support_spacing
        ]) {
            translate([0, 0, z_pos])
                cube([thickness, base_size - (thickness * 2), slit_width]);
        } 
    }
    
}

// Base
cube([base_size, base_size, thickness]);

// Walls
wall();
translate([0, thickness, 0]) rotate([0, 0, -90]) wall();
translate([0, base_size, 0]) rotate([0, 0, -90]) wall();
translate([base_size - thickness, 0, 0]) wall();
