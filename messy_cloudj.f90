!*****************************************************************************

MODULE messy_cloudj

  USE messy_main_constants_mem, ONLY: DP, RTD, Rd
  USE messy_main_tools,         ONLY: PTR_2D_ARRAY
  USE messy_cmn_photol_mem      ! IP_MAX, ip_*, jname
  ! cloudj:
  USE messy_cloudj_fjx_sub_mod
  USE messy_cloudj_fjx_init_mod ! INIT_FJX, nml variables for input file names
  USE messy_cloudj_cld_sub_mod, ONLY : cloud_jx

  IMPLICIT NONE
  PRIVATE
  ! NAME OF SUBMODEL
  CHARACTER(LEN=*), PARAMETER, PUBLIC :: modstr = 'cloudj'
  CHARACTER(LEN=*), PARAMETER, PUBLIC :: modver = '7.3c'

  PUBLIC :: init_cloudj
  PUBLIC :: cloudjvalues
  PUBLIC :: cloudj_read_nml_ctrl
 
  LOGICAL, PUBLIC, DIMENSION(IP_MAX), SAVE :: lp = .FALSE.

  ! pointer to photolysis rate coeff.
  TYPE(PTR_2D_ARRAY), PUBLIC, DIMENSION(:), POINTER, SAVE  :: cloudj_2d

  
  ! **************************************************************************

