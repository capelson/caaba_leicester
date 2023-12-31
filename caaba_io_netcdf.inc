! -*- f90 -*- Time-stamp: <2018-02-21 14:47:05 sander>

! This file produces netcdf output. It can only be used if the netcdf
! library is available.

! Author:
! Rolf Sander, MPICH, 2003-2018

! This program is free software; you can redistribute it and/or
! modify it under the terms of the GNU General Public License
! as published by the Free Software Foundation; either version 2
! of the License, or (at your option) any later version.
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU General Public License for more details.
! You should have received a copy of the GNU General Public License
! along with this program; if not, get it from:
! http://www.gnu.org/copyleft/gpl.html

!*****************************************************************************

  USE caaba_mem, ONLY: time_string, tuf, caaba_version, &
    output_step_freq, output_sync_freq, timestep
  USE messy_main_constants_mem, ONLY: DP, SP
  USE netcdf, ONLY: nf90_clobber, nf90_close, nf90_create, nf90_def_dim, &
    nf90_def_var, nf90_double, nf90_enddef, nf90_float, nf90_get_att, &
    nf90_get_var, nf90_global, nf90_inq_dimid, nf90_inq_varid, nf90_inquire, &
    nf90_inquire_attribute, nf90_inquire_dimension, nf90_inquire_variable, &
    nf90_noerr, nf90_nowrite, nf90_open, nf90_put_att, nf90_put_att, &
    nf90_put_var, nf90_strerror, nf90_sync, nf90_unlimited, &
    nf90_rename_var

  IMPLICIT NONE

  ! choose a precision:
  INTEGER, PARAMETER :: PREC = nf90_float
  ! INTEGER, PARAMETER :: PREC = nf90_double
  ! note: when using nf90_double here, it is also necessary to change
  ! "REAL(FLAGGED_BAD,SP)" in the code below to double precision

  INTEGER :: dimids2d(3), dimids3d(4), dimids1d(1)
  INTEGER :: londimid, latdimid, levdimid, tdimid
  INTEGER :: lonid, latid, levid, tid, tid1d
  INTEGER :: start3d(4), cnt3d(4), start1d(1), cnt1d(1)
  INTEGER :: nlon, ngl, nlev
  INTEGER :: specid(10000) ! at least as big as MAX_EQN in gdata.h
  INTEGER :: specid1d(10000) !> as specid, but for 1-dimensional datasets
  REAL :: nlondata(1), ngldata(1), nlevdata(1)

