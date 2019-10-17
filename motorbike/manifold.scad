/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


use <utils/shapes.scad>;


function Manifold(
     cyl_ir = 28 / 2,
     cyl_offset = 100,
     cyl_mount = 3,
     carb_ir = 32 / 2,
     carb_rise = 25,
     carb_mount = 3,
     wall_thickness = 3,
     joint_lip = 1,
     body_depth = 5) =
     [cyl_ir, cyl_offset, cyl_mount,
      carb_ir, carb_rise, carb_mount,
      wall_thickness, joint_lip,
      body_depth];


function Manifold_cyl_ir(m) = m[0];
function Manifold_cyl_or(m) = m[0] + Manifold_wall_thickness(m);
function Manifold_cyl_offset(m) = m[1];
function Manifold_cyl_mount(m) = m[2];
function Manifold_carb_ir(m) = m[3];
function Manifold_carb_or(m) = m[3] + Manifold_wall_thickness(m);
function Manifold_carb_rise(m) = m[4];
function Manifold_carb_mount(m) = m[5];
function Manifold_wall_thickness(m) = m[6];
function Manifold_joint_lip(m) = m[7];
function Manifold_body_depth(m) = m[8];


function Manifold_layout_points(m) =
     let(thick = Manifold_wall_thickness(m),
	 carb_fatlip = Manifold_carb_or(m) + thick,
	 cyl_fatlip = Manifold_cyl_or(m) + thick,
	 half_offset = (Manifold_cyl_offset(m) / 2),
	 rise = Manifold_carb_rise(m))

     [ [0, rise, carb_fatlip],
       [half_offset, 0, cyl_fatlip],
       [0, -cyl_fatlip, -carb_fatlip],
       [-half_offset, 0, cyl_fatlip] ];


module manifold_cyl_face(m, $fn=100) {
     points = Manifold_layout_points(m);
     cyl_ir = Manifold_cyl_ir(m);
     cyl_or = Manifold_cyl_or(m);
     cyl_offset = Manifold_cyl_offset(m);
     thick = Manifold_wall_thickness(m);
     lip = Manifold_joint_lip(m);
     mount_h = Manifold_cyl_mount(m);

     difference() {
	  rounded_inset_poly(points, thick, thick, lip);

	  translate([cyl_offset / 2, 0, -0.5]) {
	       cylinder(thick + 1, r=cyl_ir);
	  };
	  translate([-cyl_offset / 2, 0, -0.5]) {
	       cylinder(thick + 1, r=cyl_ir);
	  };
     };

     translate([cyl_offset / 2, 0, -mount_h]) {
	  barrel(cyl_or, mount_h, cyl_ir);
     };
     translate([-cyl_offset / 2, 0, -mount_h]) {
	  barrel(cyl_or, mount_h, cyl_ir);
     };
}


module manifold_body(m) {
     points = Manifold_layout_points(m);
     thick = Manifold_wall_thickness(m);
     body_h = Manifold_body_depth(m);

     rounded_hollow_poly(points, thick, body_h);
}


module manifold_carb_face(m, $fn=100) {
     points = Manifold_layout_points(m);
     thick = Manifold_wall_thickness(m);
     lip = Manifold_joint_lip(m);
     carb_ir = Manifold_carb_ir(m);
     carb_or = Manifold_carb_or(m);
     mount_h = Manifold_carb_mount(m);
     rise = Manifold_carb_rise(m);

     difference() {
	  rounded_inset_poly(points, thick, thick, lip);
	  translate([0, rise, -0.5]) {
	       cylinder(thick + 1, r=carb_ir);
	  };
     };
     translate([0, rise, -mount_h]) {
	  barrel(carb_or, mount_h, carb_ir);
     };
}


module manifold_demo(manifold=undef) {

     m = manifold? manifold: Manifold();

     thick = Manifold_wall_thickness(m);
     lip = Manifold_joint_lip(m);

     body_offset = thick - lip;
     carb_offset = (2 * body_offset) + Manifold_body_depth(m);

     manifold_cyl_face(m);

     #translate([0, 0, body_offset]) {
	  manifold_body(m);
     };

     translate([0, 0, carb_offset]) {
	  rotate([0, 180, 0]) {
	       manifold_carb_face(m);
	  };
     };
}


module manifold_printable(manifold=undef) {

     m = manifold? manifold: Manifold();

     translate([0,  60, 0]) {
	  manifold_body(m);
     };

     rotate([0, 180, 0]) {
	  translate([0, 0, -Manifold_wall_thickness(m)]) {
	       manifold_cyl_face(m);

	       translate([0, -60, 0]) {
		    manifold_carb_face(m);
	       };
	  };
     };
}


if($preview) {
     manifold_demo();
} else {
     manifold_printable();
}


// The end.
