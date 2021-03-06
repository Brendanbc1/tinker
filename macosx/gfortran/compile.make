#
#
#  #############################################################
#  ##                                                         ##
#  ##  compile.make  --  compile each of the TINKER routines  ##
#  ##            (GNU gfortran for Mac OSX Version)           ##
#  ##                                                         ##
#  #############################################################
#
#
#  compile all the modules; "sizes" must be first since it is used
#  to set static array dimensions in many of the other modules
#
#
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp sizes.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp action.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp align.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp analyz.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp angang.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp angbnd.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp angpot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp angtor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp argue.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ascii.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp atmlst.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp atomid.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp atoms.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp bath.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp bitor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp bndpot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp bndstr.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp bound.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp boxes.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp cell.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp charge.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp chgpot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp chrono.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp chunks.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp couple.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp deriv.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp dipole.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp disgeo.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp dma.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp domega.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp energi.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ewald.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp faces.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp fft.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp fields.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp files.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp fracs.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp freeze.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp gkstuf.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp group.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp hescut.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp hessn.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp hpmf.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp improp.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp imptor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp inform.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp inter.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp iounit.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kanang.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kangs.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kantor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp katoms.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kbonds.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kchrge.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kdipol.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp keys.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp khbond.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kiprop.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kitors.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kmulti.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kopbnd.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kopdst.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp korbs.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kpitor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kpolr.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kstbnd.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ksttor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ktorsn.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ktrtor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kurybr.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kvdwpr.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kvdws.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp light.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp limits.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp linmin.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp math.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp mdstuf.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp merck.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp minima.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp molcul.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp moldyn.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp moment.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp mplpot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp mpole.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp mrecip.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp mutant.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp neigh.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp nonpol.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp nucleo.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp omega.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp opbend.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp opdist.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp openmp.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp orbits.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp output.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp params.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp paths.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp pbstuf.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp pdb.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp phipsi.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp piorbs.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp pistuf.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp pitors.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp pme.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp polar.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp polgrp.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp polpot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp potent.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp potfit.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp precis.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ptable.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp qmstuf.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp refer.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp resdue.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp restrn.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp rgddyn.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp rigid.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ring.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp rotbnd.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp rxnfld.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp rxnpot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp scales.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp sequen.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp shunt.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp socket.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp solute.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp stodyn.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp strbnd.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp strtor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp syntrn.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp tarray.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp titles.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp torpot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp tors.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp tortor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp tree.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp units.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp uprior.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp urey.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp urypot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp usage.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp usolve.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp valfit.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp vdw.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp vdwpot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp vibs.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp virial.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp warp.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp xtals.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp zclose.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp zcoord.f
#
#  now compile separately each of the Fortran source files
#
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp active.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp alchemy.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp analysis.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp analyze.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp angles.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp anneal.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp archive.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp attach.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp bar.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp basefile.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp beeman.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp bicubic.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp bitors.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp bonds.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp born.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp bounds.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp bussi.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp calendar.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp center.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp chkpole.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp chkring.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp chkxyz.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp cholesky.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp clock.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp cluster.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp column.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp command.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp connect.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp connolly.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp control.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp correlate.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp crystal.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp cspline.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp cutoffs.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp deflate.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp delete.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp diagq.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp diffeq.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp diffuse.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp distgeom.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp document.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp dynamic.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eangang.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eangang1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eangang2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eangang3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eangle.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eangle1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eangle2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eangle3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eangtor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eangtor1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eangtor2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eangtor3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ebond.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ebond1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ebond2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ebond3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ebuck.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ebuck1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ebuck2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ebuck3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp echarge.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp echarge1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp echarge2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp echarge3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp echgdpl.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp echgdpl1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp echgdpl2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp echgdpl3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp edipole.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp edipole1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp edipole2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp edipole3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp egauss.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp egauss1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp egauss2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp egauss3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp egeom.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp egeom1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp egeom2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp egeom3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ehal.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ehal1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ehal2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ehal3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eimprop.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eimprop1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eimprop2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eimprop3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eimptor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eimptor1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eimptor2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eimptor3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp elj.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp elj1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp elj2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp elj3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp embed.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp emetal.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp emetal1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp emetal2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp emetal3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp emm3hb.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp emm3hb1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp emm3hb2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp emm3hb3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp empole.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp empole1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp empole2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp empole3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp energy.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eopbend.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eopbend1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eopbend2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eopbend3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eopdist.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eopdist1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eopdist2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eopdist3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp epitors.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp epitors1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp epitors2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp epitors3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp epolar.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp epolar1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp epolar2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp epolar3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp erf.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp erxnfld.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp erxnfld1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp erxnfld2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp erxnfld3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp esolv.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp esolv1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp esolv2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp esolv3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp estrbnd.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp estrbnd1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp estrbnd2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp estrbnd3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp estrtor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp estrtor1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp estrtor2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp estrtor3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp etors.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp etors1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp etors2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp etors3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp etortor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp etortor1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp etortor2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp etortor3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eurey.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eurey1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eurey2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp eurey3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp evcorr.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp extra.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp extra1.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp extra2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp extra3.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp fatal.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp fft3d.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp fftpack.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp field.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp final.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp flatten.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp freeunit.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp gda.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp geometry.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp getint.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp getkey.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp getmol.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp getmol2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp getnumb.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp getpdb.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp getprm.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp getref.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp getstring.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp gettext.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp getword.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp getxyz.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ghmcstep.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp gradient.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp gradrgd.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp gradrot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp groups.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp grpline.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp gyrate.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp hessian.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp hessrgd.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp hessrot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp hybrid.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp image.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp impose.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp induce.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp inertia.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp initatom.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp initial.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp initprm.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp initres.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp initrot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp insert.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp intedit.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp intxyz.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp invbeta.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp invert.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp jacobi.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kangang.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kangle.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kangtor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp katom.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kbond.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kcharge.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kdipole.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kewald.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kextra.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kgeom.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kimprop.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kimptor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kinetic.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kmetal.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kmpole.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kopbend.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kopdist.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp korbit.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kpitors.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kpolar.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ksolv.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kstrbnd.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kstrtor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ktors.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ktortor.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kurey.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp kvdw.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp lattice.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp lbfgs.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp lights.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp makeint.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp makeref.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp makexyz.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp maxwell.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp mdinit.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp mdrest.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp mdsave.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp mdstat.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp mechanic.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp merge.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp minimize.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp minirot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp minrigid.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp molecule.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp molxyz.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp moments.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp monte.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp mutate.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp nblist.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp newton.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp newtrot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp nextarg.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp nexttext.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp nose.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp nspline.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp nucleic.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp number.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp numeral.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp numgrad.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp ocvm.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp openend.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp optimize.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp optirot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp optrigid.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp optsave.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp orbital.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp orient.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp orthog.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp overlap.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp path.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp pdbxyz.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp picalc.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp pmestuff.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp pmpb.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp polarize.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp poledit.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp polymer.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp potential.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp precise.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp pressure.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp prmedit.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp prmkey.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp promo.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp protein.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp prtdyn.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp prterr.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp prtint.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp prtmol2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp prtpdb.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp prtprm.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp prtseq.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp prtxyz.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp pss.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp pssrigid.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp pssrot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp qrfact.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp quatfit.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp radial.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp random.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp rattle.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp readdyn.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp readgau.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp readint.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp readmol.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp readmol2.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp readpdb.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp readprm.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp readseq.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp readxyz.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp replica.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp respa.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp rgdstep.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp rings.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp rmsfit.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp rotlist.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp rotpole.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp saddle.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp scan.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp sdstep.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp search.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp server.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp shakeup.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp sigmoid.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp simplex.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp sktstuff.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp sniffer.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp sort.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp spacefill.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp spectrum.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp square.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp suffix.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp superpose.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp surface.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp surfatom.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp switch.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp sybylxyz.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp temper.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp testgrad.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp testhess.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp testpair.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp testpol.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp testrot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp timer.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp timerot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp tncg.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp torphase.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp torque.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp torsfit.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp torsions.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp trimtext.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp unitcell.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp valence.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp verlet.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp version.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp vibbig.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp vibrate.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp vibrot.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp volume.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp xtalfit.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp xtalmin.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp xyzatm.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp xyzedit.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp xyzint.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp xyzpdb.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp xyzsybyl.f
gfortran -c -O3 -mssse3 -ffast-math -funroll-loops -fopenmp zatom.f
