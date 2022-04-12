proc shift_to_center {} {
    set res1 [box size]
    move [expr {-[lindex $res1 0] / 2}]i [expr {-[lindex $res1 1] / 2}]i
}

proc place_nmos {x_center y_center width length nf index} {
    puts $x_center
    select clear
    box [expr $x_center]um [expr $y_center]um [expr $x_center]um [expr $y_center]um  
    magic::gencell sky130::sky130_fd_pr__nfet_01v8_lvt [format "xm%d" $index] w $width l $length nf $nf m 1 diffcov 100 polycov 60 poverlap 0 doverlap 1 topc 1 botc 1 guard 0 full_metal 0 viagate 40
    shift_to_center
}

proc place_pmos {x_center y_center width length nf index} {
    select clear
    box [expr $x_center]um [expr $y_center]um [expr $x_center]um [expr $y_center]um  
    magic::gencell sky130::sky130_fd_pr__pfet_01v8_lvt [format "xm%d" $index] w $width l $length nf $nf m 1 diffcov 100 polycov 60 poverlap 0 doverlap 1 topc 1 botc 1 guard 0 full_metal 0 viagate 40
    shift_to_center
}


load amplifier_xy
set cell_lx -15
set cell_ux 15
set cell_ly -22.5
set cell_uy 22.5

set fet_index 1

#left nmos
place_nmos 0 -6 9 2 3 $fet_index 

set fet_index [expr $fet_index + 1]

#right nmos 
place_nmos 8 -6 9 2 3 $fet_index

set fet_index [expr $fet_index + 1]

#left pmos
place_pmos 0 8 12.9 2 3 $fet_index

set fet_index [expr $fet_index + 1]

#right pmos
place_pmos 8 8 12.9 2 3 $fet_index


box -1261 100 2065 1800
paint nwell