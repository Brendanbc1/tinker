c
c
c     #############################################################
c     ##  COPYRIGHT (C) 1999 by Pengyu Ren & Jay William Ponder  ##
c     ##                   All Rights Reserved                   ##
c     #############################################################
c
c     ##################################################################
c     ##                                                              ##
c     ##  subroutine empole3  --  atomic multipole energy & analysis  ##
c     ##                                                              ##
c     ##################################################################
c
c
c     "empole3" calculates the electrostatic energy due to atomic
c     multipole interactions, and partitions the energy among atoms
c
c
      subroutine empole3
      use limits
      implicit none
c
c
c     choose the method for summing over multipole interactions
c
      if (use_ewald) then
         if (use_mlist) then
            call empole3d
         else
            call empole3c
         end if
      else
         if (use_mlist) then
            call empole3b
         else
            call empole3a
         end if
      end if
      return
      end
c
c
c     ###############################################################
c     ##                                                           ##
c     ##  subroutine empole3a  --  double loop multipole analysis  ##
c     ##                                                           ##
c     ###############################################################
c
c
c     "empole3a" calculates the atomic multipole interaction energy
c     using a double loop, and partitions the energy among atoms
c
c
      subroutine empole3a
      use sizes
      use action
      use analyz
      use atomid
      use atoms
      use bound
      use boxes
      use cell
      use chgpot
      use couple
      use energi
      use group
      use inform
      use inter
      use iounit
      use math
      use molcul
      use mplpot
      use mpole
      use potent
      use shunt
      use usage
      implicit none
      integer i,j,k
      integer ii,kk
      integer ix,iy,iz
      integer kx,ky,kz
      real*8 e,f,fgrp
      real*8 r,r2,xr,yr,zr
      real*8 rr1,rr3,rr5
      real*8 rr7,rr9
      real*8 ci,dix,diy,diz
      real*8 qixx,qixy,qixz
      real*8 qiyy,qiyz,qizz
      real*8 ck,dkx,dky,dkz
      real*8 qkxx,qkxy,qkxz
      real*8 qkyy,qkyz,qkzz
      real*8 qix,qiy,qiz
      real*8 qkx,qky,qkz
      real*8 sc(10)
      real*8 gl(0:4)
      real*8, allocatable :: mscale(:)
      logical proceed
      logical header,huge
      logical usei,usek
      character*6 mode
c
c
c     zero out total atomic multipole energy and partitioning
c
      nem = 0
      em = 0.0d0
      do i = 1, n
         aem(i) = 0.0d0
      end do
      if (npole .eq. 0)  return
c
c     print header information if debug output was requested
c
      header = .true.
      if (debug .and. npole.ne.0) then
         header = .false.
         write (iout,10)
   10    format (/,' Individual Atomic Multipole Interactions :',
     &           //,' Type',14x,'Atom Names',15x,'Distance',
     &              8x,'Energy',/)
      end if
c
c     check the sign of multipole components at chiral sites
c
      call chkpole
c
c     rotate the multipole components into the global frame
c
      call rotpole
c
c     perform dynamic allocation of some local arrays
c
      allocate (mscale(n))
c
c     set arrays needed to scale connected atom interactions
c
      do i = 1, n
         mscale(i) = 1.0d0
      end do
c
c     set conversion factor, cutoff and switching coefficients
c
      f = electric / dielec
      mode = 'MPOLE'
      call switch (mode)
c
c     calculate the multipole interaction energy term
c
      do i = 1, npole-1
         ii = ipole(i)
         iz = zaxis(i)
         ix = xaxis(i)
         iy = yaxis(i)
         ci = rpole(1,i)
         dix = rpole(2,i)
         diy = rpole(3,i)
         diz = rpole(4,i)
         qixx = rpole(5,i)
         qixy = rpole(6,i)
         qixz = rpole(7,i)
         qiyy = rpole(9,i)
         qiyz = rpole(10,i)
         qizz = rpole(13,i)
         usei = (use(ii) .or. use(iz) .or. use(ix) .or. use(iy))
c
c     set interaction scaling coefficients for connected atoms
c
         do j = 1, n12(ii)
            mscale(i12(j,ii)) = m2scale
         end do
         do j = 1, n13(ii)
            mscale(i13(j,ii)) = m3scale
         end do
         do j = 1, n14(ii)
            mscale(i14(j,ii)) = m4scale
         end do
         do j = 1, n15(ii)
            mscale(i15(j,ii)) = m5scale
         end do
c
c     decide whether to compute the current interaction
c
         do k = i+1, npole
            kk = ipole(k)
            kz = zaxis(k)
            kx = xaxis(k)
            ky = yaxis(k)
            usek = (use(kk) .or. use(kz) .or. use(kx) .or. use(ky))
            proceed = .true.
            if (use_group)  call groups (proceed,fgrp,ii,kk,0,0,0,0)
            if (.not. use_intra)  proceed = .true.
            if (proceed)  proceed = (usei .or. usek)
c
c     compute the energy contribution for this interaction
c
            if (proceed) then
               xr = x(kk) - x(ii)
               yr = y(kk) - y(ii)
               zr = z(kk) - z(ii)
               if (use_bounds)  call image (xr,yr,zr)
               r2 = xr*xr + yr* yr + zr*zr
               if (r2 .le. off2) then
                  r = sqrt(r2)
                  ck = rpole(1,k)
                  dkx = rpole(2,k)
                  dky = rpole(3,k)
                  dkz = rpole(4,k)
                  qkxx = rpole(5,k)
                  qkxy = rpole(6,k)
                  qkxz = rpole(7,k)
                  qkyy = rpole(9,k)
                  qkyz = rpole(10,k)
                  qkzz = rpole(13,k)
c
c     construct some intermediate quadrupole values
c
                  qix = qixx*xr + qixy*yr + qixz*zr
                  qiy = qixy*xr + qiyy*yr + qiyz*zr
                  qiz = qixz*xr + qiyz*yr + qizz*zr
                  qkx = qkxx*xr + qkxy*yr + qkxz*zr
                  qky = qkxy*xr + qkyy*yr + qkyz*zr
                  qkz = qkxz*xr + qkyz*yr + qkzz*zr
c
c     calculate the scalar products for permanent multipoles
c
                  sc(2) = dix*dkx + diy*dky + diz*dkz
                  sc(3) = dix*xr + diy*yr + diz*zr
                  sc(4) = dkx*xr + dky*yr + dkz*zr
                  sc(5) = qix*xr + qiy*yr + qiz*zr
                  sc(6) = qkx*xr + qky*yr + qkz*zr
                  sc(7) = qix*dkx + qiy*dky + qiz*dkz
                  sc(8) = qkx*dix + qky*diy + qkz*diz
                  sc(9) = qix*qkx + qiy*qky + qiz*qkz
                  sc(10) = 2.0d0*(qixy*qkxy+qixz*qkxz+qiyz*qkyz)
     &                        + qixx*qkxx + qiyy*qkyy + qizz*qkzz
c
c     calculate the gl functions for permanent multipoles
c
                  gl(0) = ci*ck
                  gl(1) = ck*sc(3) - ci*sc(4) + sc(2)
                  gl(2) = ci*sc(6) + ck*sc(5) - sc(3)*sc(4)
     &                       + 2.0d0*(sc(7)-sc(8)+sc(10))
                  gl(3) = sc(3)*sc(6) - sc(4)*sc(5) - 4.0d0*sc(9)
                  gl(4) = sc(5)*sc(6)
c
c     get reciprocal distance terms with units and scaling
c
                  rr1 = f * mscale(kk) / r
                  rr3 = rr1 / r2
                  rr5 = 3.0d0 * rr3 / r2
                  rr7 = 5.0d0 * rr5 / r2
                  rr9 = 7.0d0 * rr7 / r2
c
c     compute the energy contribution for this interaction
c
                  e = rr1*gl(0) + rr3*gl(1) + rr5*gl(2)
     &                   + rr7*gl(3) + rr9*gl(4)
                  if (use_group)  e = e * fgrp
                  nem = nem + 1
                  em = em + e
                  aem(ii) = aem(ii) + 0.5d0*e
                  aem(kk) = aem(kk) + 0.5d0*e
