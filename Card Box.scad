// Vector of Card Sets (Number of cards per set)
base_card_sets = [5 + 2, 27, 27, 27];
// Length of one card (short side)
base_card_length = 64;
// Height of one card (long side)
base_card_height = 90;
// Width / Thickness of one card
card_width = 0.4;
// A bit of nudge room for each card slot
card_nudge = 1.2;
// The width between each card slot
slot_width = 10;
// A bit of nudge roome for the length of the box
length_nudge = 1.2;
// The thickness of the box edge and base
base_edge_thickness = 5;
// If short way is true, the cards would stand taller rather than longer
short_way = true;
// Use minkowski sum with a sphere to round all the edges
smoothen = false;
// How much smoothing you want. The higher, the smoother, but will take more time to process
smoothen_amount = 10;
// Simultaneously create a lid for it
make_lid = true;
// Connection Width
lid_con_width = 5;
// Nudge factor for the lid
lid_nudge = -0.2;
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
edge_thickness = make_lid ? (base_edge_thickness * 2) + lid_con_width : base_edge_thickness;
base_length = short_way ? base_card_length : base_card_height;
base_height = short_way ? base_card_height : base_card_length;
length = base_length + (edge_thickness * 2) + length_nudge;
height = (base_height * (2 / 3)) + base_edge_thickness;
width = (edge_thickness * 2) + card_space + slot_space;


if (smoothen) {
    minkowski () {
        make_box();
        fibonacci_sphere(1, n=smoothen_amount);
    }
} else {
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

module make_base_shape(height_modifier=1) {
    difference () {
        cube([length, width, (height * height_modifier)]);
        translate([edge_thickness, edge_thickness, base_edge_thickness])
            cube([length - (edge_thickness * 2), width - (edge_thickness * 2), (height * height_modifier)]);
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
    rotate([90, 0, 90])
        cylinder(r=holder_radius, h=holder_length, $fn=holder_resolution, center=true);
}    
module make_holders (holder_height) {
    translate([-base_edge_thickness, width / 2, holder_height - holder_radius - 2])
        make_one_holder();
    translate([length + base_edge_thickness, width / 2, holder_height - holder_radius - 2])
        make_one_holder();
}

module make_box () {
    if (make_lid) {
        height_mod = 1 / 3;
        translate ([length + 20, 0, 0]) {
            make_base_shape(height_modifier=height_mod);
            translate([base_edge_thickness, base_edge_thickness, (height * height_mod)])
                make_lid_insert();
        }
        difference () {
            union () {
                make_base_shape();
                make_card_slots();
            }
            translate([base_edge_thickness, base_edge_thickness, base_edge_thickness + (height / 2)])
                make_lid_insert(use_nudge=true);
        }
        make_holders(height);
    } else {
        make_base_shape();
        make_card_slots();
    }
}

// Function to sum a list/vector into one value
function sum_list(v, i = 0, r = 0) = i < len(v) ? sum_list(v, i + 1, r + v[i]) : r;

// Module to define a sphere using fibonacci numbers somehow
module fibonacci_sphere(r, n, $fn){
    $n = n == undef ? ceil((0.5 * $fn * $fn) / 2) : n;
    hull()
    polyhedron(points = [
        for(i = [-$n : ($n - 2)])
            r * _pos(i, $n)
    ], faces=[
        for(i = [0 : 3 : 2 * $n])
            [i, i + 1, i + 2]
    ]);
}

//calculates ith vertex position on a fibonacci unit sphere of 2*n vertices
function _pos(i, n) =
	[cos(_lon(i)) * _xy(_z(i, n)), 
	 sin(_lon(i)) * _xy(_z(i, n)), 
	 _z(i, n)];

function _lon(i) = _golden_angle * i;
function _z(i,n) = 2 * i / (2 * n + 1);
function _xy(z)  = sqrt(1 - pow(z, 2));

_golden_ratio = 1.61803;
_golden_angle = 360 * _golden_ratio; 