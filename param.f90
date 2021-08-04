      module param

      implicit none

      character(len=*),parameter :: file_in=&
      &"rho_glorys12v1_1993_2019.nc"

      character(len=*),parameter :: t_NAME="time"
      character(len=*),parameter :: y_NAME="latitude"
      character(len=*),parameter :: x_NAME="longitude"
      character(len=*),parameter :: z_NAME='depth'
      character(len=*),parameter :: temp_NAME="pres"

      integer, parameter :: nx = 361, ny = 26, nz = 50, nt = 9861

      integer i, j, k, ierr

      real, parameter :: pi=3.1415927, missing_val=-32767, sf_thetao=1, af_thetao=0

      real :: T(nt), X(nx), Y(ny), Z(nz), amp_temp(nx,ny,nz,2), pha_temp(nx,ny,nz,2), mean_temp(nx,ny,nz)
      real :: time(nx,ny,nt), mask(nx,ny,nz), rhvalue

      real, allocatable :: temp(:,:,:)

      integer :: ncid, ndims, retval, tvarid, xvarid, yvarid, zvarid, tempvarid
      integer :: start(4), counting(4)

      end module