c
c     increment the total intermolecular energy
c
                  if (molcule(ii) .ne. molcule(kk)) then
                     einter = einter + e
                  end if
c
c     print a message if the energy of this interaction is large
c
                  huge = (abs(e) .gt. 100.0d0)
                  if (debug .or. (verbose.and.huge)) then
                     if (header) then
                        header = .false.
                        write (iout,20)
   20                   format (/,' Individual Atomic Multipole',
     &                             ' Interactions :',
     &                          //,' Type',14x,'Atom Names',
     &                             15x,'Distance',8x,'Energy',/)
                     end if
                     write (iout,30)  ii,name(ii),kk,name(kk),r,e
   30                format (' M-Pole',4x,2(i7,'-',a3),9x,
     &                          f10.4,2x,f12.4)
                  end if
               end if
            end if
         end do
c
c     reset interaction scaling coefficients for connected atoms
c
         do j = 1, n12(ii)
            mscale(i12(j,ii)) = 1.0d0
         end do
         do j = 1, n13(ii)
            mscale(i13(j,ii)) = 1.0d0
         end do
         do j = 1, n14(ii)
            mscale(i14(j,ii)) = 1.0d0
         end do
         do j = 1, n15(ii)
            mscale(i15(j,ii)) = 1.0d0
         end do
      end do
c
c     for periodic boundary conditions with large cutoffs
c     neighbors must be found by the replicates method
c
      if (.not. use_replica)  return
c
c     calculate interaction energy with other unit cells
c
      do i = 1, npole
         ii = ipole(i)
         iz = zaxis(i)
         ix = xaxis(i)
         iy = yaxis(k)
         usei = (use(ii) .or. use(iz) .or. use(ix) .or. use(iy))
         ci = rpole(1,i)
         dix = rpole(2,i)
         diy = rpole(3,i)
         diz = rpole(4,i)
         qixx = rpole(5,i)
         qixy = rpole(6,i)
         qixz = rpole(7,i)
         qiyy = rpole(9,i)
         qiyz = rpole(10,i)
         qizz = rpole(13,i)
c
c     set interaction scaling coefficients for connected atoms
c
         do j = 1, n12(ii)
            mscale(i12(j,ii)) = m2scale
         end do
         do j = 1, n13(ii)
            mscale(i13(j,ii)) = m3scale
         end do
         do j = 1, n14(ii)
            mscale(i14(j,ii)) = m4scale
         end do
         do j = 1, n15(ii)
            mscale(i15(j,ii)) = m5scale
         end do
c
c     decide whether to compute the current interaction
c
         do k = i, npole
            kk = ipole(k)
            kz = zaxis(k)
            kx = xaxis(k)
            ky = yaxis(k)
            usek = (use(kk) .or. use(kz) .or. use(kx) .or. use(ky))
            if (use_group)  call groups (proceed,fgrp,ii,kk,0,0,0,0)
            proceed = .true.
            if (proceed)  proceed = (usei .or. usek)
c
c     compute the energy contribution for this interaction
c
            if (proceed) then
               do j = 1, ncell
                  xr = x(kk) - x(ii)
                  yr = y(kk) - y(ii)
                  zr = z(kk) - z(ii)
                  call imager (xr,yr,zr,j)
                  r2 = xr*xr + yr* yr + zr*zr
                  if (r2 .le. off2) then
                     r = sqrt(r2)
                     ck = rpole(1,k)
                     dkx = rpole(2,k)
                     dky = rpole(3,k)
                     dkz = rpole(4,k)
                     qkxx = rpole(5,k)
                     qkxy = rpole(6,k)
                     qkxz = rpole(7,k)
                     qkyy = rpole(9,k)
                     qkyz = rpole(10,k)
                     qkzz = rpole(13,k)
c
c     construct some intermediate quadrupole values
c
                     qix = qixx*xr + qixy*yr + qixz*zr
                     qiy = qixy*xr + qiyy*yr + qiyz*zr
                     qiz = qixz*xr + qiyz*yr + qizz*zr
                     qkx = qkxx*xr + qkxy*yr + qkxz*zr
                     qky = qkxy*xr + qkyy*yr + qkyz*zr
                     qkz = qkxz*xr + qkyz*yr + qkzz*zr
c
c     calculate the scalar products for permanent multipoles
c
                     sc(2) = dix*dkx + diy*dky + diz*dkz
                     sc(3) = dix*xr + diy*yr + diz*zr
                     sc(4) = dkx*xr + dky*yr + dkz*zr
                     sc(5) = qix*xr + qiy*yr + qiz*zr
                     sc(6) = qkx*xr + qky*yr + qkz*zr
                     sc(7) = qix*dkx + qiy*dky + qiz*dkz
                     sc(8) = qkx*dix + qky*diy + qkz*diz
                     sc(9) = qix*qkx + qiy*qky + qiz*qkz
                     sc(10) = 2.0d0*(qixy*qkxy+qixz*qkxz+qiyz*qkyz)
     &                           + qixx*qkxx + qiyy*qkyy + qizz*qkzz
c
c     calculate the gl functions for permanent multipoles
c
                     gl(0) = ci*ck
                     gl(1) = ck*sc(3) - ci*sc(4) + sc(2)
                     gl(2) = ci*sc(6) + ck*sc(5) - sc(3)*sc(4)
     &                          + 2.0d0*(sc(7)-sc(8)+sc(10))
                     gl(3) = sc(3)*sc(6) - sc(4)*sc(5) - 4.0d0*sc(9)
                     gl(4) = sc(5)*sc(6)
c
c     get reciprocal distance terms with units and scaling
c
                     rr1 = f * mscale(kk) / r
                     rr3 = rr1 / r2
                     rr5 = 3.0d0 * rr3 / r2
                     rr7 = 5.0d0 * rr5 / r2
                     rr9 = 7.0d0 * rr7 / r2
c
c     compute the energy contribution for this interaction
c
                     e = rr1*gl(0) + rr3*gl(1) + rr5*gl(2)
     &                      + rr7*gl(3) + rr9*gl(4)
                     if (ii .eq. kk)  e = 0.5d0 * e
                     if (use_polymer .and. r2.le.polycut2)
     &                  e = e * mscale(kk)
                     if (use_group)  e = e * fgrp
                     nem = nem + 1
                     em = em + e
                     aem(ii) = aem(ii) + 0.5d0*e
                     aem(kk) = aem(kk) + 0.5d0*e
c
c     increment the total intermolecular energy
c
                     einter = einter + e
c
c     print a message if the energy of this interaction is large
c
                     huge = (abs(e) .gt. 100.0d0)
                     if (debug .or. (verbose.and.huge)) then
                        if (header) then
                           header = .false.
                           write (iout,40)
   40                      format (/,' Individual Atomic Multipole',
     &                                ' Interactions :',
     &                             //,' Type',14x,'Atom Names',
     &                                15x,'Distance',8x,'Energy',/)
                        end if
                        write (iout,50)  ii,name(ii),kk,name(kk),r,e
   50                   format (' M-Pole',4x,2(i7,'-',a3),1x,
     &                             '(X)',5x,f10.4,2x,f12.4)
                     end if
                  end if
               end do
            end if
         end do
c
c     reset interaction scaling coefficients for connected atoms
c
         do j = 1, n12(ii)
            mscale(i12(j,ii)) = 1.0d0
         end do
         do j = 1, n13(ii)
            mscale(i13(j,ii)) = 1.0d0
         end do
         do j = 1, n14(ii)
            mscale(i14(j,ii)) = 1.0d0
         end do
         do j = 1, n15(ii)
            mscale(i15(j,ii)) = 1.0d0
         end do
      end do
c
c     perform deallocation of some local arrays
c
      deallocate (mscale)
      return
      end
