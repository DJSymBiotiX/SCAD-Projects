base_length = 50;
base_width = 50;
height = 110;
thickness = 4;

hole_size = 0.75;
hole_count = 20;
hole_count_w = 20;
hole_spacing = .25;

do_difference = true;

hypotenuse = sqrt((hole_size * hole_size) + (hole_size * hole_size));


module length_cubes() {
    useable_space = base_length - (thickness * 2);
    hole_space_usage = hole_count * hypotenuse;
    hole_gap = (useable_space - hole_space_usage) / (hole_count - 1);

    useable_space_alt = base_length - (thickness * 2) - hypotenuse - hole_gap;
    hole_space_usage_alt = (hole_count - 1) * hypotenuse;
    hole_gap_alt = (useable_space_alt - hole_space_usage_alt) / (hole_count - 2);


    for (z_pos = [thickness + (hypotenuse / 2) + hole_spacing : hypotenuse + hole_spacing : height - thickness]) {
        for (x_pos = [thickness : hole_gap + hypotenuse : base_length - thickness]) {
            translate([x_pos, thickness + 1, z_pos])
                rotate([90, 45, 0])
                    color("red")
                        cube([hole_size, hole_size, thickness + 2]);
        }
    }
     for (z_pos = [thickness + hypotenuse + (hole_spacing * 1.5) : hypotenuse + hole_spacing : height - thickness]) {
        for (x_pos = [thickness + (hypotenuse / 2) + (hole_gap_alt / 2): hole_gap_alt + hypotenuse : base_length - thickness - (hypotenuse / 2) - (hole_gap / 2)]) {
            translate([x_pos, thickness + 1, z_pos])
                rotate([90, 45, 0])
                    color("blue")
                        cube([hole_size, hole_size, thickness + 2]);
        }
    }
}


module width_cubes() {
    useable_space = base_width - (thickness * 2);
    hole_space_usage = hole_count_w * hypotenuse;
    hole_gap = (useable_space - hole_space_usage) / (hole_count_w - 1);

    useable_space_alt = base_width - (thickness * 2) - hypotenuse - hole_gap;
    hole_space_usage_alt = (hole_count_w - 1) * hypotenuse;
    hole_gap_alt = (useable_space_alt - hole_space_usage_alt) / (hole_count_w - 2);

    for (z_pos = [thickness + hole_spacing : hypotenuse + hole_spacing : height - thickness - (hypotenuse / 2)]) {
        for (x_pos = [thickness + (hypotenuse / 2): hole_gap + hypotenuse : base_width - thickness]) {
            translate([-1, x_pos, z_pos])
                rotate([45, 0, 0])
                    color("red")
                        cube([thickness + 2, hole_size, hole_size]);
        }
    }
    for (z_pos = [thickness + (hypotenuse / 2) + (hole_spacing * 1.5) : hypotenuse + hole_spacing : height - thickness - (hypotenuse / 2)]) {
        for (x_pos = [thickness + hypotenuse + (hole_gap_alt / 2): hole_gap_alt + hypotenuse : base_width - thickness - (hypotenuse / 2) - (hole_gap / 2)]) {
            translate([-1, x_pos, z_pos])
                rotate([45, 0, 0])
                    color("blue")
                        cube([thickness + 2, hole_size, hole_size]);
        }
    }
}

module draw_holes() {
    length_cubes();
    translate([0, base_width - thickness, 0])
        length_cubes();

    width_cubes();
    translate([base_length - thickness, 0, 0])
        width_cubes();
}


difference() {
    cube([base_length, base_width, height]);
    translate([thickness, thickness, thickness])
        cube([base_length - (thickness * 2), base_width - (thickness * 2), height]);
    
    if (do_difference) {
        draw_holes();
    }
}
   
if (!do_difference) {
    draw_holes();
}