CONTAINS

  !*****************************************************************************

  ! turn nf90_* function into subroutine + checks status
  SUBROUTINE nf(status, infostring)
    USE netcdf, ONLY: nf90_noerr, nf90_strerror
    IMPLICIT NONE
    INTEGER,                    INTENT(IN) :: status
    CHARACTER(LEN=*), OPTIONAL, INTENT(IN) :: infostring
    IF (status /= nf90_noerr) THEN
      WRITE (*,*) 'netcdf error: ', nf90_strerror(status)
      IF (PRESENT(infostring)) THEN
        WRITE (*,*) infostring
      ENDIF
      STOP 1
    ENDIF
  END SUBROUTINE nf

  !***************************************************************************

  SUBROUTINE open_input_file(ncid, filename)

    IMPLICIT NONE
    INTRINSIC :: TRIM

    INTEGER, INTENT(OUT) :: ncid
    CHARACTER(LEN=*), INTENT(IN) :: filename

    CALL nf(nf90_open(TRIM(filename), nf90_nowrite, ncid))

  END SUBROUTINE open_input_file

  !*****************************************************************************

  SUBROUTINE open_output_file (ncid, filename, species, units, long_name)

    USE messy_main_constants_mem, ONLY: FLAGGED_BAD

    IMPLICIT NONE

    CHARACTER(*), INTENT(IN) :: filename, species(:), units(:)
    CHARACTER(*), OPTIONAL, INTENT(IN) :: long_name(:)
    INTEGER, INTENT(OUT) :: ncid

    INTEGER :: i

    ! define the grid size (1 box)
    nlon = 1
    ngl  = 1
    nlev = 1

    ! define the grid (pseudo, since only box)
    nlondata = (/ 0. /)
    ngldata  = (/ 0. /)
    nlevdata = (/ 0. /)

    ! open the netcdf file (nf90_clobber = overwrite existing file)
    CALL nf(nf90_create(filename//'.nc', nf90_clobber, ncid))

    ! global attributes
    CALL nf(nf90_put_att(ncid, nf90_global, 'title', 'CAABA'))
    CALL nf(nf90_put_att(ncid, nf90_global, 'version', TRIM(caaba_version)))

    ! definition of the dimensions
    ! syntax: nf90_def_dim(IN:ncid, IN:name, IN:len, OUT:dimid)
    CALL nf(nf90_def_dim(ncid, 'lon',  nlon,           londimid))
    CALL nf(nf90_def_dim(ncid, 'lat',  ngl,            latdimid))
    CALL nf(nf90_def_dim(ncid, 'lev',  nlev,           levdimid))
    CALL nf(nf90_def_dim(ncid, 'time', nf90_unlimited, tdimid))

    dimids2d(:) = (/ londimid, latdimid,           tdimid /) ! 2d (3rd dim=t)
    dimids3d(:) = (/ londimid, latdimid, levdimid, tdimid /) ! 3d (4th dim=t)
    cnt3d(:)    = (/ nlon,     ngl,      nlev,     1 /)

    ! definition of variables
    ! syntax: nf90_def_var(IN:ncid, IN:name, IN:xtype, IN:dimids, OUT:varid)
    ! coordinate variables
    CALL nf(nf90_def_var(ncid, 'lon',   PREC,        londimid,  lonid))
    CALL nf(nf90_def_var(ncid, 'lat',   PREC,        latdimid,  latid))
    CALL nf(nf90_def_var(ncid, 'lev',   PREC,        levdimid,  levid))
    CALL nf(nf90_def_var(ncid, 'time',  nf90_double, tdimid,    tid))

    DO i = 1, SIZE(species)
      CALL nf(nf90_def_var(ncid, TRIM(ADJUSTL(species(i))), PREC, dimids3d, &
        specid(i)))
      IF (PRESENT(long_name)) THEN
        CALL nf(nf90_put_att(ncid, specid(i), 'long_name', TRIM(long_name(i))))
      ELSE
        CALL nf(nf90_put_att(ncid, specid(i), 'long_name', TRIM(species(i))))
      ENDIF
      CALL nf(nf90_put_att(ncid, specid(i), 'units',     TRIM(units(i))))
      CALL nf(nf90_put_att(ncid, specid(i), '_FillValue', REAL(FLAGGED_BAD,SP)))
      CALL nf(nf90_put_att(ncid, specid(i), 'missing_value', REAL(FLAGGED_BAD,SP)))
    END DO

    ! assign attributes
    ! syntax: nf90_put_att(IN:ncid, IN:vid, IN:name, IN:values)
    ! longitude
    CALL nf(nf90_put_att(ncid, lonid,  'long_name', 'longitude'))
    CALL nf(nf90_put_att(ncid, lonid,  'units',     'degrees_east'))
    ! latitude
    CALL nf(nf90_put_att(ncid, latid,  'long_name', 'latitude'))
    CALL nf(nf90_put_att(ncid, latid,  'units',     'degrees_north'))
    ! levels
    CALL nf(nf90_put_att(ncid, levid,  'long_name', 'level index'))
    CALL nf(nf90_put_att(ncid, levid,  'units',     'level'))
    CALL nf(nf90_put_att(ncid, levid,  'positive',  'down'))
    ! time
    CALL nf(nf90_put_att(ncid, tid,    'long_name', 'time'))
    CALL nf(nf90_put_att(ncid, tid,    'units', time_string))

    ! end of the definitions, switch to data mode
    CALL nf(nf90_enddef(ncid))

    ! syntax: nf90_put_var(IN:ncid, IN:varid, IN:values)
    ! write the data of the grid
    CALL nf(nf90_put_var(ncid, lonid,   nlondata))
    CALL nf(nf90_put_var(ncid, latid,   ngldata))
    CALL nf(nf90_put_var(ncid, levid,   nlevdata))

  END SUBROUTINE open_output_file

  !*****************************************************************************

  !mz_hr_20160411+
  SUBROUTINE open_output_file_1d (ncid, filename, species, units, long_name)

    USE messy_main_constants_mem, ONLY: FLAGGED_BAD

    IMPLICIT NONE

    CHARACTER(*), INTENT(IN) :: filename, species(:), units(:)
    CHARACTER(*), OPTIONAL, INTENT(IN) :: long_name(:)
    INTEGER, INTENT(OUT) :: ncid

    INTEGER :: i

    ! open the netcdf file (nf90_clobber = overwrite existing file)
    CALL nf(nf90_create(filename//'.nc', nf90_clobber, ncid))

    ! global attributes
    CALL nf(nf90_put_att(ncid, nf90_global, 'title', 'CAABA'))
    CALL nf(nf90_put_att(ncid, nf90_global, 'version', TRIM(caaba_version)))

    ! definition of the dimensions
    ! syntax: nf90_def_dim(IN:ncid, IN:name, IN:len, OUT:dimid)
    CALL nf(nf90_def_dim(ncid, 'time', nf90_unlimited, tdimid))

    dimids1d(:) = (/ tdimid /) ! 0d (1st dim=t)
    cnt1d(:)    = (/ 1 /)

    ! definition of variables
    ! syntax: nf90_def_var(IN:ncid, IN:name, IN:xtype, IN:dimids, OUT:varid)
    ! coordinate variables
    CALL nf(nf90_def_var(ncid, 'time',  nf90_double, tdimid,    tid1d))

    DO i = 1, SIZE(species)
      CALL nf(nf90_def_var(ncid, TRIM(ADJUSTL(species(i))), PREC, dimids1d, &
        specid1d(i)))
      IF (PRESENT(long_name)) THEN
        CALL nf(nf90_put_att(ncid, specid1d(i), 'long_name', TRIM(long_name(i))))
      ELSE
        CALL nf(nf90_put_att(ncid, specid1d(i), 'long_name', TRIM(species(i))))
      ENDIF
      CALL nf(nf90_put_att(ncid, specid1d(i), 'units',     TRIM(units(i))))
      CALL nf(nf90_put_att(ncid, specid1d(i), '_FillValue', REAL(FLAGGED_BAD,SP)))
      CALL nf(nf90_put_att(ncid, specid1d(i), 'missing_value', REAL(FLAGGED_BAD,SP)))
    END DO

    ! assign attributes
    ! syntax: nf90_put_att(IN:ncid, IN:vid, IN:name, IN:values)
    ! time
    CALL nf(nf90_put_att(ncid, tid1d,    'long_name', 'time'))
    CALL nf(nf90_put_att(ncid, tid1d,    'units', time_string))

    ! end of the definitions, switch to data mode
    CALL nf(nf90_enddef(ncid))

  END SUBROUTINE open_output_file_1d
  !mz_hr_20160411-

  !*****************************************************************************

  SUBROUTINE write_output_file (ncid, time, x)

    IMPLICIT NONE

    ! I/O
    INTEGER,  INTENT(IN) :: ncid
    REAL(dp), INTENT(IN) :: time
    REAL(dp), INTENT(IN) :: x(:)

    ! LOCAL
    REAL(dp) :: ad_time
    INTEGER  :: i, nc_timestep

    IF (MOD(timestep,output_step_freq)/=0) RETURN

    ! write nc_timestep (timestep in nc file)
    CALL nf(nf90_inquire_dimension(ncid, tid, len=nc_timestep))
    nc_timestep = nc_timestep + 1

    ! syntax: nf90_put_var(ncid, varid, values, start, cnt)
    ! start:  start in netcdf variable
    ! cnt:    number of netcdf variable points
    ! values: starting point of the fortran variable
    start3d = (/ 1, 1, 1, nc_timestep /)

    !mz_hr_20061002+
    ! adapt output time to input time unit
    IF (tuf>0.) THEN
      ad_time = time/tuf
    ELSE
      ad_time = time
    ENDIF
    !mz_hr_20061002-
    CALL nf(nf90_put_var(ncid, tid, ad_time, (/nc_timestep/) ))
    species_loop: DO I = 1, SIZE(x)
      CALL nf(nf90_put_var(ncid, specid(i), (/x(i)/), start3d, cnt3d))
    END DO species_loop

    IF (MOD(timestep,output_step_freq*output_sync_freq)==0) &
      CALL nf(nf90_sync(ncid)) ! write buffer to file

  END SUBROUTINE write_output_file

  !*****************************************************************************

  !mz_hr_20160414+
  SUBROUTINE write_output_file_1d (ncid, time, x)

    IMPLICIT NONE

    ! I/O
    INTEGER,  INTENT(IN) :: ncid
    REAL(dp), INTENT(IN) :: time
    REAL(dp), INTENT(IN) :: x(:)

    ! LOCAL
    REAL(dp) :: ad_time
    INTEGER  :: i, nc_timestep

    IF (MOD(timestep,output_step_freq)/=0) RETURN

    ! write nc_timestep (timestep in nc file)
    CALL nf(nf90_inquire_dimension(ncid, tid1d, len=nc_timestep))
    nc_timestep = nc_timestep + 1

    ! syntax: nf90_put_var(ncid, varid, values, start, cnt)
    ! start:  start in netcdf variable
    ! cnt:    number of netcdf variable points
    ! values: starting point of the fortran variable
    start1d = (/ nc_timestep /)

    ! adapt output time to input time unit
    IF (tuf>0.) THEN
      ad_time = time/tuf
    ELSE
      ad_time = time
    ENDIF
    CALL nf(nf90_put_var(ncid, tid1d, ad_time, (/nc_timestep/) ))
    species_loop: DO I = 1, SIZE(x)
      CALL nf(nf90_put_var(ncid, specid1d(i), (/x(i)/), start1d, cnt1d))
    END DO species_loop

    IF  (MOD(timestep,output_step_freq*output_sync_freq)==0) &
      CALL nf(nf90_sync(ncid)) ! write buffer to file

  END SUBROUTINE write_output_file_1d
  !mz_hr_20160414-

  !*****************************************************************************

  SUBROUTINE close_file (ncid)

    IMPLICIT NONE

    INTEGER, INTENT(IN) :: ncid

    CALL nf(nf90_close(ncid))

  END SUBROUTINE close_file

  !*****************************************************************************