c
c
c     #################################################################
c     ##                                                             ##
c     ##  subroutine empole3b  --  neighbor list multipole analysis  ##
c     ##                                                             ##
c     #################################################################
c
c
c     "empole3b" calculates the atomic multipole interaction energy
c     using a neighbor list, and partitions the energy among the atoms
c
c
      subroutine empole3b
      use sizes
      use action
      use analyz
      use atomid
      use atoms
      use bound
      use boxes
      use chgpot
      use couple
      use energi
      use group
      use inform
      use inter
      use iounit
      use math
      use molcul
      use mplpot
      use mpole
      use neigh
      use potent
      use shunt
      use usage
      implicit none
      integer i,j,k
      integer ii,kk,kkk
      integer ix,iy,iz
      integer kx,ky,kz
      integer nemo
      real*8 e,f,fgrp
      real*8 r,r2,xr,yr,zr
      real*8 rr1,rr3,rr5
      real*8 rr7,rr9
      real*8 ci,dix,diy,diz
      real*8 qixx,qixy,qixz
      real*8 qiyy,qiyz,qizz
      real*8 ck,dkx,dky,dkz
      real*8 qkxx,qkxy,qkxz
      real*8 qkyy,qkyz,qkzz
      real*8 qix,qiy,qiz
      real*8 qkx,qky,qkz
      real*8 emo,eintero
      real*8 sc(10)
      real*8 gl(0:4)
      real*8, allocatable :: mscale(:)
      real*8, allocatable :: aemo(:)
      logical proceed
      logical header,huge
      logical usei,usek
      character*6 mode
c
c
c     zero out total atomic multipole energy and partitioning
c
      nem = 0
      em = 0.0d0
      do i = 1, n
         aem(i) = 0.0d0
      end do
c
c     print header information if debug output was requested
c
      header = .true.
      if (debug .and. npole.ne.0) then
         header = .false.
         write (iout,10)
   10    format (/,' Individual Atomic Multipole Interactions :',
     &           //,' Type',14x,'Atom Names',15x,'Distance',
     &              8x,'Energy',/)
      end if
c
c     check the sign of multipole components at chiral sites
c
      call chkpole
c
c     rotate the multipole components into the global frame
c
      call rotpole
c
c     perform dynamic allocation of some local arrays
c
      allocate (mscale(n))
      allocate (aemo(n))
c
c     set arrays needed to scale connected atom interactions
c
      do i = 1, n
         mscale(i) = 1.0d0
      end do
c
c     set conversion factor, cutoff and switching coefficients
c
      f = electric / dielec
      mode = 'MPOLE'
      call switch (mode)
c
c     initialize local variables for OpenMP calculation
c
      emo = 0.0d0
      eintero = einter
      nemo = nem
      do i = 1, n
         aemo(i) = aem(i)
      end do
c
c     set OpenMP directives for the major loop structure
c
!$OMP PARALLEL default(shared) firstprivate(f)
!$OMP& private(i,j,k,ii,ix,iy,iz,usei,kk,kx,ky,kz,usek,kkk,proceed,e,
!$OMP& xr,yr,zr,r,r2,rr1,rr3,rr5,rr7,rr9,ci,dix,diy,diz,qix,qiy,qiz,
!$OMP& qixx,qixy,qixz,qiyy,qiyz,qizz,ck,dkx,dky,dkz,qkx,qky,qkz,
!$OMP& qkxx,qkxy,qkxz,qkyy,qkyz,qkzz,fgrp,sc,gl)
!$OMP& firstprivate(mscale)
!$OMP DO reduction(+:emo,eintero,nemo,aemo)
!$OMP& schedule(guided)
c
c     calculate the multipole interaction energy term
c
      do i = 1, npole-1
         ii = ipole(i)
         iz = zaxis(i)
         ix = xaxis(i)
         iy = yaxis(i)
         ci = rpole(1,i)
         dix = rpole(2,i)
         diy = rpole(3,i)
         diz = rpole(4,i)
         qixx = rpole(5,i)
         qixy = rpole(6,i)
         qixz = rpole(7,i)
         qiyy = rpole(9,i)
         qiyz = rpole(10,i)
         qizz = rpole(13,i)
         usei = (use(ii) .or. use(iz) .or. use(ix) .or. use(iy))
c
c     set interaction scaling coefficients for connected atoms
c
         do j = 1, n12(ii)
            mscale(i12(j,ii)) = m2scale
         end do
         do j = 1, n13(ii)
            mscale(i13(j,ii)) = m3scale
         end do
         do j = 1, n14(ii)
            mscale(i14(j,ii)) = m4scale
         end do
         do j = 1, n15(ii)
            mscale(i15(j,ii)) = m5scale
         end do
c
c     decide whether to compute the current interaction
c
         do kkk = 1, nelst(i)
            k = elst(kkk,i)
            kk = ipole(k)
            kz = zaxis(k)
            kx = xaxis(k)
            ky = yaxis(k)
            usek = (use(kk) .or. use(kz) .or. use(kx) .or. use(ky))
            proceed = .true.
            if (use_group)  call groups (proceed,fgrp,ii,kk,0,0,0,0)
            if (.not. use_intra)  proceed = .true.
            if (proceed)  proceed = (usei .or. usek)
c
c     compute the energy contribution for this interaction
c
            if (proceed) then
               xr = x(kk) - x(ii)
               yr = y(kk) - y(ii)
               zr = z(kk) - z(ii)
               if (use_bounds)  call image (xr,yr,zr)
               r2 = xr*xr + yr* yr + zr*zr
               if (r2 .le. off2) then
                  r = sqrt(r2)
                  ck = rpole(1,k)
                  dkx = rpole(2,k)
                  dky = rpole(3,k)
                  dkz = rpole(4,k)
                  qkxx = rpole(5,k)
                  qkxy = rpole(6,k)
                  qkxz = rpole(7,k)
                  qkyy = rpole(9,k)
                  qkyz = rpole(10,k)
                  qkzz = rpole(13,k)
c
c     construct some intermediate quadrupole values
c
                  qix = qixx*xr + qixy*yr + qixz*zr
                  qiy = qixy*xr + qiyy*yr + qiyz*zr
                  qiz = qixz*xr + qiyz*yr + qizz*zr
                  qkx = qkxx*xr + qkxy*yr + qkxz*zr
                  qky = qkxy*xr + qkyy*yr + qkyz*zr
                  qkz = qkxz*xr + qkyz*yr + qkzz*zr
c
c     calculate the scalar products for permanent multipoles
c
                  sc(2) = dix*dkx + diy*dky + diz*dkz
                  sc(3) = dix*xr + diy*yr + diz*zr
                  sc(4) = dkx*xr + dky*yr + dkz*zr
                  sc(5) = qix*xr + qiy*yr + qiz*zr
                  sc(6) = qkx*xr + qky*yr + qkz*zr
                  sc(7) = qix*dkx + qiy*dky + qiz*dkz
                  sc(8) = qkx*dix + qky*diy + qkz*diz
                  sc(9) = qix*qkx + qiy*qky + qiz*qkz
                  sc(10) = 2.0d0*(qixy*qkxy+qixz*qkxz+qiyz*qkyz)
     &                        + qixx*qkxx + qiyy*qkyy + qizz*qkzz
c
c     calculate the gl functions for permanent multipoles
c
                  gl(0) = ci*ck
                  gl(1) = ck*sc(3) - ci*sc(4) + sc(2)
                  gl(2) = ci*sc(6) + ck*sc(5) - sc(3)*sc(4)
     &                       + 2.0d0*(sc(7)-sc(8)+sc(10))
                  gl(3) = sc(3)*sc(6) - sc(4)*sc(5) - 4.0d0*sc(9)
                  gl(4) = sc(5)*sc(6)
c
c     get reciprocal distance terms with units and scaling
c
                  rr1 = f * mscale(kk) / r
                  rr3 = rr1 / r2
                  rr5 = 3.0d0 * rr3 / r2
                  rr7 = 5.0d0 * rr5 / r2
                  rr9 = 7.0d0 * rr7 / r2
c
c     compute the energy contribution for this interaction
c
                  e = rr1*gl(0) + rr3*gl(1) + rr5*gl(2)
     &                   + rr7*gl(3) + rr9*gl(4)
                  if (use_group)  e = e * fgrp
                  nemo = nemo + 1
                  emo = emo + e
                  aemo(ii) = aemo(ii) + 0.5d0*e
                  aemo(kk) = aemo(kk) + 0.5d0*e
