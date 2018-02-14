// Vector of Card Sets (Number of cards per set)
base_card_sets = [5, 27, 27, 27];
// Length of one card (short side)
base_card_length = 64;
// Height of one card (long side)
base_card_height = 90;
// Width / Thickness of one card
card_width = 0.4;
// A bit of nudge room for each card slot
card_nudge = 1.2;
// The width between each card slot
slot_width = 5;
// A bit of nudge roome for the length of the box
length_nudge = 1.2;
// The thickness of the box edge and base
base_edge_thickness = 2;
// If short way is true, the cards would stand taller rather than longer
short_way = true;
// Simultaneously create a lid for it
use_lid_style = true;
// When using the lid style, don't display the base
no_base = true;
// When using the lid style, don't display the lid
no_lid = false;
// Space between the base and the lid when displaying both
lid_spacer = 20;
// Connection Width
lid_con_width = 3;
// Nudge factor for the lid
lid_nudge = -0.2;
// Add a bit of nudge room to the height of the lid so cards have a bit of room above them
lid_height_nudge = 5;
// Add lid holders
make_lid_holders = true;
// Radius of holders
holder_radius = 5;
// Length of holders
holder_length = 10;
// Resolution of holders
holder_resolution = 256;

// Card Derived Values
card_sets = [ for (i = base_card_sets) (i * card_width) + card_nudge ];
card_space = sum_list(card_sets);
slot_space = slot_width * (len(card_sets) - 1);

// Box Derived Values
edge_thickness = use_lid_style ? (base_edge_thickness * 2) + lid_con_width : base_edge_thickness;
base_length = short_way ? base_card_length : base_card_height;
base_height = short_way ? base_card_height : base_card_length;
length = base_length + (edge_thickness * 2) + length_nudge;
height = (base_height * (2 / 3)) + base_edge_thickness;
width = (edge_thickness * 2) + card_space + slot_space;

if (use_lid_style && no_base) {
    translate([(-length * 2 / 2) - lid_spacer - (length / 2), -width / 2, 0])
        make_box();
} else {
    translate([-length / 2, -width / 2, 0])
        make_box(); 
}

module make_lid_insert(use_nudge=false) {
    nudge = use_nudge ? lid_nudge : 0;
    difference () {
        translate([nudge, nudge, 0])
            cube([length - (base_edge_thickness * 2) - (nudge * 2), width - (base_edge_thickness * 2) - (nudge * 2), height / 2]);
        translate([lid_con_width - nudge, lid_con_width - nudge, -1])
            cube([length - ((lid_con_width + base_edge_thickness) * 2) + (nudge * 2), width - ((lid_con_width + base_edge_thickness) * 2) + (nudge * 2), (height / 2) + 2]);
    }
}

module make_base_shape(height_modifier=1, is_lid=false) {
    h = is_lid ? (height * height_modifier) + lid_height_nudge : height * height_modifier;
    difference () {
        cube([length, width, h]);
        translate([edge_thickness, edge_thickness, base_edge_thickness])
            cube([length - (edge_thickness * 2), width - (edge_thickness * 2), h]);
    }             
}

module make_card_slots() {
    for (i = [0 : 1 : len(card_sets) - 2]) {
        set = card_sets[i];
        prev_set = i == 0 ? [0] : [ for (j = [i - 1 : -1 : 0]) card_sets[j] ];
        width = edge_thickness + set + sum_list(prev_set) + (slot_width * i);
        translate([0, width, 0])
            cube([length, slot_width, height]);
    }
}

module make_one_holder() {
    x = short_way ? 90 : 0;
    y = short_way ? 0 : 90;
    z = short_way ? 90 : 90;
    rotate([x, y, z])
        cylinder(r=holder_radius, h=holder_length, $fn=holder_resolution, center=true);
}    
module make_holders (holder_height) {
    if (short_way) {
        translate([-base_edge_thickness - (holder_length / 2 - base_edge_thickness), width / 2, holder_height - holder_radius - 2])
            make_one_holder();
        translate([length + base_edge_thickness + (holder_length / 2 - base_edge_thickness), width / 2, holder_height - holder_radius - 2])
            make_one_holder();
    } else {
        translate([length / 2, -base_edge_thickness - (holder_length / 2 - base_edge_thickness), holder_height - holder_radius - 2])
            make_one_holder();
        translate([length / 2, width + base_edge_thickness + (holder_length / 2 - base_edge_thickness), holder_height - holder_radius - 2])
            make_one_holder();
    }
}

module make_box () {
    if (use_lid_style) {
        if (!no_lid) {
            height_mod = (1 / 3);
            translate ([length + lid_spacer, 0, 0]) {
                make_base_shape(height_modifier=height_mod, is_lid=true);
                translate([base_edge_thickness, base_edge_thickness, (height * height_mod + lid_height_nudge)])
                    make_lid_insert();
            }
        }
        if (!no_base) {
            difference () {
                union () {
                    make_base_shape();
                    make_card_slots();
                }
                translate([base_edge_thickness, base_edge_thickness, base_edge_thickness + (height / 2)])
                    make_lid_insert(use_nudge=true);
            }
            if (make_lid_holders) {
                make_holders(height);
            }
        }
    } else {
        make_base_shape();
        make_card_slots();
    }
}

// Function to sum a list/vector into one value
function sum_list(v, i = 0, r = 0) = i < len(v) ? sum_list(v, i + 1, r + v[i]) : r;