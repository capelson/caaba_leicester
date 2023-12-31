MODULE messy_dissoc

  ! ****************************************************************************
  !  MESSy MODULE FOR DISSOC (used in CLaMS)
  !
  !    == CALCULATION OF STRATOSPHERIC PHOTOLYSIS FREQUENCIES ==
  !
  !  Author: Jens-Uwe Grooss
  !  (IEK-7, Forschungszentrum Juelich, j.-u.grooss@fz-juelich.de)
  !  developed from CLaMS photolysis module by JUG, January 2014
  !
  !  Copyright (c) 2010 - 2018
  !  Jens-Uwe Grooss, Daniel S. McKenna, Rolf Mueller, Nicole Thomas,
  !  David Lary, Gaby Becker, Thomas Breuer
  !  Forschungszentrum Juelich GmbH
  !
  !  This program is free software; you can redistribute it and/or modify
  !  it under the terms of the GNU General Public License as published by
  !  the Free Software Foundation; either version 2 of the License, or
  !  (at your option) any later version. This program is distributed in
  !  the hope that it will be useful, but WITHOUT ANY WARRANTY; without
  !  even the implied warranty of MERCHANTABILITY or FITNESS FOR A
  !  PARTICULAR PURPOSE. See the GNU General Public License for more
  !  details. You should have received a copy of the GNU General Public
  !  License along with this program. If not, see
  !  <https://www.gnu.org/licenses/>.
  !
  !   =====               CODE HISTORY AND EXPLANATION                    =====
  !
  !  * Radiation scheme by Meier et al., Planet. Space Sci., 30, 923 933 (1982)
  !
  !  * Initial implementation by David Lary  
  !    (Lary and Pyle, J. Atmos. Chem. 13, 373 406, 1991)
  !
  !  * Coupled to FACSIMILE Mainz box model (Rolf Mueller and Thomas Peter, 1992)
  !
  !  * Improvement of the treatment of the diffuse actinic flux and error
  !    correction (Becker et al., J. Atmos. Chem., 37, 217-229, 2000)
  !
  !  * Development as photolysis module for CLaMS by R. Mueller, G. Becker and 
  !    J.-U. Grooss  (McKenna et al., J. Geophys. Res., 107 (D15), 4256, 
  !    doi:10.1029/2000JD000113, 2002)
  !
  !  * Extension switch "davg" for calculation of diurnally averaged photolysis 
  !    frequencies for the use in a simplified chemistry scheme by J.-U. Grooss
  !    (Pommrich et al., Geosci. Model Dev. Discuss., 4, 1185-1211, 2011)   
  !
  !  * Adaption to MESSy interface structure by Thomas Breuer and Jens-Uwe
  !    Grooss (2012-2014)
  !    (Thomas Breuer, Erweiterung des Modular Earth Submodel System um das 
  !    CLaMS-Photolysemodul DISSOC sowie Vergleich mit JVAL, Bachelor thesis, 
  !    Juelich, 2012)
  !
  !    ju_jg_20181212
  !  * Major code structure change: variables for absorption cross sections (a<spec>)
  !    and photolysis rates (aj<spec> ) are defined as private variables in the
  !    module head. They do not need to be transferred at each subroutine call.
  !
  !    ju_jg_20190617
  !  * added species Ch3Br and Halons H1211 (CF2ClBr) and H1301 (CF3Br)
  !
  !   =====               CODE DESCRIPTION                                =====
  ! 
  !  * Input of ozone profile (latitude dependent) from external file (o3dat)
  !    in routine reado3 (also altitude, O2, Temperature)
  !
  !  * Interpolation onto dissoc pressure level grid (defined in setp), ozone 
  !    concentrations (do3 etc.) are handled as MESSy channel objects 
  !    (messy_do3c etc.)
  !
  !  * Input of p/T independent absorption cross sections and solar irradiance
  !    at the top of the atmosphere from ASCII input files located in
  !    directory datdir (= "photodata/")
  !
  !  * Calculation of 4-dim "enhancement factor table" tabs (pressure, zenith
  !    angle, wavelength, latitude) in subroutine settab as MESSy channel 
  !    object dissoc_tabs assuming spherical geometry
  !    Rayleigh scattering is calculated based on Nicolet (1984).
  ! 
  !  * On demand (switch davg) Calculation of 3-dim "enhancement factor table" 
  !    tabs_davg (pressure, wavelength, latitude) as MESSy channel object 
  !    dissoc_tabs_davg for diurnally averaged photolysis rates
  !
  !  * Update of this table on demand, typically every month. 
  !    (calc_photolysis_table / calc_davg)
  !
  !  * calculation of temperature and pressure dependent absorption cross
  !    sections for each air parcel (acstdp)
  !  
  !  * calculation of photolysis rates (calcjs)
  !
  ! **************************************************************************
  
  USE messy_main_constants_mem, ONLY: DP, SP, pi, dtr &
                                    , boltz => k_B, radius_earth
  USE messy_main_tools,         ONLY: PTR_2D_ARRAY
  USE messy_cmn_photol_mem   !, ONLY: IP_MAX, ip_*
      
  IMPLICIT NONE
  PRIVATE ! op_pj_20150728: set default

  CHARACTER(LEN=*),PARAMETER, PUBLIC :: modstr = 'dissoc'
  CHARACTER(LEN=*),PARAMETER, PUBLIC :: modver = '1.2'

  INTEGER,    PARAMETER, PUBLIC ::  prec = dp
  REAL(PREC), PARAMETER, PUBLIC ::  mdi=-1.00+30_dp  ! missing data indicator
  REAL(PREC), PARAMETER, PUBLIC ::  eps=1E-6_dp      ! used by comparisons of real values

  ! make USEd through variables / parameters PUBLIC for SMIL
  PUBLIC :: IP_MAX, dp, dtr

  ! pointer to photolysis rate coeff.
  TYPE(PTR_2D_ARRAY), PUBLIC, DIMENSION(:), POINTER, SAVE  :: dissoc_2d

  ! GLOBAL PARAMETERS
  !     total number of zenith angles: jpschi
  integer, parameter, public :: jpschi = 20
  !     number of zenith angles at > 90 degrees: jpsover.
  integer, parameter, public :: jpsover = 8
  !     index of the 90 degree zenith angle in the tabulations: jpschin.
  integer, parameter, public :: jpschin = jpschi - jpsover
  !     Number of levels in scattering table: jpslevall.
  !     Make sure that JPSLEVALL is an even number:
  !     number of level edges.
  integer, parameter, public :: jpslevall = 36
  !     number of level centres: jpslev.
  integer, parameter, public :: jpslev = jpslevall - 1
  !     number of wavelength intervals: jpwave.
  integer, parameter, public :: jpwave = 203

  !     maximum possible number of latitudes with o3 profiles
  integer, parameter, public :: jplats = 34
  !     used number of latitudes
  integer, public :: nlats

  ! top pressure level that is used by the photolysis code
  real(kind=DP), parameter :: ptop = 0.1D0

  ! Wavelength range index used in calculations
  integer, parameter :: jplo = 45
  integer, parameter :: jphi = jpwave

  !  lsw:   Whether or not multiple scattering is included.
  logical, parameter :: lsw = .true.

  integer :: jday, month_o3
  real(kind=DP), public :: albedo
  real(kind=DP), public :: mean_albedo = 0.4_dp

  !  davg: switch for calculating diurnally averaged photolysis rates
  logical, public :: davg

  ! op_pj_20150727: ideally, all data import should be performed via IMPORT
  !  o3dat: filename of ozone profile
  character(len=100), public :: o3dat

  !  datdir: directory of ASCII input files
  ! op_pj_20150728+:  must be modified via namelist ...
  character(len=200), public :: datdir = "photodata/"
  ! op_pj_20150728-

  ! ju_nt_20180620+
  ! timestep_dissoc: timestep for calling dissoc (sec) in sub. dissoc_global_end
  ! timestep_dissoc_gp: timestep for calling dissoc (sec)
  !                     for grid-point data in sub. dissoc_physc
  integer, public :: timestep_dissoc = 0  
  integer, public :: timestep_dissoc_gp = 0 
  ! ju_nt_20180620-
  
  !----------------------------------------------------------------------------
  ! physical constants
  
  ! Boltzmann constant
! op_pj_20150728: use constant from messy_main_constants_mem, see above
!!$  real(kind=DP), parameter, public :: boltz = 1.38066E-23
  ! Radius of Earth
! op_pj_20150728: use constant from messy_main_constants_mem, see above
!!$  real(kind=DP), parameter, public :: re = 6.371E3
  real(kind=DP), parameter, public :: re = radius_earth/1000._dp ! [km]
 
  !----------------------------------------------------------------------------
  !  Variables used internally in all dissoc subroutines

  ! photolysis rates ** DECLARED ONLY HERE **
  real(kind=DP) :: aj2, aj3, aj3a, ajccl4, ajch2oa, ajch2ob, ajch3o2h, ajbrno3, &
        ajbrcl, ajoclo, ajcl2, ajcl2o2, ajcnit, ajcnita, ajclno2, ajf11, ajf113, ajf12, &
        ajf22, ajh2o, ajh2o2, ajhcl, ajhno3, ajhocl, ajmc, ajn2o, ajn2o5, &
        ajno, ajno2, ajno31, ajno32, ajpna, ajhobr, ajch3ocl, ajbr2, ajbro, &
        ajch3br, ajh1211, ajh1301
  
  ! absorption cross sections ** DECLARED ONLY HERE **
  real(kind=DP), dimension(jpwave) :: accl4, ach2o, ach3o2h, abrno3,  &
       abrcl, aoclo, acl2, acl2o2, aclno2, acnit, qecnit,  aco2, af11, &
       af113, af12, &
       af22, ah2o, ahcl, ahno2, ahno3, ahocl, amc, an2o, an2o5, ano, ano2, &
       ao2, ao2sr, ao3, apna, ahno3298, bhno3, ano20, qeno31, qeno32, tdepno2, &
       abr2, abro, qeno2, qeo1d, qech2oa, &
       qech2ob, quanta, factor, wavecm, ahobr, ach3ocl, ano3, ah2o2, &
       ach3br, ah1211, ah1301
  real(kind=DP), dimension(jpwave) :: atoto2
  !
  real(kind=DP) , dimension(jpwave) :: angrad
  real(kind=DP) , dimension(3,jpwave) :: qeno31t, qeno32t
  !
  real(kind=DP) , dimension(2,jpwave) :: ano3t
  !
  real(kind=DP) , dimension(jpslevall,jplats) :: tem
  !
  real(kind=DP) , dimension(jpslev,jplats) :: zenmax
  !
  real(kind=DP) , dimension(jpslev,jpschi,jplats) :: tspo2
  !
  real(kind=DP) , dimension(jpslev,jpwave,jplats) :: ano_davg, ao2sr_davg

  real(kind=DP) ::  degrees, spco2, vco2, vco2b, minlat, dlat, dz, angle

  !----------------------------------------------------------------------------
  !  Variables used for input of ozone profile
  integer :: dim_pres_inp
  real(kind=DP), allocatable :: pres_inp(:)
  real(kind=DP), allocatable :: temp_inp(:,:), alt_inp(:,:), o3_inp(:,:)
! op_pj_20150710+: need to be PUBLIC, because of I/O in parallel decomposition
!                  needs to be performed on I/O PE with subsequent broadcast
!                  to non-I/O PEs (see SMIL)
  PUBLIC :: dim_pres_inp, pres_inp, temp_inp, alt_inp, o3_inp
! op_pj_20150710-

  !----------------------------------------------------------------------------
  !   variables transferred through MESSy channel objects

  REAL(kind=DP), DIMENSION(:), POINTER, PUBLIC   :: angdeg
  REAL(kind=DP), DIMENSION(:), POINTER, PUBLIC   :: wavenm
  REAL(kind=DP), DIMENSION(:), POINTER, PUBLIC   :: lats
  REAL(kind=DP), DIMENSION(:), POINTER, PUBLIC   :: pres
  REAL(kind=DP), DIMENSION(:), POINTER, PUBLIC   :: presc

  REAL(kind=DP), DIMENSION(:,:), POINTER, PUBLIC :: alt
  REAL(kind=DP), DIMENSION(:,:), POINTER, PUBLIC :: altc
  REAL(kind=DP), DIMENSION(:,:), POINTER, PUBLIC :: dtemp
  REAL(kind=DP), DIMENSION(:,:), POINTER, PUBLIC :: dtempc
  REAL(kind=DP), DIMENSION(:,:), POINTER, PUBLIC :: do2
  REAL(kind=DP), DIMENSION(:,:), POINTER, PUBLIC :: do2c
  REAL(kind=DP), DIMENSION(:,:), POINTER, PUBLIC :: do3
  REAL(kind=DP), DIMENSION(:,:), POINTER, PUBLIC :: do3c

  REAL(kind=DP), DIMENSION(:,:,:), POINTER, PUBLIC  :: tabs_davg 
  REAL(kind=DP), DIMENSION(:,:,:,:), POINTER, PUBLIC  :: tabs 

  ! logical array for mapping of photolysis rates
  LOGICAL, PUBLIC, DIMENSION(IP_MAX), SAVE :: jcalc = .FALSE.

  integer :: numj

  ! mz_rs_20180711+
  ! numj_max reduced by 1 because jcalc(ip_BrONO2) is deactivated
  ! ju_jg_20181212+
  ! In this version of the code, the jcalc(ip_BrONO2) has been activated again.
  ! if set to .false. the total BrONO2 photolysis rate is written to
  ! js1(ip_BrNO3), else it will be divided between js1(ip_BrNO3) and js1(ip_BrONO2)
  !
  integer, parameter:: numj_max = 42
  ! ju_jg_20181212-
  ! mz_rs_20180711-
  
  TYPE rate_type
     CHARACTER(len=9)                :: jname_messy
     CHARACTER(len=10)               :: reactant
     CHARACTER(len=10)               :: product1
     CHARACTER(len=10)               :: product2
     CHARACTER(len=50)               :: units
     CHARACTER(len=80)               :: longname
     REAL(DP), DIMENSION(:), POINTER :: values
  END TYPE rate_type
  PUBLIC :: rate_type

!!$  LOGICAL, PUBLIC :: loutput_dissoc = .true.

! op_j_20150728: - settab, setp, p_ascend PUBLIC, for I/O on SMIL
!                - calc_zenith PUBLIC
!                - dissoc_read_nml_ctrl: MESSy standard name
  PUBLIC :: dissoc, settab, setp, p_ascend, calc_zenith
  PUBLIC :: dissoc_read_nml_ctrl
  PUBLIC :: iniphoto, calc_davg, reado3


!----------- 
CONTAINS
!----------- 

!!!!!!!!!!!!!!!!!!!!!!!!!! -*- Mode: F90 -*- !!!!!!!!!!!!!!!!!!!!!!!!


subroutine dissoc(t, p, lati, angle, js1)

    !-----------------------------------------------
    !     calculates photolysis rates using the LARY scheme (Lary et al, 1991)
    !
    !     updated version for temp. dependent HNO3 photolysis
    !     R.Mueller/Th.Peter Nov. 2, 1992
    !     R.Mueller Sept. 8, 1993 einbau der Photolyse raten fuer die
    !     Br-Chemie
    !
    !     adjusted to version 10 of Lary code (photosub10.f)
    !     that was improved by Gaby Becker
    !     J.U. Grooss, 9.12.1997
    !
    !     Fortran90 version of the code prepared March 1998 with help of
    !     G.Groten, ZAM
    !
    !     f90 version of subroutine dissoc finished (23.07.1998, J.U. Grooss)
    !  
    !     BrO photolysis included (jug, rm, 05.01.2000)
    !
    !     pathlengths corrected for zenith angles > 90 degrees (jug, 5.10.2010)
    !
    !
    !     Adaption to MESSy (T. Breuer, 2012)
    !
    !     Include switch davg (jug, 2011)
    !     This version of dissoc calculates diurnal average photolysis rates 
    !     depending on latitude and time of year (jug, 12.06.2007)
    !     To activate this version, the logical variable davg must be set to true
    !
    !     NB: davg interpolates factor between latitudes of the ozone profile
    !     while .not. davg gets the nearest latitude 
    !
    !-----------------------------------------------
    !   M o d u l e s
    !-----------------------------------------------

! op_pj_20150728: SMCL files merged into one file
!!$    use messy_dissoc_global, only: &
!!$         jpslev, jpslevall, jpschi, jpwave, jplats, nlats, ptop, &
!!$         albedo, davg, o3dat, tabs, tabs_davg, angdeg, angrad, lats 
!!$    use messy_cmn_photol_mem
    implicit none

    !-----------------------------------------------
    !   A r g u m e n t s
    !-----------------------------------------------
       
    real(kind=DP),intent(in) :: t, p, lati, angle

    real(kind=DP),intent(out):: js1(IP_MAX)

    !-----------------------------------------------
    !   L o c a l   P a r a m e t e r s
    !-----------------------------------------------
    logical, parameter :: lprint = .false.
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jp, jx, jy, jyp1, jxp1, jl, jlp1, jpp1
    !
    integer :: i, idim, jdeg, jpress
    !
    !-------------------------------------------------------------------------
    !
    !     Start of model code.
    !
    !------------------------------------------------------------------------
    

    !-------------------------------------------------------------------------
    !
    !     Calculate js.
    !
    !-------------------------------------------------------------------------


    if (davg) then
      ! get latitude indices jl, jlp1 and fraction dlat
      if (lati<lats(1)) then 
        jl=1
        jlp1=1
        dlat=0.
      else
        call pos(lats,nlats,lati,jl)
        jlp1=jl+1
        if (jl==nlats) then 
          jlp1=nlats
          dlat=0.
        else
          dlat=(lati-lats(jl))/(lats(jlp1)-lats(jl))
        endif
      endif

      !
      !        Set up the cross-sections for this pressure & temperature.
      call acstdp (t, p)

      call pos (presc, jpslev, p, jp)

      ! check also the case jp=0, if point is below the mid of the lowest level.
      ! jug, 31.07.2007
      if (jp < jpslev .and. jp > 0) then 
         jpp1=jp+1
         dz=(p-presc(jp)) / (presc(jpp1)-presc(jp))
         if (dz >1.0 .or. dz < 0.0) stop 'Interpolationsfehler in dissoc_davg'
      else
         jp = max(jp, 1)
         jpp1=jp
         dz=0.
      endif 

      !
      !        Calculate the NO pressure dependent absorption cross section.
      ano = (ano_davg(jp,:,jl)*(1.-dlat) + ano_davg(jp,:,jlp1)*dlat) * (1.-dz) + &
            (ano_davg(jpp1,:,jl)*(1.-dlat) + ano_davg(jpp1,:,jlp1)*dlat) * dz
      !
      !        Schumann-Runge bands.
      ao2sr=(ao2sr_davg(jp,:,jl)*(1.-dlat) + ao2sr_davg(jp,:,jlp1)*dlat) * (1.-dz) + &
            (ao2sr_davg(jpp1,:,jl)*(1.-dlat) + ao2sr_davg(jpp1,:,jlp1)*dlat) * dz

      !
      !        Set up enhancement factor array.
      factor = (tabs_davg(jp,:,jl)*(1.-dlat) + tabs_davg(jp,:,jlp1)*dlat) * (1.-dz) + &
               (tabs_davg(jpp1,:,jl)*(1.-dlat) + tabs_davg(jpp1,:,jlp1)*dlat) * dz
  
    else     ! case not davg:
      ! get nearest latitude index jl
      minlat=180.
      jl = 1   ! pre-setting jl (needed if lat==mdi)
      do i=1,nlats
         dlat=abs(lati-lats(i))
         if (dlat < minlat) then
            jl = i
            minlat=dlat
         end if
      end do
      !
      !        Set up the cross-sections for this pressure & temperature.
      call acstdp (t, p)
      !
      !        Calculate the NO pressure dependent absorption cross section.
      call find2 (p, 0.0_DP, vco2, presc, angrad, tspo2, jpslev, jpschi,&
                  jplats,jl)
      call acsno (angle, p, vco2)
      !
      !        Schumann-Runge bands.
      call pos (presc, jpslev, p, jp)
      if (jp <= 0) jp = 1
      if (angle <= zenmax(jp,jl)) then
         call find2 (p, angle, spco2, presc, angrad, tspo2, jpslev, &
              jpschi, jplats,jl)
         call acssr (spco2)

      else
         ao2sr=0.0
      endif

      !
      !        Set up enhancement factor array.
      call findindex (p, angle, presc, angrad, jpslev, jpschi, jx, &
           jxp1, jy, jyp1)
      call findvect2 (p, angle, factor, presc, angrad, tabs, jpslev, &
           jpschi, jpwave, jplats, jplo, jphi, jx, jxp1, jy, jyp1, jl)

    endif  ! davg


    !
    !        Calculate the js using the appropriate cross-sections
    !        which have just been calculated.
    call calcjs(jplo, jphi)
    !
    ! Set output array JS1, indices from MESSY module messy_cmn_photol_mem
    ! photolysis rates with jcalc(ip_xxx) == .false. are set to zero
    ! Ox-species:;
    js1(ip_O2)     = aj2           ! O2 + hv -> O + O
    js1(ip_O3P)    = aj3           ! O3 + hv -> O2 + O(3P)
    js1(ip_O1D)    = aj3a          ! O3 + hv(<310nm) -> O2 + O(1D)

    ! HOx-species:;
    js1(ip_H2O2)   = ajh2o2        ! H2O2 + hv -> OH + OH

    ! ClOx-species:;
    js1(ip_Cl2)    = ajcl2         ! Cl2 + hv -> Cl + Cl
    js1(ip_Cl2O2)  = ajcl2o2       ! Cl2O2 + hv -> Cl2O + Cl
    js1(ip_HOCl)   = ajhocl        ! HOCl + hv -> OH + Cl
    js1(ip_ClNO2)  = ajclno2       ! ClNO2 + hv -> Cl + NO2
    js1(ip_ClNO3)  = ajcnit        ! ClONO2 + hv -> Cl + NO3
    ! addition of ClONO2 + hv --> ClO + NO2 (J.-U. Grooss, B.Vogel 5/00)
    js1(ip_ClONO2) = ajcnita       ! ClONO2 + hv -> ClO + NO2

    ! NOx-species:;
    js1(ip_HNO3)   = ajhno3        ! HNO3 + hv -> NO2 + OH 
    js1(ip_NO2)    = ajno2         ! NO2 + hv -> NO + O(3P)
    js1(ip_N2O5)   = ajn2o5        ! N2O5 + hv -> NO2 + NO3
!!    js1(ip_HNO4)   = ajpna         ! HO2NO2 + hv -> products

!   define the two channels in module
    js1(ip_HO2NO2)= ajpna*0.67    ! HO2NO2 + hv -> HO2 + NO2
    js1(ip_OHNO3) = ajpna*0.33    ! HO2NO2 + hv -> OH + NO3
    js1(ip_NO2O)  = ajno32        ! NO3 + hv -> NO2 + O
    js1(ip_NOO2)  = ajno31        ! NO3 + hv -> NO + O2

    ! Hydrocarbons:;
    js1(ip_COH2)   = ajch2ob       ! CH2O + hv   -> CO + H2
    js1(ip_CHOH)   = ajch2oa       ! CH2O + hv   -> CHO + H
    js1(ip_CH3OOH) = ajch3o2h      ! CH3O2H + hv -> products

    ! Br-chemistry species:;
    ! ju_jg_20181212+ see comment above
    ! mz_rs_20180613+ see email from JUG, 2018-06-12
    if (jcalc(ip_BrONO2)) then 
       js1(ip_BrONO2)= ajbrno3*0.15  ! BrONO2 + hv -> BrO + NO2
       js1(ip_BrNO3) = ajbrno3*0.85  ! BrONO2 + hv -> Br + NO3
    else   
       js1(ip_BrONO2) = 0.0 
       js1(ip_BrNO3) = ajbrno3        ! BrONO2 + hv -> products
    endif   
    ! mz_rs_20180613-
    ! ju_jg_20181212-

    js1(ip_BrCl)   = ajbrcl        ! BrCl + hv -> Br +Cl
    js1(ip_OClO)   = ajoclo        ! OClO + hv -> O + ClO

    ! additional photolysis rates: (J.U.Grooss 6/94)
    js1(ip_H2O)    = ajh2o         ! H2O + hv -> H + OH
    js1(ip_HCl)    = ajhcl         ! HCl + hv -> H + Cl
    js1(ip_NO)     = ajno          ! NO + hv -> N + O
    js1(ip_N2O)    = ajn2o         ! N2O + hv -> N2 + O(1D)

    ! addition of CH3OCl (R. Mueller 11/94)
    js1(ip_CH3OCl)= ajch3ocl      ! CH3OCl + hv -> products

    ! addition of HOBR (R. Mueller; Th. Woyke 02/96)
    js1(ip_HOBr)   = ajhobr        ! HOBr + hv -> Br + OH

    ! addition of BR2 (G.Becker 11/97)
    js1(ip_Br2)    = ajbr2         ! Br2 + hv -> Br + Br

    ! set CH3O2NO2 photolysis equal to HO2NO2 (PNA) until better knowledge
    js1(ip_MEO2NO2) = ajpna
    js1(ip_BrO)    = ajbro         ! BrO + hv -> O + Br

    js1(ip_CFCl3)  = ajf11         ! CFCl3 + hv -> 3Cl + products
    js1(ip_CF2Cl2) = ajf12         ! CF2Cl2 + hv -> 2Cl + products
    js1(ip_CHF2Cl) = ajf22         ! CHF2Cl + hv -> Cl + products
    js1(ip_F113)   = ajf113        ! CF2CFCl3 + hv -> 3Cl + products
    js1(ip_CH3Cl)  = ajmc          ! CH3Cl + hv -> CH3 + Cl
    js1(ip_CCl4)   = ajccl4        ! CCl4 + hv -> 4Cl + products
    js1(ip_CH3Br)  = ajch3br       ! CH3Br + hv -> Br + CH3
    js1(ip_CF2ClBr)= ajh1211       ! CF2ClBr + hv -> products
    js1(ip_CF3Br)  = ajh1301       ! CF3Br + hv -> products


    return