c
c     increment the total intermolecular energy
c
                  if (molcule(ii) .ne. molcule(kk)) then
                     eintero = eintero + e
                  end if
c
c     print a message if the energy of this interaction is large
c
                  huge = (abs(e) .gt. 100.0d0)
                  if (debug .or. (verbose.and.huge)) then
                     if (header) then
                        header = .false.
                        write (iout,20)
   20                   format (/,' Individual Atomic Multipole',
     &                             ' Interactions :',
     &                          //,' Type',14x,'Atom Names',
     &                             15x,'Distance',8x,'Energy',/)
                     end if
                     write (iout,30)  ii,name(ii),kk,name(kk),r,e
   30                format (' M-Pole',4x,2(i7,'-',a3),9x,
     &                          f10.4,2x,f12.4)
                  end if
               end if
            end if
         end do
c
c     reset interaction scaling coefficients for connected atoms
c
         do j = 1, n12(ii)
            mscale(i12(j,ii)) = 1.0d0
         end do
         do j = 1, n13(ii)
            mscale(i13(j,ii)) = 1.0d0
         end do
         do j = 1, n14(ii)
            mscale(i14(j,ii)) = 1.0d0
         end do
         do j = 1, n15(ii)
            mscale(i15(j,ii)) = 1.0d0
         end do
      end do
c
c     end OpenMP directives for the major loop structure
c
!$OMP END DO
!$OMP END PARALLEL
c
c     add local copies to global variables for OpenMP calculation
c
      em = em + emo
      einter = eintero
      nem = nemo
      do i = 1, n
         aem(i) = aemo(i)
      end do
c
c     perform deallocation of some local arrays
c
      deallocate (mscale)
      deallocate (aemo)
      return
      end
c
c
c     ##################################################################
c     ##                                                              ##
c     ##  subroutine empole3c  --  Ewald multipole analysis via loop  ##
c     ##                                                              ##
c     ##################################################################
c
c
c     "empole3c" calculates the atomic multipole interaction energy
c     using a particle mesh Ewald summation and double loop, and
c     partitions the energy among the atoms
c
c
      subroutine empole3c
      use sizes
      use action
      use analyz
      use atoms
      use boxes
      use chgpot
      use energi
      use ewald
      use inter
      use math
      use mpole
      implicit none
      integer i,ii
      real*8 e,eintra
      real*8 f,term,fterm
      real*8 cii,dii,qii
      real*8 xd,yd,zd
      real*8 ci,dix,diy,diz
      real*8 qixx,qixy,qixz
      real*8 qiyy,qiyz,qizz
c
c
c     zero out the multipole and polarization energies
c
      nem = 0
      em = 0.0d0
      do i = 1, n
         aem(i) = 0.0d0
      end do
      if (npole .eq. 0)  return
c
c     set the energy unit conversion factor
c
      f = electric / dielec
c
c     check the sign of multipole components at chiral sites
c
      call chkpole
c
c     rotate the multipole components into the global frame
c
      call rotpole
c
c     compute the reciprocal space part of the Ewald summation
c
      call emrecip3
c
c     compute the real space part of the Ewald summation
c
      call ereal3c (eintra)
c
c     compute the self-energy part of the Ewald summation
c
      term = 2.0d0 * aewald * aewald
      fterm = -f * aewald / sqrtpi
      do i = 1, npole
         ci = rpole(1,i)
         dix = rpole(2,i)
         diy = rpole(3,i)
         diz = rpole(4,i)
         qixx = rpole(5,i)
         qixy = rpole(6,i)
         qixz = rpole(7,i)
         qiyy = rpole(9,i)
         qiyz = rpole(10,i)
         qizz = rpole(13,i)
         cii = ci*ci
         dii = dix*dix + diy*diy + diz*diz
         qii = qixx*qixx + qiyy*qiyy + qizz*qizz
     &            + 2.0d0*(qixy*qixy+qixz*qixz+qiyz*qiyz)
         e = fterm * (cii + term*(dii/3.0d0+2.0d0*term*qii/5.0d0))
         nem = nem + 1
         em = em + e
         aem(i) = aem(i) + e
      end do
c
c     compute the cell dipole boundary correction term
c
      if (boundary .eq. 'VACUUM') then
         xd = 0.0d0
         yd = 0.0d0
         zd = 0.0d0
         do i = 1, npole
            ii = ipole(i)
            dix = rpole(2,i)
            diy = rpole(3,i)
            diz = rpole(4,i)
            xd = xd + dix + rpole(1,i)*x(ii)
            yd = yd + diy + rpole(1,i)*y(ii)
            zd = zd + diz + rpole(1,i)*z(ii)
         end do
         e = (2.0d0/3.0d0) * f * (pi/volbox) * (xd*xd+yd*yd+zd*zd)
         nem = nem + 1
         em = em + e
         do i = 1, npole
            ii = ipole(i)
            aem(ii) = aem(ii) + e/dble(npole)
         end do
      end if
c
c     intermolecular energy is total minus intramolecular part
c
      einter = einter + em - eintra
      return
      end
