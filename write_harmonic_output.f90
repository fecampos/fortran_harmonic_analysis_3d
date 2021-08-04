      subroutine write_harmonic_output(nx,ny,nz,X,Y,Z,missing_val,amp,pha,mean_var)

      use netcdf 

      implicit none      

      character(len=*), parameter :: file_out="harmonic_out.nc"

      integer :: nx, ny, nz

      real :: X(nx), Y(ny), Z(nz), NN(2), missing_val

      real :: amp(nx,ny,nz,2), pha(nx,ny,nz,2), mean_var(nx,ny,nz)

      integer, parameter :: NDIMS3 = 3

      integer, parameter :: NDIMS4 = 4

      character(len=*), parameter :: n_NAME="harmonic"
      character(len=*), parameter :: z_NAME="depth"
      character(len=*), parameter :: y_NAME="latitude"
      character(len=*), parameter :: x_NAME="longitude"

      integer :: n_dimid, z_dimid, y_dimid, x_dimid, n_varid, z_varid, y_varid, x_varid

      character(len=*), parameter :: amp_NAME="amp_temp" 
      character(len=*), parameter :: pha_NAME="pha_temp"
      character(len=*), parameter :: m_NAME="temp"

      integer :: amp_varid, pha_varid, m_varid, dimids3(NDIMS3), dimids4(NDIMS4)

      character(len=*), parameter :: UNITS="units"

      character(len=*), parameter :: n_UNITS="1st and 2nd harmonic"
      character(len=*), parameter :: z_UNITS="m"
      character(len=*), parameter :: y_UNITS="degrees_north"
      character(len=*), parameter :: x_UNITS="degrees_east"

      character(len=*), parameter :: amp_UNITS="units variable"
      character(len=*), parameter :: pha_UNITS="rad"
      character(len=*), parameter :: m_UNITS="degrees_C"

      character(len=*), parameter :: LNAME="long_name"

      character(len=*), parameter :: n_LNAME="1st and 2nd harmonic"
      character(len=*), parameter :: z_LNAME="depth"
      character(len=*), parameter :: y_LNAME="Latitude"
      character(len=*), parameter :: x_LNAME="Longitude"  

      character(len=*), parameter :: amp_LNAME="Temperature"
      character(len=*), parameter :: pha_LNAME="Angle"
      character(len=*), parameter :: m_LNAME="Temperature"

      integer :: retval, ncid, rhvarid

      NN = (/1,2/)

      retval = nf90_create(file_out, ior(nf90_noclobber,nf90_64bit_offset), ncid)

      retval = nf90_def_dim(ncid, n_NAME, 2, n_dimid)
      retval = nf90_def_dim(ncid, z_NAME, NZ, z_dimid)
      retval = nf90_def_dim(ncid, y_NAME, NY, y_dimid)
      retval = nf90_def_dim(ncid, x_NAME, NX, x_dimid)

      retval = nf90_def_var(ncid, n_NAME, NF90_REAL, n_dimid, n_varid)
      retval = nf90_def_var(ncid, z_NAME, NF90_REAL, z_dimid, z_varid)
      retval = nf90_def_var(ncid, y_NAME, NF90_REAL, y_dimid, y_varid)
      retval = nf90_def_var(ncid, x_NAME, NF90_REAL, x_dimid, x_varid)

      retval = nf90_put_att(ncid, n_varid, UNITS, n_UNITS)
      retval = nf90_put_att(ncid, z_varid, UNITS, z_UNITS)
      retval = nf90_put_att(ncid, y_varid, UNITS, y_UNITS)
      retval = nf90_put_att(ncid, x_varid, UNITS, x_UNITS)

      retval = nf90_put_att(ncid, n_varid, LNAME, n_LNAME)
      retval = nf90_put_att(ncid, z_varid, LNAME, z_LNAME)
      retval = nf90_put_att(ncid, y_varid, LNAME, y_LNAME)
      retval = nf90_put_att(ncid, x_varid, LNAME, x_LNAME)

      retval = nf90_put_att(ncid, rhvarid,"title",&
                &"code written by fecg: fecampos1302@gmail.com")

      dimids3(1) = x_dimid
      dimids3(2) = y_dimid
      dimids3(3) = z_dimid

      dimids4(1) = x_dimid
      dimids4(2) = y_dimid
      dimids4(3) = z_dimid
      dimids4(4) = n_dimid

      retval = nf90_def_var(ncid, m_NAME, NF90_REAL, dimids3, m_varid)
      retval = nf90_def_var(ncid, amp_NAME, NF90_REAL, dimids4, amp_varid)
      retval = nf90_def_var(ncid, pha_NAME, NF90_REAL, dimids4, pha_varid)

      retval = nf90_put_att(ncid, m_varid, UNITS, m_UNITS)
      retval = nf90_put_att(ncid, pha_varid, UNITS, pha_UNITS)
      retval = nf90_put_att(ncid, amp_varid, UNITS, amp_UNITS)

      retval = nf90_put_att(ncid, m_varid, LNAME,  m_LNAME)
      retval = nf90_put_att(ncid, pha_varid, LNAME, pha_LNAME)
      retval = nf90_put_att(ncid, amp_varid, LNAME, amp_LNAME)

      retval = nf90_put_att(ncid,m_varid,'missing_value', missing_val)
      retval = nf90_put_att(ncid,pha_varid,'missing_value', missing_val)
      retval = nf90_put_att(ncid,amp_varid,'missing_value', missing_val)

      retval = nf90_enddef(ncid)

      retval = nf90_put_var(ncid, n_varid, NN)
      retval = nf90_put_var(ncid, z_varid, Z)
      retval = nf90_put_var(ncid, y_varid, Y)
      retval = nf90_put_var(ncid, x_varid, X)

      retval = nf90_put_var(ncid, m_varid, mean_var)
      retval = nf90_put_var(ncid, pha_varid, pha)
      retval = nf90_put_var(ncid, amp_varid, amp)

      retval = nf90_close(ncid)

      return

      end subroutine