end subroutine dissoc

  !------------------------------------------------------------------------
  !************************************************************************
  !
  subroutine acsccl4(t)
    implicit none
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   P a r a m e t e r s
    !-----------------------------------------------
    real(kind=DP), parameter :: a0 = -37.104
    real(kind=DP), parameter :: a1 = -5.8218E-1
    real(kind=DP), parameter :: a2 = 9.9974E-3
    real(kind=DP), parameter :: a3 = -4.6765E-5
    real(kind=DP), parameter :: a4 = 6.8501E-8
    real(kind=DP), parameter :: b0 = 1.0739
    real(kind=DP), parameter :: b1 = -1.6275E-2
    real(kind=DP), parameter :: b2 = 8.8141E-5
    real(kind=DP), parameter :: b3 = -1.9811E-7
    real(kind=DP), parameter :: b4 = 1.5022E-10
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw
    real(kind=DP) :: tc, lam, lam2, lam3, lam4, arg
    !-----------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !     USED PRIVATE VARIABLES:
    !
    !     ACCL4    Array of real(kind=DP)      Absorption cross-section of CCl4 in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the carbon tetra chloride (CCl4)
    !     absorption cross section based on P. C. Simon et al. (1988).
    !
    !     Journal of atmospheric chemistry, Vol. 7, pp. 107-135, 1988.
    !
    !     This is done via a polynomial expression of the form;
    !     log10(sigma)=A(lamda) + T B(lamda)
    !
    !     The expression is valid for the wavelength range; 194-250 nm
    !                            and the temperature range; 210-300 K.
    !
    !     David Lary
    !     ----------
    !
    !     Date Started : 18/2/1990
    !
    !     Last modified: 6/9/1991
    !
    !-------------------------------------------------------------------------
    !
    !
    !     Temperature in Kelvin.
    !
    !-----------------------------------------------------------------------
    !
    !     Check that temperature is in range.
    tc = t
    tc = min(300.0_DP,tc)
    tc = max(210.0_DP,tc)
    !
    !-----------------------------------------------------------------------
    !
    !     Wavelength loop.
    do jw = 57, 79
      !
      !        Wavelength in nm.
      lam = wavenm(jw)
      !
      lam2 = lam*lam
      lam3 = lam*lam2
      lam4 = lam*lam3
      !
      ! jug following line changed tc -tc -273 according to JPL and Simon et al., 1988
      arg = a0 + a1*lam + a2*lam2 + a3*lam3 + a4*lam4 + &
            (tc-273.)*(b0 + b1*lam +  b2*lam2 + b3*lam3 + b4*lam4)
      !
      accl4(jw) = 10.0**arg
      !
      !     End of the wavelength loop.
    end do
    !------------------------------------------------------------------------
    !
    return
  end subroutine acsccl4


  !------------------------------------------------------------------------
  !C************************************************************************
  !
  subroutine acsh2o2(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw, i
    real(kind=DP) :: tc, chi
    real(kind=DP) , dimension(8) :: a
    real(kind=DP) , dimension(5) :: b
    real(kind=DP) :: h1, h2
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    
    !     AH2O2    Array of real(kind=DP)      Absorption cross-section of H2O2 in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the temperature dependent H2O2
    !     absorption cross section between 260 nm & 350 nm.
    !     JPL97 (Nicovic and Wine)
    !
    !     G. Becker
    !     ----------
    !
    !     Date Started : 24-OCT-1997
    !
    !     Last modified: 24-OCT-1997
    !

    data a/ 6.4761E4_DP, -9.2170972E2_DP, 4.535649_DP, -4.4589016E-3_DP, &
           -4.035101E-5_DP, 1.6878206E-7_DP, -2.652014E-10_DP, 1.5534675E-13_DP/

    data b/6.8123E3_DP,-5.1351E1_DP,1.1522E-1_DP,-3.0493E-5_DP,-1.0924E-7_DP/


    !     Check that temperature is in range.
    tc = t
    tc = min(400.0_DP,tc)
    tc = max(200.0_DP,tc)

    chi = 1/(1 + exp(-1265./tc))

    do jw = 1, jpwave
      if (wavenm(jw)<=350 .and. wavenm(jw)>=260) then
        h1 = 0.0
        h2 = 0.0
        do i = 1, 8
          h1 = h1 + a(i)*wavenm(jw)**(i - 1)
        end do
        do i = 1, 5
          h2 = h2 + b(i)*wavenm(jw)**(i - 1)
        end do
        ah2o2(jw) = 1.0E-21*(chi*h1 + (1.0 - chi)*h2)
      else
        ah2o2(jw) = 0.0
      endif
    end do
    return
    !
  end subroutine acsh2o2


  !
  !-------------------------------------------------------------------------
  !
  !
  subroutine acshno3(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    real(kind=DP) :: tm298
    !-----------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the temperature dependent HNO3
    !     absorption cross section between 190 nm & 330 nm.
    !     originally based on Rattigan, Buns. Ber. 1992
    !     corrected with measurements by Burkholder et al
    !     (extension to larger wavelenghth regime still necessary!!!!)
    !
    !     Rolf Mueller/ Thomas Peter
    !     ----------
    !
    !     Date Started : 1.Nov.1992
    !
    !     Last modified: 30.July.1993
    !
    !     Last modified: 2.Nov.97 G.Becker
    !-------------------------------------------------------------------------
    !
    !
    !     Temperature in Kelvin.
    !
    !
    !
    !     Parameters for the parametrisation by Rattigan et. al
    !     Numbers from Burkholder et al !!

    !
    !      Calculate the temperature dependent HNO3 cross section,
    !      using the parameterisation of Rattigan et al.
    !      J. Photochem. Photobiol. A: Chem. 66 (1992) 313-326
    !
    !-----------------------------------------------------------------------
    !
    !     Prepare Computations
    tm298 = t - 298.0
    !
    !     calculate ahno3 on rattigans wavelengths grid
    ahno3 = ahno3298*exp(bhno3*tm298)

    !
    !-----------------------------------------------------------------------
    !
    return
  end subroutine acshno3


  !------------------------------------------------------------------------
  !************************************************************************
  !
  subroutine acscnit(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in)    :: t
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer, parameter :: nburk = 63
    integer :: jw, jz, i
    real(kind=DP) :: tm296, awave
    real(kind=DP), dimension(nburk), save:: aburk

    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     USED PRIVATE VARIABLES:
    !
    !     ACNIT    Array of real(kind=DP)      Absorption cross-section of ClONO2 in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the temperature dependent ClONO2
    !     absorption cross section between 195 nm & 432 nm.
    !     based on  measurements by Burkholder et al. 1994
    !     GRL, Vol 21.0, P. 585
    !
    !     Rolf Mueller
    !     ----------
    !
    !     Date Started : 31. Oct. 1994
    !
    !     Last modified: 28. Mar. 2019
    !
    !-------------------------------------------------------------------------
    !
    !
    !     Temperature in Kelvin.
    !
    !     Parametrisation and Numbers from Burkholder et al. 1994
    !     195 to 432 nm, given with an constant spacing of DWBURK(=1) nm
    !
    !-----------------------------------------------------------------------
    !
    !      Calculate the temperature dependent CLONO2 cross section,
    !      using the parameterisation by Burkholder et al. 1994
    !
    !-----------------------------------------------------------------------

    !-----------------------------------------------------------------------
    !      Data from Burkholder et al. 1994  
    !      re-structured from former module sigcnit_M  (Jens-Uwe Grooss, 01/2014)
    !
    !      ju_jg_20190328: parameters pre-interpolated onto model wavelenth grid 
    !--------------------------------------------------------------------------

    ! ju_jg_20190328+: 
    ! wavelength intervals 57 to 119 (195.1 to 430 nm)
    integer, parameter:: jw_min = 57
    integer, parameter:: jw_max = 119
    real(kind=DP), dimension(nburk), parameter :: wb = (/&
      195.1, 197.0, 199.0, 201.0, 203.1, 205.1, 207.3, 209.4, 211.6, 213.9, &
      216.2, 218.6, 221.0, 223.5, 226.0, 228.6, 231.2, 233.9, 236.7, 239.5, &
      242.4, 245.4, 248.5, 251.6, 254.8, 258.1, 261.4, 264.9, 268.5, 272.1, &
      275.9, 279.7, 283.7, 287.8, 292.0, 296.3, 300.8, 305.3, 310.0, 315.0, &
      320.0, 325.0, 330.0, 335.0, 340.0, 345.0, 350.0, 355.0, 360.0, 365.0, &
      370.0, 375.0, 380.0, 385.0, 390.0, 395.0, 400.0, 405.0, 410.0, 415.0, &
      420.0, 425.0, 430.0/)
    ! These numbers are for only for reference / wavelength interpolation was pre-calulated to these intervals
    ! Note: This routine does only work with these standard wavelength intervals!!

    ! parameter a296 (including factor 1E-20)
    real(kind=DP), dimension(nburk), parameter :: a296 =   (/ &
      3.181E-18, 3.020E-18, 2.860E-18, 2.790E-18, 2.782E-18, 2.835E-18, 2.958E-18, 3.104E-18, 3.258E-18, 3.385E-18, &
      3.446E-18, 3.392E-18, 3.230E-18, 2.969E-18, 2.640E-18, 2.265E-18, 1.923E-18, 1.591E-18, 1.316E-18, 1.084E-18, &
      8.962E-19, 7.438E-19, 6.073E-19, 5.130E-19, 4.353E-19, 3.702E-19, 3.155E-19, 2.663E-19, 2.214E-19, 1.841E-19, &
      1.498E-19, 1.211E-19, 9.517E-20, 7.335E-20, 5.500E-20, 4.010E-20, 2.969E-20, 2.194E-20, 1.600E-20, 1.150E-20, &
      8.310E-21, 6.100E-21, 4.660E-21, 3.670E-21, 3.020E-21, 2.600E-21, 2.290E-21, 2.110E-21, 2.000E-21, 1.800E-21, &
      1.590E-21, 1.400E-21, 1.210E-21, 1.060E-21, 9.090E-22, 7.620E-22, 6.380E-22, 5.470E-22, 4.440E-22, 3.690E-22, &
      3.160E-22, 2.450E-22, 1.890E-22 /)

    real(kind=DP), dimension(nburk), parameter :: a1 =   (/ &
      1.026E-04, 8.760E-05, 3.640E-05,-5.760E-05,-1.943E-04,-3.436E-04,-5.102E-04,-6.576E-04,-7.840E-04,-8.710E-04, &
     -9.024E-04,-8.716E-04,-7.840E-04,-6.375E-04,-4.530E-04,-2.358E-04,-7.880E-06, 2.189E-04, 4.154E-04, 5.635E-04, &
      6.780E-04, 7.814E-04, 9.085E-04, 1.076E-03, 1.268E-03, 1.444E-03, 1.590E-03, 1.736E-03, 1.880E-03, 2.024E-03, &
      2.195E-03, 2.368E-03, 2.548E-03, 2.740E-03, 2.950E-03, 3.280E-03, 3.720E-03, 4.117E-03, 4.530E-03, 4.980E-03, &
      5.400E-03, 5.740E-03, 5.920E-03, 5.850E-03, 5.510E-03, 4.920E-03, 4.020E-03, 3.270E-03, 2.700E-03, 2.080E-03, &
      1.330E-03, 7.640E-04, 3.530E-04, 2.370E-04, 4.100E-04, 7.720E-04, 1.380E-03, 2.150E-03, 3.380E-03, 4.880E-03, &
      6.700E-03, 8.090E-03, 9.720E-03 /)

    real(kind=DP), dimension(nburk), parameter :: a2 =  (/ &
     -8.425E-06,-8.230E-06,-7.820E-06,-7.510E-06,-7.455E-06,-7.613E-06,-7.931E-06,-8.302E-06,-8.682E-06,-9.026E-06, &
     -9.252E-06,-9.362E-06,-9.370E-06,-9.270E-06,-9.060E-06,-8.650E-06,-7.988E-06,-7.132E-06,-6.366E-06,-6.005E-06, &
     -6.080E-06,-6.444E-06,-6.560E-06,-6.034E-06,-5.082E-06,-4.198E-06,-3.496E-06,-2.742E-06,-1.875E-06,-9.844E-07, &
      6.108E-08, 1.132E-06, 2.135E-06, 3.052E-06, 3.740E-06, 5.289E-06, 7.776E-06, 9.878E-06, 1.200E-05, 1.490E-05, &
      1.840E-05, 2.270E-05, 2.700E-05, 3.010E-05, 3.110E-05, 2.860E-05, 2.070E-05, 1.380E-05, 8.590E-06, 2.030E-06, &
     -7.400E-06,-1.440E-05,-1.910E-05,-2.120E-05,-2.050E-05,-1.870E-05,-1.420E-05,-7.150E-06, 4.470E-06, 1.930E-05, &
      3.870E-05, 5.570E-05, 7.520E-05 /)


    !-----------------------------------------------------------------------
    !
    !     Prepare Computations
    tm296 = t - 296.0
    !
    !     calculate acnit on Burks wavelengths grid
    aburk(:) = a296(:) * (1 + a1(:) * tm296 + a2(:) * tm296 * tm296)
    !
    acnit(:) = 0.
    acnit(jw_min:jw_max) = aburk(:)
    !
    !-----------------------------------------------------------------------
    !
    ! ju_jg_20190328-: 
    return
  end subroutine acscnit

  subroutine quantcnit
    ! add quantum yield ClONO2 -> Cl + NO3 (JPL 97)
    ! 09.05.2000 J.-U. Grooss  /B. Vogel
    integer :: jw
    do jw = 1, jpwave
      if (wavenm(jw) <= 308.) then
        qecnit(jw)=0.6
      else if (wavenm(jw) > 308. .and. wavenm(jw) < 364.) then
        qecnit(jw)=7.143E-3*wavenm(jw)-1.6
      else if (wavenm(jw) >= 364.) then
        qecnit(jw)=1.0
      endif
    end do
  end subroutine quantcnit

  !------------------------------------------------------------------------
  !************************************************************************
  !
  subroutine acsno2(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    real(kind=DP) :: tc
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     USED PRIVATE VARIABLES:
    !
    !     ANO20    Array of real(kind=DP)      Absorption cross-section of NO2 in
    !                                 cm^2 for temperature T=0 C for each
    !                                 interval wavelength.
    !                                 (Unchanged on exit).
    !
    !     TDEPNO2    Array of real(kind=DP)    temperature coefficient [cm^2/C] for each
    !                                 interval wavelength.
    !                                 (Unchanged on exit).
    !
    !     ANO2    Array of real(kind=DP)      Absorption cross-section of NO2 in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     T dependent NO2 cross section (JPL97) after Davidson et al.
    !
    !     G. Becker
    !     ----------
    !
    !     Date Started : 28. Oct. 1997
    !
    !     Last modified: 28. Oct. 1997
    !
    !-------------------------------------------------------------------------
    !
    !

    tc = t - 273.15
    ano2 = ano20 + tdepno2*tc
    return

  end subroutine acsno2


  !C************************************************************************
  !
  subroutine acsno3(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP), intent(in out) :: t
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer ::  i
    real(kind=DP) ::  tc, dt
    real(kind=DP) , dimension(2) :: tcr
    real(kind=DP), dimension(3) :: tqe
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     USED PRIVATE VARIABLES:
    !
    !     ANO3    Array of real(kind=DP)      Absorption cross-section of NO3 in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !     QENO31  Array of real(kind=DP)       quantum yield for NO3 channel 1
    !                                 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !     QENO32  Array of real(kind=DP)       quantum yield for NO3 channel 2
    !                                 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !     ANO3T    Array of real(kind=DP)      Absorption cross-section of NO3 in
    !                                 cm^2 for temperatures T=298/220K  for
    !                                 interval wavelength.
    !                                 (Unchanged on exit).
    !
    !     QENO31T  Array of real(kind=DP)       quantum yield for NO3 channel 1
    !                                 for temperature T=298/230/190K for each
    !                                 interval wavelength.
    !                                 (Unchanged on exit).
    !
    !     QENO32T  Array of real(kind=DP)       quantum yield for NO3 channel 2
    !                                 for temperature T=298/230/190K for each
    !                                 interval wavelength.
    !                                 (Unchanged on exit).
    !
    !------------------------------------------------------------------------
    !
    !
    !     G. Becker
    !     ----------
    !
    !     Date Started : 28. Oct. 1997
    !
    !     Last modified: 20. Jun. 2018
    !
    !     jug: multiple call of linfit slows down the performance of the code,
    !          replaced by inlined statements (20 Jun 2018)
    !-------------------------------------------------------------------------
    !
    !
    !

    data tcr/ 298, 220/
    data tqe/ 298, 230, 190/

    !     interpolate absorption corss section

    if (t <= tcr(2)) then
       ano3 = ano3t(2, :)
    else if (t >= tcr(1)) then
       ano3 = ano3t(1, :)
    else
       dt = (t - tcr(1)) / (tcr(2) - tcr(1))
       ano3 = ano3t(1, :) + dt * (ano3t(2, :) - ano3t(1, :))
    endif

    !     interpolate quantum yields
    if (t <= tqe(3)) then
       qeno31 = qeno31t(3, :)
       qeno32 = qeno32t(3, :)
    else if (t >= tqe(1)) then
       qeno31 = qeno31t(1, :)
       qeno32 = qeno32t(1, :)
    else
      tc = t
      call pos (tqe, 3, tc, i)
      dt = (tc - tqe(i)) / (tqe(i+1) - tqe(i))
      qeno31 =  qeno31t(i, :) + dt * (qeno31t(i+1, :) - qeno31t(i, :))
      qeno32 =  qeno32t(i, :) + dt * (qeno32t(i+1, :) - qeno32t(i, :))
    endif

    return

  end subroutine acsno3



  !************************************************************************
  !
  subroutine acsf11(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   P a r a m e t e r s
    !-----------------------------------------------
    real(kind=DP), parameter :: a0 = -84.611
    real(kind=DP), parameter :: a1 = 7.9551E-1
    real(kind=DP), parameter :: a2 = -2.0550E-3
    real(kind=DP), parameter :: a3 = -4.4812E-6
    real(kind=DP), parameter :: a4 = 1.5838E-8
    real(kind=DP), parameter :: b0 = -5.7912
    real(kind=DP), parameter :: b1 = 1.1689E-1
    real(kind=DP), parameter :: b2 = -8.8069E-4
    real(kind=DP), parameter :: b3 = 2.9335E-6
    real(kind=DP), parameter :: b4 = -3.6421E-9
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw
    real(kind=DP) :: tc, lam, lam2, lam3, lam4, arg
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     USED PRIVATE VARIABLES:
    !
    !     AF11     Array of real(kind=DP)      Absorption cross-section of F11 in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the F11 (CFCl3) absorption
    !     cross section based on P. C. Simon et al. (1988).
    !
    !     Journal of atmospheric chemistry, Vol. 7, pp. 107-135, 1988.
    !
    !     This is done via a polynomial expression of the form;
    !     log10(sigma)=A(lamda) + T B(lamda)
    !
    !     The expression is valid for the wavelength range; 174-230 nm
    !                            and the temperature range; 210-300 K.
    !
    !     David Lary
    !     ----------
    !
    !     Date Started : 18/2/1990
    !
    !     Last modified: 6/9/1991
    !
    !-------------------------------------------------------------------------
    !
    !
    !     Temperature in Kelvin.
    !
    !-----------------------------------------------------------------------
    !
    !     Check that temperature is in range.
    tc = t
    tc = min(300.0_DP,tc)
    tc = max(210.0_DP,tc)
    !
    !-----------------------------------------------------------------------
    !
    !     Wavelength.
    do jw = 45, 72
      !
      !        Wavelength in nm.
      lam = wavenm(jw)
      !
      lam2 = lam*lam
      lam3 = lam*lam2
      lam4 = lam*lam3
      !
      ! jug following line changed tc -tc -273 according to JPL and Simon et al., 1988
      arg = a0 + a1*lam + a2*lam2 + a3*lam3 + a4*lam4 + &
           (tc-273.)*(b0 + b1*lam +  b2*lam2 + b3*lam3 + b4*lam4)
      !
      af11(jw) = 10.0**arg
      !
      !     End of Wavelength loop.
    end do
    !
    !------------------------------------------------------------------------
    !
    return
  end subroutine acsf11


  !------------------------------------------------------------------------
  !************************************************************************
  !
  subroutine acsf12(t)

    !*** The old routine contained the parametrisation of Simon et al. (1988),
    !*** that is wrong according to JPL2006 !!!!  
    !***
    !*** now: CFC-12 parametrisation after JPL-2006/JPL-2011 (jug, 7/2013)
    !*** 

    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   P a r a m e t e r s
    !-----------------------------------------------

    real(kind=DP), parameter :: a0 = -43.8954569
    real(kind=DP), parameter :: a1 = -2.403597E-01
    real(kind=DP), parameter :: a2 = -4.2619E-04
    real(kind=DP), parameter :: a3 =  9.8743E-06
    real(kind=DP), parameter :: b0 =  4.8438E-3
    real(kind=DP), parameter :: b1 =  4.96145E-4
    real(kind=DP), parameter :: b2 = -5.6953E-6
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw
    real(kind=DP) :: tc,  lam200, t296, arg
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     USED PRIVATE VARIABLES:
    !  
    !     AF12     Array of real(kind=DP)      Absorption cross-section of F12 in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (needs to be the constant value for
    !                                  wavelengths below 200 nm, 
    !                                  Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the F12 (CF2Cl2) absorption
    !
    !     The expression is valid for the wavelength range; 200 - 231 nm
    !     (JPL extrapolates to 240 nm)           
    !     and the temperature range; 220-296 K.
    !     below 200 nm temperature indepndent data from input file 
    !     photocfc.dat is used  (e.g. JPL2011/table  Table 4F-36)
    !
    !     Jens-Uwe Grooss
    !     ----------
    !
    !     Date Started  1/7/2013
    !
    !     Last modified: 5/7/2013
    !
    !-------------------------------------------------------------------------
    !
    !
    !     Temperature in Kelvin.
    !
    !-----------------------------------------------------------------------
    !
    !     Check that temperature is in range.
    !
    tc = t
    tc = min(296.0_DP,tc)
    tc = max(220.0_DP,tc) 
    t296 = tc - 296.
    !
    !-----------------------------------------------------------------------
    !
    !     Wavelength 201..240 nm
    do jw = 60, 76
      !
      !        Wavelength in nm.
      lam200 = wavenm(jw)-200.
      !
      arg = a0 + a1 * lam200 + a2 * lam200**2 + a3 * lam200**3
      arg = arg + t296 * (b0  +  b1 * lam200 + b2 *  lam200**2)
      !
      af12(jw) = exp(arg)
      !
      !     End of wavelength loop.
    end do
    !
    !------------------------------------------------------------------------
    !
    return
  end subroutine acsf12


  !------------------------------------------------------------------------
  !************************************************************************
  !
  subroutine acsf22(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   P a r a m e t e r s
    !-----------------------------------------------
    real(kind=DP), parameter :: a0 = -106.029
    real(kind=DP), parameter :: a1 = 1.5038
    real(kind=DP), parameter :: a2 = -8.2476E-3
    real(kind=DP), parameter :: a3 = 1.4206E-5
    real(kind=DP), parameter :: b0 = -1.3399E-1
    real(kind=DP), parameter :: b1 = 2.7405E-3
    real(kind=DP), parameter :: b2 = -1.8028E-5
    real(kind=DP), parameter :: b3 = 3.8504E-8
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw
    real(kind=DP) :: tc, lam, lam2, lam3, arg
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     USED PRIVATE VARIABLES:
    !
    !     AF22     Array of real(kind=DP)      Absorption cross-section of F22 in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the F22 (CHF2Cl) absorption
    !     cross section based on P. C. Simon et al. (1988).
    !
    !     Journal of atmospheric chemistry, Vol. 7, pp. 107-135, 1988.
    !
    !     This is done via a polynomial expression of the form;
    !     log10(sigma)=A(lamda) + T B(lamda)
    !
    !     The expression is valid for the wavelength range; 174-204 nm
    !                            and the temperature range; 210-300 K.
    !
    !     David Lary
    !     ----------
    !
    !     Date Started : 18/2/1990
    !
    !     Last modified: 6/9/1991
    !
    !-------------------------------------------------------------------------
    !
    !
    !     Temperature in Kelvin.
    !
    !-----------------------------------------------------------------------
    !
    !     Check that temperature is in range.
    !
    tc = t
    tc = min(300.0_DP,tc)
    tc = max(210.0_DP,tc)
    !
    !-----------------------------------------------------------------------
    !
    !     Wavelength.
    do jw = 45, 61
      !
      !        Wavelength in nm.
      lam = wavenm(jw)
      !
      lam2 = lam*lam
      lam3 = lam*lam2
      ! jug following line changed tc -tc -273 according to JPL and Simon et al., 1988
      arg = a0 + a1*lam + a2*lam2 + a3*lam3 + &
          (tc-273.)*(b0 + b1*lam + b2*lam2 + b3*lam3)
      af22(jw) = 10.0**arg
      !
      !     End of wavelength loop.
    end do
    !
    !------------------------------------------------------------------------
    !
    return
  end subroutine acsf22


  !C************************************************************************
  !
  subroutine acsbr2(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw
    real(kind=DP) :: tc, alpha, awave
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !     USED PRIVATE VARIABLES:
    !
    !     ABR2    Array of real(kind=DP)      Absorption cross-section of Br2 in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the temperature dependent Br2
    !     absorption cross section after Maric 94
    !     Gaby Becker
    !     ----------
    !
    !     Date Started : 3. Nov 1997
    !
    !     Last modified: 3. Nov 1997
    !
    !-------------------------------------------------------------------------
    !
    !
    !     Temperature in Kelvin.
    !
    !     Check that temperature is in range.
    tc = t
    tc = min(300.0_DP,tc)
    if (tc < 195) tc = 195.0
    !
    !
    alpha = tanh(234.0309/tc)



    do jw = 1, jpwave
      !        Wavelength in nm.
      awave = wavenm(jw)
      if (awave<200 .or. awave>650) then
        abr2(jw) = 0.0
      else
        abr2(jw) = 1.0E-20*sqrt(alpha)*(1.31*exp((-79.7*alpha*log(223.3/&
         awave)**2))+76.4*exp((-165.5*alpha*log(411.9/awave)**2))+43.1&
         *exp((-162.9*alpha*log(480.2/awave)**2)) + 4.66*exp((-170.7*alpha&
         *log(549.3/awave)**2)))

      endif
    end do
    !
    !-----------------------------------------------------------------------
    !
    return
  end subroutine acsbr2


  subroutine acsch3br(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw
    real(kind=DP) :: tc, lam, loga
    real, dimension(15), parameter:: sig_182_210 = &
           (/20.21,  21.90,  28.13,  34.38,  42.23, &
             50.72,  58.92,  66.41,  72.83,  77.54, &
             79.10,  78.54,  76.45,  72.04,  67.22/) * 1E-20
    real(kind=DP), parameter :: a0 =  7.997
    real(kind=DP), parameter :: a1 = -0.889724
    real(kind=DP), parameter :: a2 =  0.00838084
    real(kind=DP), parameter :: a3 = -3.03191E-5
    real(kind=DP), parameter :: a4 =  3.69427E-8
    real(kind=DP), parameter :: b0 =  0.457415
    real(kind=DP), parameter :: b1 = -0.00882996
    real(kind=DP), parameter :: b2 =  6.40235E-5
    real(kind=DP), parameter :: b3 = -2.06827E-7
    real(kind=DP), parameter :: b4 =  2.51393E-10
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !     ACH3Br    Array of real(kind=DP) Absorption cross-section of CH3Br in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the temperature dependent CH3Br
    !     absorption cross section after JPL2015
    !
    !     Date Started : 24. Apr 2019
    !
    !     Last modified: 24. Apr 2019
    !
    !-------------------------------------------------------------------------
    !
    !
    !     Temperature in Kelvin.
    !
    !     Valid temperature range 210..290K.
    tc = t
    tc = min(290.0_DP,tc)
    if (tc < 210.0) tc = 210.0
    !
    ach3br(:) = 0.
    ach3br(50:64) = sig_182_210
    

    do jw = 65, 90
      !        Wavelength range 210..290 nm
      lam = wavenm(jw)
      loga = A0 + A1*lam + A2*lam**2 + A3*lam**3 + A4*lam**4 + &
         (tc-273.) * (B0 + B1*lam + B2*lam**2 + B3*lam**3 + B4*lam**4 )
      ach3br(jw) = 10**loga
    end do
    !
    !-----------------------------------------------------------------------
    !
    return
  end subroutine acsch3br


  subroutine acsh1211(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw
    real(kind=DP) :: tc, lamd, lna
    real, dimension(33), parameter:: sig_182_260 = &
         (/  39.34, 34.86, 34.33, 38.39, 44.56, &
             53.48, 63.98, 75.62, 87.24, 99.55, &
            109.59,115.54,118.11,118.05,115.24, &
            109.62,101.84, 92.73, 82.66, 72.43, &
             62.28, 52.70, 43.64, 35.86, 29.03, &
             22.92, 17.71, 13.36,  9.87,  7.09, &
              4.98,  3.41,  2.26/) * 1E-20

    real(kind=DP), parameter :: a0 = -48.3578
    real(kind=DP), parameter :: a1 = -0.1547325
    real(kind=DP), parameter :: a2 = -4.966942E-4
    real(kind=DP), parameter :: a3 = 1.56338E-6
    real(kind=DP), parameter :: a4 = 3.664034E-8
    real(kind=DP), parameter :: b0 = 0.0002989
    real(kind=DP), parameter :: b1 = 8.5306E-6
    real(kind=DP), parameter :: b2 = 4.26E-8
    real(kind=DP), parameter :: b3 = -1.84E-9
    real(kind=DP), parameter :: b4 = 1.284E-11
    real(kind=DP), parameter :: lambda0 = 280.376
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     AH1211    Array of real(kind=DP) Absorption cross-section of H1211 in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the temperature dependent H1211
    !     (CF2ClBr) absorption cross section after JPL2015
    !
    !     Date Started : 25. Apr 2019
    !
    !     Last modified: 25. Apr 2019
    !
    !-------------------------------------------------------------------------
    !
    !
    !     Temperature in Kelvin.
    !
    !     Valid temperature range 210..298K.
    tc = t
    tc = min(298.0_DP,tc)
    if (tc < 210.0) tc = 210.0
    !
    ah1211(:) = 0.
    ah1211(50:82) = sig_182_260
    

    !        Wavelength range 260..350 nm
    do jw = 83, 103
       lamd = wavenm(jw) - lambda0
       lna = (A0 + A1*lamd + A2*lamd**2 + A3*lamd**3 + A4*lamd**4 ) * &
            (1+ (296. - tc) * (B0 + B1*lamd + B2*lamd**2 + B3*lamd**3 + B4*lamd**4) )
       ah1211(jw) = exp(lna)
    end do
    !
    !-----------------------------------------------------------------------
    !
    return
  end subroutine acsh1211

  subroutine acsh1301(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw
    real(kind=DP) :: tc, lamd, lna
    real, dimension(16), parameter:: sig_182_212 = &
         (/  3.51,  4.14,  4.92,  5.72,  6.40, &
             7.26,  8.19,  9.16, 10.05, 10.89, &
            11.60, 12.17, 12.45, 12.43, 12.19, &
            11.54/) * 1E-20

    real(kind=DP), parameter :: a0 = -46.70542
    real(kind=DP), parameter :: a1 = -1.55047E-1
    real(kind=DP), parameter :: a2 = -1.020187E-3
    real(kind=DP), parameter :: a3 = 2.246169E-5
    real(kind=DP), parameter :: a4 = -1.300982E-7
    real(kind=DP), parameter :: b0 = 1.694026E-4
    real(kind=DP), parameter :: b1 = 8.723247E-6
    real(kind=DP), parameter :: b2 = 5.953165E-9
    real(kind=DP), parameter :: b3 = -3.872168E-9
    real(kind=DP), parameter :: b4 = -1.803325E-11
    real(kind=DP), parameter :: lambda0 = 242.2466
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     AH1301    Array of real(kind=DP) Absorption cross-section of H1301 in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the temperature dependent H1301
    !     (CF2ClBr) absorption cross section after JPL2015
    !
    !     Date Started : 25. Apr 2019
    !
    !     Last modified: 25. Apr 2019
    !
    !-------------------------------------------------------------------------
    !
    !
    !     Temperature in Kelvin.
    !
    !     Valid temperature range 210..296K.
    tc = t
    tc = min(296.0_DP,tc)
    if (tc < 210.0) tc = 210.0
    !
    ah1301(:) = 0.
    ah1301(50:65) = sig_182_212
    

    !        Wavelength range 214..285 nm
    do jw = 66, 89
       lamd = wavenm(jw) - lambda0
       lna = (A0 + A1*lamd + A2*lamd**2 + A3*lamd**3 + A4*lamd**4 ) * &
            (1+ (296. - tc) * (B0 + B1*lamd + B2*lamd**2 + B3*lamd**3 + B4*lamd**4) )
       ah1301(jw) = exp(lna)
    end do
    !
    !-----------------------------------------------------------------------
    !
    return
  end subroutine acsh1301


  !------------------------------------------------------------------------

  subroutine acsbrcl(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw
    real(kind=DP) :: tc, alpha, awave
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     USED PRIVATE VARIABLES:
    !
    !     ABRCL    Array of real(kind=DP)      Absorption cross-section of ClBr in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the temperature dependent BrCl
    !     absorption cross section after Maric 94
    !     Gaby Becker
    !     ----------
    !
    !     Date Started : 7.Okt 1997
    !
    !     Last modified:  7.Okt 1997
    !
    !-------------------------------------------------------------------------
    !
    !
    !     Temperature in Kelvin.
    !
    !
    !     Check that temperature is in range.
    tc = t
    tc = min(300.0_DP,tc)
    if (tc < 195) tc = 195.0
    !
    !
    alpha = tanh(318.8/tc)




    do jw = 1, jpwave
      !        Wavelength in nm.
      awave = wavenm(jw)
      if (awave<200 .or. awave>600) then
        abrcl(jw) = 0.0
      else
        abrcl(jw) = 1.0E-20*sqrt(alpha)*(7.34*exp((-68.6*alpha*log(227.6/&
         awave)**2)) + 43.5*exp((-123.6*alpha*log(372.5/awave)**2)) &
         + 11.2 *exp((-84.8*alpha*log(442.4/awave)**2)))
      endif
    end do
    !
    !-----------------------------------------------------------------------
    !
    return
  end subroutine acsbrcl

  !------------------------------------------------------------------------
  !************************************************************************
  !
  subroutine acsmc(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   P a r a m e t e r s
    !-----------------------------------------------
    real(kind=DP), parameter :: a0 = -299.80
    real(kind=DP), parameter :: a1 = 5.1047
    real(kind=DP), parameter :: a2 = -3.363E-2
    real(kind=DP), parameter :: a3 = 9.5805E-5
    real(kind=DP), parameter :: a4 = -1.0135E-7
    real(kind=DP), parameter :: b0 = -7.1727
    real(kind=DP), parameter :: b1 = 1.4837E-1
    real(kind=DP), parameter :: b2 = -1.1463E-3
    real(kind=DP), parameter :: b3 = 3.9188E-6
    real(kind=DP), parameter :: b4 = -4.9994E-9
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw
    real(kind=DP) :: tc, lam, lam2, lam3, lam4, arg
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     USED PRIVATE VARIABLES:
    !
    !     AMC      Array of real(kind=DP)      Absorption cross-section of CH3Cl in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the methyl chloride (CH3Cl) absorption
    !     cross section based on P. C. Simon et al. (1988).
    !
    !     Journal of atmospheric chemistry, Vol. 7, pp. 107-135, 1988.
    !
    !     This is done via a polynomial expression of the form;
    !     log10(sigma)=A(lamda) + T B(lamda)
    !
    !     The expression is valid for the wavelength range; 174-226 nm
    !                            and the temperature range; 210-300 K.
    !
    !     David Lary
    !     ----------
    !
    !     Date Started : 18/2/1990
    !
    !     Last modified: 6/9/1991
    !
    !-------------------------------------------------------------------------
    !
    !
    !     Temperature in Kelvin.
    !
    !-----------------------------------------------------------------------
    !
    !     Check that temperature is in range.
    tc = t
    tc = min(300.0_DP,tc)
    tc = max(210.0_DP,tc)
    !
    !-----------------------------------------------------------------------
    !
    !     Wavelength.
    do jw = 45, 67
      !
      !        Wavelength in nm.
      lam = wavenm(jw)
      !
      lam2 = lam*lam
      lam3 = lam*lam2
      lam4 = lam*lam3
      ! jug following line changed tc -tc -273 according to JPL and Simon et al., 1988
      arg = a0 + a1*lam + a2*lam2 + a3*lam3 + a4*lam4 + &
            (tc-273.)*(b0 + b1*lam + b2*lam2 + b3*lam3 + b4*lam4)
      amc(jw) = 10.0**arg
      !
      !     End of wavelength loop.
    end do
    !
    !------------------------------------------------------------------------
    !
    return
  end subroutine acsmc


  !------------------------------------------------------------------------
  !************************************************************************
  !
  subroutine acsn2o(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   P a r a m e t e r s
    !-----------------------------------------------
    real(kind=DP), parameter :: a1n2o = 68.210230
    real(kind=DP), parameter :: a2n2o = -4.071805
    real(kind=DP), parameter :: a3n2o = 4.301146E-2
    real(kind=DP), parameter :: a4n2o = -1.777846E-4
    real(kind=DP), parameter :: a5n2o = 2.520672E-7
    real(kind=DP), parameter :: b1n2o = 123.401400
    real(kind=DP), parameter :: b2n2o = -2.116255
    real(kind=DP), parameter :: b3n2o = 1.111572E-2
    real(kind=DP), parameter :: b4n2o = -1.881058E-5
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw
    real(kind=DP) :: tc, arg, arga, argb, tm300, lam1, lam2, lam3, lam4
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     USED PRIVATE VARIABLES:
    !
    !     AN2O     Array of real(kind=DP)      Absorption cross-section of N2O in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the temperature dependent N2O
    !     absorption cross section between 173 nm & 240 nm.
    !
    !     David Lary
    !     ----------
    !
    !     Date Started : 5/2/1990
    !
    !     Last modified: 6/9/1991
    !
    !-------------------------------------------------------------------------
    !
    !
    !     Temperature in Kelvin.
    !
    !-----------------------------------------------------------------------
    !
    !     Check is not out of parameterisation range.
    tc = t
    tc = max(194.0_DP,tc)
    tc = min(320.0_DP,tc)
    !
    !     Temperature - 300.
    tm300 = tc - 300.0
    !
    !     Wavelengths between 173 nm & 240 nm.
    do jw = 44, 76
      !
      !        Various powers of wavelength in nm.
      lam1 = wavenm(jw)
      lam2 = lam1*lam1
      lam3 = lam2*lam1
      lam4 = lam3*lam1
      !
      !        Evaluate the two polynomial expressions.
      arga = a1n2o + a2n2o*lam1 + a3n2o*lam2 + a4n2o*lam3 + a5n2o*lam4
      argb = b1n2o + b2n2o*lam1 + b3n2o*lam2 + b4n2o*lam3
      !
      !        Combine them.
      arg = arga + tm300*exp(argb)
      !
      !        Calculate the cross section.
      an2o(jw) = exp(arg)
      !
      !     End of the wavelength loop.
    end do
    !
    !-----------------------------------------------------------------------
    !
    return
  end subroutine acsn2o


  !------------------------------------------------------------------------
  !************************************************************************
  !
  subroutine acsn2o5(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw, lam
    real(kind=DP) :: tc, arg
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     USED PRIVATE VARIABLES:
    !
    !     AN2O5    Array of real(kind=DP)      Absorption cross-section of N2O5 in
    !                                 cm^2 for temperature T for each
    !                                 interval wavelength.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the temperature dependent N2O5
    !     absorption cross section between 285 nm & 380 nm.
    !
    !     David Lary
    !     ----------
    !
    !     Date Started : 5/2/1990
    !
    !     Last modified: 6/9/1991
    !
    !-------------------------------------------------------------------------
    !
    !
    !     Temperature in Kelvin.
    !
    !-----------------------------------------------------------------------
    !
    !      Calculate the temperature dependent N2O5 cross section,
    !      using the parameterisation of Yao et al. (1982), given in JPL
    !      EVAL 8 (1987) pp. 110-111. .
    !      ( still recommended in EVAL 11 (1994) )
    !
    !      This applies for wavelengths between 285 and 380 nm, and
    !      temperatures 225 K to 300 K.
    !
    !      If the temperature is below 225 K, the value for 225 K is used.
    !      If the temperature is above 300 K, the value for 300 K is used.
    !
    !-----------------------------------------------------------------------
    !
    !     Check is not out of parameterisation range.
    tc = t
    tc = max(225.0_DP,tc)
    tc = min(300.0_DP,tc)
    !
    !     Wavelengths between 285 nm & 380 nm.
    do jw = 89, 109
      !
      !        Wavelength in nm.
      lam = wavenm(jw)
      !
      !        Evaluate the parameterisation expression.
      arg = 2.735 + (4728.5 - 17.127*lam)/tc
      !
      !        Calculate the cross section.
      an2o5(jw) = 1.0E-20*exp(arg)
      !
    end do
    !
    !-----------------------------------------------------------------------
    !
    return
  end subroutine acsn2o5


  !------------------------------------------------------------------------
  !************************************************************************
  !
  subroutine acsno(angle, p, vc)
! op_pj_20150728: already globally USEd
!!$    USE messy_main_constants_mem,   ONLY: dtr
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: angle
    real(kind=DP) , intent(in) :: p
    real(kind=DP) , intent(in) :: vc
    !-----------------------------------------------
    !   L o c a l   P a r a m e t e r s
    !-----------------------------------------------
    integer, parameter :: jpnob = 9
    integer, parameter :: jpnoz = 5
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    real(kind=DP) , dimension(jpnob) :: band00
    real(kind=DP) , dimension(jpnoz) :: zen00
    real(kind=DP) :: c00
    real(kind=DP) , dimension(jpnob) :: band01
    real(kind=DP) , dimension(jpnoz) :: zen01
    real(kind=DP) :: c01, cz0, cz1, sec, sigmae0, sigmae1, zlogn, zlogn2, zlogn3, &
        zlogn4, zlogp, zlogp2, zlogp3, zlogp4, zlogp5, zlogp6, zlogp7, zlogp8&
        , cangle, zend, zcosint
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     ANGLE    Real               Solar zenith angle in radians.
    !                                 (Unchanged on exit).
    !
    !     P        Real               Pressure in mb.
    !                                 (Unchanged on exit).
    !
    !     VC       Real               Vertical O2 column above the point
    !                                 in molecules per cm^2.
    !                                 (Unchanged on exit).
    !
    !     JPWAVE   Integer            Number of wavelength intervals.
    !                                 (Unchanged on exit).
    !
    !     ANO      Array of real(kind=DP)      Absorption cross-section of NO in
    !                                 cm^2 for pressure P and solar zenith
    !                                 angle ANGLE.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which calculates the NO absorption cross section
    !     accounting for the NO absorption in the DEL(0-0) & the DEL(0-1)
    !     bands.
    !
    !     David Lary
    !     ----------
    !
    !     Date Started : 5/2/1990
    !
    !     Last modified: 21/10/1991
    !
    !-------------------------------------------------------------------------
    !
    !
    !     NO parameterisation Allen & Frederick 1983.
    !
    !
    !-----------------------------------------------------------------------
    !
    !      Absorption cross sections.
    !
    !      Polynomial coefficients for the NO effevtive absorption cross
    !      section parameterisation, due to Allen & Frederick.
    !
    !      This applies for the altitude range 20-90 km, 55 - 0.0027 mb.
    !                       zenith angles 0-80 degrees.
    !
    !-----------------------------------------------------------------------
    !
    !     BAND DEL(0-0)
    data band00/ -1.790868E1, -1.924701E-1, -7.217717E-2, 5.648282e-2, &
        4.569175E-2, 8.353572E-3, 0.0, 0.0, 0.0/
    !
    !     BAND DEL(0-1)
    data band01/ -1.654245E1, 5.836899E-1, 3.449436E-1, 1.700653E-1, &
        -3.324717E-2, -4.952424E-2, 1.579306E-2, 1.835462E-2, 3.368125E-3/
    !
    !     Polynomial coefficients for the NO effevtive absorption cross
    !     section Zenith aNGLe dependence.
    !
    !     BAND DEL(0-0)
    data zen00/ 7836.832, -1549.88, 114.8342, -3.777754, 4.655696E-2/
    !
    !     BAND DEL(0-1)
    data zen01/ 12975.81, -2582.981, 192.7709, -6.393008, 7.949835E-2/
    !
    !-----------------------------------------------------------------------
    !
    !      Calculate the NO absorption cross section accounting for
    !      the NO absorption in the DEL(0-0) & the DEL(0-1) bands.
    !      Calculated from the Mark Allen & John E Frederick
    !      parameterisation, taken from;
    !
    !      The Journal of atmospheric sciences, Vol. 39, September 82.
    !
    !------------------------------------------------------------------------
    !
    !    Initialise the cross sections to zero for the wavelength
    !    intervals 1 to JPWAVE.
    !
    ano = 0.0
    !
    !------------------------------------------------------------------------
    !
    !      Note: I found that the parameterisation seems to give silly numbers
    !            at high zenith angles & pressures. tO try and mitigate this
    !            between zenith angle ZEND (specified below) and 90 degrees
    !            I use cosine interpolation between the ZEND value & zero.
    !
    !            This is a purely empirical thing to do.
    !
    !-------------------------------------------------------------------------
    !
    !     Value at which parameterisation is not so good (in degrees).
    zend = 60
    !
    !     Take a copy of the solar zenith angle.
    cangle = angle
    !
    !-------------------------------------------------------------------------
    !
    !     Only continue if the parameterisation applies.
    !          > 20 KM           < 80 degrees.
    if (p<=55.0 .and. cangle<=90.0*dtr) then
      !
      !-------------------------------------------------------------------------
      !
      cangle = min(zend*dtr,cangle)
      !
      !-------------------------------------------------------------------------
      !
      !      Set values of the NO crossection for the TWO wavelength
      !      intervals where the parameterisation applies over the
      !      altitudes which it applies, i.e. ABOVE 20 kilometres ONLY.
      !      This parameterisation was performed by Allen & Frederick
      !      using high spectral resolution calculations of the delta
      !      band predissociation of nitric oxide.
      !
      !      N.B. It is very important that the clause (ANGLE.LE.(85.0*dtr))
      !           is included. This limits the calculation to angles less than
      !           85 degrees. At angles greater than 85 degrees the
      !           parameterisation is NOT valid and does nasty things.
      !           The NO concentration will erroneously become large close to
      !           sunset then via the terms in d[Ox]/dt involving JNO and K71
      !           ozone will be rapidly produced giving ridiculous consequences.
      !
      !----------------------------------------------------------------------
      !
      !        Set Log(P), and Log(N), P being Pressure, N being the VERTICAL
      !        O2 Column above the given point.
      zlogp = log10(p)
      zlogn = log10(vc)
      !
      !        Initialise Zenith angle dependence variables for both bands.
      c00 = 0
      c01 = 0
      !
      sec = 1.0/cos(cangle)
      !
      zlogp2 = zlogp*zlogp
      zlogp3 = zlogp2*zlogp
      zlogp4 = zlogp3*zlogp
      zlogp5 = zlogp4*zlogp
      zlogp6 = zlogp5*zlogp
      zlogp7 = zlogp6*zlogp
      zlogp8 = zlogp7*zlogp
      !
      !        For BAND DEL(0-0) calculate the NO effective cross section for
      !        an OVERHEAD sun using a simple polynomial expression.
      sigmae0 = band00(1) + band00(2)*zlogp + band00(3)*zlogp2 + band00(4)*&
          zlogp3 + band00(5)*zlogp4 + band00(6)*zlogp5
      !
      sigmae0 = 10.0**sigmae0
      !
      !        For BAND DEL(1-0) calculate the NO effective cross section for
      !        an OVERHEAD sun using a simple polynomial expression.
      sigmae1 = band01(1) + band01(2)*zlogp + band01(3)*zlogp2 + band01(4)*&
          zlogp3 + band01(5)*zlogp4 + band01(6)*zlogp5 + band01(7)*zlogp6 + &
          band01(8)*zlogp7 + band01(9)*zlogp8
      !
      sigmae1 = 10.0**sigmae1
      !
      zlogn2 = zlogn*zlogn
      zlogn3 = zlogn2*zlogn
      zlogn4 = zlogn3*zlogn
      !
      !        For BAND DEL(0-0) calculate the Zenith angle dependence of the
      !        NO effective cross section using a simple polynomial expression.
      cz0 = zen00(1) + zen00(2)*zlogn + zen00(3)*zlogn2 + zen00(4)*zlogn3&
          + zen00(5)*zlogn4
      !
      c00 = sec**cz0
      !
      !        For BAND DEL(0-1) calculate the Zenith angle dependence of the
      !        NO effective cross section using a simple polynomial expression.
      cz1 = zen01(1) + zen01(2)*zlogn + zen01(3)*zlogn2 + zen01(4)*zlogn3&
          + zen01(5)*zlogn4
      !
      c01 = sec**cz1
      !
      !        Effective NO absorption cross sections for BAND DEL(0-0)
      !        corresponding to wavelength intervals 54 & 55.
      ano(54) = sigmae0*c00
      ano(55) = ano(54)
      !
      !        Effective NO absorption cross sections for BAND DEL(1-0)
      !        corresponding to wavelength intervals 49 & 50.
      ano(49) = sigmae1*c01
      ano(50) = ano(49)
      !
      !-----------------------------------------------------------------------
      !
      !        Use cosine interpolation between the ZEND value and zero for
      !        angles between ZEND degrees and 90 degrees.
      if (angle > zend*dtr) then
        zcosint = cos(angle)/cos(zend*dtr)
        ano(54) = ano(54)*zcosint
        ano(55) = ano(55)*zcosint
        ano(49) = ano(49)*zcosint
        ano(50) = ano(50)*zcosint
      endif
      !
      !-----------------------------------------------------------------------
      !
      !     End of in range if statement.
    endif
    !
    !-----------------------------------------------------------------------
    !
    return
  end subroutine acsno


  !-----------------------------------------------------------------------
  !
  subroutine acso3(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    real(kind=DP) :: tc, tm230, tm2302
    real(kind=DP) , dimension(3,19) :: c
    real(kind=DP), dimension(19) :: n
    !-----------------------------------------------
    !
    !-----------------------------------------------------------------------
    !
    !     argrument list.
    !
    !     name     type               description.
    !     t        real(kind=DP)               temperature in Kelvin.
    !                                 (unchanged on exit).
    !
    !     USED PRIVATE VARIABLES:
    !
    !     ao3      array of real(kind=DP)      absorption cross-section of o3 in
    !                                 cm^2 for temperature t for each
    !                                 interval wavelength.
    !                                 (contains result on exit).
    !
    !-----------------------------------------------------------------------
    !
    !     a subroutine which calculates the ozone absorption cross section
    !     based on john e. frederick (1985).  the temperature dependent
    !     cross section data set is that of a. m. bass of the national
    !     bureau of standards provided by r. d. mcpeters.
    !
    !     the temperature dependence is in the 3rd significant figure
    !     between 263.158 - 266.167 nm. (intervals 84-102).
    !
    !     the temperature range covered is 203 to 298 k.
    !
    !     the fit used is a quadratic fit of the form;
    !     sigma(o3,t)={c0(i)+c1(i)(t-230)+c2(i)(t-230)^2}10^-n
    !
    !-----------------------------------------------------------------------
    !
    !     david lary
    !     ----------
    !
    !     date started : 7/3/1990
    !
    !     last modified: 6/9/1991
    !
    !-----------------------------------------------------------------------
    !
    !     .. Data statements ..
    data c/ 9.6312e+0, 1.1875e-3, -1.7386e-5, 8.3211e+0, 3.6495E-4, &
        2.4691e-6, 6.8810e+0, 2.4598E-4, 1.1692e-5, 5.3744e+0, 1.0325E-3, &
        1.2573e-6, 3.9575e+0, 1.6851e-3, -6.8648e-6, 2.7095e+0, 1.4502e-3, &
        -2.8925e-6, 1.7464e+0, 8.9350E-4, 3.5914e-6, 1.0574e+0, 7.8270E-4, &
        2.0024e-6, 5.9574e+0, 4.9448e-3, 3.6589e-5, 3.2348e+0, 3.5392e-3, &
        2.4769e-5, 1.7164e+0, 2.4542e-3, 1.6913e-5, 8.9612e+0, 1.4121e-2, &
        1.2498E-4, 4.5004e+0, 8.4327e-3, 7.8903e-5, 2.1866e+0, 4.8343e-3, &
        5.1970e-5, 1.0071e+1, 3.3409e-2, 2.6621E-4, 5.0848e+0, 1.8178e-2, &
        1.6301E-4, 2.1233e+0, 8.8453e-3, 1.2633E-4, 8.2861e+0, 4.2692e-2, &
        8.7057E-4, 2.9415e+0, 5.3051e-2, 3.4964e-4/
    data n/ 8*18, 3*19, 3*20, 3*21, 2*22/
    !     ..
    !
    !-----------------------------------------------------------------------
    !
    !     check that temperature is in range.
    !
    tc = t
    if (tc > 298.0) tc = 298.0
    if (tc < 203.0) tc = 203.0
    !
    tm230 = tc - 230.0
    tm2302 = tm230*tm230
    !
    !-----------------------------------------------------------------------
    !
    ao3(84:102) = (c(1,:)+c(2,:)*tm230+c(3,:)*tm2302)*10.0**(-n)
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine acso3


  !-----------------------------------------------------------------------
  !
  subroutine acso3w(jw, t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: jw
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jj
    real(kind=DP) :: tc, tm230, tm2302
    real(kind=DP) , dimension(3,19) :: c
    real(kind=DP), dimension(19) :: n
    !-----------------------------------------------
    !
    !-----------------------------------------------------------------------
    !
    !     argrument list.
    !
    !     name     type               description.
    !     t        real(kind=DP)               temperature in Kelvin.
    !                                 (unchanged on exit).
    !
    !     jw       integer            the wavelength interval.
    !                                 (unchanged on exit).
    !
    !     jpwave   integer            number of wavelength intervals.
    !                                 (unchanged on exit).
    !
    !     wavenm   array of real(kind=DP)      wavelength of each interval in nm.
    !                                 (unchanged on exit).
    !
    !     ao3      array of real(kind=DP)      absorption cross-section of o3 in
    !                                 cm^2 for temperature t for
    !                                 wavelength interval jw.
    !                                 (contains result on exit).
    !
    !-----------------------------------------------------------------------
    !
    !     a subroutine which calculates the ozone absorption cross section
    !     based on john e. frederick (1985).  the temperature dependent
    !     cross section data set is that of a. m. bass of the national
    !     bureau of standards provided by r. d. mcpeters.
    !
    !     the temperature dependence is in the 3rd significant figure
    !     between 263.158 - 266.167 nm. (intervals 84-102).
    !
    !     the temperature range covered is 203 to 298 k.
    !
    !     the fit used is a quadratic fit of the form;
    !     sigma(o3,t)={c0(i)+c1(i)(t-230)+c2(i)(t-230)^2}10^-n
    !
    !     David Lary
    !     ----------
    !
    !     date started : 7/3/1990
    !
    !     last modified: 6/9/1991
    !
    !-----------------------------------------------------------------------
    !
    !     .. Data statements ..
    data c/ 9.6312e+0, 1.1875e-3, -1.7386e-5, 8.3211e+0, 3.6495E-4, &
        2.4691e-6, 6.8810e+0, 2.4598E-4, 1.1692e-5, 5.3744e+0, 1.0325e-3, &
        1.2573e-6, 3.9575e+0, 1.6851e-3, -6.8648e-6, 2.7095e+0, 1.4502e-3, &
        -2.8925e-6, 1.7464e+0, 8.9350E-4, 3.5914e-6, 1.0574e+0, 7.8270E-4, &
        2.0024e-6, 5.9574e+0, 4.9448e-3, 3.6589e-5, 3.2348e+0, 3.5392e-3, &
        2.4769e-5, 1.7164e+0, 2.4542e-3, 1.6913e-5, 8.9612e+0, 1.4121e-2, &
        1.2498E-4, 4.5004e+0, 8.4327e-3, 7.8903e-5, 2.1866e+0, 4.8343e-3, &
        5.1970e-5, 1.0071e+1, 3.3409e-2, 2.6621E-4, 5.0848e+0, 1.8178e-2, &
        1.6301E-4, 2.1233e+0, 8.8453e-3, 1.2633E-4, 8.2861e+0, 4.2692e-2, &
        8.7057E-4, 2.9415e+0, 5.3051e-2, 3.4964e-4/
    data n/ 8*18, 3*19, 3*20, 3*21, 2*22/
    !     ..
    !
    !-----------------------------------------------------------------------
    !
    !     check if the calculation is required.
    if (jw>=84 .and. jw<=102) then
      !
      !-----------------------------------------------------------------------
      !
      !        check that temperature is in range.
      tc = t
      if (tc > 298.0) tc = 298.0
      if (tc < 203.0) tc = 203.0
      !
      tm230 = tc - 230.0
      tm2302 = tm230*tm230
      !
      jj = jw - 83
      ao3(jw) = (c(1,jj)+c(2,jj)*tm230+c(3,jj)*tm2302)*10.0**(-n(jj))
      !
      !-----------------------------------------------------------------------
      !
      !     end if the calculation is required.
    endif
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine acso3w


  !-----------------------------------------------------------------------
  !
  subroutine acssr(tc)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: tc
    !-----------------------------------------------
    !   L o c a l   P a r a m e t e r s
    !-----------------------------------------------
    integer, parameter :: jpwavesr = 17
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: j, jw
    real(kind=DP) :: arg, c, logc, logc2
    real(kind=DP), dimension(jpwavesr) :: sr0, sr1, sr2
    !-----------------------------------------------
    !   I n t r i n s i c  F u n c t i o n s
    !-----------------------------------------------
    INTRINSIC exp, log
    !-----------------------------------------------
    !
    !-----------------------------------------------------------------------
    !
    !     argrument list.
    !
    !     name     type               description.
    !     tc       real(kind=DP)               total slant path o2 column above the
    !                                 point in molecules per cm^2.
    !                                 (unchanged on exit).
    !
    !     USED PRIVATE VARIABLES:
    !
    !     ao2sr    array of real(kind=DP)      absorption cross-section of o2 in
    !                                 cm^2 for each wavelength interval
    !                                 in the schumann-runge bands.
    !                                 (contains result on exit).
    !
    !-----------------------------------------------------------------------
    !
    !     a subroutine which calculates the sr absorption cross section for
    !     wavelength interval jw and slantpath column tc.
    !
    !     david lary
    !     ----------
    !
    !     date started : 6/2/1990
    !
    !     last modified: 6/9/1991
    !
    !-----------------------------------------------------------------------
    !
    !     .. Data statements ..
    !     schumann runge cross section parameterisation (frederick 1985)
    !     wmo intervals (1 to 17)
    data sr0/ 8.587e1, 2.670e1, 1.858e1, 4.791e1, 3.796e1, 5.381e1, 5.440e1&
        , 5.467e1, 5.941e1, 8.666e1, 1.238e2, 1.220e2, 1.229e2, 1.345e2, &
        4.000e1, 4.769e1, 1.965e1/
    data sr1/ -2.239, 4.390e-1, 8.151e-1, -4.853e-1, -5.609e-2, -6.840e-1, &
        -6.537e-1, -6.389e-1, -8.120e-1, -1.838, -3.403, -3.196, -3.120, &
        -3.390, 4.420e-1, 2.376e-1, 1.353/
    data sr2/ 2.922e-2, -4.684E-4, -4.577e-3, 9.756e-3, 5.366e-3, 1.173e-2&
        , 1.097e-2, 1.081e-2, 1.258e-2, 2.231e-2, 3.868e-2, 3.560e-2, &
        3.418e-2, 3.548e-2, -2.869e-3, -1.604e-3,  -1.253e-2/
    !     ..
    !
    !-----------------------------------------------------------------------
    !
    if (tc <= 0.0) then
      ao2sr = 0.0
      !
    else
      do jw = 1, jpwave
        !
        !         Lyman-alpha
        if (jw == 1) then
          !
          c = tc
          ao2sr(jw) = 2.115E-18*c**(-0.1145)
          !
        else
          if (jw>=46 .and. jw<=62) then
            !
            !             natural log of o2 column used in the frederick
            !             parameterisation of o2 cross section.
            c = tc
            logc = log(c)
            logc2 = logc*logc
            !
            j = jw - 45
            arg = sr0(j) + sr1(j)*logc + sr2(j)*logc2
            ao2sr(jw) = exp((-arg))
          else
            ao2sr(jw) = 0.0
          endif
        endif
      end do
    endif
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine acssr


  !-----------------------------------------------------------------------
  !
  subroutine acssrw(tc, jw)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: jw
    real(kind=DP) , intent(in) :: tc
    !-----------------------------------------------
    !   L o c a l   P a r a m e t e r s
    !-----------------------------------------------
    integer, parameter :: jpwavesr = 17
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: j
    real(kind=DP) :: arg, c, logc, logc2
    real(kind=DP), dimension(jpwavesr) :: sr0, sr1, sr2
    !-----------------------------------------------
    !   I n t r i n s i c  F u n c t i o n s
    !-----------------------------------------------
    INTRINSIC exp, log
    !-----------------------------------------------
    !
    !-----------------------------------------------------------------------
    !
    !     argrument list.
    !
    !     name     type               description.
    !     tc       real(kind=DP)               total slant path o2 column above the
    !                                 point in molecules per cm^2.
    !                                 (unchanged on exit).
    !
    !     jw       integer            wavelength interval.
    !                                 (unchanged on exit).
    !
    !     jpwave   integer            number of wavelength intervals.
    !                                 (unchanged on exit).
    !
    !     ao2sr    array of real(kind=DP)      absorption cross-section of o2 in
    !                                 cm^2 for each wavelength interval
    !                                 in the schumann-runge bands.
    !                                 (contains result on exit).
    !
    !-----------------------------------------------------------------------
    !
    !     a subroutine which calculates the sr absorption cross section for
    !     wavelength interval jw and slantpath column tc.
    !
    !     david lary
    !     ----------
    !
    !     date started : 6/2/1990
    !
    !     last modified: 6/9/1991
    !
    !-----------------------------------------------------------------------
    !
    !     .. Data statements ..
    !
    !     absorption cross sections.
    !
    !     schumann runge cross section parameterisation (frederick 1985)
    !     wmo intervals (1 to 17)
    !
    data sr0/ 8.587e1, 2.670e1, 1.858e1, 4.791e1, 3.796e1, 5.381e1, 5.440e1&
        , 5.467e1, 5.941e1, 8.666e1, 1.238e2, 1.220e2, 1.229e2, 1.345e2, &
        4.000e1, 4.769e1, 1.965e1/
    data sr1/ -2.239, 4.390e-1, 8.151e-1, -4.853e-1, -5.609e-2, -6.840e-1, &
        -6.537e-1, -6.389e-1, -8.120e-1, -1.838, -3.403, -3.196, -3.120, &
        -3.390, 4.420e-1, 2.376e-1, 1.353/
    data sr2/ 2.922e-2, -4.684E-4, -4.577e-3, 9.756e-3, 5.366e-3, 1.173e-2&
        , 1.097e-2, 1.081e-2, 1.258e-2, 2.231e-2, 3.868e-2, 3.560e-2, &
        3.418e-2, 3.548e-2, -2.869e-3, -1.604e-3,  -1.253e-2/
    !     ..
    !
    !-----------------------------------------------------------------------
    !
    if (tc <= 0.0) then
      ao2sr(jw) = 0.0
      !
      !     Lyman-alpha
    else if (jw == 1) then
      !
      c = tc
      ao2sr(jw) = 2.115E-18*c**(-0.1145)
      !
    else if (jw>=46 .and. jw<=62) then
      !
      !         tc=min(tc,2.5e23_DP)
      !
      !         natural log of o2 column used in the frederick
      !         parameterisation of o2 cross section.
      c = tc
      logc = log(c)
      logc2 = logc*logc
      !
      j = jw - 45
      arg = sr0(j) + sr1(j)*logc + sr2(j)*logc2
      ao2sr(jw) = exp((-arg))
    else
      ao2sr(jw) = 0.0
    endif
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine acssrw


  !-----------------------------------------------------------------------
  !************************************************************************
  !
  subroutine acstdp(t, p)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP)  :: t  ! temperature in K
    real(kind=DP)  :: p  ! pressude in hPa

    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     p        Real               Pressure in hPa
    !                                 (Unchanged on exit).
    !
    !-----------------------------------------------------------------------
    !
    !     An umbrella routine to calculate all the temperature dependent
    !     absorption cross-sections. Variables named a<species name> declared
    !     above contain the resultin absorption cross section  on exit.
    !
    !
    !     David Lary
    !     ----------
    !
    !     Date Started : 6/9/1991
    !
    !     Last modified: 6/9/1991
    !     Last modified: 31/10/1994 Rolf Mueller
    !     Last modified: 3/11/1997 G.BECKER
    !                    11/12/2018 J.-U. Grooss
    !
    !-----------------------------------------------------------------------
    !
    !     N2O5 Temperature dependent absorption cross section.
     if (jcalc(ip_N2O5)) call acsn2o5 (t)
    !
    !     N2O Temperature dependent absorption cross section.
    if (jcalc(ip_N2O))   call acsn2o (t)
    !
    !     CCl4 Temperature dependent absorption cross section.
    if (jcalc(ip_CCl4))  call acsccl4 (t)
    !
    !     F11 (CFCl3) Temperature dependent absorption cross section.
    if (jcalc(ip_CFCl3)) call acsf11 (t)
    !
    !     F12 (CF2Cl2) Temperature dependent absorption cross section.
    if (jcalc(ip_CF2Cl2)) call acsf12 (t)
    !
    !     F22 (CHF2Cl) Temperature dependent absorption cross section.
    if (jcalc(ip_CHF2Cl)) call acsf22 (t)
    !
    !     MC (CH3Cl) Temperature dependent absorption cross section.
    if (jcalc(ip_CH3Cl))  call acsmc (t)
    !
    !     O[1D] Temperature dependent Quantum yield.
    if  (jcalc(ip_O3P) .or. jcalc(ip_O1D))  call quanto1d (t)
    !
    !     O3 Temperature dependent cross section. (always needed)
    call acso3 (t)
    !
    !     HNO3 Temperature dependent cross section.
    if (jcalc(ip_HNO3))  call acshno3 (t)
    !
    !     ClONO2 Temperature dependent cross section.
    if (jcalc(ip_ClNO3) .or. jcalc(ip_ClONO2)) call acscnit (t)
    !
    !     H2O2 Temperature dependent cross section.
    if (jcalc(ip_H2O2))  call acsh2o2 (t)
    !
    !     BrCl Temperature dependent cross section.
    if (jcalc(ip_BrCl)) call acsbrcl (t)
    !
    !     NO2 Temperature dependent cross section.
    if (jcalc(ip_NO2)) call acsno2 (t)
    !
    !     NO3 Temperature dependent cross section and quantum yields
    if (jcalc(ip_NOO2) .or.jcalc(ip_NO2O) ) call acsno3 (t)
    !
    !     Br2 Temperature dependent cross section.
    if (jcalc(ip_Br2)) call acsbr2 (t)
    !
    !     CH2O Temperature and pressure dependent cross section.
    if (jcalc(ip_CHOH) .or. jcalc(ip_COH2)) call quantch2o (t, p)
    !
    !     CH3Br Temperature dependent cross section.
    if (jcalc(ip_CH3Br)) call acsch3br (t)

    !     H1211 Temperature dependent cross section.
    if (jcalc(ip_CF2ClBr)) call acsh1211 (t)

    !     H1301 Temperature dependent cross section.
    if (jcalc(ip_CF3Br)) call acsh1301 (t)

    !-----------------------------------------------------------------------
    !
    return
  end subroutine acstdp


  !-----------------------------------------------------------------------
  !
  subroutine calc_current_acs(jlev , jc, jw, jl)
    !-----------------------------------------------
    !   M o d u l e s
    !-----------------------------------------------
! op_pj_20150728: SMCL files merged into one file
!!$    use messy_dissoc_global, only: jpslev,  jpschi, jpwave, jplats

    !
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: jlev
    integer , intent(in) :: jc
    integer , intent(in) :: jl
    integer  :: jw

    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    real(kind=DP) :: colo2
    !-----------------------------------------------------------------------
    !
    !     calculate the t dependent o3 cross-section.
    if (jw>=84 .and. jw<=102) call acso3w (jw, dtempc(jlev, jl))
    !
    !     calculate o2 cross section using the frederick parameterisation.
    !     note - this depends on the slant path column.
    if (jw>=46 .and. jw<=62) then
      colo2 = tspo2(jlev,jc,jl)
      call acssrw (colo2, jw)
      atoto2(jw) = ao2(jw) + ao2sr(jw)
    else
      atoto2(jw) = ao2(jw)
    endif
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine calc_current_acs


  !------------------------------------------------------------------------
  !************************************************************************
  !
  subroutine calcjs(jplo, jphi)

    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: jplo
    integer , intent(in) :: jphi
    !     Cross-sections & quantum yields.

    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw
    real(kind=DP) :: qu
    !------------------------------------------------------------------------
    !
    !     A subroutine to calculate the photolysis rates given that all the
    !     absorption cross-sections are supplied and the vectors FACTOR &
    !     QUANTA which contain the enhancement factor & solar irradiance
    !     respectively.
    !
    !-------------------------------------------------------------------------
    !     Last modified: 19/11/91 by Thomas Peter to treat more species
    !                    13/04/93 by Rolf Mueller to include Br Chem.
    !                    31/10/94 by Rolf Mueller to include CH3OCL
    !                    22/02/96 by Rolf Mueller to include HOBR
    !-------------------------------------------------------------------------
    !      Ox species photochemical reactions.
    !      AJ2:      O2     +  hv             ->   O     +   O
    !      AJ3:      O3     +  hv             ->   O2    +   O(3P)
    !      AJ3A:     O3     +  hv(<310nm)     ->   O2    +   O(1D)
    !
    !      NOx species photochemical reactions.
    !      AJNO:     NO       +  hv             ->   N     +   O
    !      AJNO2:    NO2      +  hv             ->   NO    +   O(3P)
    !      AJNO31:   NO3      +  hv             ->   NO    +   O2
    !      AJNO32:   NO3      +  hv             ->   NO2   +   O
    !      AJHNO3:   HNO3     +  hv             ->   NO2   +   OH
    !      AJPNA:    HO2NO2   +  hv             ->   NO2   +   HO2
    !      AJN2O:    N2O      +  hv             ->   N2    +   O(1D)
    !      AJN2O5:   N2O5     +  hv             ->   NO2   +   NO3
    !
    !      HOx species photochemical reactions.
    !      AJH2O:    H2O      +  hv             ->   OH    +   H
    !      AJH2O2:   H2O2     +  hv             ->   OH    +   OH
    !
    !      Clx species photochemical reactions.
    !      AJCl2:    Cl2      +  hv             ->   Cl    +   Cl
    !      AJCl2O2:  Cl2O2    +  hv             ->   Cl2O  +   Cl
    !      AJCNIT:   ClONO2   +  hv             ->   Cl    +   NO3
    !      AJCNITA:  ClONO2   +  hv             ->   ClO   +   NO2
    !      AJClNO2:  ClNO2    +  hv             ->   Cl    +   NO2
    !      AJF11:    CFCl3    +  hv             ->   3Cl
    !      AJF12:    CF2Cl2   +  hv             ->   2Cl
    !      AJF22:    CHF2Cl   +  hv             ->   Cl
    !      AJF113:   CF2CFCl3 +  hv             ->   3Cl
    !      AJMC:     CH3Cl    +  hv             ->   CH3   +   Cl
    !      AJCCl4:   CCl4     +  hv             ->   4Cl
    !      AJHCl:    HCl      +  hv             ->   H     +   Cl
    !      AJHOCl:   HOCl     +  hv             ->   OH    +   Cl
    !      AJCH3OCl: CH3OCl   +  hv             ->   prod.
    !
    !      Hydrocarbon photochemical reactions.
    !      AJCH2OA:  CH2O     +  hv             ->   CHO   +   H
    !      AJCH2OB:  CH2O     +  hv             ->   CO    +   H2
    !      AJCH3O2H: CH3O2H   +  hv             ->   products
    !
    !      Bromine chemistry photochemical reactions.
    !      AJBRNO3:  BrNO3    +  hv             ->   products
    !      AJBRCL:   BrCl     +  hv             ->   Br    +   Cl
    !      AJBR2:    Br2      +  hv             ->   Br    +   Br
    !      AJHOBr:   HOBr     +  hv             ->   Br    +   OH
    !      AJOCLO:   OClO     +  hv             ->   O     +   ClO
    !      AJBrO:    BrO      +  hv             ->   O     +   Br
    !-------------------------------------------------------------------------
    !
    !     Initialise js to zero.
    call inijs
        
    !
    !-----------------------------------------------------------------------
    !
    !     Wavelength loop.
    ! ju_jg_20181212 only calculate photolysis rates, if jcalc(ip_xxx) is set
    !
    do jw = jplo, jphi
      !
      !        Set up the number of photons into the volume element.
      qu = quanta(jw)*factor(jw)
      !        Ox species photolysis.
      if (jcalc(ip_O2)) aj2 = qu*(ao2(jw)+ao2sr(jw)) + aj2
      
      if (jcalc(ip_O3P))  aj3 = qu*ao3(jw)*(1.0 - qeo1d(jw)) + aj3
      if (jcalc(ip_O1D))  aj3a = qu*ao3(jw)*qeo1d(jw) + aj3a
      !
      !        NOx species photolysis.
      if (jcalc(ip_NO))     ajno = qu*ano(jw) + ajno
      if (jcalc(ip_NO2))    ajno2 = qu*ano2(jw)*qeno2(jw) + ajno2
      if (jcalc(ip_NOO2))   ajno31 = qu*ano3(jw)*qeno31(jw) + ajno31
      if (jcalc(ip_NO2O))   ajno32 = qu*ano3(jw)*qeno32(jw) + ajno32
      if (jcalc(ip_N2O))    ajn2o = qu*an2o(jw) + ajn2o
      if (jcalc(ip_N2O5))   ajn2o5 = qu*an2o5(jw) + ajn2o5
      if (jcalc(ip_HNO3))   ajhno3 = qu*ahno3(jw) + ajhno3
      if (jcalc(ip_HO2NO2) .or. jcalc(ip_OHNO3)) ajpna = qu*apna(jw) + ajpna
      if (jcalc(ip_ClNO3))  ajcnit = qu*acnit(jw)*qecnit(jw)  + ajcnit
      if (jcalc(ip_ClONO2)) ajcnita = qu*acnit(jw)*(1.0 - qecnit(jw)) + ajcnita
      !
      !        HOx species photolysis.
      if (jcalc(ip_H2O2))   ajh2o2 = qu*ah2o2(jw) + ajh2o2
      if (jcalc(ip_H2O))    ajh2o = qu*ah2o(jw) + ajh2o
      !
      !        Clx species.
      if (jcalc(ip_HOCl))   ajhocl = qu*ahocl(jw) + ajhocl
      if (jcalc(ip_HCl))    ajhcl = qu*ahcl(jw) + ajhcl
      if (jcalc(ip_Cl2))    ajcl2 = qu*acl2(jw) + ajcl2
      if (jcalc(ip_Cl2O2))  ajcl2o2 = qu*acl2o2(jw) + ajcl2o2
      if (jcalc(ip_ClNO2)) ajclno2 = qu*aclno2(jw) + ajclno2
      if (jcalc(ip_CH3OCl)) ajch3ocl = qu*ach3ocl(jw) + ajch3ocl
      !
      !        Halocarbons
      if (jcalc(ip_CH3Cl))  ajmc = qu*amc(jw) + ajmc
      if (jcalc(ip_CCl4))   ajccl4 = qu*accl4(jw) + ajccl4
      if (jcalc(ip_CFCl3))  ajf11 = qu*af11(jw) + ajf11
      if (jcalc(ip_CF2Cl2)) ajf12 = qu*af12(jw) + ajf12
      if (jcalc(ip_CHF2Cl)) ajf22 = qu*af22(jw) + ajf22
      if (jcalc(ip_F113))   ajf113 = qu*af113(jw) + ajf113
      !
      !        Hydrocarbons.
      if (jcalc(ip_CHOH))  ajch2oa = qu*ach2o(jw)*qech2oa(jw) + ajch2oa
      if (jcalc(ip_COH2))  ajch2ob = qu*ach2o(jw)*qech2ob(jw) + ajch2ob
      if (jcalc(ip_CH3OOH)) ajch3o2h = qu*ach3o2h(jw) + ajch3o2h
      !
      !        Bromine chemistry compounds
      if (jcalc(ip_BrNO3) .or. jcalc(ip_BrONO2)) ajbrno3 = qu*abrno3(jw) + ajbrno3
      if (jcalc(ip_HOBr))  ajhobr = qu*ahobr(jw) + ajhobr
      if (jcalc(ip_BrCl))  ajbrcl = qu*abrcl(jw) + ajbrcl
      if (jcalc(ip_OClO))  ajoclo = qu*aoclo(jw) + ajoclo
      if (jcalc(ip_Br2))   ajbr2 = qu*abr2(jw) + ajbr2
      if (jcalc(ip_BrO))   ajbro = qu*abro(jw) + ajbro
      if (jcalc(ip_CH3Br)) ajch3br = qu*ach3br(jw) + ajch3br
      if (jcalc(ip_CF2ClBr)) ajh1211 = qu*ah1211(jw) + ajh1211
      if (jcalc(ip_CF3Br)) ajh1301 = qu*ah1301(jw) + ajh1301


      !     End of the wavelength loop.
    end do
    !
    call chkj
    !
    !-----------------------------------------------------------------------
    !
    return
  end subroutine calcjs


  !------------------------------------------------------------------------
  !************************************************************************
  !
  subroutine chkj
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    !-----------------------------------------------
    !
    aj2 = max(aj2,0.0_DP)
    aj3 = max(aj3,0.0_DP)
    aj3a = max(aj3a,0.0_DP)
    ajccl4 = max(ajccl4,0.0_DP)
    ajch2oa = max(ajch2oa,0.0_DP)
    ajch2ob = max(ajch2ob,0.0_DP)
    ajch3o2h = max(ajch3o2h,0.0_DP)
    ajcl2 = max(ajcl2,0.0_DP)
    ajcl2o2 = max(ajcl2o2,0.0_DP)
    ajcnit = max(ajcnit,0.0_DP)
    ajcnita = max(ajcnita,0.0_DP)
    ajclno2 = max(ajclno2,0.0_DP)
    ajf11 = max(ajf11,0.0_DP)
    ajf113 = max(ajf113,0.0_DP)
    ajf12 = max(ajf12,0.0_DP)
    ajf22 = max(ajf22,0.0_DP)
    ajh2o = max(ajh2o,0.0_DP)
    ajh2o2 = max(ajh2o2,0.0_DP)
    ajhcl = max(ajhcl,0.0_DP)
    ajhno3 = max(ajhno3,0.0_DP)
    ajhocl = max(ajhocl,0.0_DP)
    ajmc = max(ajmc,0.0_DP)
    ajn2o = max(ajn2o,0.0_DP)
    ajn2o5 = max(ajn2o5,0.0_DP)
    ajno = max(ajno,0.0_DP)
    ajno2 = max(ajno2,0.0_DP)
    ajno31 = max(ajno31,0.0_DP)
    ajno32 = max(ajno32,0.0_DP)
    ajpna = max(ajpna,0.0_DP)
    ajbrno3 = max(ajbrno3,0.0_DP)
    ajhobr = max(ajhobr,0.0_DP)
    ajbrcl = max(ajbrcl,0.0_DP)
    ajoclo = max(ajoclo,0.0_DP)
    ajch3ocl = max(ajch3ocl,0.0_DP)
    ajbr2 = max(ajbr2,0.0_DP)
    ajbro = max(ajbro,0.0_DP)
    ajch3br = max(ajch3br,0.0_DP)
    ajh1211 = max(ajh1211,0.0_DP)
    ajh1301 = max(ajh1301,0.0_DP)

    !
    !-------------------------------------------------------------------------
    !
    return
  end subroutine chkj


  !
  !-----------------------------------------------------------------------
  !
  subroutine find2(xwant, ywant, value, x, y, array, nx, ny, nz, jz)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer, intent(in)  :: nx
    integer, intent(in)  :: ny
    integer, intent(in)  :: nz
    integer, intent(in)  :: jz
    real(kind=DP), intent(in)  :: xwant
    real(kind=DP), intent(in)  :: ywant
    real(kind=DP), intent(out) :: value
    real(kind=DP), intent(in)  :: x(nx)
    real(kind=DP), intent(in)  :: y(ny)
    real(kind=DP), intent(in)  :: array(nx,ny,nz)
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jx, jxp1, jy, jyp1
    !-----------------------------------------------------------------------
    !
    call findindex (xwant, ywant, x, y, nx, ny, jx, jxp1, jy, jyp1)
    call findpoint2 (xwant, ywant, value, x, y, array, nx, ny, nz, jx, jxp1, jy&
        , jyp1, jz)
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine find2


  !
  !-----------------------------------------------------------------------
  !
  subroutine findindex(xwant, ywant, x, y, nx, ny, jx, jxp1, jy, jyp1)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer, intent(in)  :: nx
    integer, intent(in)  :: ny
    integer, intent(out) :: jx
    integer, intent(out) :: jxp1
    integer, intent(out) :: jy
    integer, intent(out) :: jyp1
    real(kind=DP), intent(in) :: xwant
    real(kind=DP), intent(in) :: ywant
    real(kind=DP), intent(in) :: x(nx)
    real(kind=DP), intent(in) :: y(ny)
    !-----------------------------------------------------------------------
    !
    !     Find grid references.
    !     i) x
    call pos (x, nx, xwant, jx)
    if (jx == 0) then
      jx = 1
    else if (jx >= nx) then
      jx = nx - 1
    endif
    jxp1 = jx + 1
    !
    !     ii) y
    call pos (y, ny, ywant, jy)
    if (jy == 0) then
      jy = 1
    else if (jy >= ny) then
      jy = ny - 1
    endif
    jyp1 = jy + 1
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine findindex

  !
  !-----------------------------------------------------------------------
  !
  subroutine findpoint2(xwant, ywant, value, x, y, array, nx, ny, nz, jx, jxp1,&
      jy, jyp1, jz)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: nx
    integer , intent(in) :: ny
    integer , intent(in) :: nz
    integer , intent(in) :: jx
    integer , intent(in) :: jxp1
    integer , intent(in) :: jy
    integer , intent(in) :: jyp1
    integer , intent(in) :: jz
    real(kind=DP) , intent(in) :: xwant
    real(kind=DP) , intent(in) :: ywant
    real(kind=DP) , intent(out) :: value
    real(kind=DP) , intent(in) :: x(nx)
    real(kind=DP) , intent(in) :: y(ny)
    real(kind=DP) , intent(in) :: array(nx,ny,nz)
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    real(kind=DP) :: s1, s2, s3, s4, zt, zta, ztb, zu, zua, zub
    !-----------------------------------------------------------------------
    !
    !     look up relevant grid points.
    !
    !-----------------------------------------------------------------------
    !
    s1 = array(jx,jy,jz)
    s2 = array(jxp1,jy,jz)
    s3 = array(jxp1,jyp1,jz)
    s4 = array(jx,jyp1,jz)
    !
    !     find slopes used in interpolation;
    !     i) x.
    zta = xwant - x(jx)
    ztb = x(jxp1) - x(jx)
    !
    zt = zta/ztb
    !
    !     ii) y.
    zua = ywant - y(jy)
    zub = y(jyp1) - y(jy)
    !
    zu = zua/zub
    !
    !     use bilinear interpolation.
    value = (1.0 - zt)*(1.0 - zu)*s1 + zt*(1.0 - zu)*s2 + zt*zu*s3 + (1.0&
        - zt)*zu*s4
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine findpoint2


  !------------------------------------------------------------------------
  !************************************************************************
  !
  subroutine findvect2(xwant, ywant, vector, x, y, array, nx, ny, nz, nl, jlo, &
      jhi, jx, jxp1, jy, jyp1, jl)

    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: nx
    integer , intent(in) :: ny
    integer , intent(in) :: nz
    integer , intent(in) :: nl
    integer , intent(in) :: jlo
    integer , intent(in) :: jhi
    integer , intent(in) :: jx
    integer , intent(in) :: jxp1
    integer , intent(in) :: jy
    integer , intent(in) :: jyp1
    integer , intent(in) :: jl
    real(kind=DP) , intent(in) :: xwant
    real(kind=DP) , intent(in) :: ywant
    real(kind=DP) , intent(out) :: vector(nz)
    real(kind=DP) , intent(in) :: x(nx)
    real(kind=DP) , intent(in) :: y(ny)
    real(kind=DP) , intent(in) :: array(nx,ny,nz,nl)
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    real(kind=DP) :: zt, zta, ztb, zu, zua, zub
    !-----------------------------------------------
    !
    !-----------------------------------------------------------------------
    !
    !     Look up all points.
    !
    !        Find slopes used in interpolation;
    !        i) X.
    zta = xwant - x(jx)
    ztb = x(jxp1) - x(jx)
    !
    zt = zta/ztb
    !
    !        ii) Y.
    zua = ywant - y(jy)
    zub = y(jyp1) - y(jy)
    !
    zu = zua/zub
    !
    vector=0.0
    
    !        Use bilinear interpolation.
    vector(jlo:jhi) = (1.0 - zt)*(1.0 - zu)*array(jx,jy,jlo:jhi,jl) + &
         zt*(1.0- zu)*array(jxp1,jy,jlo:jhi,jl) + &
         zt*zu*array(jxp1,jyp1,jlo:jhi,jl) + &
         (1.0- zt)*zu*array(jx,jyp1,jlo:jhi,jl)
    !
    !
    !-----------------------------------------------------------------------
    !
    return
  end subroutine findvect2


  !
  !************************************************************************
  !
  subroutine inijs
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    !-------------------------------------------------------------------------
    !
    !      Initialise the photolysis rates to zero.
    !
    !-------------------------------------------------------------------------
    !
    !     Ox species.
    aj2 = 0.0
    aj3 = 0.0
    aj3a = 0.0
    !
    !     NOx species.
    ajno = 0.0
    ajno2 = 0.0
    ajn2o = 0.0
    ajno31 = 0.0
    ajno32 = 0.0
    ajn2o5 = 0.0
    ajhno3 = 0.0
    ajpna = 0.0
    ajcnit = 0.0
    ajcnita = 0.0
    !
    !     HOx species.
    ajh2o2 = 0.0
    ajh2o = 0.0
    !
    !     Clx species.
    ajhocl = 0.0
    ajhcl = 0.0
    ajcl2 = 0.0
    ajcl2o2 = 0.0
    ajclno2 = 0.0
    ajmc = 0.0
    ajf11 = 0.0
    ajf12 = 0.0
    ajf22 = 0.0
    ajf113 = 0.0
    ajccl4 = 0.0
    ajch3ocl = 0.0
    !
    !     Hydrocarbons:
    ajch2oa = 0.0
    ajch2ob = 0.0
    ajch3o2h = 0.0
    !
    !     Br Chemistry compounds
    ajbrno3 = 0.0
    ajhobr = 0.0
    ajbrcl = 0.0
    ajoclo = 0.0
    ajbr2 = 0.0
    ajbro = 0.0
    ajch3br = 0.0
    ajh1211 = 0.0
    ajh1301 = 0.0

    !-------------------------------------------------------------------------
    !
    return
  end subroutine inijs

  subroutine iniphoto(jday)

    !-----------------------------------------------
    !   M o d u l e s
    !-----------------------------------------------
! op_pj_20150728: SMCL files merged into one file
!!$    use messy_dissoc_global

    !
    !     -----------------------------
    !     Adjusted to Mainz box model: 1/8/1994 (J.U.Grooss)
    !     inclusion of CH3OCl: 31 Oct. 1994     (Rolf Mueller)
    !     adapted to CLaMS-MESSY: Jan 2014      (J.U.Grooss)
    !     (divide into two routines for init and update of tables)
    !     last modified : 23.01. 2014           (J.U. Grooss)
    !     -----------------------------
    !
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer,intent(in)  :: jday
    !
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jc, jlev, j, jchan, nin

    logical :: found_save=.false.
    character(len=20)::save_file
    integer :: n_sav,ilen
    real(kind=DP)::alb_sav

    ! set t-dependend acs that are not read in from file to 0 here (jug / 01/2014)
    ahno3(:) = 0.
    ah2o2(:) = 0.
    abrcl(:) = 0.
    ano2(:) = 0.
    ano3(:) = 0.
    abr2(:) = 0.
    ach3br(:) = 0.
    ah1211(:) = 0.
    ah1301(:) = 0.
    qeo1d(:) = 0.
    qeno31(:) = 0.
    qeno32(:) = 0.
    qech2oa(:) = 0.
    qech2ob(:) = 0.

    ! set MESSy indices ip_* of calculated photolysis rates
    call set_jcalc_indices

    jchan = 1
    !
    !     Read in the solar irradiances.
    call fluxrd 
    !
    !     Determine quantum yields for ClONO2 photolysis
    call quantcnit
    !
    !     Initialise some cross-sections to zero.
    ano(:) = 0.
    ao2sr(:) = 0.
    !
    !     Read in absorption cross sections and quantum yields
    call photord 
    !   
    !
    !     correct solar flux data for sun-earth distance if julian day is given:
    !     (jday=0 means no correction)
    if (jday > 0) then
      do j = 1, jpwave
        quanta(j) = quanta(j)*sun_factor(jday)
      end do
    endif

! op_pj_20150728: due to I/O on parallel decomposition, this needs to be
!                 split and called from SMIL ...
!!$    call calc_photolysis_table 
    !write(*,*) 'iniphoto finished'
    return
  end subroutine iniphoto

! op_pj_20150728+: due to I/O on parallel decomposition, this needs to be
!                  split and called from SMIL ...
!!$  subroutine calc_photolysis_table
! op_pj_20150728: SMCL files merged into one file 
!!$    use messy_dissoc_global, only: o3dat, month_o3, nlats
!!$
!!$    ! read in ozone profile(s)
!!$    !write(*,*) 'reado3'
!!$    call reado3(o3dat,month_o3,nlats)
!!$    !
!!$    !
!!$    !  set up the enhancement factor table.
!!$    !write(*,*) 'settab'
!!$    call settab
!!$    !
!!$  end subroutine calc_photolysis_table
! op_pj_20150728-

  !------------------------------------------------------------------------
  !************************************************************************
  !
  subroutine fluxrd
    !-----------------------------------------------
    !   M o d u l e s
    !-----------------------------------------------
! op_pj_20150728: SMCL files merged into one file
!!$    use messy_dissoc_global, only: jpwave, wavenm, wavecm, quanta, datdir
! op_pj_20150728: NOTE: reading of ASCII-data should be replaced by
!                       data tables in code ...
    use messy_main_tools, only: find_next_free_unit
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     JPWAVE   Integer            Number of wavelength intervals.
    !                                 (Unchanged on exit).
    !
    !     WAVENM   Array of real(kind=DP)      Wavelength of each interval in nm.
    !                                 (Contains data on exit).
    !
    !     WAVECM   Array of real(kind=DP)      Wavelength of each interval in
    !                                 wavenumbers.
    !                                 (Contains data on exit).
    !
    !     QUANTA   Array of real(kind=DP)      Solar irradiance at each interval.
    !                                 (Contains data on exit).
    !
    !------------------------------------------------------------------------
    !
    !     Subroutine to read in the solar irradiances.
    !
    !     David Lary
    !     ----------
    !
    !     Date Started : 4/2/1990
    !
    !     Last modified: 27/9/1991
    !
    !     Adjusted to Mainz box model: 1/8/1994 (J.U.Grooss)
    !
    !-----------------------------------------------------------------------
    !
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jchan, i, j, iostatus
    real(kind=DP):: lam(jpwave), b, c
    !
    !
    !------------------------------------------------------------------------
    !
    jchan = find_next_free_unit(100,200)
    open(jchan, file=trim(datdir)//"solar.dat", status="OLD", position=&
        "asis",iostat=iostatus)
    if (iostatus.ne.0) then
       write(*,*) 'Cannot read from file '//trim(datdir)&
            &//'solar.dat'
       stop
    endif
    !
    !-----------------------------------------------------------------------
    !
    read (jchan, *)
    !
    do j = 1, jpwave
       read (jchan, *) i, lam(j),wavecm(j),quanta(j)
    end do
    wavenm = lam
    !
    close(jchan)
    !
    !----------------------------------------------------------------------
    !
    return
  end subroutine fluxrd


  !------------------------------------------------------------------------
  !************************************************************************
  !
  subroutine photord
    !-----------------------------------------------
    !   M o d u l e s
    !-----------------------------------------------
    use messy_main_tools, only: find_next_free_unit
    ! op_pj_20150728: SMCL files merged into one file
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list. -- now defined in module messy_dissoc_global
    !
    !     Name     Type               Description.
    !     JPWAVE   Integer            Number of wavelength intervals.
    !                                 (Unchanged on exit).
    !
    !     WAVENM   Array of real(kind=DP)      Wavelength of each interval in nm.
    !                                 (Contains result on exit).
    !
    !     QENO2    Array of real(kind=DP)      The quantum yield for NO2 photolysis.
    !                                 (Contains result on exit).
    !
    !     ANO2     Array of real(kind=DP)      Absorption cross-section of NO2 in
    !                                 cm^2 for T=0 C
    !                                 (Contains result on exit).
    !
    !     TDEPNO2  Array of real(kind=DP)      Temperature coefficient of NO2
    !                                  Absorption cross-section [cm^2/degree]
    !                                 (Contains result on exit).
    !
    !
    !     QENO31T    Array of real(kind=DP)    Quantum yields  of NO3  for photolysis channel 1.
    !                                 for temperatures 298,230,190K
    !                                  (Contains result on exit).
    !
    !     QENO32T    Array of real(kind=DP)    Quantum yields  of NO3  for photolysis channel 2.
    !                                 for temperatures 298,230,190K
    !                                  (Contains result on exit).
    !
    !     ANO3T    Array of real(kind=DP)      Absorption cross-section of NO3 in
    !                                 cm^2 for temperatures 298,220 K
    !                                 (Contains result on exit).
    !
    !     AN2O     Array of real(kind=DP)      Absorption cross-section of N2O in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     AN2O5    Array of real(kind=DP)      Absorption cross-section of N2O5 in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     AHNO2    Array of real(kind=DP)      Absorption cross-section of HNO2 in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     AHNO3    Array of real(kind=DP)      Absorption cross-section of HNO3 in
    !                                 cm^2. for T=298
    !                                 (Contains result on exit).
    !
    !     BHNO3    Array of real(kind=DP)      Temperature corfficient of HNO3 in
    !                                 1/K
    !
    !     APNA     Array of real(kind=DP)      Absorption cross-section of HO2NO2
    !                                 in cm^2.
    !                                 (Contains result on exit).
    !
    !     ACNIT    Array of real(kind=DP)      Absorption cross-section of ClONO2
    !                                 in cm^2.
    !                                 (Contains result on exit).
    !
    !     AO2      Array of real(kind=DP)      Absorption cross-section of O2 in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     AO3      Array of real(kind=DP)      Absorption cross-section of O3 in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     AH2O     Array of real(kind=DP)      Absorption cross-section of H2O in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     ACH2O    Array of real(kind=DP)      Absorption cross-section of CH2O in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     ACO2     Array of real(kind=DP)      Absorption cross-section of CO2 in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     AF11     Array of real(kind=DP)      Absorption cross-section of F11 in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     AF12     Array of real(kind=DP)      Absorption cross-section of F12 in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     AF22     Array of real(kind=DP)      Absorption cross-section of F22 in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     AF113    Array of real(kind=DP)      Absorption cross-section of F113 in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     AMC      Array of real(kind=DP)      Absorption cross-section of CH3Cl in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     ACCl4    Array of real(kind=DP)      Absorption cross-section of CCl4 in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     AHCL     Array of real(kind=DP)      Absorption cross-section of HCl in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     AHOCl    Array of real(kind=DP)      Absorption cross-section of HOCl in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     ACL2O2   Array of real(kind=DP)      Absorption cross-section of Cl2O2 in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     ACL2     Array of real(kind=DP)      Absorption cross-section of Cl2 in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     ACLNO2   Array of real(kind=DP)      Absorption cross-section of ClNO2 in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     ACH3O2H  Array of real(kind=DP)      Absorption cross-section of CH3O2H in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !     ABRNO3   Array of real(kind=DP)      Absorption cross-section of BRNO3 in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     AHOBR    Array of real(kind=DP)      Absorption cross-section of HOBR in
    !                                 cm2.
    !                                 (Contains result on exit).
    !
    !     AOCLO    Array of real(kind=DP)      Absorption cross-section of OCLO in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !     ACH3OCL    Array of real(kind=DP)    Absorption cross-section of CH3OCL in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !     ABrO       Array of real(kind=DP)    Absorption cross-section of BrO in
    !                                 cm^2.
    !                                 (Contains result on exit).
    !
    !------------------------------------------------------------------------
    !
    !     A subroutine which reads in photochemical data from a set of data
    !     files.
    !
    !     David Lary
    !     ----------
    !
    !     Date Started : 4/2/1990
    !
    !     Last modified: 18/12/1991  by Thomas Peter
    !     Last modified: 13/04/1993  by Rolf Mueller
    !
    !     Adjusted to Mainz box model: 1/8/1994 (J.U.Grooss)
    !
    !     Last modified: 31/10/1993  by Rolf Mueller (CH3OCl)
    !     Last modified: 28/10/1997  Gaby Becker
    !     Last modified: 05/01/2000  J.-U.Grooss+ Rolf Mueller
    !-------------------------------------------------------------------------
    !
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s -- defined in module messy_dissoc_global
    !-----------------------------------------------
    !
    !
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: i, j, jchan01, jchan02, jchan03, jchan04, jchan05, jchan06, &
         & jchan07, jchan08, jchan09, jchan10, jchan11, jchan12, jchan13, jchan14 

    real(kind=DP):: lambda
    real(kind=DP), parameter:: eps=0.1
    !
    !------------------------------------------------------------------------
    !
    !     Open the files.
    jchan01 = find_next_free_unit(100,200)
    open(jchan01, file=trim(datdir)//"photo1.dat", status="OLD", position="asis")

    jchan02 = find_next_free_unit(100,200)
    open(jchan02, file=trim(datdir)//"photo2.dat", status="OLD", position="asis")

    jchan03 = find_next_free_unit(100,200)
    open(jchan03, file=trim(datdir)//"photo3.dat", status="OLD", position="asis")

    jchan04 = find_next_free_unit(100,200)
    open(jchan04, file=trim(datdir)//"photo4.dat", status="OLD", position="asis")

    jchan05 = find_next_free_unit(100,200)
    open(jchan05, file=trim(datdir)//"photocfc.dat", status="OLD", position="asis")

    jchan06 = find_next_free_unit(100,200)
    open(jchan06, file=trim(datdir)//"photo6.dat", status="OLD", position="asis")

    jchan08 = find_next_free_unit(100,200)
    open(jchan08, file=trim(datdir)//"photo8.dat", status="OLD", position="asis")

    jchan09 = find_next_free_unit(100,200)
    open(jchan09, file=trim(datdir)//"photo9.dat", status="OLD", position="asis")

    jchan10 = find_next_free_unit(100,200)
    open(jchan10, file=trim(datdir)//"photo10.dat", status="OLD", position="asis")

    jchan11 = find_next_free_unit(100,200)
    open(jchan11, file=trim(datdir)//"photo11.dat", status="OLD", position="asis")

    jchan12 = find_next_free_unit(100,200)
    open(jchan12, file=trim(datdir)//"photo12.dat", status="OLD", position="asis")

    jchan13 = find_next_free_unit(100,200)
    open(jchan13, file=trim(datdir)//"photo13.dat", status="OLD", position="asis")

    jchan14 = find_next_free_unit(100,200)
    open(jchan14, file=trim(datdir)//"photo14.dat", status="OLD", position="asis")
    !
    !-----------------------------------------------------------------------
    !
    !     Skip headers.
    read (jchan01, *)
    read (jchan02, *)
    read (jchan03, *)
    read (jchan04, *)
    read (jchan05, *)
    read (jchan06, *)
    read (jchan08, *)
    read (jchan09, *)
    read (jchan10, *)
    read (jchan11, *)
    read (jchan12, *)
    read (jchan13, *)
    read (jchan14, *)
    !
    !-----------------------------------------------------------------------
    !
    !     Wavelength read loop.
    do j = 1, jpwave

      read (jchan01, *) i, lambda, qeno2(j), ano20(j), tdepno2(j)
      if (abs(wavenm(j) - lambda) > eps) stop 'Wrong wavelength in file photo1.dat'
      read (jchan02, *) i, lambda, an2o(j), an2o5(j), ahno2(j), apna(j), &
           acnit(j)
      if (abs(wavenm(j) - lambda) > eps) stop 'Wrong wavelength in file photo2.dat'
      read (jchan03, *) i, lambda, ao2(j), ao3(j)
      if (abs(wavenm(j) - lambda) > eps) stop 'Wrong wavelength in file photo3.dat'
      read (jchan04, *) i, lambda, ah2o(j), aco2(j)
      if (abs(wavenm(j) - lambda) > eps) stop 'Wrong wavelength in file photo4.dat'
      read (jchan05, *) i, lambda, af11(j), af12(j), af22(j), af113(j),&
           amc(j), accl4(j)
      if (abs(wavenm(j) - lambda) > eps) stop 'Wrong wavelength in file photocfc.dat'
      read (jchan06, *) i, lambda, ahocl(j), ahcl(j), acl2o2(j), ach3ocl(j)
      if (abs(wavenm(j) - lambda) > eps) stop 'Wrong wavelength in file photo6.dat'
      read (jchan08, *) i, lambda, ach2o(j)
      if (abs(wavenm(j) - lambda) > eps) stop 'Wrong wavelength in file photo8.dat'
      read (jchan09, *) i, lambda, acl2(j), aclno2(j), ach3o2h(j)
      if (abs(wavenm(j) - lambda) > eps) stop 'Wrong wavelength in file photo9.dat'
      read (jchan10, *) i, lambda, abrno3(j), aoclo(j)
      if (abs(wavenm(j) - lambda) > eps) stop 'Wrong wavelength in file photo10.dat'
      read (jchan11, *) i, lambda, ahobr(j), abro(j)
      if (abs(wavenm(j) - lambda) > eps) stop 'Wrong wavelength in file photo11.dat'
      read (jchan12, *) i, lambda, ahno3298(j), bhno3(j)
      if (abs(wavenm(j) - lambda) > eps) stop 'Wrong wavelength in file photo12.dat'
      read (jchan13, *) i, lambda, qeno31t(1,j), qeno31t(2,j), qeno31t(3,j), &
          qeno32t(1,j), qeno32t(2,j), qeno32t(3,j)
      if (abs(wavenm(j) - lambda) > eps) stop 'Wrong wavelength in file photo13.dat'
      read (jchan14, *) i, lambda, ano3t(1,j), ano3t(2,j)
      if (abs(wavenm(j) - lambda) > eps) stop 'Wrong wavelength in file photo14.dat'
    end do
    !
    !------------------------------------------------------------------------
    !
    !     Close the files.
    close(jchan01)
    close(jchan02)
    close(jchan03)
    close(jchan04)
    close(jchan05)
    close(jchan06)
    close(jchan08)
    close(jchan09)
    close(jchan10)
    close(jchan11)
    close(jchan12)
    close(jchan13)
    close(jchan14)
    !
    !-----------------------------------------------------------------------
    !
    !     End of photolysis data read routine.
    return
  end subroutine photord


  !-------------------------------------------------------------------------

! op_pj_20150710: NOTE: this should ultimately replaced by a proper coupling
!                 (selectable via CPL-namelist) to external O3 field,
!                 e.g., ozone tracer or climatology provided via IMPORT_GRID
  !************************************************************************
  !
  subroutine reado3(o3dat,month_o3, nlats)

    use netcdf
! op_pj_20150728: moved to here (see below) for resolving dependencies ...
!!$    use messy_clams_tools_ncutils, only: is_netcdf_file
    use messy_main_tools, only: find_next_free_unit
! op_pj_20150728: SMCL files merged into one file
!!$    use messy_dissoc_global, only: jplats, nlats, &
!!$         lats, alt, dtemp, pres, do2, do3, &
!!$         pres_inp, temp_inp,alt_inp,o3_inp, dim_pres_inp
    
    implicit none

    integer, intent(out) :: nlats
    integer, intent(in)  :: month_o3
    character(len=*), intent(in) :: o3dat

    integer :: i, j, rcode, ncid, id_temp, id_alt, id_o3, id_p
    integer :: id_lat, vartype, jchan
    integer :: ndims, start2(2), count2(2), start3(3), count3(3)
    integer,allocatable :: ilat(:)
    real, allocatable   :: rfield(:) 

    real(kind=DP), dimension(4) :: dummy
    character(len=3)    :: txt


    !write(*,*) 'reado3: ',o3dat,month_o3

    if ( is_netcdf_file(o3dat) ) then 
       ! o3dat is a Netcdf file
       rcode=nf90_open(o3dat, nf90_nowrite, ncid)

       ! get pressure levels
       rcode = nf90_inq_dimid(ncid,'press',id_p)
       rcode = nf90_inquire_dimension(ncid,id_p,len=dim_pres_inp)
       rcode = nf90_inq_varid(ncid,'press',id_p)
       allocate(rfield(dim_pres_inp),pres_inp(dim_pres_inp))
       rcode = nf90_get_var(ncid,id_p,rfield)
       pres_inp=rfield
       deallocate(rfield)
       ! get latitudes
       rcode = nf90_inq_dimid(ncid,'lat',id_lat)
       ! latitude dimension could be named 'eqlat'
       if (rcode/=0) rcode = nf90_inq_dimid(ncid,'eqlat',id_lat)
       rcode = nf90_inquire_dimension(ncid,id_lat,len=nlats)
       if (rcode/=0) then 
          write(*,*) 'error reading file '//trim(o3dat)
          call handle_error(rcode)
          stop
       endif
       if (nlats > jplats) then
          write(*,*) 'Maximum number of latitudes exceeded'
          write(*,*) 'nlats=',nlats,'; jplats=',jplats
          stop
       end if
       rcode = nf90_inq_varid(ncid,'lat',id_lat)
       if (rcode/=0) rcode = nf90_inq_varid(ncid,'eqlat',id_lat)
       rcode = nf90_inquire_variable(ncid,id_lat,xtype=vartype)
       if (vartype == nf90_int) then
          allocate(ilat(nlats))
          rcode = nf90_get_var(ncid,id_lat,ilat)
          lats(:nlats) = ilat
          deallocate(ilat)
       else
          allocate(rfield(nlats))
          rcode = nf90_get_var(ncid,id_lat,rfield)
          lats(:nlats) = rfield
          deallocate(rfield)
       endif
       start3 = (/1,1,month_o3/)
       count3 = (/nlats,dim_pres_inp,1/)
       ! get altitudes
       rcode = nf90_inq_varid(ncid,'ALT',id_alt)
       rcode = nf90_inquire_variable(ncid,id_alt,ndims=ndims)
       if (rcode/=0) then 
          write(*,*) 'error reading file '//trim(o3dat)
          call handle_error(rcode)
          stop
       endif
       allocate(alt_inp(dim_pres_inp,nlats),temp_inp(dim_pres_inp,nlats),o3_inp(dim_pres_inp,nlats))
       if (ndims == 2) then
          ! Altitude defined in dimensions time and press
          ! no latitude dependence 
          allocate(rfield(dim_pres_inp))
          start2 = (/1,month_o3/)
          count2 = (/dim_pres_inp,1/)
          rcode = nf90_get_var(ncid,id_alt,rfield,start2,count2)
          if (rcode /= 0) call handle_error(rcode)
          do i=1,nlats
             alt_inp(1:dim_pres_inp,i)=rfield
          enddo
          deallocate(rfield)
       else
          allocate(rfield(nlats*dim_pres_inp))
          rcode = nf90_get_var(ncid,id_alt,rfield,start3,count3)
          if (rcode /= 0) call handle_error(rcode)
          alt_inp = transpose(reshape(rfield,(/nlats,dim_pres_inp/)))
          deallocate(rfield)
       endif

       ! get temperature and ozone field 
       rcode = nf90_inq_varid(ncid,'TEMP',id_temp)
       allocate(rfield(nlats*dim_pres_inp))
       rcode = nf90_get_var(ncid,id_temp,rfield,start3,count3)
       if (rcode /= 0) call handle_error(rcode)
       temp_inp = transpose(reshape(rfield,(/nlats,dim_pres_inp/)))
       rcode = nf90_inq_varid(ncid,'O3',id_o3)
       if (rcode /= 0) call handle_error(rcode)
       rcode = nf90_get_var(ncid,id_o3,rfield,start3,count3)
       if (rcode /= 0) call handle_error(rcode)
       o3_inp = transpose(reshape(rfield,(/nlats,dim_pres_inp/)))
       deallocate(rfield)
       ! close NetCDF file
       rcode = nf90_close(ncid)
    else
       jchan = find_next_free_unit(100,200)
       ! no Netcdf file, read in ascii O3 profile data

       !     open the data file.
       open(jchan, file=o3dat, status="old", position="asis")
       !
       ! read header line
       read (jchan, fmt=*)
       !
       ! get number of levels in the input file (dim_pres_inp) in loop
       dim_pres_inp=0
       do while (.true.)
          read (jchan,*,end=10) dummy
          dim_pres_inp = dim_pres_inp+1
       end do
10     continue
       ! number of latitudes
       nlats = 1
       ! set dummy value for latitude
       lats(1)=0.0
       !
       allocate(pres_inp(dim_pres_inp))
       allocate(alt_inp(dim_pres_inp,nlats),temp_inp(dim_pres_inp,nlats),o3_inp(dim_pres_inp,nlats))
       rewind(jchan)
       !     skip 1 header line
       read (jchan, *)
       do j=1,dim_pres_inp
          read (jchan, *) alt_inp(j,1), temp_inp(j,1), pres_inp(j), o3_inp(j,1)
       end do
       !     end of read in the data loop.
       close(jchan)
    endif
    !-----------------------------------------------------------------------
    !
    !   sort arrays into ascending altitude order.
    !   (i.e. start at the ground)
    !   this call was at the beginning from setpro before (jug, 15.9.99)
    !   now the arrays are sorted immedeately after they are read in

! op_pj_20150728+: due to the I/O requirements in parallel decomposition,
!                  this needs to be split and called directly from SMIL ...
!!$    call p_ascend (dim_pres_inp, nlats, pres_inp, alt_inp, temp_inp, o3_inp)
!!$    
!!$
!!$    !     set up suitable levels for the scattering table.
!!$    ! setpro replaced by setp
!!$    call setp 
!!$
!!$    deallocate(pres_inp, alt_inp, temp_inp, o3_inp)
! op_pj_20150728-
    return

! op_pj_20150709+: temporary placed here, later obsolete after proper 
!                  coupling to external ozone field
  contains
  !*************************************************************************
  !  Function to verify if a file is a netcdf-file
  !*************************************************************************
  function is_netcdf_file(dateiname) result(erg)

    character(len=*)     :: dateiname
    logical              :: erg
    character(len=3)     :: txt

    open(unit=13, file=dateiname, status='old', position='rewind', action='read')
    read(unit=13,fmt=*) txt
    if ( txt .eq. 'CDF' ) then
       erg = .true.
    else
       erg = .false.
    endif
    close(13)
    
  end function is_netcdf_file
! op_pj_20150709-
  end subroutine reado3

  subroutine set_jcalc_indices

! op_pj_20150728: SMCL files merged; already USEd globally
!!$     use messy_cmn_photol_mem
!!$     use messy_dissoc_global, only: jcalc, numj_max, numj
     integer :: i

     ! set indices of jcalc array that are calculated here
     !
     jcalc(:)         = .false.
     jcalc(ip_O2)     = .true.      ! O2 + hv -> O + O
     jcalc(ip_O3P)    = .true.      ! O3 + hv -> O2 + O(3P)
     jcalc(ip_O1D)    = .true.      ! O3 + hv(<310nm) -> O2 + O(1D)
     jcalc(ip_H2O2)   = .true.      ! H2O2 + hv -> OH + OH
     jcalc(ip_Cl2)    = .true.      ! Cl2 + hv -> Cl + Cl
     jcalc(ip_Cl2O2)  = .true.      ! Cl2O2 + hv -> Cl2O + Cl
     jcalc(ip_HOCl)   = .true.      ! HOCl + hv -> OH + Cl
     jcalc(ip_ClNO2)  = .true.      ! ClNO2 + hv -> Cl + NO2
     jcalc(ip_ClNO3)  = .true.      ! ClONO2 + hv -> Cl + NO3
     jcalc(ip_ClONO2) = .true.      ! ClONO2 + hv -> ClO + NO2
     jcalc(ip_HNO3)   = .true.      ! HNO3 + hv -> NO2 + OH 
     jcalc(ip_NO2)    = .true.      ! NO2 + hv -> NO + O(3P)
     jcalc(ip_N2O5)   = .true.      ! N2O5 + hv -> NO2 + NO3
     jcalc(ip_HNO4)   = .false.     ! HO2NO2 + hv -> products ! caution, no
                                                              ! duplicate reactions
     jcalc(ip_HO2NO2) = .true.      ! HO2NO2 + hv -> HO2 + NO2
     jcalc(ip_OHNO3)  = .true.      ! HO2NO2 + hv -> OH + NO3
     jcalc(ip_NO2O)   = .true.      ! NO3 + hv -> NO2 + O
     jcalc(ip_NOO2)   = .true.      ! NO3 + hv -> NO + O2
     jcalc(ip_CHOH)   = .true.      ! CH2O + hv   -> CHO + H
     jcalc(ip_COH2)   = .true.      ! CH2O + hv   -> CO + H2
     jcalc(ip_CH3OOH) = .true.      ! CH3O2H + hv -> products
     ! ju_jg_20181212+
     ! if jcalc(ip_BrONO2) will be set to false, the partitioning needs to be
     ! determined by the chemistry solver
     ! mz_rs_20180614+
     jcalc(ip_BrONO2) = .true.      ! BrONO2 + hv -> BrO + NO2
     jcalc(ip_BrNO3)  = .true.      ! BrONO2 + hv -> Br + NO3
     ! mz_rs_20180614-
     ! ju_jg_20181212-
     jcalc(ip_BrCl)   = .true.      ! BrCl + hv -> Br +Cl
     jcalc(ip_OClO)   = .true.      ! OClO + hv -> O + ClO
     jcalc(ip_H2O)    = .true.      ! H2O + hv -> H + OH
     jcalc(ip_HCl)    = .true.      ! HCl + hv -> H + Cl
     jcalc(ip_NO)     = .true.      ! NO + hv -> N + O
     jcalc(ip_N2O)    = .true.      ! N2O + hv -> N2 + O(1D)
     jcalc(ip_CH3OCl) = .true.      ! CH3OCl + hv -> products
     jcalc(ip_HOBr)   = .true.      ! HOBr + hv -> Br + OH
     jcalc(ip_Br2)    = .true.      ! Br2 + hv -> Br + Br
     jcalc(ip_MEO2NO2)= .true.     
     jcalc(ip_BrO)    = .true.      ! BrO + hv -> O + Br
     jcalc(ip_CFCl3)  = .true.      ! CFCl3 + hv -> 3Cl + products
     jcalc(ip_CF2Cl2) = .true.      ! CF2Cl2 + hv -> 2Cl + products
     jcalc(ip_CHF2Cl) = .true.      ! CHF2Cl + hv -> Cl + products
     jcalc(ip_F113)   = .true.      ! CF2CFCl3 + hv -> 3Cl + products
     jcalc(ip_CH3Cl)  = .true.      ! CH3Cl + hv -> CH3 + Cl
     jcalc(ip_CCl4)   = .true.      ! CCl4 + hv -> 4Cl + products

     jcalc(ip_CH3Br)  = .true.      ! CH3Br + hv -> Br + CH3
     jcalc(ip_CF2ClBr)= .true.      ! CF2BrCl + hv -> products
     jcalc(ip_CF3Br)  = .true.      ! CF3Br + hv -> products


     
     numj = count(jcalc)
     
     ! this could be changed if number of needed Js is known here (numj < numj_max)
     !write(*,*)'set_jcalc_indices: jcalc ',jcalc
     !write(*,*)'set_jcalc_indices: numj, numj_max ',numj, numj_max
     if (numj /= numj_max) stop 'inconsistent mapping of photolysis rates'

     
  end subroutine set_jcalc_indices


  subroutine handle_error(rcode)
    use netcdf
    integer :: rcode
    write(*,*) nf90_strerror(rcode)
    stop
    return
  end subroutine handle_error

  !
  !-----------------------------------------------------------------------
  !
  subroutine invert(a, ainv, acopy, indx, np)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer  :: np
    integer  :: indx(np)
    real(kind=DP)  :: a(np,np)
    real(kind=DP)  :: ainv(np,np)
    real(kind=DP)  :: acopy(np,np)
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: i, j
    real(kind=DP) :: d
    !-----------------------------------------------------------------------
    !
    !     set up the identity matrix.
    do i = 1, np
      ainv(i,:np) = 0.0
      ainv(i,i) = 1.0
    end do
    !
    !     take copies of matrix a.
    acopy = a
    !
    !     Decompose the matrix once.
    call ludcmp (acopy, np, np, indx, d)
    !
    !     Find the inverse by columns.
    do j = 1, np
      call lubksb (acopy, np, np, indx, ainv(1:np,j))
    end do
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine invert


  !
  !-----------------------------------------------------------------------
  !
  subroutine linfit(n, j, x, y, xwant, ywant)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: n
    integer , intent(in) :: j
    real(kind=DP) , intent(in) :: xwant
    real(kind=DP) , intent(out) :: ywant
    real(kind=DP) , intent(in) :: x(n)
    real(kind=DP) , intent(in) :: y(n)
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    real(kind=DP) :: c, m
    !-----------------------------------------------
    !
    !-----------------------------------------------------------------------
    !
    !      purpose
    !      -------
    !
    !      performs linear interpolation between data points.
    !
    !**    interface
    !      ---------
    !
    !      *call**(n,j,x,y,xwant,ywant)*
    !      n        - the number of points in the array.
    !      j        - array index of point below xwant in the x array.
    !      x        - x array.
    !      y        - y array.
    !      xwant    - required x.
    !      ywant    - required y returned on exit.
    !
    !      method
    !      ------
    !
    !      equation of a straight line, y=mx+c
    !
    !      externals
    !      ---------
    !
    !      none.
    !
    !      author
    !      ------
    !
    !      emma lutman
    !
    !      last modified  : 17/4/1991
    !
    !-----------------------------------------------------------------------
    !
    m = (y(j+1)-y(j))/(x(j+1)-x(j))
    !
    !     intercept.
    c = y(j) - m*x(j)
    !
    !     new value.
    ywant = xwant*m + c
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine linfit

  subroutine linfit2(n, k, k1, j, x, y, xwant, ywant)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: n, k, k1, j
    real(kind=DP) , intent(in) :: xwant
    real(kind=DP) , intent(out) :: ywant
    real(kind=DP) , intent(in) :: x(n)
    real(kind=DP) , intent(in) :: y(n,k)
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    real(kind=DP) :: c, m
    !-----------------------------------------------
    ! 
    ! same as subroutine linfit, but for  2-dim array y(n,k). Only the 1-dim 
    ! sub-array y(:,k1) is used here.
    !-----------------------------------------------------------------------
    !
    !      purpose
    !      -------
    !
    !      performs linear interpolation between data points.
    !
    !**    interface
    !      ---------
    !
    !      *call**(n,j,x,y,xwant,ywant)*
    !      n        - the number of points in the array.
    !      j        - array index of point below xwant in the x array.
    !      x        - x array.
    !      y        - y array.
    !      xwant    - required x.
    !      ywant    - required y returned on exit.
    !
    !      method
    !      ------
    !
    !      equation of a straight line, y=mx+c
    !
    !      externals
    !      ---------
    !
    !      none.
    !
    !      author
    !      ------
    !
    !      emma lutman
    !
    !      last modified  : 17/11/1998, J.U. Grooss
    !
    !-----------------------------------------------------------------------
    !
    m = (y(j+1,k1)-y(j,k1))/(x(j+1)-x(j))
    !
    !     intercept.
    c = y(j,k1) - m*x(j)
    !
    !     new value.
    ywant = xwant*m + c
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine linfit2


  !
  !-----------------------------------------------------------------------
  !
  subroutine lubksb(a, n, np, indx, b)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: n
    integer , intent(in) :: np
    integer , intent(in) :: indx(n)
    real(kind=DP) , intent(in) :: a(np,np)
    real(kind=DP) , intent(inout) :: b(n)
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: i, ii, j, ll
    real(kind=DP) :: sum
    !-----------------------------------------------
    !
    ii = 0
    do i = 1, n
      ll = indx(i)
      sum = b(ll)
      b(ll) = b(i)
      if (ii /= 0) then
        do j = ii, i - 1
          sum = sum - a(i,j)*b(j)
        end do
      else if (sum /= 0) then
        ii = i
      endif
      b(i) = sum
    end do
    do i = n, 1, -1
      sum = b(i)
      if (i < n) then
        do j = i + 1, n
          sum = sum - a(i,j)*b(j)
        end do
      endif
      b(i) = sum/a(i,i)
    end do
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine lubksb


  !
  !-----------------------------------------------------------------------
  !
  subroutine ludcmp(a, n, np, indx, d)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: n
    integer , intent(in) :: np
    real(kind=DP) , intent(out) :: d
    integer , intent(out) :: indx(n)
    real(kind=DP) , intent(inout) :: a(np,np)
    !-----------------------------------------------
    !   L o c a l   P a r a m e t e r s
    !-----------------------------------------------
    integer, parameter :: nmax = 100
    real(kind=DP), parameter :: tiny = 1.0E-20
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: i, imax, j, k
    real(kind=DP) :: aamax, dum, sum
    real(kind=DP), dimension(nmax) :: vv
    !-----------------------------------------------
    !   I n t r i n s i c  F u n c t i o n s
    !-----------------------------------------------
    INTRINSIC abs
    !-----------------------------------------------
    !
    d = 1.0
    do i = 1, n
      aamax = 0
      aamax = max(maxval(abs(a(i,:n))),aamax)
      if (aamax == 0) then
        write(unit=*,fmt="(2A)") "PAUSE ", "Singular matrix."
        read *
      endif
      vv(i) = 1.0/aamax
    end do
    do j = 1, n
      if (j > 1) then
        do i = 1, j - 1
          sum = a(i,j)
          if (i <= 1) cycle
          do k = 1, i - 1
            sum = sum - a(i,k)*a(k,j)
          end do
          a(i,j) = sum
        end do
      endif
      aamax = 0
      do i = j, n
        sum = a(i,j)
        if (j > 1) then
          do k = 1, j - 1
            sum = sum - a(i,k)*a(k,j)
          end do
          a(i,j) = sum
        endif
        dum = vv(i)*abs(sum)
        if (dum < aamax) cycle
        imax = i
        aamax = dum
      end do
      if (j /= imax) then
        do k = 1, n
          dum = a(imax,k)
          a(imax,k) = a(j,k)
          a(j,k) = dum
        end do
        d = -d
        vv(imax) = vv(j)
      endif
      indx(j) = imax
      if (j == n) cycle
      if (a(j,j) == 0) a(j,j) = tiny
      dum = 1.0/a(j,j)
      a(j+1:n,j) = a(j+1:n,j)*dum
    end do
    if (a(n,n) == 0) a(n,n) = tiny
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine ludcmp


  !-----------------------------------------------------------------------
  !
  subroutine maxzen(jpslev, jpslevall, nlats, jplats,zenmax)
    !-----------------------------------------------
    !   M o d u l e s
    !-----------------------------------------------
! op_pj_20150728: SMCL files merged; already USEd globally
!!$    USE messy_main_constants_mem,  ONLY: pi
!!$    USE messy_dissoc_global,  ONLY: alt, re
   !
    !-----------------------------------------------------------------------
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: jpslev
    integer , intent(in) :: jpslevall
    integer , intent(in) :: nlats
    integer , intent(in) :: jplats
    real(kind=DP) , intent(out) :: zenmax(jpslev,jplats)

    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: j, jl
    real(kind=DP) :: zmrgn
    !-----------------------------------------------
    !   I n t r i n s i c  F u n c t i o n s
    !-----------------------------------------------
    INTRINSIC asin
    !-----------------------------------------------
    !
    !     a 0.5 degree margin, i.e. stop photolysis 1 degree early.
    !     joe farman suggested this.
    !     zmrgn=0.5*dtr
    zmrgn = 0.0
    !
    j = 1
    zenmax(j,:nlats) = pi*0.5
    !
    do jl=1,nlats
       zenmax(2:jpslev,jl) = (pi - asin(re/(re + alt(2:jpslev,jl)))) - zmrgn
    end do
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine maxzen


  !
  !-----------------------------------------------------------------------
  !
  subroutine nxtzen(alpha, alta, beta, altb, re)
! op_pj_20150728: already USEd globally
!!$    USE messy_main_constants_mem,   ONLY: dtr
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: alpha
    real(kind=DP) , intent(in) :: alta
    real(kind=DP) , intent(out) :: beta
    real(kind=DP) , intent(in) :: altb
    real(kind=DP) , intent(in) :: re
    !-----------------------------------------------
    !   L o c a l   P a r a m e t e r s
    !-----------------------------------------------
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    real(kind=DP) :: altacm, altbcm, arg
    !-----------------------------------------------
    !   I n t r i n s i c  F u n c t i o n s
    !-----------------------------------------------
    INTRINSIC asin, sin
    !-----------------------------------------------
    !
    !-----------------------------------------------------------------------
    !
    !     argrument list.
    !
    !     name     type               description.
    !     alpha    real(kind=DP)               zenith angle at level a.
    !                                 (unchanged on exit).
    !
    !     alta     real(kind=DP)               altitude level a in km.
    !                                 (unchanged on exit).
    !
    !     beta     real(kind=DP)               zenith angle at level b.
    !                                 (contains answer on exit).
    !
    !     altb     real(kind=DP)               altitude level b in km.
    !                                 (unchanged on exit).
    !
    !     re       real(kind=DP)               the radius of the earth in km.
    !                                 (unchanged on exit).
    !
    !-----------------------------------------------------------------------
    !
    !     calculate zenith angle @ altb(in km), beta(in radians) from a
    !     knowledge of the zenith angle @ alta(in km), alpha(in radians),
    !     using the sine rule.
    !
    !     david lary
    !     ----------
    !
    !     date started : 7/2/1990
    !
    !     last modified: 27/9/1991
    !
    !-----------------------------------------------------------------------
    !     ..
    !     .. Intrinsic Functions ..
    !     ..
    !
    !-----------------------------------------------------------------------
    !
    !
    !-----------------------------------------------------------------------
    !
    altacm = (alta + re)*1.0E5
    altbcm = (altb + re)*1.0E5

    arg = altacm*sin(alpha)/altbcm

    if (arg > 1.0) then
      write(unit=*,fmt=*) "*** nxtzen ***"
      write(unit=*,fmt=*) alta, altb, alpha/dtr
      write(unit=*,fmt=*) "argument for asin > 1:", arg
      stop
    else
      beta = asin(arg)
    endif
    return
  end subroutine nxtzen


  !
  !-----------------------------------------------------------------------
  !
  subroutine physmid(nlats)
! op_pj_20150728: SMCL files merged
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) ::  nlats
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: i, ip1
    !-----------------------------------------------
    !
    !-----------------------------------------------------------------------
    !
    !     argrument list.
    !
    !     name      type              description.
    !     jpslev    integer           number of pressure levels.
    !                                 (unchanged on exit).
    !
    !     jpslevall integer           number of pressure levels + 1.
    !                                 (unchanged on exit).
    !
    !     alt      array of real(kind=DP)      altitude at the edge of each level
    !                                 in km.
    !                                 (unchanged on exit).
    !
    !     altc     array of real(kind=DP)      altitude at the centre of each level
    !                                 in km.
    !                                 (contains answer on exit).
    !
    !     sao2     array of real(kind=DP)      vertical o2 column above the edge of
    !                                 each level in molecules per cm^2.
    !                                 (unchanged on exit).
    !
    !     sao2c    array of real(kind=DP)      vertical o2 column above the centre
    !                                 of each level in molecules per cm^2.
    !                                 (contains answer on exit).
    !
    !     sao3     array of real(kind=DP)      vertical o3 column above the edge of
    !                                 each level in molecules per cm^2.
    !                                 (unchanged on exit).
    !
    !     sao3c    array of real(kind=DP)      vertical o3 column above the centre
    !                                 of each level in molecules per cm^2.
    !                                 (contains answer on exit).
    !
    !     do2      array of real(kind=DP)      number density of o2 at the edge of
    !                                 each level in molecules per cm^3.
    !                                 (unchanged on exit).
    !
    !     do2c     array of real(kind=DP)      number density of o2 column at the
    !                                 centre of each level in molecules per
    !                                 cm^3.
    !                                 (contains answer on exit).
    !
    !     do3      array of real(kind=DP)      number density of o3 at the edge of
    !                                 each level in molecules per cm^3.
    !                                 (unchanged on exit).
    !
    !     do3c     array of real(kind=DP)      number density of o3 column at the
    !                                 centre of each level in molecules per
    !                                 cm^3.
    !                                 (contains answer on exit).
    !
    !     samc     array of real(kind=DP)      total vertical column above the centre
    !                                 of each level in molecules per cm^2.
    !                                 (contains answer on exit).
    !
    !     dtempc    array of real(kind=DP)      temperature in Kelvin at the centre of
    !                                 each level.
    !                                 (contains answer on exit).
    !
    !     dtemp     array of real(kind=DP)      temperature in Kelvin at the edge of
    !                                 each level.
    !                                 (unchanged on exit).
    !
    !     presc    array of real(kind=DP)      pressure in mb at the centre of
    !                                 each level.
    !                                 (contains answer on exit).
    !
    !     tabpres  array of real(kind=DP)      pressure in mb of each level in the
    !                                 various tables created. 
    !                                 -- identical to presc, left out (jug 01/2014)
    !                                 (contains answer on exit).
    !
    !     pres     array of real(kind=DP)      pressure in mb at the edge of
    !                                 each level.
    !                                 (unchanged on exit).
    !
    !-----------------------------------------------------------------------
    !
    !     a subroutine which calculates the value of the physical quantities
    !     at the centre of each scattering level.
    !
    !     david lary
    !     ----------
    !
    !     date started : 7/2/1990
    !
    !     last modified: 27/9/1991
    !
    !-----------------------------------------------------------------------
    !
    do i = 1, jpslev
      ip1 = i + 1
      altc(i,:nlats) = (alt(i,:nlats)+alt(ip1,:nlats))*0.5
      do2c(i,:nlats) = (do2(i,:nlats)+do2(ip1,:nlats))*0.5
      do3c(i,:nlats) = (do3(i,:nlats)+do3(ip1,:nlats))*0.5
      dtempc(i,:nlats) = (dtemp(i,:nlats)+dtemp(ip1,:nlats))*0.5
      presc(i) = (pres(i)*pres(ip1))**0.5
    end do
    return
  end subroutine physmid


  !
  !-----------------------------------------------------------------------
  !
  subroutine pos(xx, n, x, j)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: n
    integer , intent(out) :: j
    real(kind=DP) , intent(in) :: x
    real(kind=DP) , intent(in) :: xx(n)
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jl, jm, ju
    !-----------------------------------------------
    !
    !-----------------------------------------------------------------------
    !
    !     argrument list.
    !
    !     name      type              description.
    !     xx        array of real(kind=DP)     monotonic array of length n.
    !                                 (unchanged on exit).
    !
    !     n         integer           length of array xx.
    !                                 (unchanged on exit).
    !
    !     x         real(kind=DP)              value whose position in xx is
    !                                 required.
    !                                 (unchanged on exit).
    !
    !     j         integer           index of x in array xx.
    !                                 (contains answer on exit).
    !
    !-----------------------------------------------------------------------
    !
    !     given an array xx of length n, and given a value x, pos returns a
    !     value j sucha that x lies between xx(j) and xx(j+1). xx must be
    !     monotonic, either increasing or decreasing. j=0 or j=n is returned
    !     to indicate that x is out of range.
    !
    !     the table entry j is found by bisection.
    !
    !     taken from numerical recipes, the art of scientific computing,
    !     section 3.4, by press, flannery, teukolsky & vetterling,
    !     cambridge university press, 1987, (where it is called locate).
    !
    !     modified by: david lary
    !                  ----------
    !
    !     date started : 7/2/1990
    !
    !     last modified: 27/9/1991
    !
    !-----------------------------------------------------------------------
    !
    jl = 0
    ju = n + 1
10  continue
    if (ju - jl > 1) then
      !
      jm = (ju + jl)/2
      if (xx(n)>xx(1) .eqv. x>xx(jm)) then
        jl = jm
      else
        ju = jm
      endif
      !           repeat untill the test condition is satisfied.
      go to 10
    endif
    !     set the output.
    j = jl
    return
    !
    !----------------------------------------------------------------------
    !
  end subroutine pos

  subroutine pos2(xx, n, k, k1, x, j)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: n, k, k1
    integer , intent(out) :: j
    real(kind=DP) , intent(in) :: x
    real(kind=DP) , intent(in) :: xx(n,k)
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jl, jm, ju
    !-----------------------------------------------
    !
    ! same as subroutine pos, but for a 2-dim array xx(k,n). Only the 1-dim 
    ! sub-array xx(:,k1) is used here.
    !-----------------------------------------------------------------------
    !
    !     argrument list.
    !
    !     name      type              description.
    !     xx        array of real(kind=DP)     monotonic array of length n.
    !                                 (unchanged on exit).
    !
    !     n         integer           length of array xx.
    !                                 (unchanged on exit).
    !
    !     x         real(kind=DP)              value whose position in xx is
    !                                 required.
    !                                 (unchanged on exit).
    !
    !     j         integer           index of x in array xx.
    !                                 (contains answer on exit).
    !
    !-----------------------------------------------------------------------
    !
    !     given an array xx of length n, and given a value x, pos returns a
    !     value j sucha that x lies between xx(j) and xx(j+1). xx must be
    !     monotonic, either increasing or decreasing. j=0 or j=n is returned
    !     to indicate that x is out of range.
    !
    !     the table entry j is found by bisection.
    !
    !     taken from numerical recipes, the art of scientific computing,
    !     section 3.4, by press, flannery, teukolsky & vetterling,
    !     cambridge university press, 1987, (where it is called locate).
    !
    !     modified by: david lary
    !                  ----------
    !
    !     date started : 7/2/1990
    !
    !     last modified: 27/9/1991
    !
    !-----------------------------------------------------------------------
    !
    jl = 0
    ju = n + 1
10  continue
    if (ju - jl > 1) then
      !
      jm = (ju + jl)/2
      if (xx(n,k1)>xx(1,k1) .eqv. x>xx(jm,k1)) then
        jl = jm
      else
        ju = jm
      endif
      !           repeat untill the test condition is satisfied.
      go to 10
    endif
    !     set the output.
    j = jl
    return
    !
    !----------------------------------------------------------------------
    !
  end subroutine pos2


  !------------------------------------------------------------------------
  !
  subroutine quanto1d(t)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: t
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    !
    !real(kind=DP), dimension(3), parameter :: a  =  (/0.887_DP,2.35_DP,57.0_DP/) ,&
    !                                         lam0 = (/302._DP,311.1_DP,313.9_DP/),&
    !                                         nu =  (/0.0_DP,820._DP,1190._DP/),&
    !                                         omega=(/7.9_DP,2.2_DP,7.4_DP/)
    !real(kind=DP),parameter :: k=0.695          ! cm^-1 K^-1
    real(kind=DP), dimension(3), parameter :: a  =  (/0.8036_DP,8.9061_DP,0.1192_DP/) ,&
                                             lam0 =(/304.225_DP,314.957_DP,310.737_DP/),&
                                             nu =  (/0.0_DP,825.518_DP,0.0_DP/),&
                                             omega=(/5.576_DP,6.601_DP,2.187_DP/)
    real(kind=DP),parameter :: r=0.695_DP          ! cm^-1 K^-1
    real(kind=DP),parameter :: c=0.0765_DP
    real(kind=DP) :: q1,q2,tc
    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     JPWAVE   Integer            Number of wavelength intervals.
    !                                 (Unchanged on exit).
    !
    !     WAVENM   Array of real(kind=DP)      Wavelength of each interval in nm.
    !                                 (Unchanged on exit).
    !
    !     QEO1D    Array of real(kind=DP)      The quantum yield of O(1D) from O3
    !                                 photolysis at wavelengths less than
    !                                 310 nm.
    !                                 (Contains result on exit).
    !************************************************************************
    !
    !     A subroutine which calculates the quantum yield of O(1D) from O3
    !     photolysis at wavelengths 289-329 nm (203-320 K)
    !
    !     source: Sander et al, 2000 (JPL00)
    !
    !
    !     Jens-Uwe Grooss   
    !     ---------------   
    !
    !     Date Started : 12/05/2000
    !
    !     Last modified: 12/05/2000
    !
    !-------------------------------------------------------------------------
    !
    !
    !
    !------------------------------------------------------------------------
    tc=t
    if (tc < 200) tc=200.
    if (tc > 320) tc=320.

    !
    !  Set values of PHI at values not covered by the parameterisation.
    !     i)  Intervals 1 to 92. (lambda < 306 nm)
    qeo1d(:94) = 0.90_DP
    !
    !     ii) Intervals 99 to 102 (328 nm < lambda <= 345 nm)
    qeo1d(99:102) = 0.08_DP
    !
    !     ii) Intervals 103 to jpwave (lambda > 345 nm)
    qeo1d(103:jpwave) = 0.0

    !
    !     Intervals 93 to 99.(300 nm < lambda <= 330 nm)
    !
    !     Set up the quantum yield of O(1D) from O3 photolysis at
    !     wavelengths 289-329 nm (203-320 K)
    !     Parametrisation according to JPL2003 for 306-328 nm

    !
    q1=exp(-nu(1)/(r*tc))
    q2=exp(-nu(2)/(r*tc))
    qeo1d(95:98) = q1/(q1+q2) * a(1) * exp(-((lam0(1)-wavenm(95:98))/omega(1))**4) + &
       q2/(q1+q2) * a(2) * (tc/300.)**2 * exp(-((lam0(2)-wavenm(95:98))/omega(2))**2) +& 
       a(3) * (tc/300.)**1.5 * exp(-((lam0(3)-wavenm(95:98))/omega(3))**2) + c


    !
    !--------------------------------------------------------------------
    !
    return
  end subroutine quanto1d

  subroutine quantch2o(t, p)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: T
    real(kind=DP) , intent(in) :: p
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    !
    real(kind=DP), parameter:: boltz = 1.38066E-23  ! J/K
    real(kind=DP), parameter:: h = 6.6256E-34       ! Js
    real(kind=DP), parameter:: c = 299792458.       ! m/s
    real(kind=DP), parameter:: hc = h*c
    real(kind=DP), parameter:: M0 = 2.46E+19        ! cm^-3
    real(kind=DP) :: M, x1(jpwave), x2(jpwave), x3(jpwave)

    !-----------------------------------------------
    !
    !------------------------------------------------------------------------
    !
    !     Argrument list.
    !
    !     Name     Type               Description.
    !     T        Real               Temperature in Kelvin.
    !                                 (Unchanged on exit).
    !
    !     p        Real               Pressure in hPa
    !                                 (Unchanged on exit).
    !
    !     JPWAVE   Integer            Number of wavelength intervals.
    !                                 (Unchanged on exit).
    !
    !     WAVENM   Array of real(kind=DP)      Wavelength of each interval in nm.
    !                                 (Unchanged on exit).
    !
    !     QECH2Oa    Array of real(kind=DP)   The quantum yield of CH2O to form
    !                                 H + HCO (radical channel)
    !                                 (Contains result on exit).
    !
    !     QECH2Ob    Array of real(kind=DP)   The quantum yield of CH2O to form
    !                                 H2 + CO (molecular channel)
    !                                 (Contains result on exit).
    !************************************************************************
    !
    !     A subroutine which calculates the quantum yield of O(1D) from O3
    !     photolysis at wavelengths 289-329 nm (203-320 K)
    !
    !     source: Roeth and Ehhalt, Atmos. Chem. Phys., 15, 7195-7202, 2015
    !
    !
    !     Jens-Uwe Grooss   
    !     ---------------   
    !
    !     Date Started : 26/10/2015
    !
    !     Last modified: 26/10/2015
    !
    !-------------------------------------------------------------------------
    !
    !
    !
    !------------------------------------------------------------------------

    ! calulate total air molecule number density
    M = (p * 100.)/(boltz * T * 1.0E6)

    where(wavenm > 250. .and. wavenm <= 380.) 

       ! Temperature dependence term (300. - T) * 3E-9 * boltz/hc after Troe
       ! should be seen as an upper limit (Roeth, pers. comm. 10/2015)
       !
       ! factor 3 * boltz / hc needs to be converted into nm^-1
       x1 =  0.74 / (1. + exp( -(1./wavenm + (300. - T) * 3E-9 * boltz/hc &
                               - 1./327.4 ) / 5.4E-5) ) 
       x2 = 1.0 + exp(-(1./wavenm - 1./279.) / 5.2E-5)
       x3 = 1./(1. + exp(-(1./wavenm - 1/346.9) / 5.4E-5 )*M/M0) 
       
       qech2oa = (x1 - 0.40/x2)
       qech2ob = (x3 - x1 + 0.18/x2)
    elsewhere
       qech2oa = 0.
       qech2ob = 0.
    end where

    !
    !--------------------------------------------------------------------
    !
    return
  end subroutine quantch2o

  !-----------------------------------------------------------------------
  !
  subroutine scatcs(scs)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(inout) :: scs(jpwave)
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: jw
    real(kind=DP) :: xlamda, xx
    !-----------------------------------------------
    !   I n t r i n s i c  F u n c t i o n s
    !-----------------------------------------------
    INTRINSIC exp, log
    !-----------------------------------------------
    !
    !-----------------------------------------------------------------------
    !
    !     argrument list.
    !
    !     name     type               description.
    !     jpwave   integer            number of wavelength intervals.
    !                                 (unchanged on exit).
    !
    !     scs      array of real(kind=DP)      the rayleigh scattering cross
    !                                 section for air molecules in
    !                                 molecules per cm^2.
    !                                 (contains result on exit).
    !
    !     wavenm   array of real(kind=DP)      wavelength of each interval in nm.
    !                                 (unchanged on exit).
    !
    !-----------------------------------------------------------------------
    !
    !     a subroutine which calculates the rayleigh scattering cross
    !     section based on nicolet (1984).
    !
    !     M. Nicolet, Planet. Space Sci., Vol. 32, No. 11, pp. 1467-1468. 1984
    !
    !     david lary
    !     ----------
    !
    !     date started : 5/2/1990
    !
    !     last modified: 6/9/1991
    !
    !-----------------------------------------------------------------------
    !
    do jw = 1, jpwave
      !         nicolet (1984) relationship for rayleigh cross section.
      xlamda = wavenm(jw)*1.0e-3
      xx = 0.389*xlamda + 0.09426/xlamda - 0.3228
      scs(jw) = exp((4.0 + xx)*log(xlamda))
      scs(jw) = 4.02E-28/scs(jw)
    end do
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine scatcs


  !-----------------------------------------------------------------------
  !
  subroutine setp
! op_pj_20150728: SMCL files merged
!!$    use  messy_dissoc_global, only: jpslevall, jplats, nlats, ptop, &
!!$         dim_pres_inp, pres_inp, alt_inp, temp_inp, o3_inp, alt, dtemp, &
!!$         pres, do2, do3, boltz

    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: i, jz, jl
    real(kind=DP) :: p, pmax, pmin, pow, prange, tnd, zint
    !-----------------------------------------------------------------------
    !
    !     subroutine to set up profiles suitable for the radiative transfer
    !     model on a log-pressure scale.
    !
    !     David Lary
    !     ----------
    !
    !     date started : 27/9/1991
    !
    !     last modified: 27/9/1991
    !
    !-----------------------------------------------------------------------
    !
    pmax=maxval(pres_inp)
    pmin=minval(pres_inp)
    ! ignore pressure levels above the top pressure level defined by ptop
    !  (defined in module photodim_M)
    pmin = max(pmin,ptop)
    !
    !     calculate the pressure range.
    prange = abs(log10(pmax) - log10(pmin))
    !
    !     assign interval.
    zint = prange/real(jpslevall - 1,DP)
    !write(unit=*,fmt=*) "zint:", zint
    if (zint == 0.0) stop
    !
    !-----------------------------------------------------------------------
    !
    !     level loop to construct new pressure levels.
    do i = 1, jpslevall
       !
       !         use a log pressure scale.
       if (i == 1) then
          p = pmax
       else if (i == jpslevall) then
          p = pmin
       else
          pow = log10(pmax) - real(i - 1,DP)*zint
          p = 10.0**pow
       endif
       !
       !         assign pressure.
       pres(i) = p
       p = max(p,pmin*1.0001)
       p = min(p,pmax*0.9999)
       !
       !         find appropriate temperatures, ozone values and altitudes.
       call pos (pres_inp, dim_pres_inp, p, jz)
       !
       ! loop over latitudes
       do jl = 1,nlats

         !         if in range.
         if (jz/=0 .and. jz/=dim_pres_inp) then
           !
           call linfit2 (dim_pres_inp, nlats, jl, jz, pres_inp, temp_inp, p, dtemp(i,jl))
           call linfit2 (dim_pres_inp, nlats, jl, jz, pres_inp, o3_inp, p, do3(i,jl))
           call linfit2 (dim_pres_inp, nlats, jl, jz, pres_inp, alt_inp, p, alt(i,jl))
           !
           !         else
         else if (jz <= 1) then
           !
           write(unit=*,fmt=*) "jz<1"
           dtemp(i,jl) = temp_inp(1,jl)
           do3(i,jl) = o3_inp(1,jl)
           alt(i,jl) = alt_inp(1,jl)
           !
           !         else
         else if (jz >= dim_pres_inp) then
           !
           dtemp(i,jl) = temp_inp(dim_pres_inp,jl)
           do3(i,jl) = o3_inp(dim_pres_inp,jl)
           alt(i,jl) = alt_inp(dim_pres_inp,jl)
           !
           !         end of if in range.
         endif
         !
         !         assign other variables.
         !
         !         total number density.
         tnd = (pres(i)*1.0E2)/(boltz*dtemp(i,jl)*1.0E6)
         !
         !         oxygen number density.
         do2(i,jl) = tnd*0.20946
         !
         !         convert o3 v.m.r. to a number density.
         do3(i,jl) = do3(i,jl)*tnd
         !
       end do
    end do
    !
    !-----------------------------------------------------------------------
    !
    return
  end subroutine setp


  !
  !-----------------------------------------------------------------------
  !
  subroutine settab
    !-----------------------------------------------
    !   M o d u l e s
    !-----------------------------------------------
! op_pj_20150728: SMCL files merged

    !
    !-----------------------------------------------------------------------
    ! Jan. 96 : matrix a calculated whith jacobian d tau/ d delta tau
    !           including correct treatment of a_kk  (g.becker)
    !-----------------------------------------------------------------------
    !
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: i, j, jc, jci, jk, jlev, jn, jt, jw, jl
    integer , dimension(jpsover,jpslev) :: ijt
    integer, dimension(jpslev) :: indx
    real(kind=DP) :: alpha, alt90, alta, altb, altcur, arg, beta, spl, tauk
    real(kind=DP) :: taun, tauv, teak, tean, teav, twoamu, teanp, taunp
    real(kind=DP) , dimension(jpslev,jpslev) :: a
    real(kind=DP) , dimension(jpslev,jpslev) :: b, bcopy, binv
    real(kind=DP) , dimension(jpslev,jplats) :: dalt
    real(kind=DP) , dimension(jpslev,jpschi) :: deptha, depths
    real(kind=DP) , dimension(jpslev) ::  dt
    real(kind=DP) , dimension(jpslevall,jplats) :: drs
    real(kind=DP) , dimension(jpslev,jplats) :: drsc
    real(kind=DP) , dimension(jpwave) :: scs
    real(kind=DP) , dimension(jpslev,jpslev,jpschin) :: tablen
    real(kind=DP) , dimension(jpslev,jpslev,jpsover) :: tablenoa, tablenob
    real(kind=DP) , dimension(jpslev,jpschi,jpwave) :: tabs0
    real(kind=DP) , dimension(jpslev) :: tauc, teac
    real(kind=DP) , dimension(jpslev,jpschi) :: totsp
    real(kind=DP) , dimension(jpslevall) :: tau, tea
    real(kind=DP) , dimension(jpslev) :: jac

    !-----------------------------------------------------------------------
    !
    !     make sure that the lowest level really is the ground.
    alt(1,:nlats) = 0.0
    !
    !-----------------------------------------------------------------------
    !
    !     calculate physical data at the centre of levels.
    call physmid (nlats)

    !
    !-----------------------------------------------------------------------
    !
    do jl=1,nlats
       drs(:jpslevall,jl) = (pres(:jpslevall)*1.0E2)/ &
                              (boltz*dtemp(:jpslevall,jl)*1.0E6)
       drsc(:jpslev,jl) = (presc(:jpslev)*1.0E2)/ &
                            (boltz*dtempc(:jpslev,jl)*1.0E6)
    end do
    dalt(:jpslev,:nlats) = abs(alt(2:jpslev+1,:nlats)-alt(:jpslev,:nlats))
    altc(:jpslev,:nlats) = 0.5*(alt(2:jpslev+1,:nlats)+alt(:jpslev,:nlats))
    !
    !     calculate the zenith angle grid.
!    call setzen (jpschi, jpsover, angrad, angdeg)
    call setzen (jpschi, jpsover)
    !
    !     calculate maximum zenith angle experiencing direct sun for
    !     each level.
    call maxzen (jpslev, jpslevall, nlats, jplats, zenmax)
    !
    !-----------------------------------------------------------------------
    ! loop over all latitudes
   
    do jl = 1,nlats
      !
      !     set up path lengths up to and including 90 degrees.
      do jc = 1, jpschin
        do i = 1, jpslev
          !
          totsp(i,jc) = 0.0
          !
          !             initialise variables.
          !             zenith angle at the starting point.
          alpha = angrad(jc)
          !
          !             follow the path back in spherical geometry.
          do j = i, jpslev
            !
            !                 initialise variables.
            !
            if (j == i) then
              !                 if we are at the starting level
              alta = max(0.0_DP,altc(j,jl))
            else
              !                 for all other levels.
              alta = max(0.0_DP,alt(j,jl))
            endif
            !
            altb = max(0.0_DP,alt(j+1,jl))
            !
            !                 calculate zenith angle for the next level up.
            call nxtzen (alpha, alta, beta, altb, re)
            !
            !                 calculate the slant path between this level and the
            !                 the next level up in cm.
            call slantp (alpha, alta, beta, altb, spl, re)
            !
            !                 the distance in cm between the levels.
            tablen(i,j,jc) = spl
            !
            !                 reintialise variables.
            !                 adjust zenith angle for spherical geometry.
            alpha = beta
            !
            totsp(i,jc) = totsp(i,jc) + tablen(i,j,jc)
          end do
       end do
     end do

      !-----------------------------------------------------------------------
      !
      !     find the level index for each zenith angle and each level for
      !     which the zenith angle is 90 degrees, i.e. the level including the
      !      tangent point.
      do jc = jpschin + 1, jpschi
        jci = jc - jpschin
        do jlev = 1, jpslev
          alt90 = (altc(jlev,jl)+re)*sin(angrad(jc)) - re
          call pos2 (alt, jpslevall, jplats, jl, alt90, jt)
          ijt(jci,jlev) = jt
        end do
      end do
      !
      !-----------------------------------------------------------------------
      !
      !     when the zenith angle angrad(jc) > 90.0 degrees.
      do jc = jpschin + 1, jpschi
        !
        !         a zenith angle index.
        jci = jc - jpschin
        !
        do j = 1, jpslev
          !
          !             initialise to zero.
          totsp(j,jc) = 0.0
          spl = 0.0

          ! initialize tables
          ! tablenoa: length of the opt path (in cm) from point to tangent point
          !           to the top of the tangent points level (jt)
          ! tablenob: length of the opt path (in cm) from the top of the
          !           tangent points level to the top of the atmosphere
          ! obs: index 1 and 2 of these fields are in opposite order than in tablen

          tablenoa(:jpslev,j,jci) = 0.0
          tablenob(:jpslev,j,jci) = 0.0
          !
          !             find level, jt, just below where alpha=90 degrees.
          jt = ijt(jci,j)
          !
          !             check if light can get there.
          if (jt<=0 .or. j<jt) cycle
          !
          !                 start by calculating path lengths just to the left of
          !                 the tangent point.
          !
          !                 check if this part of the calculation is needed.
          if (j >= jt + 1) then
            !
            !                     altitude where the zenith angle is 90 degrees.
            alt90 = (altc(j,jl)+re)*sin(angrad(jc))
            !
            !                     altitude jt+1.
            !                     altcur: top of level jt
            altcur = alt(jt+1,jl) + re
            !
            !                     set zenith angle at the current point.
            alpha = asin(alt90/altcur)
            !
            !                     having found this level first go from the current
            !                     level down to the level above jt suming the path
            !                     lengths.
            do i = jt + 1, j - 1
              !
              !                         initialise variables.
              alta = max(0.0_DP,alt(i,jl))
              altb = max(0.0_DP,alt(i+1,jl))
              !
              !                         calculate zenith angle at the centre of the
              !                         next level down.
              call nxtzen (alpha, alta, beta, altb, re)
              !
              !                         calculate the slant path between the centre of
              !                         this level and the centre of the next level
              !                         down in cm.
              call slantp (alpha, alta, beta, altb, spl, re)
              !
              tablenoa(i,j,jci) = spl
              !
              totsp(j,jc) = totsp(j,jc) + tablenoa(i,j,jci)
              !
              !                         reintialise variables.
              !                         adjust zenith angle for spherical geometry.
              alpha = beta
            end do

            ! jug, 10/2010: added the way from mid of level j to bottom of level j, if j>jt
            alta = max(0.0_DP,alt(j,jl))
            altb = max(0.0_DP,altc(j,jl))
            call nxtzen (alpha, alta, beta, altb, re)
            call slantp (alpha, alta, beta, altb, spl, re)
            tablenoa(j,j,jci) = spl
            !
            !
            !                 end of check if this part of the calculation is
            !                 needed.
          endif
          !
          !                 now calculate the path length between the level
          !                 jt + 1 as it stradles the zenith angle of 90 degrees.
          !
          !                 check which calculation is needed.
          !                 case (a) j > jt +1
          if (j >= jt + 1) then
            !
            !                     altitude where the zenith angle is 90 degrees.
            alt90 = (altc(j,jl)+re)*sin(angrad(jc))
            !
            !                     altitude jt+1.
            altcur = alt(jt+1,jl) + re
            !
            !                     slant path length using pythagoras.
            spl = 2.0*1E5*sqrt(altcur*altcur - alt90*alt90)
            ! spl: length top of level jt to tangent point to top of level jt
            !
            !                 case (b) j = jt
          else if (j == jt) then
            !jug 10/2010: part b and part a needed to be interchanged
            !             the sum spl remains unchanged, but now altcur contains the
            !             top of the tangent point level jt at the end needed later
            !
            !                     part (b)
            !
            !                     altitude where the zenith angle is 90 degrees.
            alt90 = (altc(j,jl)+re)*sin(angrad(jc))
            !
            !                     altitude jt+1.
            altcur = altc(j,jl) + re
            !
            !                     slant path length using pythagoras.
            spl =  1E5*sqrt(altcur*altcur - alt90*alt90)
            !  add mid of level j (=jt) to tangent point 
            !
            !                     part (a)
            !
            !                     altitude where the zenith angle is 90 degrees.
            alt90 = (altc(j,jl)+re)*sin(angrad(jc))
            !
            !                     altitude jt+1.
            altcur = alt(jt+1,jl) + re
            !
            !                     slant path length using pythagoras.
            spl = spl + 1E5*sqrt(altcur*altcur - alt90*alt90)
            ! tangent point to top of level j (=jt)
            !
            !                 end of check which calculation is needed.
          endif
          !
          tablenoa(jt,j,jci) = spl
          !
          totsp(j,jc) = totsp(j,jc) + tablenoa(jt,j,jci)
          !
          !                 now calculate path lengths to the right of the tangent
          !                 point.
          !
          !                 set zenith angle at the current point.
          alpha = asin(alt90/altcur)
          !
          !                 now go from jt all the way to the top of the
          !                 atmosphere.
          do i = jt + 1, jpslev
            !
            !                     initialise variables.
            alta = max(0.0_DP,alt(i,jl))
            altb = max(0.0_DP,alt(i+1,jl))
            !
            !                     calculate zenith angle for the next level up.
            call nxtzen (alpha, alta, beta, altb, re)
            !
            !                     calculate the slant path between this level and
            !                     the next level down in cm.
            call slantp (alpha, alta, beta, altb, spl, re)
            tablenob(i,j,jci) = spl
            ! in loop jt+1 to top of atm: bottom to top of level i
            !
            !                     reintialise variables.
            !                     adjust zenith angle for spherical geometry.
            alpha = beta
            !
            totsp(j,jc) = totsp(j,jc) + tablenob(i,j,jci)
          end do
        end do
      end do
      !
      !-----------------------------------------------------------------------
      !
      !
      !     set up slant path o2 column.
      !
      !     set up path lengths up to and including 90 degrees.
      do jc = 1, jpschin
        do i = 1, jpslev
          !
          !             follow the path back in spherical geometry.
          !
          tspo2(i,jc,jl) = sum(tablen(i,i:jpslev,jc)*do2c(i:jpslev,jl))
        end do
      end do
      !
      !-----------------------------------------------------------------------
      !
      !     when the zenith angle angrad(jc) > 90.0 degrees.
      do jc = jpschin + 1, jpschi
        !
        !         a zenith angle index.
        jci = jc - jpschin
        !
        do j = 1, jpslev
          !
          !             initialise to zero.
          tspo2(j,jc,jl) = 0
          !
          !             find level, jt, just below where alpha=90 degrees.
          jt = ijt(jci,j)
          !
          !             check if light can get there.
          if (jt<=0 .or. j<jt) cycle
          !
          !                 having found this level first go from the current
          !                 level down to the level above jt suming the path
          !                 lengths.
          !
          tspo2(j,jc,jl) = tspo2(j,jc,jl) + &
               sum(tablenoa(jt+1:j-1,j,jci)*do2c(jt+1:j-1,jl))
          !
          !                 now calculate the path length between the level
          !                 jt + 1 as it stradles the zenith angle of 90 degrees.
          tspo2(j,jc,jl) = tspo2(j,jc,jl) + tablenoa(jt,j,jci)*do2c(jt,jl)
          !
          !                 now calculate path lengths to the right of the tangent
          !                 point.
          !
          !                 now go from jt all the way to the top of the
          !                 atmosphere.
          !
          tspo2(j,jc,jl) = tspo2(j,jc,jl) + &
               sum(tablenob(jt+1:jpslev,j,jci) * do2c(jt+1:jpslev,jl))
        end do
      end do
      !

      !-----------------------------------------------------------------------
      !
      call scatcs (scs)
      !
      !-----------------------------------------------------------------------
      !
      !     wavelength loop.
      do jw = jplo, jphi
        !
        !-----------------------------------------------------------------------
        !
        !         up to and including 90 degrees.
        do jc = 1, jpschin
          do i = 1, jpslev
            !
            !
            !
            deptha(i,jc) = 0.0
            depths(i,jc) = 0.0
            do j = i, jpslev
              !                     calculate the absorption cross sections.
              call calc_current_acs (j, jc, jw, jl)

              deptha(i,jc) = deptha(i,jc) + tablen(i,j,jc)*(do3c(j,jl)*ao3(jw)+&
                  do2c(j,jl)*atoto2(jw))
              depths(i,jc) = depths(i,jc) + tablen(i,j,jc)*drsc(j,jl)*scs(jw)
            end do
          end do
        end do

        !
        !-----------------------------------------------------------------------
        !
        !         greater than 90 degrees.
        do jc = jpschin + 1, jpschi
          !
          !             a zenith angle index.
          jci = jc - jpschin
          !
          do j = 1, jpslev
            !
            !                 initialise deptha
            deptha(j,jc) = 0.0
            depths(j,jc) = 0.0
            !
            !                 recall what jt was.
            jt = ijt(jci,j)
            !
            !                 having found this level first go from the current
            !                 level down to the level above jt suming the path
            !                 lengths.
            !
            !                 if the calculation is required.
            if (jt<=0 .or. j<jt) cycle
            !
            ! jug 10/2010: upper index changed from j-1 to j, since tablenoa also contains
            !              the path from the point (mid level) to the bottom of its level
            do i = jt + 1, j  
              !
              !                         calculate the absorption cross sections.
              call calc_current_acs (i, jc, jw, jl)
              !
              deptha(j,jc) = deptha(j,jc) + tablenoa(i,j,jci)*(do3c(i,jl)*ao3(jw)&
                  + do2c(i,jl)*atoto2(jw))
              depths(j,jc) = depths(j,jc) + tablenoa(i,j,jci)*drsc(i,jl)*scs(jw)
            end do
            !
            !                     calculate the absorption cross sections.
            call calc_current_acs (jt, jc, jw, jl)
            !
            deptha(j,jc) = deptha(j,jc) + tablenoa(jt,j,jci)*(do3c(jt,jl)*ao3(jw)&
                + do2c(jt,jl)*atoto2(jw))
            depths(j,jc) = depths(j,jc) + tablenoa(jt,j,jci)*drsc(jt,jl)*scs(jw)
            !
            !                     now go from jt+1 all the way to the top of the
            !                     atmosphere.
            do i = jt + 1, jpslev
              !
              !                         calculate the absorption cross sections.
              call calc_current_acs (i, jc, jw, jl)
              !
              deptha(j,jc) = deptha(j,jc) + tablenob(i,j,jci)*(do3c(i,jl)*ao3(jw)&
                  + do2c(i,jl)*atoto2(jw))
              depths(j,jc) = depths(j,jc) + tablenob(i,j,jci)*drsc(i,jl)*scs(jw)
            end do
          end do
        end do
        !
        !-----------------------------------------------------------------------
        !
        !         set up the vertical optical depths etc.
        !
        teac(:jpslev) = deptha(:jpslev,1)
        tauc(:jpslev) = depths(:jpslev,1)
        !
        !             half optical thickness of each level.
        dt(:jpslev) = 0.5*(dalt(:jpslev,jl)*1.0E5*drsc(:jpslev,jl)*scs(jw))
        !
        !-----------------------------------------------------------------------
        !
        !
        !         assign the total vertical optical depth at the ground;
        tauv = 0.0
        teav = 0.0


        !
        do jlev = 1, jpslev

          !             calculate the absorption cross sections.
          jc = 1
          call calc_current_acs (jlev, jc, jw, jl)
          !
          !             scattering.
          tauv = tauv + dalt(jlev,jl)*1E5*drsc(jlev,jl)*scs(jw)
          !
          !             absorption.
          teav = teav + dalt(jlev,jl)*1E5*(do3c(jlev,jl)*ao3(jw)+ &
               do2c(jlev,jl)*atoto2(jw))

        end do
        !
        !
        !
        !         get vertical optical depth in the middle of levels


        tau(1) = tauv
        tea(1) = teav
        tau(jpslevall) = 0.0
        tea(jpslevall) = 0.0

        do i = jpslev, 1, -1
          !
          !        calculate  the absorption cross sections.
          call calc_current_acs (i, 1, jw, jl)

          !
          tea(i) = tea(i+1) + 1.E5*(alt(i+1,jl)-alt(i,jl))*(do3c(i,jl)*ao3(jw)+&
               do2c(i,jl)*atoto2(jw))
          tau(i) = tau(i+1) + 1.E5*(alt(i+1,jl)-alt(i,jl))*drsc(i,jl)*scs(jw)
        end do






        !     claculate d tau / d delta tau

        do i = 1, jpslev

          call calc_current_acs (i, 1, jw, jl)
          jac(i) = 1.0/(1.0 + (do3c(i,jl)*ao3(jw)+do2c(i,jl)*atoto2(jw))/ &
               drsc(i,jl)/scs(jw))

        end do

        !-----------------------------------------------------------------------
        !
        !         calculate the initial scattering rate.
        !
        !         zenith angle loop.
        do jc = 1, jpschi
          !
          !             ground reflected component.
          if (jc <= jpschin) then
            arg = deptha(1,jc) + depths(1,jc)
            twoamu = 2.0*albedo*cos(angrad(jc))*exp((-arg))
          else
            twoamu = 0.0
          endif
          !
          !             level loop.
          do jk = 1, jpslev
            !
            arg = deptha(jk,jc) + depths(jk,jc)
            tabs0(jk,jc,jw) = exp((-arg))
            if (albedo <= 0.0) cycle

            teak = teac(jk)
            tauk = tauc(jk)
            tabs0(jk,jc,jw) = tabs0(jk,jc,jw) + twoamu*expint(2,max(0.0_DP,tauv&
                - tauk + teav - teak))
            !
          end do
        end do
        !
        !-----------------------------------------------------------------------
        !
        if (lsw) then
          !
          !-----------------------------------------------------------------------
          !
          !             two nested level loops.


          do jn = 1, jpslev
            !
            tean = tea(jn)
            taun = tau(jn)
            teanp = tea(jn+1)
            taunp = tau(jn+1)

            !
            do jk = 1, jpslev
              !
              teak = teac(jk)
              tauk = tauc(jk)


              !
              !                     set up a matrix
              ! case   lsimple deleted (jug)
              if (jn /= jk) then
                 a(jn,jk) = 0.5*abs(expint(2,abs(tauk - taun) + &
                      abs(teak - tean)) - expint(2,abs(tauk - taunp) + &
                      abs(teak - teanp)))*jac(jn)
              else
                 a(jn,jk) = 0.5*(2.0 - expint(2,abs(tauk - taun) + &
                       abs(teak - tean)) - expint(2,abs(tauk - taunp) + &
                       abs(teak - teanp)))*jac(jn)
              endif



              if (albedo > 0.0) a(jn,jk) = a(jn,jk) + &
                   albedo*expint(2,max(0.0_DP,tauv - tauk + teav - teak))* &
                   abs(expint(3,max(0.0_DP,tauv - taun + teav - tean)) - &
                   expint(3,max(0.0_DP,tauv - taunp + teav - teanp)))*jac(jn)


              !                     set up b matrix
              b(jn,jk) = delta(jn,jk) - a(jn,jk)
            end do
          end do


          !-----------------------------------------------------------------------
          !
          !             invert the matrix b.

          call invert (b, binv, bcopy, indx, jpslev)
          !
          !-----------------------------------------------------------------------
          !
          !             for greater than 90 degrees make sure where there is no
          !             direct sun that the initial scattering rate is zero.
          !
          !
          !                     recall what jt was.
          where (transpose(ijt(:jpschi-jpschin,:jpslev)<=0))
            tabs0(:jpslev,jpschin+1:jpschi,jw) = 0.0
          end where
          !
          !-----------------------------------------------------------------------
          !
          !             zenith angle loop.
          do jc = 1, jpschi
            !
            do jn = 1, jpslev
              !
              !                     initialise s.
              tabs(jn,jc,jw,jl) = 0.0
              !
              !                     sum: s(jn)=s0(jk)*binv(jk,jn)
              tabs(jn,jc,jw,jl) = tabs(jn,jc,jw,jl) + &
                   sum(tabs0(:jpslev,jc,jw) * binv(:jpslev,jn))
            end do
          end do
          !
          !-----------------------------------------------------------------------
          !
          !             for greater than 90 degrees make sure where there is no
          !             direct sun that the initial scattering rate is zero.
          !
          !
          !                     recall what jt was.
          where (transpose(ijt(:jpschi-jpschin,:jpslev)<=0))
            tabs(:jpslev,jpschin+1:jpschi,jw,jl) = 0.0
          end where
          !
          !-----------------------------------------------------------------------
          !
          !             check values are sensible.
          tabs(:jpslev,:jpschi,jw,jl) = max(0.0_DP,tabs(:jpslev,:jpschi,jw,jl))
          !
          !-----------------------------------------------------------------------
          !
          !         else if no scattering.
        else
          !
          !-----------------------------------------------------------------------
          !
          !             zenith angle loop.
          !
          !
          !                     just initial scattering rate.
          tabs(:jpslev,:jpschi,jw,jl) = tabs0(:jpslev,:jpschi,jw)
          !
          !-----------------------------------------------------------------------
          !
        endif
      end do
      ! end of latitude loop (jl)
    end do
   
    return
  end subroutine settab


  !
  !-----------------------------------------------------------------------
  !
  subroutine setzen(jpschi, jpsover)
    !-----------------------------------------------
    !   M o d u l e s
    !-----------------------------------------------
! op_pj_20150728: SMCL files merged; already USEd globally
!!$    USE messy_main_constants_mem,   ONLY: pi, dtr
!!$    use  messy_dissoc_global, only: angrad, angdeg
    !
    !-----------------------------------------------------------------------
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: jpschi
    integer , intent(in) :: jpsover
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: j, j1, j2, jc, jpschin
    real(kind=DP) :: cosint, zenstop, degint
    !-----------------------------------------------
    !   I n t r i n s i c  F u n c t i o n s
    !-----------------------------------------------
    INTRINSIC abs, acos, real
    !
    !-----------------------------------------------------------------------
    !
    !     index of 90 degrees in the scattering table.
    jpschin = jpschi - jpsover
    !
    cosint = 1.0/real(jpschi - 1 - jpsover,DP)
    !
    j = 1
    angrad(j) = 0.0
    angdeg(j) = 0.0
    !
    do j = 2, jpschin - 1
      jc = abs(j - jpschin)
      angrad(j) = acos(cosint*real(jc,DP))
      angdeg(j) = angrad(j) / dtr
    end do
    !
    j = jpschin
    angdeg(j) = 90.0
    angrad(j) = angdeg(j)*dtr
    !
    !     zenith angle interval in degrees for > 90.
    zenstop = 100.0
    degint = (zenstop - 90.0)/real(jpsover,DP)
    !
    j1 = jpschin + 1
    j2 = jpschi
    !
    do j = j1, j2
      angdeg(j) = 90.0 + real(j - jpschin,DP)*degint
      angrad(j) = angdeg(j)*dtr
    end do
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine setzen


  !
  !-----------------------------------------------------------------------
  !
  subroutine slantp(alpha, alta, beta, altb, spl, re)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    real(kind=DP) , intent(in) :: alpha
    real(kind=DP) , intent(in) :: alta
    real(kind=DP) , intent(in) :: beta
    real(kind=DP) , intent(in) :: altb
    real(kind=DP) , intent(out) :: spl
    real(kind=DP) , intent(in) :: re
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    real(kind=DP) :: altacm, altbcm, cos75, cosalpha, spl2
    !-----------------------------------------------
    !   I n t r i n s i c  F u n c t i o n s
    !-----------------------------------------------
    INTRINSIC cos, sqrt
    !-----------------------------------------------
    !
    !-----------------------------------------------------------------------
    !
    !     argrument list.
    !
    !     name     type               description.
    !     alpha    real(kind=DP)               zenith angle at level a.
    !                                 (unchanged on exit).
    !
    !     alta     real(kind=DP)               altitude level a in km.
    !                                 (unchanged on exit).
    !
    !     beta     real(kind=DP)               zenith angle at level b.
    !                                 (unchanged on exit).
    !
    !     altb     real(kind=DP)               altitude level b in km.
    !                                 (unchanged on exit).
    !
    !     spl      real(kind=DP)               the slant path length (in cm) between
    !                                 alta and altb where the solar zenith
    !                                 angles are alpha & beta respectively.
    !                                 (contains answer on exit).
    !
    !     re       real(kind=DP)               the radius of the earth in km.
    !                                 (unchanged on exit).
    !
    !-----------------------------------------------------------------------
    !
    !     calculate the slant path length (in cm) between alta (in km) and
    !     altb (in km) where the solar zenith angles are alpha & beta
    !     (in radians) respectively using the cosine rule.
    !
    !     david lary
    !     ----------
    !
    !     date started : 7/2/1990
    !
    !     last modified: 7/2/1990
    !
    !-----------------------------------------------------------------------
    !
    cosalpha = cos(alpha)
    !
    !     cosine of 75 degrees.
    cos75 = 0.258819045
    !
    !-----------------------------------------------------------------------
    !
    !     < 75 degrees
    if (cosalpha > cos75) then
      !
      spl = 1.0E5*(altb - alta)/cosalpha
    else
      !
      !     > 75 degrees
      !
      !         convert to cm.
      altacm = (alta + re)*1.0E5
      altbcm = (altb + re)*1.0E5
      spl2 = altacm*altacm + altbcm*altbcm - 2*altacm*altbcm*cos(alpha - &
          beta)
      !
      !         trap rounding error giving negative number.
      if (spl2 < 0.0) spl2 = 0.0
      spl = sqrt(spl2)
      !
    endif
    !
    !-----------------------------------------------------------------------
    !
    if (spl < 0) then
      write(unit=*,fmt=*) "warning slant path length < 0 in slantp."
      write(unit=*,fmt=*) "alta:", alta
      write(unit=*,fmt=*) "altb:", altb
      write(unit=*,fmt=*) "alpha:", alpha*57.318
      write(unit=*,fmt=*) "spl:", spl
      stop
      !
      !-----------------------------------------------------------------------
      !
    endif
    return
    !
    !-----------------------------------------------------------------------
    !
  end subroutine slantp


  !
  !-----------------------------------------------------------------------
  !

  subroutine p_ascend(n1, n2, ra, rb, rc, rd)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: n1, n2
    real(kind=DP) , intent(inout) :: ra(n1)
    real(kind=DP) , intent(inout) :: rb(n1,n2)
    real(kind=DP) , intent(inout) :: rc(n1,n2)
    real(kind=DP) , intent(inout) :: rd(n1,n2)
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: i, ir, j, l
    real(kind=DP) :: rmem
    real(kind=DP),dimension(n1) :: rra
    real(kind=DP),dimension(n1,n2) :: rrb, rrc, rrd
    !-----------------------------------------------
    ! Routine p_ascend checks whether the array ra (e.g. pressure) is in 
    ! descending or ascening order. It changes the array into ascending order
    ! as well as the corresponding arrays rb, rc and rd if necessary.
    ! If pressure levels are not monoton increasing or decreasing, the program 
    ! stops with an error message.
    ! 
    ! J.-U. Grooss, 16.11. 1998
    ! 
    !
    !-----------------------------------------------------------------------
    !
    !     argrument list.
    !
    !     name      type              description.
    !     n1,n2     integer           length of arrays ra, rb, rc & rd.
    !                                 (unchanged on exit).
    !    
    !
    !     ra(n1) array     array of length n1 to be sorted into
    !                      ascending numerical order, if necessary.
    !                      (contains result on exit).
    !
    !     rb(n1,n2)        array of length (n1,n2) to be sorted into
    !                      an order corresponding to that of ra with respect to
    !                      the second dimnesion
    !                      (contains result on exit).
    !
    !     rc(n1,n2), rd(n1,n2) similar
    !
    !-----------------------------------------------------------------------
    !
    rmem=ra(1)
    if (ra(1) > ra(n1)) then
       do i=1,n1
          if (rmem < ra(i)) then
             write(*,*)'initial ozone profile does not have monotone'
             write(*,*)'decreasing pressure levels !!!'
             stop
          endif
          rmem=ra(i)
          rra(n1-i+1)=ra(i)
          rrb(n1-i+1,:)=rb(i,:)
          rrc(n1-i+1,:)=rc(i,:)
          rrd(n1-i+1,:)=rd(i,:)
       enddo
       ra = rra
       rb = rrb
       rc = rrc
       rd = rrd
    else
       do i=1,n1
          if (rmem > ra(i)) then
             write(*,*)'initial ozone profile does not have monotone'
             write(*,*)'increasing pressure levels !!!'
             stop
          endif
          rmem=ra(i)
       enddo
    endif
    !
    !-----------------------------------------------------------------------
    !
  end subroutine p_ascend

  !
  !----------------------------------------------------------------------
  !

  real(kind=DP) function delta (jn, jk)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: jn
    integer , intent(in) :: jk
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    !-----------------------------------------------
    !
    !-----------------------------------------------------------------------
    !
    !     .. Scalar Arguments ..
    !     ..
    !
    !-----------------------------------------------------------------------
    !
    if (jn == jk) then
      delta = 1.0
    else
      delta = 0.0
    endif
    return
    !
    !-----------------------------------------------------------------------
    !
  end function delta


  real(kind=DP) function expint (n, x)
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: n
    real(kind=DP) , intent(in) :: x
    !-----------------------------------------------
    !   L o c a l   P a r a m e t e r s
    !-----------------------------------------------
    integer, parameter :: maxit = 100
    real(kind=DP), parameter :: eps = 1.E-7
    real(kind=DP), parameter :: fpmin = 1.e-30
    real(kind=DP), parameter :: euler = .5772156649
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    integer :: i, ii, nm1
    real(kind=DP) :: a, b, c, d, del, fact, h, psi
    !-----------------------------------------------
    !   I n t r i n s i c  F u n c t i o n s
    !-----------------------------------------------
    INTRINSIC abs, exp, log
    !-----------------------------------------------
    !
    nm1 = n - 1
    if (n<0 .or. x<0 .or. x==0 .and. (n==0 .or. n==1)) then
      write(unit=*,fmt=*) "n,x:", n, x
      write(unit=*,fmt="(2A)") "PAUSE ", "bad arguments in expint"
      read *
    else if (n == 0) then
      expint = exp((-x))/x
    else if (x == 0) then
      expint = 1.0/nm1
    else if (x > 1) then
      b = x + n
      c = 1.0/fpmin
      d = 1.0/b
      h = d
      do i = 1, maxit
        a = -i*(nm1 + i)
        b = b + 2.0
        d = 1.0/(a*d + b)
        c = b + a/c
        del = c*d
        h = h*del
        if (abs(del - 1) < eps) go to 10
      end do
      write(unit=*,fmt="(2A)") "PAUSE ", "continued fraction failed in expint"
      read *
      expint = 0
      return
10    continue
      expint = h*exp((-x))
    else
      if (nm1 /= 0) then
        expint = 1.0/nm1
      else
        expint= (-log(x)) - euler
      endif
      fact = 1
      do i = 1, maxit
        fact = -fact*x/i
        if (i /= nm1) then
          del = -fact/(i - nm1)
        else
          psi = -euler
          do ii = 1, nm1
            psi = psi + 1.0/ii
          end do
          del = fact*((-log(x)) + psi)
        endif
        expint = expint + del
        if (abs(del) >= abs(expint)*eps) cycle
        return
      end do
      write(unit=*,fmt="(2A)") "PAUSE ", "series failed in expint"
      read *
    endif
    return
    !
    !-----------------------------------------------------------------------
    !
  end function expint


  real(kind=DP) function sun_factor (jday)
! op_pj_20150728: already USEd globally
!!$    USE messy_main_constants_mem,   ONLY: pi
    !-----------------------------------------------
    !   D u m m y   A r g u m e n t s
    !-----------------------------------------------
    integer , intent(in) :: jday
    !-----------------------------------------------
    !   L o c a l   V a r i a b l e s
    !-----------------------------------------------
    real(kind=DP) :: a0, a1, a2, a3, a4, theta
    !-----------------------------------------------
    !
    !
    !     calculates the variation in solar irridiance due to earth's
    !     elliptic orbit. SUN_FACTOR is the factor in the irridiance relative
    !     to mean irridiance (about +- 3.5%)
    !     values are taken from; S. Madronich, The Atmosphere and UV-B Radiation
    !     at Ground Level, Environmental UV Photobiology, New York, 1993
    !
    !     jday : julian day (1 .. 365)

    data a0/ 1.000110/
    data a1/ 0.034221/
    data a2/ 0.001280/
    data a3/ 0.000719/
    data a4/ 0.000077/

    theta = 2*pi*(jday - 1)/365.0
    sun_factor = a0 + a1*cos(theta) + a2*sin(theta) + a3*cos(2*theta) + a4&
        *sin(2*theta)
    return
  end function sun_factor

  subroutine calc_davg(js, jd) ! op_pj_20150709: jd added

! op_pj_20150728: SMCL files merged; already USEd globally

    implicit none
    
    ! latitudes determined by ozone input profile

!    integer,intent(in)::month_o3,nlats
    integer, parameter::nlons=24
    real(kind=DP), intent(in) :: js
    real(kind=DP), intent(in) :: jd ! op_pj_20150709
    real(kind=DP) , dimension(jpwave) ::  helpno, helpsr
    
    real(kind=DP), dimension(nlats,nlons) ::sza_arr
    real(kind=DP), dimension(nlons)::latarr,lonarr,help
    real(kind=DP)::p
    integer::ilat,ilon,jp,jl,jx,jxp1,jy,jyp1,jw

    !if (rank==0) write(*,*) '***  Diurnal average photolysis rates are calculated  ***'

    do ilon=1,nlons 
       lonarr(ilon)=ilon*(360./nlons)
    enddo
    do ilat=1,nlats
       latarr= lats(ilat)
! op_pj_20150709: jd added
       call calc_zenith(latarr,lonarr,nlons,js,jd,help)
       sza_arr(ilat,:)=help
    enddo

    tabs_davg = 0.
    ao2sr_davg = 0.
    ano_davg = 0.
    do jp=1,jpslev
       p=presc(jp)
       do jl=1,nlats
          helpno(:)=0.
          helpsr(:)=0.
          do ilon=1,nlons
             angle=sza_arr(jl,ilon)*dtr
             if (angle <= zenmax(jp,jl)) then

                ! Calculate the NO pressure dependent absorption cross section.
                call find2 (p, 0.0_DP, vco2, presc, angrad, tspo2, jpslev, jpschi,&
                     jplats,jl)
                call acsno (angle, p, vco2)
                
                call find2 (p, angle, spco2, presc, angrad, tspo2, jpslev, &
                     jpschi, jplats,jl)
                call acssr (spco2)

                ! sum up Schumann-Runge cross sections


                call pos(angrad, jpschi,angle,jy)
                jx=jp
                if (jp == jpslev) jx=jpslev-1 
                jxp1=jx+1
                jyp1=jy+1
                   
                call findvect2 (p, angle, factor, presc, angrad, tabs, jpslev, &
                     jpschi, jpwave, jplats, jplo, jphi, jx, jxp1, jy, jyp1, jl)

                tabs_davg(jp,:,jl)=tabs_davg(jp,:,jl) + factor/nlons

                helpno = helpno + factor * ano
                helpsr = helpsr + factor * ao2sr

             endif
          enddo ! ilon
          ! correct pressure-dependent absorption cross sections for the 
          ! diurnal average
          !
          ! s= 1/(24h *tabs_davg) * int(factor*sigma *dt)


          do jw=jplo,jphi
            if (tabs_davg(jp,jw,jl) > 0.) then
              ano_davg(jp,jw,jl) =  helpno(jw) / (nlons*tabs_davg(jp,jw,jl))
              ao2sr_davg(jp,jw,jl) = helpsr(jw) / (nlons*tabs_davg(jp,jw,jl))
            else
              ano_davg(jp,jw,jl) = 0.
              ao2sr_davg(jp,jw,jl) = 0.
            endif
          enddo

       enddo ! jl
    enddo ! jp

  end subroutine calc_davg

!---------------------------------------------------------------------------

!*******************************************************************************
!
! Subroutine calc_zenith to calculate the solar zenith angle based on
! the idl routine calc_solar_zenith_angle.pro by Theo Brauers (ICG-3)
! translated to fortran by Nicole Thomas 11.09.2000 
!
!   This set of routines is based on
!   Yoshio Kubo, Rep. of Hydrographic Res. No. 15 1980
!   Sun position for 1970 - 2030
!   ( copied from MFC199m source code, GETMOON2.C, GETMOON.C, by Theo Brauers)
!   typed by K. Pfeilsticker 13.9.1989)
!
!   10.10.2000 corrected calculation of sideral time                    (mf,jug)
!   24.10.2000 modulo usage corrected, variable jdf removed             (mf,jug)
!   03.08.2001 correction in azimuth angle calculation (calc_geo_pos)      (jug)
!   06.01.2011 correction in tangens formular in subroutine calc_ellipsoid
!              needed for latitude=+-90 degrees                            (jug)
! 
!*******************************************************************************

!---------------------------------------------------------------------------
! op_pj_20150709: jd added 
SUBROUTINE calc_zenith (latitude, longitude, npoints, js, jd, sza, altitude)

  implicit none

  integer, intent(in) :: npoints

  real(kind=DP), intent(in), dimension(*) :: latitude, longitude
  real(kind=DP), intent(in) :: js
  real(kind=DP), intent(in) :: jd ! op_pj_20150709
  real(kind=DP), intent(out), dimension(npoints) :: sza
! op_pj_20150710+
!!$  real(kind=DP), intent(in), optional :: altitude
  real(kind=DP), intent(in), dimension(npoints), optional :: altitude
! op_pj_20150710-

  real(kind=DP) :: azimuth
! op_pj_20150710+
!!$  real(kind=DP) :: alt, dayfrac, jd_0h
  real(kind=DP) :: dayfrac, jd_0h
  real(kind=DP), dimension(npoints) :: alt
! op_pj_20150710-
  real(kind=DP) :: rs, ds, ut, gh, ha, sl, ha0

  integer :: i
  integer :: year, month, day, sec

  IF (present(altitude)) THEN 
     alt=altitude 
  ELSE 
     alt=0.D0
  ENDIF

  ! calculate the julian day
  ! if (dates30) then
  !    call js30_to_ymds30 (js,year,month,day,sec)
  !    if (month==2 .and. (day==29 .or. day==30)) then
  !       month = 3
  !       day = 1
  !    endif
  !    jd = ymd2jd (year,month,day)
  ! else
!!$     jd = js2jd(js) ! op_pj_20150709: now formal parameter ... (see above)
  ! endif

  ! kubo sun pos formula
  rs   = calc_sun_pos(jd, .true.)  ! right ascension
  ds   = calc_sun_pos(jd, .false.) ! declination

  !ut: universal time
  ut   = modulo(js, 86400.D0) / 3600.D0

  !jd_0h: Julian day of same day 0h  
  dayfrac= modulo(jd-0.5, 1.d0)
  jd_0h = jd - dayfrac

  !gh: Sternzeit
  gh   = 6.656306D0 + 0.0657098242D0*(jd_0h -2445700.5D0) + 1.0027379093D0*ut
  !ha: hour angle
  ha   = gh - rs
  ha0  = modulo(ha, 24.d0)

  do i = 1, npoints

     if (abs(latitude(i)) <= 90.) then
        ! sl: longitude oqf sun
        sl = ha0 - longitude(i)/(-15.0D0)
! op_pj_20150728: altiude vector ...
        ha = calc_parallaxe((-1)*longitude(i), latitude(i), sl, ds, alt(i))
        call calc_geo_pos (latitude(i), ha, ds, azimuth, sza(i), alt(i))
     else
        sza(i)=mdi
     endif
  enddo

END SUBROUTINE calc_zenith

!***********************************************************************
!
!***********************************************************************

FUNCTION calc_dec_sun (T)

  implicit none


  real(kind=DP) :: T
  real(KIND=DP) :: calc_dec_sun
          

  calc_dec_sun = 23.2643D0*COS(dtr*(36000.7696*T + 190.4602)) &
    -  0.0127*T*COS(dtr*(36000.7696*T + 190.4602)) &
    +  0.3888*COS(dtr*(1.72*T + 12.94)) &
    -  0.0012*T*COS(dtr*(1.72*T + 12.94)) &
    +  0.3886*COS(dtr*(71999.82*T + 187.99)) &
    -  0.0012*T*COS(dtr*(71999.82*T + 187.99)) &
    +  0.1646*COS(dtr*(108002.3*T + 211.4)) &
    -  0.0003*T*COS(dtr*(108002.3*T + 211.4)) &
    +  0.0082*COS(dtr*(72003.0*T + 34.0)) &
    +  0.0082*COS(dtr*(144001.0*T + 209.0)) &
    +  0.0073*COS(dtr*(107999.0*T +  186.0)) &
    +  0.0031*COS(dtr*(180004.0*T + 232.0)) &
    +  0.0022*COS(dtr*(37935.0*T + 65.0)) &
    +  0.0008*COS(dtr*(35997.0*T + 345.0)) &
    +  0.0004*COS(dtr*(68965.0*T + 78.0)) &
    +  0.0004*COS(dtr*(3036.0*T + 123.0)) &
    +  0.0003*COS(dtr*(481268.0*T + 128.0)) &
    +  0.0003*COS(dtr*(35982.0*T + 121.0)) &
    +  0.0003*COS(dtr*(36020.0*T + 80.0)) &
    +  0.0003*COS(dtr*(409266.0*T + 287.0)) &
    +  0.0003*COS(dtr*(13482.0*T + 293.0)) &
    +  0.0003*COS(dtr*(9037.0*T + 332.0)) &
    +  0.0003*COS(dtr*(180000.0*T + 206.0))

END FUNCTION calc_dec_sun

!***********************************************************************
!
!***********************************************************************
FUNCTION calc_rec_sun (T)

  implicit none


  real(kind=DP) :: T
  real(KIND=DP) :: calc_rec_sun
          
  calc_rec_sun= 18.69735 + 2400.05130*T &
      + 0.16419*COS(dtr*(72001.539*T + 290.920)) &
      - 0.00019*T*COS(dtr*(72001.539*T + 290.920)) &
      + 0.12764*COS(dtr*(35999.050*T + 267.520)) &
      - 0.00032*T*COS(dtr*(35999.050*T + 267.520)) &
      + 0.00549*COS(dtr*(36002.5*T +113.4)) &
      - 0.00002*T*COS(dtr*(36002.5*T + 113.4)) &
      + 0.00549*COS(dtr*(108000.6*T + 288.5)) &
      - 0.00002*T*COS(dtr*(108000.6*T +288.5)) &
      + 0.00353*COS(dtr*(144003.1*T +311.9)) &
      + 0.00133*COS(dtr*(71998.1*T + 265.1)) &
      + 0.00032*COS(dtr*(1934.0*T + 145.0)) &
      + 0.00024*COS(dtr*(108004.0*T + 134.0)) &
      + 0.00024*COS(dtr*(180002.0*T + 309.0)) &
      + 0.00015*COS(dtr*(144000.0*T + 286.0)) &
      + 0.00013*COS(dtr*(32964.0*T + 158.0)) &
      + 0.00012*COS(dtr*(19.0*T + 159.0)) &
      + 0.00012*COS(dtr*(445267.0*T + 208.0)) &
      + 0.00010*COS(dtr*(45038.0*T + 254.0)) &
      + 0.00010*COS(dtr*(216005.0*T + 333.0)) &
      + 0.00009*COS(dtr*(22519.0*T + 352.0)) &
      + 0.00005*COS(dtr*(65929.0*T + 45.0)) &
      + 0.00005*COS(dtr*(3035.0*T + 110.0)) &
      + 0.00005*COS(dtr*(9038.0*T + 64.0)) &
      + 0.00004*COS(dtr*(33718.0*T + 316.0)) &
      + 0.00003*COS(dtr*(155.0*T + 118.0)) &
      + 0.00003*COS(dtr*(73936.0*T + 166.0)) &
      + 0.00003*COS(dtr*(2281.0*T + 221.0)) &
      + 0.00003*COS(dtr*(3.0*T + 296.0)) &
      + 0.00003*COS(dtr*(29930.0*T + 48.0)) &
      + 0.00003*COS(dtr*(31557.0*T + 161.0))
  calc_rec_sun = MOD (calc_rec_sun, 24D0)

END FUNCTION calc_rec_sun

!***********************************************************************
!
!***********************************************************************
FUNCTION calc_sun_pos (jdf, right_ascension)

  implicit none

!!$  real(kind(0d0)) :: calc_sun_pos
!!$  real(kind(0d0)) :: jdf

  real(kind=DP) :: calc_sun_pos
  real(kind=DP) :: jdf
  logical :: right_ascension

  real(kind=dp) :: T

  ! calc time for Kubo formula
  T    =  (jdf - 2451545.0D0)/36525.D0

  ! right ascencion
  IF (right_ascension) THEN 
     calc_sun_pos = calc_rec_sun(T)
  ELSE
     calc_sun_pos = calc_dec_sun(T)
  ENDIF

END FUNCTION calc_sun_pos



!***********************************************************************
!
!***********************************************************************
FUNCTION calc_ellipsoid (zenith, latitude, azimuth, altitude)

  implicit none
      
  real(kind=DP):: zenith, latitude
  real(kind=DP):: azimuth,dlat
  real(kind=DP), optional :: altitude
           
  real(kind=DP) :: calc_ellipsoid
           
  real(kind=DP) :: alt, E_radius, P_radius, x,  lat_cor

  IF (PRESENT(altitude)) THEN 
     alt=altitude 
  ELSE 
     alt=0.D0
  ENDIF
  E_radius=6378.14D0 + alt
  P_radius=6356.755D0 + alt
  x=P_radius/E_radius

  ! avoid tan(+- pi/2) in the following formula; (jug, 1/2011)
  dlat = min(latitude,89.9999d0)
  dlat = max(dlat, -89.9999d0)

  lat_cor = dlat - ATAN(x*x*TAN(dlat*dtr))/dtr
  calc_ellipsoid = zenith + COS(azimuth*dtr)*lat_cor

END FUNCTION calc_ellipsoid

!***********************************************************************
!
!***********************************************************************
SUBROUTINE calc_geo_pos (latitude, hour_angle, dec, azimuth, zenith, altitude)
  
  implicit none

  real(kind=DP) :: latitude, zenith
  real(kind=DP) :: hour_angle, dec, azimuth
  real(kind=DP), optional:: altitude
           
  real(kind=DP) ::  za, sa, ca, factor1, factor2, factor3, factor4

  za=SIN(dtr*latitude)*SIN(dtr*dec)+ &
       COS(dtr*latitude)*COS(dtr*dec)*COS(dtr*hour_angle*15.0D0)
  za=ACOS(za)
  sa=COS(dtr*dec)*SIN(dtr*hour_angle*15.0)/SIN(za)
  ca=-(COS(dtr*latitude)*SIN(dtr*dec) &
       -SIN(dtr*latitude)*COS(dtr*dec)*COS(dtr*hour_angle*15.0D0))/SIN(za)
!!!!!
  !azimuth = ASIN(sa)*(ca GE 0) + (ca LT 0) * ((pi - ASIN(sa))* (sa GE 0) + &
  !         (ABS(ASIN(sa)) - pi )* (sa LT 0))
  if (ca >= 0) then
     factor1 = 1
     factor2 = 0
  else
     factor1 = 0
     factor2 = 1
  endif
  if (sa >= 0) then
     factor3 = 1
     factor4 = 0
  else
     factor3 = 0
     factor4 = 1
  endif
  ! correction included (jug) since with -O3 opt. sa = -1 -eps was possible
  if (sa < -1. )sa=-1.
  if (sa > 1. ) sa=1.
  
  azimuth = ASIN(sa)*factor1 + factor2 * ((pi - ASIN(sa))* factor3 + &
           (ABS(ASIN(sa)) - pi )* factor4)

!!!
  !azimuth = azimuth + pi * (SIN(za) GT 0)
  if (sin(za) > 0) azimuth = azimuth + pi
  azimuth = azimuth/dtr
!!!
  !azimuth = azimuth + 360.D0 * (azimuth LT 0)
  !if (azimuth < 0) azimuth = azimuth + 360.D0 
  azimuth = modulo(azimuth, 360.D0)
  zenith = za/dtr
  zenith = calc_ellipsoid(zenith, latitude, azimuth, altitude)

END SUBROUTINE calc_geo_pos

!***********************************************************************
!
!***********************************************************************
FUNCTION calc_parallaxe (longitude, latitude, ha, dec, altitude)

  implicit none

  real(kind=DP) :: longitude, latitude
  real(kind=DP) :: ha, dec
  real(kind=DP), optional :: altitude
           
  real(kind=DP) :: calc_parallaxe
           
  real(kind=DP) :: alt, dist, rho, r_strich, x, y, z, dec_c, &
                   a_sin, a_cos, hk, &
                   quot, asin_ge_0, asin_lt_0, acos_ge_pi2, acos_lt_pi2

  IF (present(altitude)) THEN 
     alt=altitude 
  ELSE 
     alt=0.D0
  ENDIF

  dist = 1.495954D8
  rho = 6378.14D0 + alt

  r_strich=SQRT(dist*dist+rho*rho-2*dist*rho*COS(dtr*dec))
  x = dist * COS(dtr*Dec)*SIN(dtr*ha*15.0D0)-rho*COS(dtr*latitude)*SIN(dtr*longitude)
  y = dist * COS(dtr*Dec)*COS(dtr*ha*15.0D0)-rho*COS(dtr*latitude)*COS(dtr*longitude)
  dec_c = ASIN((Dist*SIN(dtr*Dec) - rho*SIN(dtr*latitude))/r_strich)/dtr
  z = r_strich*COS(dec_c*dtr)
!!!!!
  !a_sin= ASIN(((x/z) < 1.D0) > (-1.D0))
  quot = x/z
  if (quot > 1.d0) quot=1.d0
  if (quot < -1.d0) quot=-1.d0
  a_sin = ASIN (quot)
  !a_cos= ACOS(((y/z) < 1.D0) > (-1.D0))
  quot = y/z
  if (quot > 1.d0) quot=1.d0
  if (quot < -1.d0) quot=-1.d0
  a_cos = ACOS (quot)

  hk = ATAN(x/y)/(dtr*15.D0)
!!!!!
  !hk = hk + DOUBLE(a_sin GE 0.D0)*(12.D*DOUBLE(a_cos GE pi/2.D0))+ &
  !     DOUBLE(a_sin LT 0.D0)*(12.D*DOUBLE(a_cos GE pi/2.D0) + 24.D*DOUBLE(a_cos LT pi/2.D0))
  if (a_sin >= 0.d0) then
     asin_ge_0 = 1
     asin_lt_0 = 0
  else
     asin_ge_0 = 0
     asin_lt_0 = 1
  endif
  if (a_cos >= pi/2.D0) then
     acos_ge_pi2 = 1
     acos_lt_pi2 = 0
  else
     acos_ge_pi2 = 0
     acos_lt_pi2 = 1
  endif

  hk = hk + asin_ge_0 * (12.D0 * acos_ge_pi2)+ &
       asin_lt_0 * (12.D0 * acos_ge_pi2 + 24.D0 * acos_lt_pi2)
 
  calc_parallaxe=hk

END FUNCTION calc_parallaxe
!---------------------------------------------------------------------------

!---------------------------------------------------------------------------
  SUBROUTINE dissoc_read_nml_ctrl(status, iou)

    USE messy_main_tools, ONLY: read_nml_open, read_nml_check, read_nml_close

    IMPLICIT NONE
    !I/O
    INTEGER, INTENT(OUT) ::   status
    INTEGER, INTENT(IN)  ::   iou
    !LOCAL
    CHARACTER(LEN=*),PARAMETER :: substr='dissoc_read_nml'
    LOGICAL              :: lex      ! file exists ?
    INTEGER              :: fstat    ! file status

    ! ju_nt_20180620 timesteps added to namelist
    NAMELIST /CTRL/ o3dat, davg, datdir, mean_albedo, &
                    timestep_dissoc, timestep_dissoc_gp

    status = 1 !ERROR
    CALL read_nml_open(lex, substr, iou, 'CTRL', modstr)
    IF (.not.lex) RETURN    ! <modstr>.nml does not exist

    READ(iou, NML=CTRL, IOSTAT=fstat)
    CALL read_nml_check(fstat, substr, iou, 'CTRL', modstr)
    IF (fstat /= 0) RETURN  ! error while reading namelist
    
    CALL read_nml_close(substr, iou, modstr)
    
    if (datdir(LEN_TRIM(datdir):LEN_TRIM(datdir))/='/')  datdir = trim(datdir)//'/'

    status = 0 !NO ERROR

  END SUBROUTINE dissoc_read_nml_ctrl


! **************************************************************************
END MODULE messy_dissoc
! **************************************************************************