c
c
c     ##################################################################
c     ##                                                              ##
c     ##  subroutine ereal3c  --  real space mpole analysis via loop  ##
c     ##                                                              ##
c     ##################################################################
c
c
c     "ereal3c" evaluates the real space portion of the Ewald sum
c     energy due to atomic multipole interactions and partitions
c     the energy among the atoms
c
c     literature reference:
c
c     W. Smith, "Point Multipoles in the Ewald Summation (Revisited)",
c     CCP5 Newsletter, 46, 18-30, 1998  (see http://www.ccp5.org/)
c
c
      subroutine ereal3c (eintra)
      use sizes
      use action
      use analyz
      use atomid
      use atoms
      use bound
      use boxes
      use cell
      use chgpot
      use couple
      use energi
      use ewald
      use inform
      use iounit
      use math
      use molcul
      use mplpot
      use mpole
      use potent
      use shunt
      implicit none
      integer i,j,k,m
      integer ii,kk
      real*8 e,eintra
      real*8 efull
      real*8 f,erfc
      real*8 r,r2,xr,yr,zr
      real*8 bfac,exp2a
      real*8 ralpha,scalekk
      real*8 alsq2,alsq2n
      real*8 rr1,rr3,rr5
      real*8 rr7,rr9
      real*8 ci,dix,diy,diz
      real*8 qixx,qixy,qixz
      real*8 qiyy,qiyz,qizz
      real*8 ck,dkx,dky,dkz
      real*8 qkxx,qkxy,qkxz
      real*8 qkyy,qkyz,qkzz
      real*8 qix,qiy,qiz
      real*8 qkx,qky,qkz
      real*8 sc(10)
      real*8 gl(0:4)
      real*8 bn(0:4)
      real*8, allocatable :: mscale(:)
      logical header,huge
      character*6 mode
      external erfc
c
c
c     zero out the intramolecular portion of the Ewald energy
c
      eintra = 0.0d0
c
c     print header information if debug output was requested
c
      header = .true.
      if (debug .and. npole.ne.0) then
         header = .false.
         write (iout,10)
   10    format (/,' Individual Atomic Multipole Interactions :',
     &           //,' Type',14x,'Atom Names',15x,'Distance',
     &              8x,'Energy',/)
      end if
c
c     perform dynamic allocation of some local arrays
c
      allocate (mscale(n))
c
c     set arrays needed to scale connected atom interactions
c
      do i = 1, n
         mscale(i) = 1.0d0
      end do
c
c     set conversion factor, cutoff and switching coefficients
c
      f = electric / dielec
      mode = 'EWALD'
      call switch (mode)
c
c     compute the real space portion of the Ewald summation
c
      do i = 1, npole-1
         ii = ipole(i)
         ci = rpole(1,i)
         dix = rpole(2,i)
         diy = rpole(3,i)
         diz = rpole(4,i)
         qixx = rpole(5,i)
         qixy = rpole(6,i)
         qixz = rpole(7,i)
         qiyy = rpole(9,i)
         qiyz = rpole(10,i)
         qizz = rpole(13,i)
c
c     set interaction scaling coefficients for connected atoms
c
         do j = 1, n12(ii)
            mscale(i12(j,ii)) = m2scale
         end do
         do j = 1, n13(ii)
            mscale(i13(j,ii)) = m3scale
         end do
         do j = 1, n14(ii)
            mscale(i14(j,ii)) = m4scale
         end do
         do j = 1, n15(ii)
            mscale(i15(j,ii)) = m5scale
         end do
         do k = i+1, npole
            kk = ipole(k)
            xr = x(kk) - x(ii)
            yr = y(kk) - y(ii)
            zr = z(kk) - z(ii)
            call image (xr,yr,zr)
            r2 = xr*xr + yr* yr + zr*zr
            if (r2 .le. off2) then
               r = sqrt(r2)
               ck = rpole(1,k)
               dkx = rpole(2,k)
               dky = rpole(3,k)
               dkz = rpole(4,k)
               qkxx = rpole(5,k)
               qkxy = rpole(6,k)
               qkxz = rpole(7,k)
               qkyy = rpole(9,k)
               qkyz = rpole(10,k)
               qkzz = rpole(13,k)
c
c     calculate the error function damping terms
c
               ralpha = aewald * r
               bn(0) = erfc(ralpha) / r
               alsq2 = 2.0d0 * aewald**2
               alsq2n = 0.0d0
               if (aewald .gt. 0.0d0)
     &            alsq2n = 1.0d0 / (sqrtpi*aewald)
               exp2a = exp(-ralpha**2)
               do m = 1, 4
                  bfac = dble(m+m-1)
                  alsq2n = alsq2 * alsq2n
                  bn(m) = (bfac*bn(m-1)+alsq2n*exp2a) / r2
               end do
c
c     construct some intermediate quadrupole values
c
               qix = qixx*xr + qixy*yr + qixz*zr
               qiy = qixy*xr + qiyy*yr + qiyz*zr
               qiz = qixz*xr + qiyz*yr + qizz*zr
               qkx = qkxx*xr + qkxy*yr + qkxz*zr
               qky = qkxy*xr + qkyy*yr + qkyz*zr
               qkz = qkxz*xr + qkyz*yr + qkzz*zr
c
c     calculate the scalar products for permanent multipoles
c
               sc(2) = dix*dkx + diy*dky + diz*dkz
               sc(3) = dix*xr + diy*yr + diz*zr
               sc(4) = dkx*xr + dky*yr + dkz*zr
               sc(5) = qix*xr + qiy*yr + qiz*zr
               sc(6) = qkx*xr + qky*yr + qkz*zr
               sc(7) = qix*dkx + qiy*dky + qiz*dkz
               sc(8) = qkx*dix + qky*diy + qkz*diz
               sc(9) = qix*qkx + qiy*qky + qiz*qkz
               sc(10) = 2.0d0*(qixy*qkxy+qixz*qkxz+qiyz*qkyz)
     &                     + qixx*qkxx + qiyy*qkyy + qizz*qkzz
c
c     calculate the gl functions for permanent multipoles
c
               gl(0) = ci*ck
               gl(1) = ck*sc(3) - ci*sc(4) + sc(2)
               gl(2) = ci*sc(6) + ck*sc(5) - sc(3)*sc(4)
     &                    + 2.0d0*(sc(7)-sc(8)+sc(10))
               gl(3) = sc(3)*sc(6) - sc(4)*sc(5) - 4.0d0*sc(9)
               gl(4) = sc(5)*sc(6)
c
c     get reciprocal distance terms as unscaled values
c
               rr1 = 1.0d0 / r
               rr3 = rr1 / r2
               rr5 = 3.0d0 * rr3 / r2
               rr7 = 5.0d0 * rr5 / r2
               rr9 = 7.0d0 * rr7 / r2
c
c     compute the full undamped permanent multipole energy
c
               efull = rr1*gl(0) + rr3*gl(1) + rr5*gl(2)
     &                    + rr7*gl(3) + rr9*gl(4)
               efull = f * mscale(kk) * efull
c
c     modify error function terms by scaled true distance
c
               scalekk = 1.0d0 - mscale(kk)
               rr1 = f * (bn(0)-scalekk*rr1)
               rr3 = f * (bn(1)-scalekk*rr3)
               rr5 = f * (bn(2)-scalekk*rr5)
               rr7 = f * (bn(3)-scalekk*rr7)
               rr9 = f * (bn(4)-scalekk*rr9)
c
c     compute the energy contribution for this interaction
c
               e = rr1*gl(0) + rr3*gl(1) + rr5*gl(2)
     &                + rr7*gl(3) + rr9*gl(4)
               nem = nem + 1
               em = em + e
               aem(ii) = aem(ii) + 0.5d0*e
               aem(kk) = aem(kk) + 0.5d0*e
c
c     increment the total intramolecular energy
c
               if (molcule(ii) .eq. molcule(kk)) then
                  eintra = eintra + efull
               end if
c
c     print a message if the energy of this interaction is large
c
               huge = (abs(efull) .gt. 100.0d0)
               if (debug .or. (verbose.and.huge)) then
                  if (header) then
                     header = .false.
                     write (iout,20)
   20                format (/,' Individual Real Space Multipole',
     &                          ' Interactions :',
     &                       //,' Type',14x,'Atom Names',
     &                          15x,'Distance',8x,'Energy',/)
                  end if
                  write (iout,30)  ii,name(ii),kk,name(kk),r,efull
   30             format (' M-Pole',4x,2(i7,'-',a3),9x,
     &                       f10.4,2x,f12.4)
               end if
            end if
         end do
c
c     reset interaction scaling coefficients for connected atoms
c
         do j = 1, n12(ii)
            mscale(i12(j,ii)) = 1.0d0
         end do
         do j = 1, n13(ii)
            mscale(i13(j,ii)) = 1.0d0
         end do
         do j = 1, n14(ii)
            mscale(i14(j,ii)) = 1.0d0
         end do
         do j = 1, n15(ii)
            mscale(i15(j,ii)) = 1.0d0
         end do
      end do
c
c     for periodic boundary conditions with large cutoffs
c     neighbors must be found by the replicates method
c
      if (.not. use_replica)  return
c
c     calculate interaction energy with other unit cells
c
      do i = 1, npole
         ii = ipole(i)
         ci = rpole(1,i)
         dix = rpole(2,i)
         diy = rpole(3,i)
         diz = rpole(4,i)
         qixx = rpole(5,i)
         qixy = rpole(6,i)
         qixz = rpole(7,i)
         qiyy = rpole(9,i)
         qiyz = rpole(10,i)
         qizz = rpole(13,i)
c
c     set interaction scaling coefficients for connected atoms
c
         do j = 1, n12(ii)
            mscale(i12(j,ii)) = m2scale
         end do
         do j = 1, n13(ii)
            mscale(i13(j,ii)) = m3scale
         end do
         do j = 1, n14(ii)
            mscale(i14(j,ii)) = m4scale
         end do
         do j = 1, n15(ii)
            mscale(i15(j,ii)) = m5scale
         end do
         do k = i, npole
            kk = ipole(k)
            do j = 1, ncell
               xr = x(kk) - x(ii)
               yr = y(kk) - y(ii)
               zr = z(kk) - z(ii)
               call imager (xr,yr,zr,j)
               r2 = xr*xr + yr* yr + zr*zr
               if (r2 .le. off2) then
                  r = sqrt(r2)
                  ck = rpole(1,k)
                  dkx = rpole(2,k)
                  dky = rpole(3,k)
                  dkz = rpole(4,k)
                  qkxx = rpole(5,k)
                  qkxy = rpole(6,k)
                  qkxz = rpole(7,k)
                  qkyy = rpole(9,k)
                  qkyz = rpole(10,k)
                  qkzz = rpole(13,k)
c
c     calculate the error function damping terms
c
                  ralpha = aewald * r
                  bn(0) = erfc(ralpha) / r
                  alsq2 = 2.0d0 * aewald**2
                  alsq2n = 0.0d0
                  if (aewald .gt. 0.0d0)
     &               alsq2n = 1.0d0 / (sqrtpi*aewald)
                  exp2a = exp(-ralpha**2)
                  do m = 1, 4
                     bfac = dble(m+m-1)
                     alsq2n = alsq2 * alsq2n
                     bn(m) = (bfac*bn(m-1)+alsq2n*exp2a) / r2
                  end do
c
c     construct some intermediate quadrupole values
c
                  qix = qixx*xr + qixy*yr + qixz*zr
                  qiy = qixy*xr + qiyy*yr + qiyz*zr
                  qiz = qixz*xr + qiyz*yr + qizz*zr
                  qkx = qkxx*xr + qkxy*yr + qkxz*zr
                  qky = qkxy*xr + qkyy*yr + qkyz*zr
                  qkz = qkxz*xr + qkyz*yr + qkzz*zr
c
c     calculate the scalar products for permanent multipoles
c
                  sc(2) = dix*dkx + diy*dky + diz*dkz
                  sc(3) = dix*xr + diy*yr + diz*zr
                  sc(4) = dkx*xr + dky*yr + dkz*zr
                  sc(5) = qix*xr + qiy*yr + qiz*zr
                  sc(6) = qkx*xr + qky*yr + qkz*zr
                  sc(7) = qix*dkx + qiy*dky + qiz*dkz
                  sc(8) = qkx*dix + qky*diy + qkz*diz
                  sc(9) = qix*qkx + qiy*qky + qiz*qkz
                  sc(10) = 2.0d0*(qixy*qkxy+qixz*qkxz+qiyz*qkyz)
     &                        + qixx*qkxx + qiyy*qkyy + qizz*qkzz
c
c     calculate the gl functions for permanent multipoles
c
                  gl(0) = ci*ck
                  gl(1) = ck*sc(3) - ci*sc(4) + sc(2)
                  gl(2) = ci*sc(6) + ck*sc(5) - sc(3)*sc(4)
     &                       + 2.0d0*(sc(7)-sc(8)+sc(10))
                  gl(3) = sc(3)*sc(6) - sc(4)*sc(5) - 4.0d0*sc(9)
                  gl(4) = sc(5)*sc(6)
c
c     get reciprocal distance terms as unscaled values
c
                  rr1 = 1.0d0 / r
                  rr3 = rr1 / r2
                  rr5 = 3.0d0 * rr3 / r2
                  rr7 = 5.0d0 * rr5 / r2
                  rr9 = 7.0d0 * rr7 / r2
c
c     compute the full undamped permanent multipole energy
c
                  efull = rr1*gl(0) + rr3*gl(1) + rr5*gl(2)
     &                       + rr7*gl(3) + rr9*gl(4)
                  efull = f * efull
c
c     modify error function terms by scaled true distance
c
                  scalekk = 1.0d0 - mscale(kk)
                  rr1 = f * (bn(0)-scalekk*rr1)
                  rr3 = f * (bn(1)-scalekk*rr3)
                  rr5 = f * (bn(2)-scalekk*rr5)
                  rr7 = f * (bn(3)-scalekk*rr7)
                  rr9 = f * (bn(4)-scalekk*rr9)
c
c     compute the energy contribution for this interaction
c
                  e = rr1*gl(0) + rr3*gl(1) + rr5*gl(2)
     &                   + rr7*gl(3) + rr9*gl(4)
                  if (use_polymer .and. r2.le.polycut2)
     &               e = e - efull*(1.0d0-mscale(kk))
                  if (ii .eq. kk)  e = 0.5d0 * e
                  nem = nem + 1
                  em = em + e
                  aem(ii) = aem(ii) + 0.5d0*e
                  aem(kk) = aem(kk) + 0.5d0*e
c
c     print a message if the energy of this interaction is large
c
                  efull = efull * mscale(kk)
                  huge = (abs(efull) .gt. 100.0d0)
                  if (debug .or. (verbose.and.huge)) then
                     if (header) then
                        header = .false.
                        write (iout,40)
   40                   format (/,' Individual Real Space Multipole',
     &                             ' Interactions :',
     &                          //,' Type',14x,'Atom Names',
     &                             15x,'Distance',8x,'Energy',/)
                     end if
                     write (iout,50)  ii,name(ii),kk,name(kk),r,efull
   50                format (' M-Pole',4x,2(i7,'-',a3),1x,
     &                          '(X)',5x,f10.4,2x,f12.4)
                  end if
               end if
            end do
         end do
c
c     reset interaction scaling coefficients for connected atoms
c
         do j = 1, n12(ii)
            mscale(i12(j,ii)) = 1.0d0
         end do
         do j = 1, n13(ii)
            mscale(i13(j,ii)) = 1.0d0
         end do
         do j = 1, n14(ii)
            mscale(i14(j,ii)) = 1.0d0
         end do
         do j = 1, n15(ii)
            mscale(i15(j,ii)) = 1.0d0
         end do
      end do
c
c     perform deallocation of some local arrays
c
      deallocate (mscale)
      return
      end
c
c
c     ##################################################################
c     ##                                                              ##
c     ##  subroutine empole3d  --  Ewald multipole analysis via list  ##
c     ##                                                              ##
c     ##################################################################
c
c
c     "empole3d" calculates the atomic multipole interaction energy
c     using particle mesh Ewald summation and a neighbor list, and
c     partitions the energy among the atoms
c
c
      subroutine empole3d
      use sizes
      use action
      use analyz
      use atoms
      use boxes
      use chgpot
      use energi
      use ewald
      use inter
      use math
      use mpole
      implicit none
      integer i,ii
      real*8 e,eintra
      real*8 f,term,fterm
      real*8 cii,dii,qii
      real*8 xd,yd,zd
      real*8 ci,dix,diy,diz
      real*8 qixx,qixy,qixz
      real*8 qiyy,qiyz,qizz
c
c
c     zero out the multipole and polarization energies
c
      nem = 0
      em = 0.0d0
      do i = 1, n
         aem(i) = 0.0d0
      end do
      if (npole .eq. 0)  return
c
c     set the energy unit conversion factor
c
      f = electric / dielec
c
c     check the sign of multipole components at chiral sites
c
      call chkpole
c
c     rotate the multipole components into the global frame
c
      call rotpole
c
c     compute the reciprocal space part of the Ewald summation
c
      call emrecip3
c
c     compute the real space part of the Ewald summation
c
      call ereal3d (eintra)
c
c     compute the self-energy part of the Ewald summation
c
      term = 2.0d0 * aewald * aewald
      fterm = -f * aewald / sqrtpi
      do i = 1, npole
         ci = rpole(1,i)
         dix = rpole(2,i)
         diy = rpole(3,i)
         diz = rpole(4,i)
         qixx = rpole(5,i)
         qixy = rpole(6,i)
         qixz = rpole(7,i)
         qiyy = rpole(9,i)
         qiyz = rpole(10,i)
         qizz = rpole(13,i)
         cii = ci*ci
         dii = dix*dix + diy*diy + diz*diz
         qii = qixx*qixx + qiyy*qiyy + qizz*qizz
     &            + 2.0d0*(qixy*qixy+qixz*qixz+qiyz*qiyz)
         e = fterm * (cii + term*(dii/3.0d0+2.0d0*term*qii/5.0d0))
         nem = nem + 1
         em = em + e
         aem(i) = aem(i) + e
      end do
c
c     compute the cell dipole boundary correction term
c
      if (boundary .eq. 'VACUUM') then
         xd = 0.0d0
         yd = 0.0d0
         zd = 0.0d0
         do i = 1, npole
            ii = ipole(i)
            dix = rpole(2,i)
            diy = rpole(3,i)
            diz = rpole(4,i)
            xd = xd + dix + rpole(1,i)*x(ii)
            yd = yd + diy + rpole(1,i)*y(ii)
            zd = zd + diz + rpole(1,i)*z(ii)
         end do
         e = (2.0d0/3.0d0) * f * (pi/volbox) * (xd*xd+yd*yd+zd*zd)
         nem = nem + 1
         em = em + e
         do i = 1, npole
            ii = ipole(i)
            aem(ii) = aem(ii) + e/dble(npole)
         end do
      end if
c
c     intermolecular energy is total minus intramolecular part
c
      einter = einter + em - eintra
      return
      end
c
c
c     ##################################################################
c     ##                                                              ##
c     ##  subroutine ereal3d  --  real space mpole analysis via list  ##
c     ##                                                              ##
c     ##################################################################
c
c
c     "ereal3d" evaluates the real space portion of the Ewald sum
c     energy due to atomic multipole interactions, and partitions
c     the energy among the atoms using a pairwise neighbor list
c
c     literature reference:
c
c     W. Smith, "Point Multipoles in the Ewald Summation (Revisited)",
c     CCP5 Newsletter, 46, 18-30, 1998  (see http://www.ccp5.org/)
c
c
      subroutine ereal3d (eintra)
      use sizes
      use action
      use analyz
      use atomid
      use atoms
      use bound
      use boxes
      use chgpot
      use couple
      use energi
      use ewald
      use inform
      use iounit
      use math
      use molcul
      use mplpot
      use mpole
      use neigh
      use potent
      use shunt
      implicit none
      integer i,j,k,m
      integer ii,kk,kkk
      integer nemo
      real*8 e,eintra
      real*8 efull
      real*8 f,erfc,r,r2
      real*8 xr,yr,zr
      real*8 bfac,exp2a
      real*8 ralpha,scalekk
      real*8 alsq2,alsq2n
      real*8 rr1,rr3,rr5
      real*8 rr7,rr9
      real*8 ci,dix,diy,diz
      real*8 qixx,qixy,qixz
      real*8 qiyy,qiyz,qizz
      real*8 ck,dkx,dky,dkz
      real*8 qkxx,qkxy,qkxz
      real*8 qkyy,qkyz,qkzz
      real*8 qix,qiy,qiz
      real*8 qkx,qky,qkz
      real*8 emo,eintrao
      real*8 sc(10)
      real*8 gl(0:4)
      real*8 bn(0:4)
      real*8, allocatable :: mscale(:)
      real*8, allocatable :: aemo(:)
      logical header,huge
      character*6 mode
      external erfc
c
c
c     zero out the intramolecular portion of the Ewald energy
c
      eintra = 0.0d0
c
c     print header information if debug output was requested
c
      header = .true.
      if (debug .and. npole.ne.0) then
         header = .false.
         write (iout,10)
   10    format (/,' Individual Atomic Multipole Interactions :',
     &           //,' Type',14x,'Atom Names',15x,'Distance',
     &              8x,'Energy',/)
      end if
c
c     perform dynamic allocation of some local arrays
c
      allocate (mscale(n))
      allocate (aemo(n))
c
c     set arrays needed to scale connected atom interactions
c
      do i = 1, n
         mscale(i) = 1.0d0
      end do
c
c     set conversion factor, cutoff and switching coefficients
c
      f = electric / dielec
      mode = 'EWALD'
      call switch (mode)
c
c     initialize local variables for OpenMP calculation
c
      emo = 0.0d0
      eintrao = eintra
      nemo = nem
      do i = 1, n
         aemo(i) = aem(i)
      end do
c
c     set OpenMP directives for the major loop structure
c
!$OMP PARALLEL default(shared) firstprivate(f)
!$OMP& private(i,j,k,ii,kk,kkk,e,efull,bfac,alsq2,alsq2n,exp2a,ralpha,
!$OMP& scalekk,xr,yr,zr,r,r2,rr1,rr3,rr5,rr7,rr9,ci,dix,diy,diz,
!$OMP& qix,qiy,qiz,qixx,qixy,qixz,qiyy,qiyz,qizz,ck,dkx,dky,dkz,
!$OMP& qkx,qky,qkz,qkxx,qkxy,qkxz,qkyy,qkyz,qkzz,bn,sc,gl)
!$OMP& firstprivate(mscale)
!$OMP DO reduction(+:emo,eintrao,nemo,aemo)
!$OMP& schedule(guided)
c
c     compute the real space portion of the Ewald summation
c
      do i = 1, npole
         ii = ipole(i)
         ci = rpole(1,i)
         dix = rpole(2,i)
         diy = rpole(3,i)
         diz = rpole(4,i)
         qixx = rpole(5,i)
         qixy = rpole(6,i)
         qixz = rpole(7,i)
         qiyy = rpole(9,i)
         qiyz = rpole(10,i)
         qizz = rpole(13,i)
c
c     set interaction scaling coefficients for connected atoms
c
         do j = 1, n12(ii)
            mscale(i12(j,ii)) = m2scale
         end do
         do j = 1, n13(ii)
            mscale(i13(j,ii)) = m3scale
         end do
         do j = 1, n14(ii)
            mscale(i14(j,ii)) = m4scale
         end do
         do j = 1, n15(ii)
            mscale(i15(j,ii)) = m5scale
         end do
         do kkk = 1, nelst(i)
            k = elst(kkk,i)
            kk = ipole(k)
            xr = x(kk) - x(ii)
            yr = y(kk) - y(ii)
            zr = z(kk) - z(ii)
            call image (xr,yr,zr)
            r2 = xr*xr + yr* yr + zr*zr
            if (r2 .le. off2) then
               r = sqrt(r2)
               ck = rpole(1,k)
               dkx = rpole(2,k)
               dky = rpole(3,k)
               dkz = rpole(4,k)
               qkxx = rpole(5,k)
               qkxy = rpole(6,k)
               qkxz = rpole(7,k)
               qkyy = rpole(9,k)
               qkyz = rpole(10,k)
               qkzz = rpole(13,k)
c
c     construct some intermediate quadrupole values
c
               qix = qixx*xr + qixy*yr + qixz*zr
               qiy = qixy*xr + qiyy*yr + qiyz*zr
               qiz = qixz*xr + qiyz*yr + qizz*zr
               qkx = qkxx*xr + qkxy*yr + qkxz*zr
               qky = qkxy*xr + qkyy*yr + qkyz*zr
               qkz = qkxz*xr + qkyz*yr + qkzz*zr
c
c     calculate the error function damping terms
c
               ralpha = aewald * r
               bn(0) = erfc(ralpha) / r
               alsq2 = 2.0d0 * aewald**2
               alsq2n = 0.0d0
               if (aewald .gt. 0.0d0)
     &            alsq2n = 1.0d0 / (sqrtpi*aewald)
               exp2a = exp(-ralpha**2)
               do m = 1, 4
                  bfac = dble(m+m-1)
                  alsq2n = alsq2 * alsq2n
                  bn(m) = (bfac*bn(m-1)+alsq2n*exp2a) / r2
               end do
c
c     calculate the scalar products for permanent multipoles
c
               sc(2) = dix*dkx + diy*dky + diz*dkz
               sc(3) = dix*xr + diy*yr + diz*zr
               sc(4) = dkx*xr + dky*yr + dkz*zr
               sc(5) = qix*xr + qiy*yr + qiz*zr
               sc(6) = qkx*xr + qky*yr + qkz*zr
               sc(7) = qix*dkx + qiy*dky + qiz*dkz
               sc(8) = qkx*dix + qky*diy + qkz*diz
               sc(9) = qix*qkx + qiy*qky + qiz*qkz
               sc(10) = 2.0d0*(qixy*qkxy+qixz*qkxz+qiyz*qkyz)
     &                     + qixx*qkxx + qiyy*qkyy + qizz*qkzz
c
c     calculate the gl functions for permanent multipoles
c
               gl(0) = ci*ck
               gl(1) = ck*sc(3) - ci*sc(4) + sc(2)
               gl(2) = ci*sc(6) + ck*sc(5) - sc(3)*sc(4)
     &                    + 2.0d0*(sc(7)-sc(8)+sc(10))
               gl(3) = sc(3)*sc(6) - sc(4)*sc(5) - 4.0d0*sc(9)
               gl(4) = sc(5)*sc(6)
c
c     get reciprocal distance terms as unscaled values
c
               rr1 = 1.0d0 / r
               rr3 = rr1 / r2
               rr5 = 3.0d0 * rr3 / r2
               rr7 = 5.0d0 * rr5 / r2
               rr9 = 7.0d0 * rr7 / r2
c
c     compute the full undamped permanent multipole energy
c
               efull = rr1*gl(0) + rr3*gl(1) + rr5*gl(2)
     &                    + rr7*gl(3) + rr9*gl(4)
               efull = f * mscale(kk) * efull
c
c     modify error function terms by scaled true distance
c
               scalekk = 1.0d0 - mscale(kk)
               rr1 = f * (bn(0)-scalekk*rr1)
               rr3 = f * (bn(1)-scalekk*rr3)
               rr5 = f * (bn(2)-scalekk*rr5)
               rr7 = f * (bn(3)-scalekk*rr7)
               rr9 = f * (bn(4)-scalekk*rr9)
c
c     compute the energy contributions for this interaction
c
               e = rr1*gl(0) + rr3*gl(1) + rr5*gl(2)
     &                + rr7*gl(3) + rr9*gl(4)
               nemo = nemo + 1
               emo = emo + e
               aemo(ii) = aemo(ii) + 0.5d0*e
               aemo(kk) = aemo(kk) + 0.5d0*e
c
c     increment the total intramolecular energy
c
               if (molcule(ii) .eq. molcule(kk)) then
                  eintrao = eintrao + efull
               end if
c
c     print a message if the energy of this interaction is large
c
               huge = (abs(efull) .gt. 100.0d0)
               if (debug .or. (verbose.and.huge)) then
                  if (header) then
                     header = .false.
                     write (iout,20)
   20                format (/,' Individual Real Space Multipole',
     &                          ' Interactions :',
     &                       //,' Type',14x,'Atom Names',
     &                          15x,'Distance',8x,'Energy',/)
                  end if
                  write (iout,30)  ii,name(ii),kk,name(kk),r,efull
   30             format (' M-Pole',4x,2(i7,'-',a3),9x,
     &                       f10.4,2x,f12.4)
               end if
            end if
         end do
c
c     reset interaction scaling coefficients for connected atoms
c
         do j = 1, n12(ii)
            mscale(i12(j,ii)) = 1.0d0
         end do
         do j = 1, n13(ii)
            mscale(i13(j,ii)) = 1.0d0
         end do
         do j = 1, n14(ii)
            mscale(i14(j,ii)) = 1.0d0
         end do
         do j = 1, n15(ii)
            mscale(i15(j,ii)) = 1.0d0
         end do
      end do
c
c     end OpenMP directives for the major loop structure
c
!$OMP END DO
!$OMP END PARALLEL
c
c     add local copies to global variables for OpenMP calculation
c
      em = em + emo
      eintra = eintrao
      nem = nemo
      do i = 1, n
         aem(i) = aemo(i)
      end do
c
c     perform deallocation of some local arrays
c
      deallocate (mscale)
      deallocate (aemo)
      return
      end
c
c
c     ###############################################################
c     ##                                                           ##
c     ##  subroutine emrecip3  --  PME recip space mpole analysis  ##
c     ##                                                           ##
c     ###############################################################
c
c
c     "emrecip3" evaluates the reciprocal space portion of the particle
c     mesh Ewald energy due to atomic multipole interactions, also
c     partitions the energy among the atoms
c
c     literature reference:
c
c     C. Sagui, L. G. Pedersen and T. A. Darden, "Towards an Accurate
c     Representation of Electrostatics in Classical Force Fields:
c     Efficient Implementation of Multipolar Interactions in
c     Biomolecular Simulations", Journal of Chemical Physics, 120,
c     73-87 (2004)
c
c     modifications for nonperiodic systems suggested by Tom Darden
c     during May 2007
c
c
      subroutine emrecip3
      use sizes
      use bound
      use boxes
      use chgpot
      use energi
      use ewald
      use math
      use mpole
      use mrecip
      use pme
      use potent
      implicit none
      integer i,j,k,ntot
      integer k1,k2,k3
      integer m1,m2,m3
      integer nff,nf1,nf2,nf3
      real*8 e,r1,r2,r3
      real*8 h1,h2,h3
      real*8 volterm,denom
      real*8 hsq,expterm
      real*8 term,pterm
c
c
c     return if the Ewald coefficient is zero
c
      if (aewald .lt. 1.0d-6)  return
c
c     perform dynamic allocation of some global arrays
c
      if (allocated(cmp)) then
         if (size(cmp) .lt. 10*npole) then
            deallocate (cmp)
            deallocate (fmp)
            deallocate (fphi)
         end if
      end if
      if (.not. allocated(cmp)) then
         allocate (cmp(10,npole))
         allocate (fmp(10,npole))
         allocate (fphi(20,npole))
      end if
c
c     copy the multipole moments into local storage areas
c
      do i = 1, npole
         cmp(1,i) = rpole(1,i)
         cmp(2,i) = rpole(2,i)
         cmp(3,i) = rpole(3,i)
         cmp(4,i) = rpole(4,i)
         cmp(5,i) = rpole(5,i)
         cmp(6,i) = rpole(9,i)
         cmp(7,i) = rpole(13,i)
         cmp(8,i) = 2.0d0 * rpole(6,i)
         cmp(9,i) = 2.0d0 * rpole(7,i)
         cmp(10,i) = 2.0d0 * rpole(10,i)
      end do
c
c     compute B-spline coefficients and spatial decomposition
c
      call bspline_fill
      call table_fill
c
c     convert Cartesian multipoles to fractional coordinates
c
      call cmp_to_fmp (cmp,fmp)
c
c     assign PME grid and perform 3-D FFT forward transform
c
      call grid_mpole (fmp)
      call fftfront
c
c     make the scalar summation over reciprocal lattice
c
      ntot = nfft1 * nfft2 * nfft3
      pterm = (pi/aewald)**2
      volterm = pi * volbox
      nff = nfft1 * nfft2
      nf1 = (nfft1+1) / 2
      nf2 = (nfft2+1) / 2
      nf3 = (nfft3+1) / 2
      do i = 1, ntot-1
         k3 = i/nff + 1
         j = i - (k3-1)*nff
         k2 = j/nfft1 + 1
         k1 = j - (k2-1)*nfft1 + 1
         m1 = k1 - 1
         m2 = k2 - 1
         m3 = k3 - 1
         if (k1 .gt. nf1)  m1 = m1 - nfft1
         if (k2 .gt. nf2)  m2 = m2 - nfft2
         if (k3 .gt. nf3)  m3 = m3 - nfft3
         r1 = dble(m1)
         r2 = dble(m2)
         r3 = dble(m3)
         h1 = recip(1,1)*r1 + recip(1,2)*r2 + recip(1,3)*r3
         h2 = recip(2,1)*r1 + recip(2,2)*r2 + recip(2,3)*r3
         h3 = recip(3,1)*r1 + recip(3,2)*r2 + recip(3,3)*r3
         hsq = h1*h1 + h2*h2 + h3*h3
         term = -pterm * hsq
         expterm = 0.0d0
         if (term .gt. -50.0d0) then
            denom = volterm*hsq*bsmod1(k1)*bsmod2(k2)*bsmod3(k3)
            expterm = exp(term) / denom
            if (.not. use_bounds) then
               expterm = expterm * (1.0d0-cos(pi*xbox*sqrt(hsq)))
            else if (octahedron) then
               if (mod(m1+m2+m3,2) .ne. 0)  expterm = 0.0d0
            end if
         end if
         qfac(k1,k2,k3) = expterm
      end do
c
c     account for the zeroth grid point for a finite system
c
      qfac(1,1,1) = 0.0d0
      if (.not. use_bounds) then
         expterm = 0.5d0 * pi / xbox
         qfac(1,1,1) = expterm
      end if
c
c     complete the transformation of the charge grid
c
      do k = 1, nfft3
         do j = 1, nfft2
            do i = 1, nfft1
               term = qfac(i,j,k)
               qgrid(1,i,j,k) = term * qgrid(1,i,j,k)
               qgrid(2,i,j,k) = term * qgrid(2,i,j,k)
            end do
         end do
      end do
c
c     perform 3-D FFT backward transform and get potential
c
      call fftback
      call fphi_mpole (fphi)
c
c     sum over multipoles and increment total multipole energy
c
      e = 0.0d0
      do i = 1, npole
         do k = 1, 10
            e = e + fmp(k,i)*fphi(k,i)
         end do
      end do
      e = 0.5d0 * electric * e
      em = em + e
      return
      end
