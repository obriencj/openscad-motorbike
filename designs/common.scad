/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


module duplicate(move_v=[0,0,0], rotate_v=[0,0,0]) {
     children();
     translate(move_v) {
          rotate(rotate_v) {
               children();
          };
     };
}


module copy_mirror(v) {
     children();
     mirror(v) children();
}


module copy_translate(x=0, y=0, z=0, copies=1) {
     for(i = [0:copies]) {
	  translate([x * i, y * i, z * i]) {
	       children();
	  };
     };
}


module copy_rotate(x=0, y=0, z=0, copies=1) {
     for(i = [0:copies]) {
	  rotate([x * i, y * i, z * i]) {
	       children();
	  };
     };
}


module double_sided(y_axis, z_thickness) {
     translate([0, 0, z_thickness / 2]) {
          duplicate(move_v=[0, y_axis, 0],
                    rotate_v=[180, 0, 0]) {
               children();
          };
     };
}


module barrel(barrel_r, barrel_h, bore_r, $fn=100) {
     linear_extrude(barrel_h) {
	  difference() {
	       circle(r=barrel_r);
	       circle(r=bore_r);
	  };
     };
}


module rounded_plate(width, height, thickness, turn_r=5.1, $fn=50) {
     turn_d = turn_r * 2;

     translate([turn_r, turn_r, 0]) {
          linear_extrude(thickness) {
               minkowski() {
                    square([width - turn_d, height - turn_d]);
                    circle(turn_r);
               };
          };
     };
}


module words(txt_v, size=6, thick=5, spacing=0,
             font="Liberation Sans", style="Bold",
             halign="center", valign="center", $fn=50) {

     fontstyle = str(font, ":style=", style);

     lspacing = (spacing == 0)? size + 2: spacing;

     linear_extrude(height=thick) {
          for(i = [0 : len(txt_v) - 1]) {
               translate([0, i * -lspacing, 0])
                    text(txt_v[i], size=size, font=fontstyle,
                         halign=halign, valign=valign);
          };
     };
}


// The end.
