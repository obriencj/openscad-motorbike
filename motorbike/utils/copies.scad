/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v3
*/


module copy_mirror(x=1, y=0, z=0) {
     children();
     mirror([x, y, z]) children();
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


// The end.
