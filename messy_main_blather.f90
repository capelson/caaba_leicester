! ************************************************************************
MODULE messy_main_blather
! ************************************************************************

  IMPLICIT NONE
  PRIVATE

  PUBLIC :: start_message       ! standard messages for start and end ...
  PUBLIC :: end_message         ! .. of submodel-specific MESSy-routines
  PUBLIC :: info
  PUBLIC :: warning  
  PUBLIC :: dbg_message  ! um_ak_20140414
  PUBLIC :: dbg_out      ! ub_ak_20190517 

CONTAINS

  ! --------------------------------------------------------------------
  SUBROUTINE start_message(modstr, str, substr, l_print)
    
    USE messy_main_constants_mem, ONLY: HLINE1
    IMPLICIT NONE
    INTRINSIC :: TRIM

    ! I/O
    CHARACTER(LEN=*), INTENT(IN)  :: modstr, str, substr
    LOGICAL, INTENT(IN), OPTIONAL :: l_print

    ! LOCAL
    LOGICAL :: zl_print

    IF (PRESENT(l_print)) THEN
       zl_print = l_print
    ELSE
       zl_print = .TRUE.  ! DEFAULT
    END IF

    IF (.NOT. zl_print) RETURN

    WRITE(*,*) HLINE1
    WRITE(*,*) '*** START ',TRIM(modstr),': ',TRIM(str), &
         ' (',TRIM(substr),')'
    
  END SUBROUTINE start_message
  ! --------------------------------------------------------------------

  ! --------------------------------------------------------------------
  SUBROUTINE end_message(modstr, str, substr, l_print)
    
    USE messy_main_constants_mem, ONLY: HLINE1
    IMPLICIT NONE
    INTRINSIC :: TRIM

    ! I/O
    CHARACTER(LEN=*), INTENT(IN)  :: modstr, str, substr
    LOGICAL, INTENT(IN), OPTIONAL :: l_print

    ! LOCAL
    LOGICAL :: zl_print

    IF (PRESENT(l_print)) THEN
       zl_print = l_print
    ELSE
       zl_print = .TRUE.  ! DEFAULT
    END IF

    IF (.NOT. zl_print) RETURN

    WRITE(*,*) '*** END   ',TRIM(modstr),': ',TRIM(str), &
         ' (',TRIM(substr),')'
    WRITE(*,*) HLINE1

  END SUBROUTINE end_message
  ! --------------------------------------------------------------------

  ! ---------------------------------------------------------------------
  SUBROUTINE info(string, substr, l_print)

    IMPLICIT NONE
    INTRINSIC :: PRESENT, TRIM
    CHARACTER(LEN=*),           INTENT(IN) :: string
    CHARACTER(LEN=*), OPTIONAL, INTENT(IN) :: substr
    LOGICAL,          OPTIONAL, INTENT(IN) :: l_print

    ! LOCAL
    LOGICAL :: zl_print

    IF (PRESENT(l_print)) THEN
       zl_print = l_print
    ELSE
       zl_print = .TRUE.  ! DEFAULT
    END IF

    IF (.NOT. zl_print) RETURN

    IF (PRESENT(substr)) THEN
       WRITE (*,'(A," (",A,")")') TRIM(string), TRIM(substr)
    ELSE
       WRITE (*,'(A)') TRIM(string)
    ENDIF

  END SUBROUTINE info
  !-------------------------------------------------------------------------

  !-------------------------------------------------------------------------
  SUBROUTINE warning(string, substr, l_print)

    IMPLICIT NONE
    INTRINSIC :: TRIM
    CHARACTER(LEN=*),           INTENT(IN) :: string, substr
    LOGICAL,          OPTIONAL, INTENT(IN) :: l_print

    ! LOCAL
    LOGICAL :: zl_print

    IF (PRESENT(l_print)) THEN
       zl_print = l_print
    ELSE
       zl_print = .TRUE.  ! DEFAULT
    END IF

    IF (.NOT. zl_print) RETURN

    WRITE (*,'("WARNING: ",A," (",A,")")') TRIM(string), TRIM(substr)

  END SUBROUTINE warning
  !-------------------------------------------------------------------------

  ! um_ak_20140414+
  ! --------------------------------------------------------------------
  SUBROUTINE dbg_message(modstr, str, substr, l_print)
    
    USE messy_main_constants_mem, ONLY: HLINE1
    IMPLICIT NONE
    INTRINSIC :: TRIM

    ! I/O
    CHARACTER(LEN=*), INTENT(IN)  :: modstr, str, substr
    LOGICAL, INTENT(IN), OPTIONAL :: l_print

    ! LOCAL
    LOGICAL :: zl_print

    IF (PRESENT(l_print)) THEN
       zl_print = l_print
    ELSE
       zl_print = .TRUE.  ! DEFAULT
    END IF

    IF (.NOT. zl_print) RETURN

    WRITE(*,*) HLINE1
    WRITE(*,*) TRIM(modstr),': ',TRIM(str), ' (',TRIM(substr),')'
    WRITE(*,*) HLINE1
    
  END SUBROUTINE dbg_message
  ! --------------------------------------------------------------------
  ! um_ak_20140414-
  ! ub_ak_20190517+
  SUBROUTINE dbg_out(str, var3d, var2d, yvar3d)

    USE messy_main_constants_mem, ONLY: dp
    
    IMPLICIT NONE

    CHARACTER(LEN=*)          , INTENT(IN)           :: str
    REAL(dp), DIMENSION(:,:,:), INTENT(IN), OPTIONAL :: var3d 
    REAL(dp), DIMENSION(:,:),   INTENT(IN), OPTIONAL :: var2d
    REAL(dp), DIMENSION(:,:,:), INTENT(IN), OPTIONAL :: yvar3d 

    IF (PRESENT(var3d)) THEN
       write (0,*) TRIM(str),' ', 'MIN: ',MINVAL(var3d), 'MAX ',MAXVAL(var3d)&
            , 'SUM ', SUM(var3d)
    END IF
    IF (PRESENT(yvar3d)) THEN
       write (0,*) TRIM(str),' ', 'MIN: ',MINVAL(yvar3d), 'MAX ',MAXVAL(yvar3d)&
            , 'SUM ', SUM(yvar3d)
    END IF
    IF (PRESENT(var2d)) THEN
       write (0,*) TRIM(str),' ', 'MIN: ',MINVAL(var2d), 'MAX ',MAXVAL(var2d)&
            , 'SUM ', SUM(var2d)
    END IF
  END SUBROUTINE dbg_out
  ! ub_ak_20190517-

! ************************************************************************
END MODULE messy_main_blather
! ************************************************************************
