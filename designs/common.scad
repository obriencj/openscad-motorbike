/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


module copy_mirror(v=[1, 0, 0]) {
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


module _rounded_polygon(points, $fn=100) {
/*
  each point is [x, y, r] of a circle

  adapted from
  http://forum.openscad.org/Script-to-replicate-hull-and-minkoswki-for-CSG-export-import-into-FreeCAD-td16537.html#a16556
*/

     p_len = len(points);

     function p_tang(index) =
	  let(p1 = points[index],
	      p2 = points[(index + 1) % p_len],
	      r1 = p1[2],
	      r2 = p2[2],
	      dx = p2.x - p1.x,
	      dy = p2.y - p1.y,
	      d = sqrt(dx * dx + dy * dy),
	      theta = atan2(dy, dx) + acos((r1 - r2) / d))
	  [[p1.x + (cos(theta) * r1), p1.y + (sin(theta) * r1)],
	   [p2.x + (cos(theta) * r2), p2.y + (sin(theta) * r2)]];

     // all the positive radius circles
     for(p = points) {
	  if(p[2] > 0) {
	       translate([p[0], p[1]]) {
		    circle(p[2]);
	       };
	  };
     };

     difference() {
	  // a polygon connecting the tangent points between all
	  // circles in order
	  polygon([for(i = [0: p_len - 1]) for(e = p_tang(i)) e]);

	  // then subtract all the negative radius circles
	  for(p = points) {
	       if(p[2] < 0) {
		    translate([p[0], p[1]]) {
			 circle(-p[2]);
		    };
	       };
	  };
     };
}


module rounded_polygon(points, thick=0, $fn=100) {
     /*
       each point in points is a vector of [x, y, r] where r is
       positive to indicate that it is an interior point, and negative
       to indicate it is an exterior point.
     */

     if(thick > 0) {
	  linear_extrude(thick) _rounded_polygon(points, $fn);
     } else {
	  _rounded_polygon(points, $fn);
     }
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
