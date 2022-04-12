Test Monte-Carlo Simulations of sky130_fd_pr__pnp_05v5_W3p40L3p40 
.lib "/farmshare/home/classes/ee/372/PDKs/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.option seed = random
.option seedinfo
.param mc_mm_switch=1
let vsource=1.8
V1 VDD GND 'vsource' $pwl(0us, 0, 5us, V_source) 
XQ1 GND GND VDD sky130_fd_pr__pnp_05v5_W3p40L3p40 m=39

.control
    define agauss(nom, avar, sig) (nom + avar/sig * sgauss(0))
    let loopindex = 0
    dowhile loopindex < 10   $ loop starts here
        set appendwrite
        echo index is $&loopindex
        alter vsource = agauss(1.8, 0.1, 3)
        tran 0.05u 150u
        let vvdd=v(VDD)
        print vvdd
        save all
        echo index is $ & loopindex
        let loopindex = loopindex + 1
    end
    unset askquit
    quit
.endc
end