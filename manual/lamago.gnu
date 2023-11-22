# gnuplot lamago.gnu
# epstopdf lamago.eps

set term postscript eps color
set output "lamago.eps"
set xlabel "solar zenith angle {/Symbol q} (degree)"
set ylabel "F_c_o_r_r"
set dummy sza

fj_corr1(sza) = exp(19.09 * 1.0 * (1-sza/87.5))
fj_corr2(sza) = exp(19.09 * 1.3 * (1-sza/87.5))
fj_corr3(sza) = exp(19.09 * 1.4 * (1-sza/87.5))
fj_corr4(sza) = exp(19.09 * 1.5 * (1-sza/87.5))
fj_corr5(sza) = exp(19.09 * 2.0 * (1-sza/87.5))
fj_corr6(sza) = exp(19.09 * 3.0 * (1-sza/87.5))
fj_corr7(sza) = exp(19.09 * 4.0 * (1-sza/87.5))
fj_corr8(sza) = exp(19.09 * 5.0 * (1-sza/87.5))

plot [87.5:93] fj_corr1(sza) title "b_i=1.0, fj\\_corr=1", \
               fj_corr2(sza) title "b_i=1.3, fj\\_corr=2", \
               fj_corr3(sza) title "b_i=1.4, fj\\_corr=3", \
               fj_corr4(sza) title "b_i=1.5, fj\\_corr=4", \
               fj_corr5(sza) title "b_i=2.0, fj\\_corr=5", \
               fj_corr6(sza) title "b_i=3.0, fj\\_corr=6", \
               fj_corr7(sza) title "b_i=4.0, fj\\_corr=7", \
               fj_corr8(sza) title "b_i=5.0, fj\\_corr=8"