CONTAINS

  ! **************************************************************************

  SUBROUTINE init_cloudj

    INTEGER :: NJX_DUMMY, ip
    CHARACTER*6, DIMENSION(IP_MAX) :: TITLJXX_DUMMY

    ! Write the FJX_j2j file to map cmn_photol_mem to cloudj:
    OPEN (10,file=NAMFIL_FJX_j2j,status='UNKNOWN')
    WRITE(10,'(A)') '<--J-value data from cmn_photol_mem: id#, reaction,       factor/fastJX/code(a6)'
    DO ip = 1,IP_MAX
      SELECT CASE (ip)
      CASE(ip_O2)        ; CALL map(ip, 1.0,   'O2    ')
      CASE(ip_O3P)       ; CALL map(ip, 1.0,   'O3    ')
      CASE(ip_O1D)       ; CALL map(ip, 1.0,   'O3(1D)')
      CASE(ip_NO)        ; CALL map(ip, 1.0,   'NO    ')
      CASE(ip_CHOH)      ; CALL map(ip, 1.0,   'H2COa ')
      CASE(ip_COH2)      ; CALL map(ip, 1.0,   'H2COb ')
      CASE(ip_H2O2)      ; CALL map(ip, 1.0,   'H2O2  ')
      CASE(ip_CH3OOH)    ; CALL map(ip, 1.0,   'CH3OOH')
      CASE(ip_NO2)       ; CALL map(ip, 1.0,   'NO2   ')
      CASE(ip_NO2O)      ; CALL map(ip, 0.886, 'NO3   ')
      CASE(ip_NOO2)      ; CALL map(ip, 0.114, 'NO3   ')
      CASE(ip_N2O5)      ; CALL map(ip, 1.0,   'N2O5  ')
      CASE(ip_HONO)      ; CALL map(ip, 1.0,   'HNO2  ')
      CASE(ip_HNO3)      ; CALL map(ip, 1.0,   'HNO3  ')
      CASE(ip_HNO4)      ; CALL map(ip, 1.0,   'HNO4  ')
      CASE(ip_ClNO3)     ; CALL map(ip, 1.0,   'ClNO3a')
      CASE(ip_ClONO2)    ; CALL map(ip, 1.0,   'ClNO3b')
      CASE(ip_Cl2)       ; CALL map(ip, 1.0,   'Cl2   ')
      CASE(ip_HOCl)      ; CALL map(ip, 1.0,   'HOCl  ')
      CASE(ip_OClO)      ; CALL map(ip, 1.0,   'OClO  ')
      CASE(ip_Cl2O2)     ; CALL map(ip, 1.0,   'Cl2O2 ')
      !CASE(ip_)         ; CALL map(ip, 1.0,   'ClO   ')
      CASE(ip_BrO)       ; CALL map(ip, 1.0,   'BrO   ')
      CASE(ip_BrNO3)     ; CALL map(ip, 1.0,   'BrNO3 ')
      CASE(ip_HOBr)      ; CALL map(ip, 1.0,   'HOBr  ')
      CASE(ip_BrCl)      ; CALL map(ip, 1.0,   'BrCl  ')
      CASE(ip_N2O)       ; CALL map(ip, 1.0,   'N2O   ')
      CASE(ip_CFCl3)     ; CALL map(ip, 1.0,   'CFCl3 ')
      CASE(ip_CF2Cl2)    ; CALL map(ip, 1.0,   'CF2Cl2')
      !CASE(ip_)         ; CALL map(ip, 1.0,   'F113  ')
      !CASE(ip_)         ; CALL map(ip, 1.0,   'F114  ')
      !CASE(ip_)         ; CALL map(ip, 1.0,   'F115  ')
      CASE(ip_CCl4)      ; CALL map(ip, 1.0,   'CCl4  ')
      CASE(ip_CH3Cl)     ; CALL map(ip, 1.0,   'CH3Cl ')
      CASE(ip_CH3CCl3)   ; CALL map(ip, 1.0,   'MeCCl3')
      !CASE(ip_)         ; CALL map(ip, 1.0,   'CH2Cl2')
      CASE(ip_CHF2Cl)    ; CALL map(ip, 1.0,   'CHF2Cl')
      !CASE(ip_)         ; CALL map(ip, 1.0,   'F123  ')
      !CASE(ip_)         ; CALL map(ip, 1.0,   'F141b ')
      !CASE(ip_)         ; CALL map(ip, 1.0,   'F142b ')
      CASE(ip_CH3Br)     ; CALL map(ip, 1.0,   'CH3Br ')
      !CASE(ip_)         ; CALL map(ip, 1.0,   'H1211 ')
      !CASE(ip_)         ; CALL map(ip, 1.0,   'H1301 ')
      !CASE(ip_)         ; CALL map(ip, 1.0,   'H2402 ')
      CASE(ip_CH2Br2)    ; CALL map(ip, 1.0,   'CH2Br2')
      CASE(ip_CHBr3)     ; CALL map(ip, 1.0,   'CHBr3 ')
      CASE(ip_CH3I)      ; CALL map(ip, 1.0,   'CH3I  ')
      !CASE(ip_)         ; CALL map(ip, 1.0,   'CF3I  ')
      CASE(ip_OCS)       ; CALL map(ip, 1.0,   'OCS   ')
      CASE(ip_PAN)       ; CALL map(ip, 1.0,   'PAN   ')
      CASE(ip_CH3NO3)    ; CALL map(ip, 1.0,   'CH3NO3')
      CASE(ip_CH3CHO)    ; CALL map(ip, 1.0,   'ActAld')
      CASE(ip_MVK)       ; CALL map(ip, 0.600, 'MeVK  ')
      CASE(ip_MACR)      ; CALL map(ip, 1.0,   'MeAcr ')
      CASE(ip_HOCH2CHO)  ; CALL map(ip, 0.830, 'GlyAld')
      !CASE(ip_)         ; CALL map(ip, 1.0,   'MEKeto')
      !CASE(ip_)         ; CALL map(ip, 1.0,   'PrAld ')
      CASE(ip_MGLYOX)    ; CALL map(ip, 1.0,   'MGlyxl')
      !CASE(ip_GLYOX)    ; CALL map(ip, 1.0,   'Glyxla')
      !CASE(ip_GLYOX)    ; CALL map(ip, 1.0,   'Glyxlb')
      !CASE(ip_GLYOX)    ; CALL map(ip, 1.0,   'Glyxlc')
      !CASE(ip_CH3COCH3) ; CALL map(ip, 1.0,   'Acet-a')
      !CASE(ip_CH3COCH3) ; CALL map(ip, 1.0,   'Acet-b')
      CASE DEFAULT
        WRITE (10,'(I4,1X,A12,A)') ip, jname(ip), "no map"
        lp(ip)=.FALSE.
      END SELECT
    ENDDO
    WRITE (10,'(I4)') 9999
    CLOSE(10)
    
    ! INIT_FJX reads cross sections etc.
    ! it also maps cloudj photolysis reaction number to CTM 
    CALL INIT_FJX(TITLJXX_DUMMY, IP_MAX, NJX_DUMMY)

  CONTAINS

    SUBROUTINE map(ip, JFACTA, TITLEJX)
      INTEGER, INTENT(IN) :: ip
      REAL, INTENT(IN) :: JFACTA
      CHARACTER(LEN=6), INTENT(IN) :: TITLEJX
      WRITE (10,'(I4,1X,A12,42X,F5.3,1X,A1,A6,A1)') &
        ip, jname(ip), JFACTA, "/", TITLEJX, "/"
    END SUBROUTINE map

  END SUBROUTINE init_cloudj
  
  ! **************************************************************************

  SUBROUTINE cloudjvalues(         &
    v3_2d,                         &
    cossza_1d, press_2d, relo3_2d, &
    rhum_2d, temp_2d, albedo_1d,   &
    aclc_2d, slf_1d, clp_2d)

    USE messy_cloudj_fjx_cmn_mod, ONLY: AN_, JFACTA, JIND, JVMAP, JLABEL
    USE messy_main_constants_mem, ONLY: N_A, g, M_air

    REAL, DIMENSION(:,:), INTENT(IN) :: v3_2d     ! vertical ozone column [mcl/cm2]
    REAL, DIMENSION(:),   INTENT(IN) :: cossza_1d ! cos ( solar zenith angle )
    REAL, DIMENSION(:,:), INTENT(IN) :: press_2d  ! pressure [Pa]
    REAL, DIMENSION(:,:), INTENT(IN) :: relo3_2d  ! relative ozone (mixing ratio) [mol/mol]
    REAL, DIMENSION(:,:), INTENT(IN) :: rhum_2d   ! relative humidity [%]
    REAL, DIMENSION(:,:), INTENT(IN) :: temp_2d   ! temperature [K]
    REAL, DIMENSION(:),   INTENT(IN) :: albedo_1d ! albedo
    REAL, DIMENSION(:,:), INTENT(IN) :: aclc_2d   ! cloud cover
    REAL, DIMENSION(:),   INTENT(IN) :: slf_1d    ! sea/land fraction, 0 = sea
    REAL, DIMENSION(:,:), INTENT(IN) :: clp_2d    ! clp = cloud liquid water path [g/m^2]
    INTEGER :: jp, kproma, klev, ip

    !--- local cloudj parameters as profiles
    REAL(DP)                                    :: U0, SZA
    REAL(DP), DIMENSION(SIZE(temp_2d,2)+2)      :: PPP, ZZZ
    REAL(DP), DIMENSION(SIZE(temp_2d,2)+1)      :: &
      TTT, DDD, RRR, OOO, LWP, IWP, REFFL, REFFI, CLF
    INTEGER,  DIMENSION(SIZE(temp_2d,2)+1)      :: CLDIW
    REAL(DP), DIMENSION(SIZE(temp_2d,2)+1,AN_)  :: AERSP
    INTEGER,  DIMENSION(SIZE(temp_2d,2)+1,AN_)  :: NDXAER
    REAL(DP), DIMENSION(SIZE(temp_2d,2),IP_MAX) :: VALJXX
    INTEGER                                     :: CLDFLAG, NRANDO, IRAN, LNRG
    INTEGER                                     :: NICA, JCOUNT

    !--- other locals
    REAL(DP) :: h_scale, zdel, pdel, pmid, wlc, f1, icwc
    INTEGER :: k, ip_f
    REAL(DP), PARAMETER :: M_air_si=M_air/1000.

    kproma = SIZE(temp_2d,1)   ! number of columns
    klev   = SIZE(temp_2d,2)   ! vertical levels
    ! start with 0. as default:
    DO ip = 1,IP_MAX
      cloudj_2d(ip)%ptr(:,:) = 0._DP
    ENDDO

    DO jp = 1,kproma ! loop over columns

      ! map parameters
      ! cloudj has a z upward axis assumed
      ! we are here very explicitly using original code 
      ! may be streamlined later
      U0  = cossza_1d(jp)
      SZA = RTD*ACOS( U0 )
      ! reverse profiles and scale accordingly
      ! klev number of layers of CTM
      ! klev+1 number of bounds, p(1) surface, p(klev+1) top, p(klev+2)=0.
      PPP(klev+2) = 0._DP
      PPP(klev+1) = EXP(-1.) * press_2d(jp,1) / 100.
      DO k=1,klev-1
        PPP(klev-k+1) = 0.5*( press_2d(jp,K+1) + press_2d(jp,k) )/ 100. ! -> hP
      ENDDO
      PPP(1) = PPP(2) * ppp(2) / ppp(3)
      DO K=1,klev+1
        DDD(K) = ( PPP(K) - PPP(K+1) )*100./g  & ! -> kg/m2
          /M_air_si                            & ! -> -> mol/m2 (note SI)
          *N_A                                 & ! -> molec,
          /1E4                                  ! -> cm-2
      ENDDO
      DO K=1,klev
        TTT(K) = temp_2d(jp,klev-K+1)
        RRR(K) = rhum_2d(jp,klev-K+1)
        OOO(K) = DDD(K) * relo3_2d(jp,klev-K+1)
        CLF(K) = aclc_2d(jp,klev-K+1)
      ENDDO
      TTT(klev+1) = TTT(klev)
      RRR(klev+1) = RRR(klev)
      OOO(klev+1) = OOO(klev)
      CLF(klev+1) = CLF(klev)
      DO k=1,klev+1
        IF ( CLF(k) .LT. 0.005_DP ) THEN
          CLDIW(k) = 0     !  CLDIW is an integer flag: 1 = water cld, 2 = ice cloud, 3 = both
          CLF(k)   = 0._DP
          LWP(k)   = 0._DP
          IWP(k)   = 0._DP
        ELSE
          LWP(k) = clp_2d(jp,klev-k+1) / CLF(k) ! in PHOTO_JX rescaled
          IWP(k) = 0._DP / CLF(k)
        ENDIF
      ENDDO
      ZZZ(1)  = 16E5*LOG10(1013.25/PPP(1))     ! zzz in cm
      DO k = 1,klev
        H_scale  = Rd * TTT(k) / g * 100.         ! in cm
        ZDEL     = -( LOG(PPP(k+1)/PPP(k)) * H_scale )
        PDEL     = PPP(k) - PPP(k+1)
        PMID     = ( PPP(k) + PPP(k+1) ) / 2
        ZZZ(k+1) = ZZZ(k) + ZDEL
        WLC      = LWP(k) * g / 100000. / PDEL
        IF (WLC > 1E-11) THEN                ! note: cldj.f90 uses 1e-11 and 1e-12
          F1       = 0.005 * (PMID - 610.)
          F1       = MIN(1., MAX(0., F1))
          REFFL(k) = 9.6*F1 + 12.68*(1.-F1)
          CLDIW(k) = 1
        ELSE
          LWP(k)   = 0.
          REFFL(k) = 0.
        ENDIF
        IF ( IWP(k)*g/10000./PDEL > 1E-11 ) THEN
          ICWC     = IWP(k) / ZDEL          ! g/m3
          REFFI(k) = 164. * (ICWC**0.23)
          CLDIW(k) = CLDIW(k) + 2
        ENDIF
      ENDDO
      ZZZ(klev+2) = ZZZ(klev+1) + H_scale ! use scale height from highest layer = last loop element

      AERSP   = 0.
      NDXAER  = 0
      CLDFLAG = 1
      NRANDO  = 0
      IRAN    = 0
      LNRG    = 0
      NICA    = 0
      JCOUNT  = 0

      CALL CLOUD_JX ( U0 & ! cos (SZA)
        , SZA           & ! solar zenith angle in degree
        , REAL(albedo_1d(jp),DP) & ! REFLB: Lambertian reflectivity at the Lower Boundary
        , 1.0_DP        & ! SOLF: solar flux factor for sun-earth distance
        , 0.0_DP        & ! FG0: scale for asymmetry factor (CLDFLAG=3)
        , .FALSE.       & ! LPRTJ: turn on internal print?
        , PPP           & ! top edge press (hPa)), #tr PPP(1) surface
        , ZZZ           & ! edge alt (cm)
        , TTT           & ! layer temp (K)
        , DDD           & ! layer dens-path (# molec /cm2)
        , RRR           & ! layer rel.hum.(fraction)
        , OOO           & ! layer O3 path (# O3 /cm2
        , LWP           & ! Liquid water path (g/m2)
        , IWP           & ! Ice    water path (g/m2) probably meant for cloudy part only as scaled for CLDFLG < 4
        , REFFL         & ! R-effective(microns) in liquid cloud
        , REFFI         & ! R-effective(microns) in ice    cloud
        , CLF           & ! cloud fraction (0.0 to 1.0)
        , 0.0_DP        & ! CLDCOR: cloud correl factor
        , CLDIW         & ! denoting cloud in layer: 1=water, 2=ice, 3=both
        , AERSP         & ! aerosol path (g/m2)
        , NDXAER        & ! aerosol index type, aerosols with up to AN_ different types in an ICA layer
        , klev+1        & ! dim of profile variables, top (non CTM) layer
        , AN_           & ! parameter, dim of number of aerosols being passed
        , VALJXX        & ! J-values from CLOUD_JX & PHOTO_JX
        , IP_MAX        & ! 
        , CLDFLAG       & ! integer index for type of cloud overlap
        , NRANDO        & ! number of random ICAs to do J's for (CLDFLAG=4)
        , IRAN          & ! starting index for random number selection
        , LNRG          & ! flag max-ran overlap groups: 0, 3, 6 
        , NICA          & ! total number of ICAs
        , JCOUNT        & ! 
        )

      DO ip=1,IP_MAX
        ip_f = jind(ip)
        IF (lp(ip)) THEN
          DO k=1,klev
            cloudj_2d(ip)%ptr(jp,k) = VALJXX(klev-k+1, ip_f)*jfacta(ip)
          ENDDO
        ENDIF
      ENDDO
    ENDDO

    !-------------------------------------------------------------------------

  END SUBROUTINE cloudjvalues

  ! **************************************************************************

  SUBROUTINE cloudj_read_nml_ctrl(status, iou)

    ! read CTRL namelist

    USE messy_main_tools, ONLY: read_nml_open, read_nml_check, read_nml_close

    IMPLICIT NONE

    ! I/O
    INTEGER, INTENT(IN)  :: iou    ! logical I/O unit
    INTEGER, INTENT(OUT) :: status ! error status

    ! LOCAL
    CHARACTER(LEN=*), PARAMETER  :: substr = 'cloudj_read_nml_ctrl'
    LOGICAL                      :: lex          ! file exists?
    INTEGER                      :: fstat        ! file status

    NAMELIST /CTRL/ NAMFIL_FJX_spec, NAMFIL_FJX_scat_cld, &
      NAMFIL_FJX_scat_aer, NAMFIL_FJX_scat_UMa, NAMFIL_atmos_std, &
      NAMFIL_FJX_j2j

    ! initialize
    status = 1 ! error

    CALL read_nml_open(lex, substr, iou, 'CTRL', modstr)
    IF (.NOT.lex) RETURN    ! <modstr>.nml does not exist

    READ(iou, NML = CTRL, IOSTAT = fstat)
    CALL read_nml_check(fstat, substr, iou, 'CTRL', modstr)
    IF (fstat /= 0) RETURN  ! error while reading namelist

    CALL read_nml_close(substr, iou, modstr)

    status = 0 ! no error

  END SUBROUTINE cloudj_read_nml_ctrl

  ! ****************************************************************************

  ! mz_rs_20200714+
  ! To keep the code DRY, SUBROUTINE combine_o3_fields (which was
  ! identical in JVAL and CLOUDJ) has been moved to main_tools
  ! mz_rs_20200714-

! ****************************************************************************

END MODULE messy_cloudj

! ****************************************************************************
