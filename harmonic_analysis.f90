      program harmonic_analysis

      use netcdf

      use param

      implicit none

      !$OMP PARALLEL DO
      do i = 1,nt
        time(:,:,i) = (i-1)*2*pi/365.25
      end do
      !$OMP END PARALLEL DO

      counting = (/nx,ny,1,nt/)

      retval = nf90_open(file_in, NF90_NOWRITE, ncid)

      retval = nf90_inq_varid(ncid, t_NAME, tvarid)
      retval = nf90_inq_varid(ncid, x_NAME, xvarid)
      retval = nf90_inq_varid(ncid, y_NAME, yvarid)
      retval = nf90_inq_varid(ncid, z_NAME, zvarid)

      retval = nf90_get_var(ncid, tvarid, T)
      retval = nf90_get_var(ncid, xvarid, X)
      retval = nf90_get_var(ncid, yvarid, Y)
      retval = nf90_get_var(ncid, zvarid, Z)

      retval = nf90_close(ncid)
print*,X      
      !$OMP PARALLEL DO
      do k = 1,nz
        start = (/1,1,k,1/)
      
        allocate(temp(nx,ny,nt)) 
        
        retval = nf90_open(file_in, NF90_NOWRITE, ncid)
        retval = nf90_inq_varid(ncid, temp_NAME, tempvarid)
        retval = nf90_get_var(ncid,tempvarid,temp,start,counting)
        retval = nf90_close(ncid)
        
        where(temp.ne.missing_val)
          temp = temp*sf_thetao+af_thetao
        end where
        
        call harmonic_regression(nx,ny,nt,time,temp,amp_temp(:,:,k,:), &
             & pha_temp(:,:,k,:),missing_val)  
  
        mean_temp(:,:,k) = sum(temp,3)/nt
     
        deallocate(temp)
      end do
      !$OMP END PARALLEL DO

      where(mean_temp.le.missing_val)
        mean_temp = missing_val
      end where 

      call write_harmonic_output(nx,ny,nz,X,Y,Z,missing_val,amp_temp,pha_temp,mean_temp)

      end program
