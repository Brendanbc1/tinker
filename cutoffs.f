c
c
c     ###################################################
c     ##  COPYRIGHT (C)  1992  by  Jay William Ponder  ##
c     ##              All Rights Reserved              ##
c     ###################################################
c
c     ################################################################
c     ##                                                            ##
c     ##  subroutine cutoffs  --  set distance and Hessian cutoffs  ##
c     ##                                                            ##
c     ################################################################
c
c
c     "cutoffs" initializes and stores spherical energy cutoff
c     distance windows, Hessian element and Ewald sum cutoffs,
c     and the pairwise neighbor generation method
c
c
      subroutine cutoffs
      use sizes
      use atoms
      use keys
      use limits
      use neigh
      use polpot
      use tarray
      implicit none
      integer i,next
      real*8 value
      logical truncate
      character*20 keyword
      character*120 record
      character*120 string
c
c
c     set defaults for spherical energy cutoff distances
c
      vdwcut = 9.0d0
      chgcut = 9.0d0
      dplcut = 9.0d0
      mpolecut = 9.0d0
      ewaldcut = 7.0d0
      usolvcut = 4.5d0
c
c     set defaults for tapering, Hessian cutoff and neighbor buffers
c
      vdwtaper = 0.90d0
      chgtaper = 0.65d0
      dpltaper = 0.75d0
      mpoletaper = 0.65d0
      lbuffer = 2.0d0
      pbuffer = 2.0d0
c
c     set defaults for Ewald sum, tapering style and neighbor method
c
      use_ewald = .true.
      truncate = .false.
      use_lights = .false.
      use_list = .true.
      use_vlist = .true.
      use_clist = .false.
      use_mlist = .true.
      use_ulist = .true.
      dovlst = .true.
      doclst = .false.
      domlst = .true.
      doulst = .true.
c
c     search the keywords for various cutoff parameters
c
      do i = 1, nkey
         next = 1
         record = keyline(i)
         call gettext (record,keyword,next)
         call upcase (keyword)
         string = record(next:120)
c
c     get values related to use of Ewald summation
c
         if (keyword(1:13) .eq. 'EWALD-CUTOFF ') then
            read (string,*,err=10,end=10)  ewaldcut
c
c     get cutoff for preconditioner of dipole solver
c
         else if (keyword(1:14) .eq. 'USOLVE-CUTOFF ') then
            read (string,*,err=10,end=10)  usolvcut
c
c     get the cutoff radii for potential energy functions
c
         else if (keyword(1:7) .eq. 'CUTOFF ') then
            read (string,*,err=10,end=10)  value
            vdwcut = value
            chgcut = value
            dplcut = value
            mpolecut = value
            ewaldcut = value
         else if (keyword(1:11) .eq. 'VDW-CUTOFF ') then
            read (string,*,err=10,end=10)  vdwcut
         else if (keyword(1:11) .eq. 'CHG-CUTOFF ') then
            read (string,*,err=10,end=10)  chgcut
         else if (keyword(1:11) .eq. 'DPL-CUTOFF ') then
            read (string,*,err=10,end=10)  dplcut
         else if (keyword(1:13) .eq. 'MPOLE-CUTOFF ') then
            read (string,*,err=10,end=10)  mpolecut
c
c     get distance for initialization of energy switching
c
         else if (keyword(1:6) .eq. 'TAPER ') then
            read (string,*,err=10,end=10)  value
            vdwtaper = value
            chgtaper = value
            dpltaper = value
            mpoletaper = value
         else if (keyword(1:10) .eq. 'VDW-TAPER ') then
            read (string,*,err=10,end=10)  vdwtaper
         else if (keyword(1:10) .eq. 'CHG-TAPER ') then
            read (string,*,err=10,end=10)  chgtaper
         else if (keyword(1:10) .eq. 'DPL-TAPER ') then
            read (string,*,err=10,end=10)  dpltaper
         else if (keyword(1:12) .eq. 'MPOLE-TAPER ') then
            read (string,*,err=10,end=10)  mpoletaper
c
c     get buffer width for use with pairwise neighbor lists
c
         else if (keyword(1:12) .eq. 'LIST-BUFFER ') then
            read (string,*,err=10,end=10)  lbuffer
         else if (keyword(1:14) .eq. 'USOLVE-BUFFER ') then
            read (string,*,err=10,end=10)  pbuffer
         end if
   10    continue
      end do
c
c     preconditioner list only needed for mutual polarization
c
      usolvcut = usolvcut - pbuffer
c
c     apply any Ewald cutoff to charge and multipole terms
c
      chgcut = ewaldcut
      mpolecut = ewaldcut
c
c     convert any tapering percentages to absolute distances
c
      if (vdwtaper .lt. 1.0d0)  vdwtaper = vdwtaper * vdwcut
      if (chgtaper .lt. 1.0d0)  chgtaper = chgtaper * chgcut
      if (dpltaper .lt. 1.0d0)  dpltaper = dpltaper * dplcut
      if (mpoletaper .lt. 1.0d0)  mpoletaper = mpoletaper * mpolecut
c
c     set buffer region limits for pairwise neighbor lists
c
      lbuf2 = (0.5d0*lbuffer)**2
      pbuf2 = (0.5d0*pbuffer)**2
      vbuf2 = (vdwcut+lbuffer)**2
      cbuf2 = (chgcut+lbuffer)**2
      mbuf2 = (mpolecut+lbuffer)**2
      ubuf2 = (usolvcut+pbuffer)**2
      vbufx = (vdwcut+2.0d0*lbuffer)**2
      cbufx = (chgcut+2.0d0*lbuffer)**2
      mbufx = (mpolecut+2.0d0*lbuffer)**2
      ubufx = (usolvcut+2.0d0*pbuffer)**2
c
c     perform dynamic allocation of some global arrays
c
      if (use_vlist) then
         if (.not.allocated(nvlst))  allocate (nvlst(n))
         if (.not.allocated(vlst))  allocate (vlst(maxvlst,n))
         if (.not.allocated(xvold))  allocate (xvold(n))
         if (.not.allocated(yvold))  allocate (yvold(n))
         if (.not.allocated(zvold))  allocate (zvold(n))
      end if
      if (use_clist .or. use_mlist) then
         if (.not.allocated(nelst))  allocate (nelst(n))
         if (.not.allocated(elst))  allocate (elst(maxelst,n))
      end if
      if (use_mlist) then
         if (.not.allocated(xmold))  allocate (xmold(n))
         if (.not.allocated(ymold))  allocate (ymold(n))
         if (.not.allocated(zmold))  allocate (zmold(n))
         if (.not.allocated(tindex))  allocate (tindex(2,n*maxelst))
         if (.not.allocated(tdipdip)) allocate (tdipdip(6,n*maxelst))
      end if
      if (use_ulist) then
         if (.not.allocated(nulst))  allocate (nulst(n))
         if (.not.allocated(ulst))  allocate (ulst(maxulst,n))
         if (.not.allocated(xuold))  allocate (xuold(n))
         if (.not.allocated(yuold))  allocate (yuold(n))
         if (.not.allocated(zuold))  allocate (zuold(n))
      end if
      return
      end
