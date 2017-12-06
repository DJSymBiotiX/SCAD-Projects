cs = 256;

module triangle(o_len, a_len, depth)
{
    linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[a_len,0],[0,o_len]], paths=[[0,1,2]]);
    }
}

translate ([0, 0, 8]) rotate ([0, 180, 0]) {
    rotate([0, 0, 45]) translate([-8, -8, 7]) triangle(4,4,1);
    translate([-1, -9, 7]) cube([2, 8, 1]);


    difference () {
        cylinder(h=8, d=7, $fn=cs);
        cylinder(h=6.75, d=5.02, $fn=cs);
        //translate([-3.5, 0, 0]) cube([7,3.5,8]);
    }
}