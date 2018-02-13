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
slot_width = 10;
// A bit of nudge roome for the length of the box
length_nudge = 1.2;
// The thickness of the box edge and base
edge_thickness = 5;
// If short way is true, the cards would stand taller rather than longer
short_way = true;
// Use minkowski sum with a sphere to round all the edges
smoothen = false;
// How much smoothing you want. The higher, the smoother, but will take more time to process
smoothen_amount = 20;

// Card Derived Values
card_sets = [ for (i = base_card_sets) (i * card_width) + card_nudge ];
card_space = sum_list(card_sets);
slot_space = slot_width * (len(card_sets) - 1);

// Box Derived Values
base_length = short_way ? base_card_length : base_card_height;
base_height = short_way ? base_card_height : base_card_length;
length = base_length + (edge_thickness * 2) + length_nudge;
height = (base_height * (2 / 3)) + edge_thickness;
width = (edge_thickness * 2) + card_space + slot_space;


if (smoothen) {
    minkowski () {
        make_box();
        fibonacci_sphere(1, n=smoothen_amount);
    }
} else {
    make_box();
}

module make_box () {
    difference () {
        cube([length, width, height]);
        translate([edge_thickness, edge_thickness, edge_thickness])
            cube([length - (edge_thickness * 2), width - (edge_thickness * 2), height]);
    }

    for (i = [0 : 1 : len(card_sets) - 2]) {
        set = card_sets[i];
        prev_set = i == 0 ? [0] : [ for (j = [i - 1 : -1 : 0]) card_sets[j] ];
        width = edge_thickness + set + sum_list(prev_set) + (slot_width * i);
        translate([0, width, 0])
            cube([length, slot_width, height]);
    }
}

// Function to sum a list/vector into one value
function sum_list(v, i = 0, r = 0) = i < len(v) ? sum_list(v, i + 1, r + v[i]) : r;

// Module to define a sphere using fibonacci numbers somehow
module fibonacci_sphere(r, n, $fn){
    $n = n==undef? ceil((0.5*$fn*$fn)/2) : n;
    hull()
    polyhedron(points = [
        for(i=[-$n:($n-2)])
            r * _pos(i,$n)
    ], faces=[
        for(i=[0:3:2*$n])
            [i,i+1,i+2]
        // for(i=[-$n:3:($n-2)])
        //     [i+$n,i+1+$n,i+2+$n]
    ]);
}

//calculates ith vertex position on a fibonacci unit sphere of 2*n vertices
function _pos(i, n) =
	[cos(_lon(i)) * _xy(_z(i,n)), 
	 sin(_lon(i)) * _xy(_z(i,n)), 
	 _z(i,n)];

function _lon(i) = _golden_angle*i;
function _z(i,n) = 2*i/(2*n+1);
function _xy(z)  = sqrt(1-pow(z,2));

_golden_ratio = 1.61803;
_golden_angle = 360 * _golden_ratio; 