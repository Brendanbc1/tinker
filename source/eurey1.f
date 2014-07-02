c
c
c     ###################################################
c     ##  COPYRIGHT (C)  1993  by  Jay William Ponder  ##
c     ##              All Rights Reserved              ##
c     ###################################################
c
c     ################################################################
c     ##                                                            ##
c     ##  subroutine eurey1  --  bond stretch energy & derivatives  ##
c     ##                                                            ##
c     ################################################################
c
c
c     "eurey1" calculates the Urey-Bradley interaction energy and
c     its first derivatives with respect to Cartesian coordinates
c
c
      subroutine eurey1
      use sizes
      use atoms
      use deriv
      use energi
      use urey
      use urypot
      use virial
      implicit none
      integer i,ia,ic
      real*8 e,de,ideal,force
      real*8 dt,dt2,deddt
      real*8 dedx,dedy,dedz
      real*8 vxx,vyy,vzz
      real*8 vyx,vzx,vzy
      real*8 xac,yac,zac,rac
c
c
c     zero out the Urey-Bradley energy and first derivatives
c
      eub = 0.0d0
      do i = 1, n
         deub(1,i) = 0.0d0
         deub(2,i) = 0.0d0
         deub(3,i) = 0.0d0
      end do
c
c     calculate the Urey-Bradley 1-3 energy and first derivatives
c
      do i = 1, nurey
         ia = iury(1,i)
         ic = iury(3,i)
         ideal = ul(i)
         force = uk(i)
c
c     compute the value of the 1-3 distance deviation
c
         xac = x(ia) - x(ic)
         yac = y(ia) - y(ic)
         zac = z(ia) - z(ic)
         rac = sqrt(xac*xac + yac*yac + zac*zac)
         dt = rac - ideal
         dt2 = dt * dt
         e = ureyunit * force * dt2 * (1.0d0+cury*dt+qury*dt2)
         deddt = 2.0d0 * ureyunit * force * dt
     &                 * (1.0d0+1.5d0*cury*dt+2.0d0*qury*dt2)
c
c     compute chain rule terms needed for derivatives
c
         de = deddt / rac
         dedx = de * xac
         dedy = de * yac
         dedz = de * zac
c
c     increment the total Urey-Bradley energy and first derivatives
c
         eub = eub + e
         deub(1,ia) = deub(1,ia) + dedx
         deub(2,ia) = deub(2,ia) + dedy
         deub(3,ia) = deub(3,ia) + dedz
         deub(1,ic) = deub(1,ic) - dedx
         deub(2,ic) = deub(2,ic) - dedy
         deub(3,ic) = deub(3,ic) - dedz
c
c     increment the internal virial tensor components
c
         vxx = xac * dedx
         vyx = yac * dedx
         vzx = zac * dedx
         vyy = yac * dedy
         vzy = zac * dedy
         vzz = zac * dedz
         vir(1,1) = vir(1,1) + vxx
         vir(2,1) = vir(2,1) + vyx
         vir(3,1) = vir(3,1) + vzx
         vir(1,2) = vir(1,2) + vyx
         vir(2,2) = vir(2,2) + vyy
         vir(3,2) = vir(3,2) + vzy
         vir(1,3) = vir(1,3) + vzx
         vir(2,3) = vir(2,3) + vzy
         vir(3,3) = vir(3,3) + vzz
      end do
      return
      end
