// created automatically by xmcm2mecca, DO NOT EDIT!
// PART 1: A copy of gas.eqn:
{Time-stamp: <2020-09-05 17:31:26 sander>}

{----------------------------------------------------------------------------}

{ SYNTAX AND NAMING CONVENTIONS FOR KPP SPECIES                              }
{ - Species are sorted by elements in the following order:                   }
{   O,H,N,C,F,Cl,Br,I,S,Hg                                                   }
{ - Organics are sorted by increasing number of C, H, O, N                   }
{ - All peroxides are called ROOH, all peroxy radicals are called RO2        }
{ - All species are defined here with #DEFVAR as VARIABLES. Some species     }
{   will be turned into FIXED species with #SETFIX in messy_mecca_kpp.kpp    }
{ - Lumped species start with the letter "L".                                }
{ - The maximum length for the species name is 13 (15 may also be ok?).      }
{ - The species name must not contain the underscore character "_".          }
{ - The elemental composition is needed for graphviz (spc_extract.awk) and   }
{   to check the mass balance (check_conservation.pl). There must be spaces  }
{   around the "+" sign but no spaces between a number and the element       }
{   symbol.                                                                  }
{ - The name of the species in LaTeX sytax follows after the "@" sign.       }

{----------------------------------------------------------------------------}

#DEFVAR

{----------------------------------------------------------------------------}
{--------------------------------- gas phase --------------------------------}
{----------------------------------------------------------------------------}

{------------------------------------- O ------------------------------------}

O1D             =  O                   ; {@O(^1D)}            {O singlet D}
O3P             =  O                   ; {@O(^3P)}            {O triplet P}
O2              = 2O                   ; {@O_2}               {oxygen}
O3              = 3O                   ; {@O_3}               {ozone}

{------------------------------------- H ------------------------------------}

H               =  H                   ; {@H}                 {hydrogen atom}
H2              = 2H                   ; {@H_2}               {hydrogen}
OH              =  H +  O              ; {@OH}                {hydroxyl radical}
HO2             =  H + 2O              ; {@HO_2}              {hydroperoxy radical}
H2O             = 2H +  O              ; {@H_2O}              {water}
H2O2            = 2H + 2O              ; {@H_2O_2}            {hydrogen peroxide}
H2OH2O          = 4H + 2O              ; {@(H_2O)_2}          {water dimer}

{------------------------------------- N ------------------------------------}

N               =            N         ; {@N}                 {nitrogen atom}
N2D             =            N         ; {@N(^2D)}            {N doublet D}
N2              =           2N         ; {@N_2}               {nitrogen}
NH3             = 3H      +  N         ; {@NH_3}              {ammonia}
N2O             =       O + 2N         ; {@N_2O}              {nitrous oxide}
NO              =       O +  N         ; {@NO}                {nitric oxide}
NO2             =      2O +  N         ; {@NO_2}              {nitrogen dioxide}
NO3             =      3O +  N         ; {@NO_3}              {nitrogen trioxide}
N2O5            =      5O + 2N         ; {@N_2O_5}            {dinitrogen pentoxide}
HONO            =  H + 2O +  N         ; {@HONO}              {nitrous acid}
HNO3            =  H + 3O +  N         ; {@HNO_3}             {nitric acid}
HNO4            =  H + 4O +  N         ; {@HNO_4}             {peroxynitric acid}
NH2             = 2H      +  N         ; {@NH_2}              {}
HNO             =  H +  O +  N         ; {@HNO}               {}
NHOH            = 2H +  O +  N         ; {@NHOH}              {}
NH2O            = 2H +  O +  N         ; {@NH_2O}             {}
NH2OH           = 3H +  O +  N         ; {@NH_2OH}            {}
LNITROGEN       =            N         ; {@LNITROGEN}         {lumped N species}

{------------------------------------- C ------------------------------------}

{1C (CHO)}
CH2OO           =   C +  2H +  2O      ; {@CH_2OO}            {SMI: "[O-][O+]=C" MCM: carbonyl oxide - stabilized Criegee Intermediate}
CH2OOA          =   C +  2H +  2O      ; {@CH_2OO^*}          {SMI: "[O-][O+]=C" MCM: carbonyl oxide - excited Criegee Intermediate}
CH3             =   C +  3H            ; {@CH_3}              {methyl radical}
CH3O            =   C +  3H +   O      ; {@CH_3O}             {SMI: "C[O]" MCM: methoxy radical}
CH3O2           =   C +  3H +  2O      ; {@CH_3O_2}           {SMI: "CO[O]" MCM: methylperoxy radical}
CH3OH           =   C +  4H +   O      ; {@CH_3OH}            {SMI: "CO" MCM: methanol}
CH3OOH          =   C +  4H +  2O      ; {@CH_3OOH}           {SMI: "COO" MCM: methyl peroxide}
CH4             =   C +  4H            ; {@CH_4}              {SMI: "C" MCM: methane}
CO              =   C       +   O      ; {@CO}                {carbon monoxide}
CO2             =   C       +  2O      ; {@CO_2}              {carbon dioxide}
HCHO            =   C +  2H +   O      ; {@HCHO}              {SMI: "C=O" MCM: methanal = formaldehyde}
HCOOH           =   C +  2H +  2O      ; {@HCOOH}             {SMI: "OC=O" MCM: formic acid}
HOCH2O2         =   C +  3H +  3O      ; {@HOCH_2O_2}         {hydroxy methyl peroxy radical}
HOCH2OH         =   C +  4H +  2O      ; {@HOCH_2OH}          {dyhydroxy methane}
HOCH2OOH        =   C +  4H +  3O      ; {@HOCH_2OOH}         {hydroxy methyl hydroperoxide}
{1C (CHON)}
CH3NO3          =   C +  3H +  3O +  N ; {@CH_3ONO_2}         {SMI: "CON(=O)=O" MCM: methylnitrate}
CH3O2NO2        =   C +  3H +  4O +  N ; {@CH_3O_2NO_2}       {SMI: "COON(=O)=O" MCM: peroxy methylnitrate}
CH3ONO          =   C +  3H +  2O +  N ; {@CH_3ONO}           {methylnitrite}
CN              =   C             +  N ; {@CN}                {}
HCN             =   C +   H       +  N ; {@HCN}               {}
HOCH2O2NO2      =   C +  3H +  5O +  N ; {@HOCH_2O_2NO_2}     {hydroxy methyl peroxy nitrate}
NCO             =   C       +   O +  N ; {@NCO}               {}
{1C (lumped)}
LCARBON         =   C                  ; {@LCARBON}           {lumped carbon}
{2C (CHO)}
C2H2            =  2C +  2H            ; {@C_2H_2}            {SMI: "C#C" MCM: ethyne}
C2H4            =  2C +  4H            ; {@C_2H_4}            {SMI: "C=C" MCM: ethene}
C2H5O2          =  2C +  5H +  2O      ; {@C_2H_5O_2}         {SMI: "CCO[O]" MCM: ethylperoxy radical}
C2H5OH          =  2C +  6H +   O      ; {@C_2H_5OH}          {SMI: "CCO" MCM: ethanol}
C2H5OOH         =  2C +  6H +  2O      ; {@C_2H_5OOH}         {SMI: "CCOO" MCM: ethyl hydro peroxide}
C2H6            =  2C +  6H            ; {@C_2H_6}            {SMI: "CC" MCM: ethane}
CH2CHOH         =  2C +  4H +   O      ; {@CH_2CHOH}          {vinyl alcohol}
CH2CO           =  2C +  2H +   O      ; {@CH2CO}             {ketene}
CH3CHO          =  2C +  4H +   O      ; {@CH_3CHO}           {SMI: "CC=O" MCM: acetaldehyde}
CH3CHOHO2       =  2C +  5H +  3O      ; {@CH3CHOHO2}         {}
CH3CHOHOOH      =  2C +  6H +  3O      ; {@CH3CHOHOOH}        {}
CH3CO           =  2C +  3H +  2O      ; {@CH_3C(O)}          {acetyl radical}
CH3CO2H         =  2C +  4H +  2O      ; {@CH_3COOH}          {SMI: "CC(=O)O" MCM: acetic acid}
CH3CO3          =  2C +  3H +  3O      ; {@CH_3C(O)OO}        {SMI: "CC(=O)O[O]" MCM: peroxy acetyl radical}
CH3CO3H         =  2C +  4H +  3O      ; {@CH_3C(O)OOH}       {SMI: "CC(=O)OO" MCM: peroxy acetic acid}
ETHGLY          =  2C +  6H +  2O      ; {@ETHGLY}            {SMI: "OCCO" MCM: HOCH2CH2OH}
GLYOX           =  2C +  2H +  2O      ; {@GLYOX}             {SMI: "O=CC=O" MCM: CHOCHO = glyoxal}
HCOCH2O2        =  2C +  3H +  3O      ; {@HCOCH_2O_2}        {SMI: "[O]OCC=O" MCM}
HCOCO           =  2C +   H +  2O      ; {@HCOCO}             {SMI: "O=[C]C=O" MCM}
HCOCO2H         =  2C +  2H +  3O      ; {@HCOCO_2H}          {SMI: "O=CC(=O)O" MCM: oxoethanoic acid}
HCOCO3          =  2C +   H +  4O      ; {@HCOCO_3}           {SMI: "[O]OC(=O)C=O" MCM}
HCOCO3H         =  2C +  2H +  4O      ; {@HCOCO_3H}          {SMI: "OOC(=O)C=O" MCM}
HOCH2CH2O       =  2C +  5H +  2O      ; {@HOCH_2CH_2O}       {SMI: "OCC[O]" MCM: (2-hydroxyethyl)oxidanyl}
HOCH2CH2O2      =  2C +  5H +  3O      ; {@HOCH_2CH_2O_2}     {SMI: "OCCO[O]" MCM: (2-hydroxyethyl)dioxidanyl}
HOCH2CHO        =  2C +  4H +  2O      ; {@HOCH_2CHO}         {SMI: "OCC=O" MCM: glycolaldehyde}
HOCH2CO         =  2C +  3H +  2O      ; {@HOCH2CO}           {}
HOCH2CO2H       =  2C +  4H +  3O      ; {@HOCH_2CO_2H}       {SMI: "OCC(=O)O" MCM: hydroxyethanoic acid}
HOCH2CO3        =  2C +  3H +  4O      ; {@HOCH_2CO_3}        {SMI: "OCC(=O)O[O]" MCM}
HOCH2CO3H       =  2C +  4H +  4O      ; {@HOCH_2CO_3H}       {SMI: "OCC(=O)OO" MCM}
HOCHCHO         =  2C +  3H +  2O      ; {@HOCHCHO}           {}
HOOCH2CHO       =  2C +  4H +  3O      ; {@HOOCH2CHO}         {}
HOOCH2CO2H      =  2C +  4H +  4O      ; {@HOOCH2CO2H}        {}
HOOCH2CO3       =  2C +  3H +  5O      ; {@HOOCH_2CO_3}       {}
HOOCH2CO3H      =  2C +  4H +  5O      ; {@HOOCH2CO3H}        {}
HYETHO2H        =  2C +  6H +  3O      ; {@HYETHO2H}          {SMI: "OCCOO" MCM: HOCH2CH2OOH}
{2C (CHON)}
C2H5NO3         =  2C +  5H +  3O +  N ; {@C_2H_5ONO_2}       {SMI: "CCON(=O)=O" MCM: ethyl nitrate}
C2H5O2NO2       =  2C +  5H +  4O +  N ; {@C_2H_5O_2NO_2}     {ethyl peroxy nitrate}
CH3CN           =  2C +  3H       +  N ; {@CH_3CN}            {acetonitrile}
ETHOHNO3        =  2C +  5H +  4O +  N ; {@ETHOHNO3}          {SMI: "OCCON(=O)=O" MCM: HOCH2CH2ONO2}
NCCH2O2         =  2C +  2H +  2O +  N ; {@NCCH_2O_2}         {}
NO3CH2CHO       =  2C +  3H +  4O +  N ; {@NO_3CH2CHO}        {SMI: "O=CCON(=O)=O" MCM}
NO3CH2CO3       =  2C +  2H +  6O +  N ; {@NO_3CH2CO_3}       {SMI: "[O]OC(=O)CON(=O)=O" MCM}
NO3CH2PAN       =  2C +  2H +  8O + 2N ; {@NO_3CH2CHO}        {SMI: "O=C(CON(=O)=O)OON(=O)=O" MCM}
PAN             =  2C +  3H +  5O +  N ; {@PAN}               {SMI: "CC(=O)OON(=O)=O" MCM: CH3C(O)OONO2 = peroxyacetylnitrate}
PHAN            =  2C +  3H +  6O +  N ; {@PHAN}              {SMI: "OCC(=O)OON(=O)=O" MCM: HOCH2C(O)OONO2}
{3C (CHO)}
ACETOL          =  3C +  6H +  2O      ; {@CH_3COCH_2OH}      {SMI: "CC(=O)CO" MCM: HO-CH2-CO-CH3 = hydroxy acetone}
ALCOCH2OOH      =  3C +  4H +  4O      ; {@HCOCOCH_2OOH}      {SMI: "OOCC(=O)C=O" MCM}
C2H5CHO         =  3C +  6H +   O      ; {@C_2H_5CHO}         {SMI: "CCC=O" MCM: propanal}
PROPACID        =  3C +  6H +  2O      ; {@C_2H_5CO_2H}       {SMI: "CCC(=O)O" MCM}
C2H5CO3         =  3C +  5H +  3O      ; {@C_2H_5CO_3}        {SMI: "CCC(=O)O[O]" MCM}
PERPROACID      =  3C +  6H +  3O      ; {@C_2H_5CO_3H}       {SMI: "CCC(=O)OO" MCM}
C33CO           =  3C +  2H +  3O      ; {@HCOCOCHO}          {SMI: "O=CC(=O)C=O" MCM}
C3H6            =  3C +  6H            ; {@C_3H_6}            {SMI: "CC=C" MCM: propene}
C3H8            =  3C +  8H            ; {@C_3H_8}            {SMI: "CCC" MCM: propane}
CH3CHCO         =  3C +  4H +   O      ; {@CH3CHCO}           {CH3CHCO}
CH3COCH2O2      =  3C +  5H +  3O      ; {@CH_3COCH_2O_2}     {SMI: "CC(=O)CO[O]" MCM: peroxyradical from acetone}
CH3COCH3        =  3C +  6H +   O      ; {@CH_3COCH_3}        {SMI: "CC(=O)C" MCM: acetone}
CH3COCO2H       =  3C +  4H +  3O      ; {@CH_3COCO_2H}       {SMI: "OC(=O)C(=O)C" MCM: pyruvic acid}
CH3COCO3        =  3C +  3H +  4O      ; {@CH_3COCO_3}        {SMI: "CC(=O)C(=O)O[O]" MCM}
CH3COCO3H       =  3C +  4H +  4O      ; {@CH_3COCO_3H}       {SMI: "CC(=O)C(=O)OO" MCM}
CHOCOCH2O2      =  3C +  3H +  4O      ; {@HCOCOCH_2O_2}      {SMI: "[O]OCC(=O)C=O" MCM}
HCOCH2CHO       =  3C +  4H +  2O      ; {@HCOCH2CHO}         {SMI: "O=CCC=O" MCM}
HCOCH2CO2H      =  3C +  4H +  3O      ; {@HCOCH2CO2H}        {SMI: "O=CCC(=O)O" MCM}
HCOCH2CO3       =  3C +  3H +  4O      ; {@HCOCH2CO3}         {SMI: "[O]OC(=O)CC=O" MCM}
HCOCH2CO3H      =  3C +  4H +  4O      ; {@HCOCH2CO3H}        {SMI: "OOC(=O)CC=O" MCM}
HCOCOCH2OOH     =  3C +  4H +  4O      ; {@HCOCOCH_2OOH}      {}
HOC2H4CO2H      =  3C +  6H +  3O      ; {@HOC2H4CO2H}        {SMI: "OCCC(=O)O" MCM: 3-hydroxypropanoic acid}
HOC2H4CO3       =  3C +  5H +  4O      ; {@HOC_2H_4CO_3}      {SMI: "OCCC(=O)O[O]" MCM}
HOC2H4CO3H      =  3C +  6H +  4O      ; {@HOC2H4CO3H}        {SMI: "OCCC(=O)OO" MCM}
HOCH2COCH2O2    =  3C +  5H +  4O      ; {@HOCH2COCH2O2}      {}
HOCH2COCH2OOH   =  3C +  6H +  4O      ; {@HOCH2COCH2OOH}     {}
HOCH2COCHO      =  3C +  4H +  3O      ; {@HOCH2COCHO}        {SMI: "OCC(=O)C=O" MCM: hydroxypyruvaldehyde}
HYPERACET       =  3C +  6H +  3O      ; {@CH_3COCH_2O_2H}    {SMI: "CC(=O)COO" MCM: hydroperoxide from CH3COCH2O2}
HYPROPO2        =  3C +  7H +  3O      ; {@HYPROPO2}          {SMI: "OCC(C)O[O]" MCM: CH3CH(O2)CH2OH}
HYPROPO2H       =  3C +  8H +  3O      ; {@HYPROPO2H}         {SMI: "OCC(C)OO" MCM: CH3CH(OOH)CH2OH}
IC3H7O2         =  3C +  7H +  2O      ; {@iC_3H_7O_2}        {SMI: "[O]OC(C)C" MCM: isopropylperoxy radical}
IC3H7OOH        =  3C +  8H +  2O      ; {@iC_3H_7OOH}        {SMI: "OOC(C)C" MCM: isopropyl hydro peroxide}
IPROPOL         =  3C +  8H +   O      ; {@IPROPOL}           {SMI: "CC(C)O" MCM: isopropylic alcohol}
MGLYOX          =  3C +  4H +  2O      ; {@MGLYOX}            {SMI: "O=CC(=O)C" MCM: CH3COCHO = methylglyoxal}
NC3H7O2         =  3C +  7H +  2O      ; {@C_3H_7O_2}         {SMI: "CCCO[O]" MCM: propylperoxy radical}
NC3H7OOH        =  3C +  8H +  2O      ; {@C_3H_7OOH}         {SMI: "CCCOO" MCM: propyl hydro peroxide}
NPROPOL         =  3C +  8H +   O      ; {@NPROPOL}           {SMI: "CCCO" MCM: n-propylic alcohol}
PROPENOL        =  3C +  6H +   O      ; {@CH_2CHCH_2OH}      {}
{3C (CHO) aromatics}
C32OH13CO       =  3C +  4H +  3O      ; {@C32OH13CO}         {SMI: "O=CC(O)C=O" MCM: hydroxymalonaldehyde}
C3DIALO2        =  3C +  3H +  4O      ; {@C3DIALO2}          {SMI: "[O]OC(C=O)C=O" MCM}
C3DIALOOH       =  3C +  4H +  4O      ; {@C3DIALOOH}         {SMI: "OOC(C=O)C=O" MCM}
HCOCOHCO3       =  3C +  3H +  5O      ; {@HCOCOHCO3}         {SMI: "OC(C=O)C(=O)O[O]" MCM}
HCOCOHCO3H      =  3C +  4H +  5O      ; {@HCOCOHCO3H}        {SMI: "OC(C=O)C(=O)OO" MCM}
METACETHO       =  3C +  4H +  3O      ; {@METACETHO}         {SMI: "O=COC(=O)C" MCM: acetic formic anhydride}
{3C (CHON)}
C3PAN1          =  3C +  5H +  6O +  N ; {@C_3PAN1}           {SMI: "OCCC(=O)OON(=O)=O" MCM}
C3PAN2          =  3C +  3H +  6O +  N ; {@C_3PAN2}           {SMI: "O=CCC(=O)OON(=O)=O" MCM}
CH3COCH2O2NO2   =  3C +  5H +  5O +  N ; {@CH_3COCH_2OONO_2}  {CH3-C(O)-CH2-OONO2}
IC3H7NO3        =  3C +  7H +  3O +  N ; {@iC_3H_7ONO_2}      {SMI: "CC(C)ON(=O)=O" MCM: isopropyl nitrate}
NC3H7NO3        =  3C +  7H +  3O +  N ; {@C_3H_7ONO_2}       {SMI: "CCCON(=O)=O" MCM: propyl nitrate}
NOA             =  3C +  5H +  4O +  N ; {@NOA}               {SMI: "CC(=O)CON(=O)=O" MCM: CH3-CO-CH2ONO2 = nitro-oxy-acetone}
PPN             =  3C +  5H +  5O +  N ; {@PPN}               {SMI: "CCC(=O)OON(=O)=O" MCM: CH3CH2C(O)OONO2}
PR2O2HNO3       =  3C +  7H +  5O +  N ; {@PR2O2HNO3}         {SMI: "OOC(C)CON(=O)=O" MCM: CH3-CH(OOH)-CH2ONO2}
PRONO3BO2       =  3C +  6H +  5O +  N ; {@PRONO3BO2}         {SMI: "[O]OC(C)CON(=O)=O" MCM: CH3-CH(O2)-CH2ONO2}
PROPOLNO3       =  3C +  7H +  4O +  N ; {@PROPOLNO3}         {SMI: "OCC(C)ON(=O)=O" MCM: HOCH2-CH(CH3)ONO2)}
{3C (CHON) aromatics}
HCOCOHPAN       =  3C +  3H +  7O +  N ; {@HCOCOHPAN}         {SMI: "O=CC(O)C(=O)OON(=O)=O" MCM}
{4C (CHO)}
BIACET          =  4C +  6H +  2O      ; {@BIACET}            {SMI: "CC(=O)C(=O)C" MCM: CH3-CO-CO-CH3}
BIACETO2        =  4C +  5H +  4O      ; {@CH_3COCOCH_2O_2}   {SMI: "CC(=O)C(=O)CO[O]" MCM}
BIACETOH        =  4C +  6H +  3O      ; {@BIACETOH}          {SMI: "CC(=O)C(=O)CO" MCM: CH3-CO-CO-CH2OH}
BIACETOOH       =  4C +  6H +  4O      ; {@CH_3COCOCH_2OOH}   {SMI: "CC(=O)C(=O)COO" MCM}
BUT1ENE         =  4C +  8H            ; {@BUT1ENE}           {SMI: "CCC=C" MCM}
BUT2OLO         =  4C +  8H +  2O      ; {@BUT2OLO}           {SMI: "CC(=O)C(C)O" MCM}
BUT2OLO2        =  4C +  9H +  3O      ; {@BUT2OLO2}          {SMI: "[O]OC(C)C(C)O" MCM}
BUT2OLOOH       =  4C + 10H +  3O      ; {@BUT2OLOOH}         {SMI: "OOC(C)C(C)O" MCM}
BUTENOL         =  4C +  8H +   O      ; {@BUTENOL}           {CH3CH2CHCHOH}
C312COCO3       =  4C +  3H +  5O      ; {@C312COCO3}         {SMI: "[O]OC(=O)CC(=O)C=O" MCM}
C312COCO3H      =  4C +  4H +  5O      ; {@C312COCO3H}        {SMI: "OOC(=O)CC(=O)C=O" MCM}
C3H7CHO         =  4C +  8H +   O      ; {@C_3H_7CHO}         {SMI: "CCCC=O" MCM: n-butanal}
C413COOOH       =  4C +  6H +  4O      ; {@C413COOOH}         {SMI: "OOCC(=O)CC=O" MCM}
C44O2           =  4C +  5H +  5O      ; {@C44O2}             {SMI: "O=CCC(O[O])C(=O)O" MCM}
C44OOH          =  4C +  6H +  5O      ; {@C44OOH}            {SMI: "O=CCC(OO)C(=O)O" MCM}
C4CODIAL        =  4C +  4H +  3O      ; {@C4CODIAL}          {SMI: "O=CCC(=O)C=O" MCM}
CBUT2ENE        =  4C +  8H            ; {@CBUT2ENE}          {SMI: "CC=CC" MCM}
CH3COCHCO       =  4C +  4H +  2O      ; {@CH_3COCHCO}        {}
CH3COCHO2CHO    =  4C +  5H +  4O      ; {@CH_3COCHO_2CHO}    {}
CH3COCOCO2H     =  4C +  4H +  4O      ; {@CH3COCOCO2H}       {}
CH3COOHCHCHO    =  4C +  6H +  3O      ; {@CH_3COOHCHCHO}     {}
CHOC3COO2       =  4C +  5H +  4O      ; {@CHOC3COO2}         {SMI: "[O]OCC(=O)CC=O" MCM}
CO23C3CHO       =  4C +  4H +  3O      ; {@CH_3COCOCHO}       {SMI: "O=CC(=O)C(=O)C" MCM}
CO2C3CHO        =  4C +  6H +  2O      ; {@CO2C3CHO}          {SMI: "O=CCC(=O)C" MCM: CH3COCH2CHO}
CO2H3CHO        =  4C +  6H +  3O      ; {@CO2H3CHO}          {SMI: "O=CC(O)C(=O)C" MCM: CH3-CO-CH(OH)-CHO}
CO2H3CO2H       =  4C +  6H +  5O      ; {@CO2H3CO2H}         {}
CO2H3CO3        =  4C +  5H +  5O      ; {@CO2H3CO3}          {SMI: "CC(=O)C(O)C(=O)O[O]" MCM: CH3-CO-CH(OH)-C(O)O2}
CO2H3CO3H       =  4C +  6H +  5O      ; {@CO2H3CO3H}         {SMI: "CC(=O)C(O)C(=O)OO" MCM: CH3-CO-CH(OH)-C(O)OOH}
EZCH3CO2CHCHO   =  4C +  5H +  3O      ; {@EZCH3CO2CHCHO}     {}
EZCHOCCH3CHO2   =  4C +  5H +  3O      ; {@EZCHOCCH3CHO2}     {}
HCOCCH3CHOOH    =  4C +  6H +  3O      ; {@HCOCCH_3CHOOH}     {}
HCOCCH3CO       =  4C +  4H +  2O      ; {@HCOCCH_3CO}        {}
HCOCO2CH3CHO    =  4C +  5H +  4O      ; {@HCOCO_2CH_3CHO}    {}
HMAC            =  4C +  6H +  2O      ; {@HMAC}              {SMI: "OC=C(C=O)C" MCM: HCOC(CH3)CHOH}
HO12CO3C4       =  4C +  8H +  3O      ; {@HO12CO3C4}         {SMI: "CC(=O)C(O)CO" MCM: CH3-CO-CH(OH)-CH2OH}
HVMK            =  4C +  6H +  2O      ; {@HVMK}              {SMI: "CC(=O)C=CO" MCM: CH3COCHCHOH = hydroxy vinyl methyl ketone}
IBUTALOH        =  4C +  8H +  2O      ; {@IBUTALOH}          {SMI: "O=CC(C)(C)O" MCM}
IBUTDIAL        =  4C +  6H +  2O      ; {@IBUTDIAL}          {SMI: "O=CC(C)C=O" MCM: HCOC(CH3)CHO}
IBUTOLBO2       =  4C +  9H +  3O      ; {@IBUTOLBO2}         {SMI: "OCC(C)(C)O[O]" MCM}
IBUTOLBOOH      =  4C + 10H +  3O      ; {@IBUTOLBOOH}        {}
IC4H10          =  4C + 10H            ; {@iC_4H_<10>}        {SMI: "CC(C)C" MCM: (CH3)3-CH = i-butane}
IC4H9O2         =  4C +  9H +  2O      ; {@IC_4H_9O_2}        {SMI: "[O]OCC(C)C" MCM: (CH3)2-CHCH2O2 IC4H9O2}
IC4H9OOH        =  4C + 10H +  2O      ; {@IC_4H_9OOH}        {SMI: "OOCC(C)C" MCM: (CH3)2-CHCH2OOH MCM: IC4H9OOH}
IPRCHO          =  4C +  8H +   O      ; {@IPRCHO}            {SMI: "O=CC(C)C" MCM: (CH3)2CHCHO MCM : methylpropanal}
IPRCO3          =  4C +  7H +  3O      ; {@IPRCO3}            {SMI: "[O]OC(=O)C(C)C" MCM: (CH3)2CHCO3}
IPRHOCO2H       =  4C +  8H +  3O      ; {@IPRHOCO2H}         {SMI: "OC(=O)C(C)(C)O" MCM}
IPRHOCO3        =  4C +  7H +  4O      ; {@IPRHOCO3}          {SMI: "[O]OC(=O)C(C)(C)O" MCM}
IPRHOCO3H       =  4C +  8H +  4O      ; {@IPRHOCO3H}         {SMI: "OOC(=O)C(C)(C)O" MCM}
MACO2           =  4C +  5H +  2O      ; {@MACO2}             {}
MACO2H          =  4C +  6H +  2O      ; {@MACO2H}            {SMI: "CC(=C)C(=O)O" MCM: CH2=C(CH3)COOH = methacrylic acid}
MACO3           =  4C +  5H +  3O      ; {@MACO3}             {SMI: "CC(=C)C(=O)O[O]" MCM: CH2=C(CH3)C(O)O2}
MACO3H          =  4C +  6H +  3O      ; {@MACO3H}            {SMI: "CC(=C)C(=O)OO" MCM: CH2=C(CH3)C(O)OOH}
MACR            =  4C +  6H +   O      ; {@MACR}              {SMI: "CC(=C)C=O" MCM: CH2=C(CH3)CHO = methacrolein}
MACRO           =  4C +  7H +  3O      ; {@MACRO}             {SMI: "CC([O])(CO)C=O" MCM}
MACRO2          =  4C +  7H +  4O      ; {@MACRO2}            {SMI: "OCC(C)(O[O])C=O" MCM: HOCH2C(OO)(CH3)CHO}
MACROH          =  4C +  8H +  3O      ; {@MACROH}            {SMI: "CC(O)(CO)C=O" MCM: HOCH2C(OH)(CH3)CHO}
MACROOH         =  4C +  8H +  4O      ; {@MACROOH}           {SMI: "OCC(C)(OO)C=O" MCM: HOCH2C(OOH)(CH3)CHO}
MBOOO           =  4C +  8H +  3O      ; {@MBOOO}             {SMI: "[O-][O+]=CC(C)(C)O" MCM}
MEK             =  4C +  8H +   O      ; {@MEK}               {SMI: "CCC(=O)C" MCM: CH3-CO-CH2-CH3 = methyl ethyl ketone}
MEPROPENE       =  4C +  8H            ; {@MEPROPENE}         {SMI: "CC(=C)C" MCM}
MPROPENOL       =  4C +  8H +   O      ; {@MPROPENOL}         {(CH3)2CCHOH methylpropenol}
MVK             =  4C +  6H +   O      ; {@MVK}               {SMI: "CC(=O)C=C" MCM: CH3-CO-CH=CH2 = methyl vinyl ketone}
NC4H10          =  4C + 10H            ; {@C_4H_<10>}         {SMI: "CCCC" MCM: CH3-CH2-CH2-CH3 = n-butane}
PERIBUACID      =  4C +  8H +  3O      ; {@PERIBUACID}        {SMI: "OOC(=O)C(C)C" MCM: (CH3)2CHCO3H}
TBUT2ENE        =  4C +  8H            ; {@TBUT2ENE}          {SMI: "CC=CC" MCM}
TC4H9O2         =  4C +  9H +  2O      ; {@TC_4H_9O_2}        {SMI: "[O]OC(C)(C)C" MCM: (CH3)3-CO2}
TC4H9OOH        =  4C + 10H +  2O      ; {@TC_4H_9OOH}        {SMI: "OOC(C)(C)C" MCM: (CH3)3-COOH}
{4C (CHO) aromatics}
BZFUCO          =  4C +  4H +  4O      ; {@BZFUCO}            {SMI: "OC1COC(=O)C1=O" MCM}
BZFUO2          =  4C +  5H +  5O      ; {@BZFUO2}            {SMI: "[O]OC1C(O)COC1=O" MCM}
BZFUONE         =  4C +  4H +  2O      ; {@BZFUONE}           {SMI: "C1OC(=O)C=C1" MCM: 2(5H)-furanone}
BZFUOOH         =  4C +  6H +  5O      ; {@BZFUOOH}           {SMI: "OOC1C(O)COC1=O" MCM}
CO14O3CHO       =  4C +  4H +  4O      ; {@CO14O3CHO}         {SMI: "O=CCOC(=O)C=O" MCM}
CO14O3CO2H      =  4C +  4H +  5O      ; {@CO14O3CO2H}        {SMI: "O=CCOC(=O)C(=O)O" MCM}
CO2C4DIAL       =  4C +  2H +  4O      ; {@CO2C4DIAL}         {SMI: "O=CC(=O)C(=O)C=O" MCM: 2,3-dioxosuccinaldehyde}
EPXC4DIAL       =  4C +  4H +  3O      ; {@EPXC4DIAL}         {SMI: "O=CC1OC1C=O" MCM}
EPXDLCO2H       =  4C +  4H +  4O      ; {@EPXDLCO2H}         {SMI: "O=CC1OC1C(=O)O" MCM}
EPXDLCO3        =  4C +  3H +  5O      ; {@EPXDLCO3}          {SMI: "[O]OC(=O)C1OC1C=O" MCM}
EPXDLCO3H       =  4C +  4H +  5O      ; {@EPXDLCO3H}         {SMI: "OOC(=O)C1OC1C=O" MCM}
HOCOC4DIAL      =  4C +  4H +  4O      ; {@HOCOC4DIAL}        {SMI: "O=CC(=O)C(O)C=O" MCM: 2-hydroxy-3-oxosuccinaldehyde}
MALANHY         =  4C +  2H +  3O      ; {@MALANHY}           {SMI: "O=C1C=CC(=O)O1" MCM: maleic anhydride}
MALANHYO2       =  4C +  3H +  6O      ; {@MALANHYO2}         {SMI: "[O]OC1C(=O)OC(=O)C1O" MCM}
MALANHYOOH      =  4C +  4H +  6O      ; {@MALANHYOOH}        {SMI: "OOC1C(=O)OC(=O)C1O" MCM}
MALDALCO2H      =  4C +  4H +  3O      ; {@MALDALCO2H}        {SMI: "O=CC=CC(=O)O" MCM: 4-oxo-2-butenoic acid}
MALDALCO3H      =  4C +  4H +  4O      ; {@MALDALCO3H}        {SMI: "OOC(=O)C=CC=O" MCM}
MALDIAL         =  4C +  4H +  2O      ; {@MALDIAL}           {SMI: "O=CC=CC=O" MCM: 2-butenedial}
MALDIALCO3      =  4C +  3H +  4O      ; {@MALDIALCO3}        {SMI: "[O]OC(=O)C=CC=O" MCM}
MALDIALO2       =  4C +  5H +  5O      ; {@MALDIALO2}         {SMI: "[O]OC(C=O)C(O)C=O" MCM}
MALDIALOOH      =  4C +  6H +  5O      ; {@MALDIALOOH}        {SMI: "OOC(C=O)C(O)C=O" MCM}
MALNHYOHCO      =  4C +  2H +  5O      ; {@MALNHYOHCO}        {SMI: "O=C1OC(=O)C(O)C1=O" MCM}
MECOACEOOH      =  4C +  6H +  5O      ; {@MECOACEOOH}        {SMI: "CC(=O)OC(=O)COO" MCM}
MECOACETO2      =  4C +  5H +  5O      ; {@MECOACETO2}        {SMI: "CC(=O)OC(=O)CO[O]" MCM}
{4C (CHON)}
BUT2OLNO3       =  4C +  9H +  4O +  N ; {@BUT2OLNO3}         {SMI: "O=N(=O)OC(C)C(C)O" MCM}
C312COPAN       =  4C +  3H +  7O +  N ; {@C312COPAN}         {SMI: "O=CC(=O)CC(=O)OON(=O)=O" MCM}
C4PAN5          =  4C +  7H +  6O +  N ; {@C4PAN5}            {SMI: "O=N(=O)OOC(=O)C(C)(C)O" MCM}
IBUTOLBNO3      =  4C +  9H +  4O +  N ; {@IBUTOLBNO3}        {SMI: "OCC(C)(C)ON(=O)=O" MCM}
IC4H9NO3        =  4C +  9H +  3O +  N ; {@IC4H9NO3}          {SMI: "CC(C)CON(=O)=O" MCM}
MACRNO3         =  4C +  7H +  5O +  N ; {@MACRNO3}           {SMI: "OCC(C)(C=O)ON(=O)=O" MCM}
MPAN            =  4C +  5H +  5O +  N ; {@MPAN}              {SMI: "O=N(=O)OOC(=O)C(=C)C" MCM: CH2=C(CH3)C(O)OONO2 = peroxymethacryloyl nitrate = peroxymethacrylic nitric anhydride}
MVKNO3          =  4C +  7H +  5O +  N ; {@MVKNO3}            {SMI: "OCC(ON(=O)=O)C(=O)C" MCM}
PIPN            =  4C +  7H +  5O +  N ; {@PIPN}              {SMI: "O=N(=O)OOC(=O)C(C)C" MCM: (CH3)2CHCO3} 
TC4H9NO3        =  4C +  9H +  3O +  N ; {@TC4H9NO3}          {SMI: "O=N(=O)OC(C)(C)C" MCM}
{4C (CHON) aromatics}
EPXDLPAN        =  4C +  3H +  7O +  N ; {@EPXDLPAN}          {SMI: "O=CC1OC1C(=O)OON(=O)=O" MCM}
MALDIALPAN      =  4C +  3H +  6O +  N ; {@MALDIALPAN}        {SMI: "O=CC=CC(=O)OON(=O)=O" MCM}
NBZFUO2         =  4C +  4H +  7O +  N ; {@NBZFUO2}           {SMI: "[O]OC1C(=O)OCC1ON(=O)=O" MCM}
NBZFUONE        =  4C +  3H +  6O +  N ; {@NBZFUONE}          {SMI: "O=N(=O)OC1C(=O)COC1=O" MCM}
NBZFUOOH        =  4C +  5H +  7O +  N ; {@NBZFUOOH}          {SMI: "OOC1C(=O)OCC1ON(=O)=O" MCM}
NC4DCO2H        =  4C +  3H +  5O +  N ; {@NC4DCO2H}          {SMI: "O=CC(=CC(=O)O)N(=O)=O" MCM}
{4C (CHO) (lumped)}
LBUT1ENO2       =  4C +  9H +  2O      ; {@LBUT1ENO2}         {HO3C4O2 + NBUTOLAO2}
LBUT1ENOOH      =  4C + 10H +  3O      ; {@LBUT1ENOOH}        {HO3C4OOH + NBUTOLAOOH}
LC4H9O2         =  4C +  9H +  2O      ; {@LC_4H_9O_2}        {CH3-CH2-CH(O2)-CH3 + CH3-CH2-CH2-CH2O2 = NC4H9O2 + SC4H9O2}
LC4H9OOH        =  4C + 10H +  2O      ; {@LC_4H_9OOH}        {CH3-CH2-CH(OOH)-CH3 + CH3-CH2-CH2-CH2OOH = NC4H9OOH + SC4H9OOH}
LHMVKABO2       =  4C +  7H +  4O      ; {@LHMVKABO2}         {HOCH2-CH(O2)-CO-CH3 + CH2(O2)-CH(OH)-CO-CH3}
LHMVKABOOH      =  4C +  8H +  4O      ; {@LHMVKABOOH}        {HOCH2-CH(OOH)-CO-CH3 + CH2(OOH)-CH(OH)-CO-CH3}
LMEKO2          =  4C +  7H +  3O      ; {@LMEKO2}            {CH3-CO-CH2-CH2-OO + CH3-CO-CH(O2)-CH3}
LMEKOOH         =  4C +  8H +  3O      ; {@LMEKOOH}           {CH3-CO-CH2-CH2-OOH + CH3-CO-CH(OOH)-CH3}
{4C (CHON) (lumped)}
LBUT1ENNO3      =  4C +  9H +  5O +  N ; {@LBUT1ENNO3}        {HO3C4NO3 + NBUTOLANO3}
LC4H9NO3        =  4C +  9H +  3O +  N ; {@LC4H9NO3}          {NC4H9NO3 + SC4H9NO3}
LMEKNO3         =  4C +  7H +  5O +  N ; {@LMEKNO3}           {CH3-CO-CH2-CH2-ONO2 + CH3-CO-CH(ONO2)-CH3}
{5C (CHO)}
C1ODC2O2C4OD    =  5C +  7H +  4O      ; {@C1ODC2O2C4OD}      {}
C1ODC2O2C4OOH   =  5C +  9H +  5O      ; {@C1ODC2O2C4OOH}     {}
C1ODC2OOHC4OD   =  5C +  8H +  4O      ; {@C1ODC2OOHC4OD}     {}
C1ODC3O2C4OOH   =  5C +  9H +  5O      ; {@C1ODC3O2C4OOH}     {}
C1OOHC2O2C4OD   =  5C +  9H +  5O      ; {@C1OOHC2O2C4OD}     {}
C1OOHC2OOHC4OD  =  5C + 10H +  5O      ; {@C1OOHC2OOHC4OD}    {}
C1OOHC3O2C4OD   =  5C +  9H +  5O      ; {@C1OOHC3O2C4OD}     {}
C4MDIAL         =  5C +  6H +  2O      ; {@C4MDIAL}           {SMI: "O=CC=C(C)C=O" MCM: 2-methyl-butenedial}
C511O2          =  5C +  7H +  4O      ; {@C511O2}            {SMI: "O=CCC(O[O])C(=O)C" MCM}
C511OOH         =  5C +  8H +  4O      ; {@C511OOH}           {SMI: "O=CCC(OO)C(=O)C" MCM}
C512O2          =  5C +  7H +  4O      ; {@C512O2}            {SMI: "[O]OCCC(=O)CC=O" MCM}
C512OOH         =  5C +  8H +  4O      ; {@C512OOH}           {SMI: "OOCCC(=O)CC=O" MCM}
C513CO          =  5C +  6H +  4O      ; {@C513CO}            {SMI: "OCCC(=O)C(=O)C=O" MCM}
C513O2          =  5C +  7H +  5O      ; {@C513O2}            {SMI: "OCCC(=O)C(O[O])C=O" MCM}
C513OOH         =  5C +  8H +  5O      ; {@C513OOH}           {SMI: "OCCC(=O)C(OO)C=O" MCM}
C514O2          =  5C +  7H +  4O      ; {@C514O2}            {SMI: "O=CCC(O[O])CC=O" MCM}
C514OOH         =  5C +  8H +  4O      ; {@C514OOH}           {SMI: "O=CCC(OO)CC=O" MCM}
C59O2           =  5C +  9H +  5O      ; {@C59O2}             {SMI: "OCC(=O)C(C)(CO)O[O]" MCM: HOCH2-CO-C(CH3)(O2)-CH2OH}
C59OOH          =  5C + 10H +  5O      ; {@C59OOH}            {SMI: "OCC(=O)C(C)(CO)OO" MCM: HOCH2-CO-C(CH3)(OOH)-CH2OH}
C5H8            =  5C +  8H            ; {@C_5H_8}            {SMI: "C=CC(=C)C" MCM: CH2=C(CH3)CH=CH2 = isoprene}
CHOC3COCO3      =  5C +  5H +  5O      ; {@CHOC3COCO3}        {SMI: "[O]OC(=O)CC(=O)CC=O" MCM}
CHOC3COOOH      =  5C +  6H +  5O      ; {@CHOC3COOOH}        {SMI: "OOC(=O)CC(=O)CC=O" MCM}
CO13C4CHO       =  5C +  6H +  3O      ; {@CO13C4CHO}         {SMI: "O=CCC(=O)CC=O" MCM}
CO23C4CHO       =  5C +  6H +  3O      ; {@CO23C4CHO}         {SMI: "O=CCC(=O)C(=O)C" MCM}
CO23C4CO3       =  5C +  5H +  5O      ; {@CO23C4CO3}         {SMI: "[O]OC(=O)CC(=O)C(=O)C" MCM}
CO23C4CO3H      =  5C +  6H +  5O      ; {@CO23C4CO3H}        {SMI: "OOC(=O)CC(=O)C(=O)C" MCM}
DB1O            =  5C +  9H +  3O      ; {@DB1O2}             {Alkoxy radical which undergoes the double H-shift predicted by T. Dibble and confirmed by F. Paulot}
DB1O2           =  5C +  9H +  4O      ; {@DB1O2}             {Peroxy radical with a vinyl alcohol part}
DB1OOH          =  5C + 10H +  4O      ; {@DB1OOH}            {}
DB2O2           =  5C +  9H +  5O      ; {@DB1O2}             {}
DB2OOH          =  5C + 10H +  5O      ; {@DB2OOH}            {}
HCOC5           =  5C +  8H +  2O      ; {@HCOC5}             {SMI: "CC(=C)C(=O)CO" MCM: HOCH2-CO-C(CH3)=CH2}
ISOPAOH         =  5C + 10H +  2O      ; {@ISOPAOH}           {SMI: "OCC=C(C)CO" MCM: HOCH2-C(CH3)=CH-CH2OH}
ISOPBO2         =  5C +  9H +  3O      ; {@ISOPBO2}           {SMI: "OCC(C)(O[O])C=C" MCM: HOCH2-C(CH3)(O2)-CH=CH2}
ISOPBOH         =  5C + 10H +  2O      ; {@ISOPBOH}           {SMI: "CC(O)(CO)C=C" MCM: HOCH2-C(CH3)(OH)-CH=CH2}
ISOPBOOH        =  5C + 10H +  3O      ; {@ISOPBOOH}          {SMI: "OCC(C)(OO)C=C" MCM: HOCH2-C(CH3)(OOH)-CH=CH2}
ISOPDO2         =  5C +  9H +  3O      ; {@ISOPDO2}           {SMI: "OCC(O[O])C(=C)C" MCM: CH2=C(CH3)CH(O2)-CH2OH}
ISOPDOH         =  5C + 10H +  2O      ; {@ISOPDOH}           {SMI: "CC(=C)C(O)CO" MCM: CH2=C(CH3)CH(OH)-CH2OH}
ISOPDOOH        =  5C + 10H +  3O      ; {@ISOPDOOH}          {SMI: "OCC(OO)C(=C)C" MCM: CH2=C(CH3)CH(OOH)-CH2OH}
MBO             =  5C + 10H +   O      ; {@MBO}               {SMI: "C=CC(C)(C)O" MCM: 2-methyl-3-buten-2-ol}
MBOACO          =  5C + 10H +  3O      ; {@MBOACO}            {SMI: "OCC(=O)C(C)(C)O" MCM}
MBOCOCO         =  5C +  8H +  3O      ; {@MBOCOCO}           {SMI: "O=CC(=O)C(C)(C)O" MCM}
ME3FURAN        =  5C +  6H +   O      ; {@3METHYLFURAN}      {3-methyl-furan}
{5C aromatics (CHO)}
ACCOMECHO       =  5C +  6H +  4O      ; {@ACCOMECHO}         {SMI: "O=CCC(=O)OC(=O)C" MCM}
ACCOMECO3       =  5C +  5H +  6O      ; {@ACCOMECO3}         {SMI: "CC(=O)OC(=O)CC(=O)O[O]" MCM}
ACCOMECO3H      =  5C +  6H +  6O      ; {@ACCOMECO3H}        {SMI: "CC(=O)OC(=O)CC(=O)OO" MCM}
C24O3CCO2H      =  5C +  6H +  5O      ; {@C24O3CCO2H}        {SMI: "OC(=O)CC(=O)OC(=O)C" MCM}
C4CO2DBCO3      =  5C +  3H +  5O      ; {@C4CO2DBCO3}        {SMI: "[O]OC(=O)C=CC(=O)C=O" MCM}
C4CO2DCO3H      =  5C +  4H +  5O      ; {@C4CO2DCO3H}        {SMI: "OOC(=O)C=CC(=O)C=O" MCM}
C5134CO2OH      =  5C +  6H +  4O      ; {@C5134CO2OH}        {SMI: "O=CC(O)C(=O)C(=O)C" MCM: 2-hydroxy-3,4-dioxopentanal}
C54CO           =  5C +  4H +  4O      ; {@C54CO}             {SMI: "O=CC(=O)C(=O)C(=O)C" MCM: 2,3,4-trioxopentanal}
C5CO14O2        =  5C +  5H +  4O      ; {@C5CO14O2}          {SMI: "CC(=O)C=CC(=O)O[O]" MCM}
C5CO14OH        =  5C +  6H +  3O      ; {@C5CO14OH}          {SMI: "CC(=O)C=CC(=O)O" MCM: 4-oxo-2-pentenoic acid}
C5CO14OOH       =  5C +  6H +  4O      ; {@C5CO14OOH}         {SMI: "CC(=O)C=CC(=O)OO" MCM}
C5DIALCO        =  5C +  4H +  3O      ; {@C5DIALCO}          {SMI: "O=CC=CC(=O)C=O" MCM}
C5DIALO2        =  5C +  5H +  4O      ; {@C5DIALO2}          {SMI: "O=CC=CC(O[O])C=O" MCM}
C5DIALOOH       =  5C +  6H +  4O      ; {@C5DIALOOH}         {SMI: "O=CC=CC(OO)C=O" MCM}
C5DICARB        =  5C +  6H +  2O      ; {@C5DICARB}          {SMI: "O=CC=CC(=O)C" MCM: 4-oxo-2-pentenal}
C5DICARBO2      =  5C +  7H +  5O      ; {@C5DICARBO2}        {SMI: "[O]OC(C(=O)C)C(O)C=O" MCM: carboxy(hydroxy)acetate}
C5DICAROOH      =  5C +  8H +  5O      ; {@C5DICAROOH}        {SMI: "OOC(C(=O)C)C(O)C=O" MCM}
MC3ODBCO2H      =  5C +  6H +  3O      ; {@MC3ODBCO2H}        {SMI: "O=CC=C(C)C(=O)O" MCM}
MMALANHY        =  5C +  4H +  3O      ; {@MMALANHY}          {SMI: "O=C1C=C(C)C(=O)O1" MCM: 3-methyl-2,5-furandione}
MMALANHYO2      =  5C +  5H +  6O      ; {@MMALANHYO2}        {SMI: "CC1(O[O])C(O)C(=O)OC1=O" MCM}
MMALNHYOOH      =  5C +  6H +  6O      ; {@MMALNHYOOH}        {SMI: "CC1(OO)C(O)C(=O)OC1=O" MCM}
TLFUO2          =  5C +  7H +  5O      ; {@TLFUO2}            {SMI: "[O]OC1C(=O)OC(C)C1O" MCM}
TLFUONE         =  5C +  6H +  2O      ; {@TLFUONE}           {SMI: "CC1C=CC(=O)O1" MCM: 5-methyl-2(5H)-furanone}
TLFUOOH         =  5C +  8H +  5O      ; {@TLFUOOH}           {SMI: "OOC1C(=O)OC(C)C1O" MCM}
{5C (CHON)}
C4MCONO3OH      =  5C +  9H +  5O +  N ; {@C4MCONO3OH}        {SMI: "O=N(=O)OCC(=O)C(C)(C)O" MCM}
C514NO3         =  5C +  7H +  5O +  N ; {@C514NO3}           {SMI: "O=CCC(CC=O)ON(=O)=O" MCM}
C5PAN9          =  5C +  5H +  7O +  N ; {@C5PAN9}            {SMI: "O=N(=O)OOC(=O)CC(=O)C(=O)C" MCM}
CHOC3COPAN      =  5C +  5H +  7O +  N ; {@CHOC3COPAN}        {SMI: "O=CCC(=O)CC(=O)OON(=O)=O" MCM}
DB1NO3          =  5C +  9H +  6O +  N ; {@DB1NO3}            {}
ISOPBDNO3O2     =  5C + 10H +  7O +  N ; {@ISOPBDNO3O2}       {}
ISOPBNO3        =  5C +  9H +  4O +  N ; {@ISOPBNO3}          {SMI: "OCC(C)(C=C)ON(=O)=O" MCM: HOCH2-C(CH3)(ONO2)-CH=CH2}
ISOPDNO3        =  5C +  9H +  4O +  N ; {@ISOPDNO3}          {SMI: "OCC(ON(=O)=O)C(=C)C" MCM: CH2=C(CH3)CH(ONO2)-CH2OH}
NC4CHO          =  5C +  7H +  4O +  N ; {@NC4CHO}            {SMI: "O=CC=C(C)CON(=O)=O" MCM: O2NOCH2-C(CH3)=CH-CHO}
NC4OHCO3        =  5C +  8H +  7O +  N ; {@NC4OHCO3}          {SMI: "[O]OC(=O)C(ON(=O)=O)C(C)(C)O" MCM}
NC4OHCO3H       =  5C +  9H +  7O +  N ; {@NC4OHCO3H}         {SMI: "OOC(=O)C(ON(=O)=O)C(C)(C)O" MCM}
NC4OHCPAN       =  5C +  8H +  9O + 2N ; {@NC4OHCPAN}         {SMI: "O=N(=O)OOC(=O)C(ON(=O)=O)C(C)(C)O" MCM}
NISOPO2         =  5C +  8H +  5O +  N ; {@NISOPO2}           {SMI: "[O]OCC=C(C)CON(=O)=O" MCM: O2NOCH2-C(CH3)=CH-CH2O2}
NISOPOOH        =  5C +  9H +  5O +  N ; {@NISOPOOH}          {SMI: "OOCC=C(C)CON(=O)=O" MCM: O2NOCH2-C(CH3)=CH-CH2OOH}
NMBOBCO         =  5C +  9H +  5O +  N ; {@NMBOBCO}           {SMI: "O=CC(ON(=O)=O)C(C)(C)O" MCM}
{5C aromatics (CHON)}
ACCOMEPAN       =  5C +  5H +  8O +  N ; {@ACCOMEPAN}         {SMI: "O=C(OON(=O)=O)CC(=O)OC(=O)C" MCM}
C4CO2DBPAN      =  5C +  3H +  7O +  N ; {@C4CO2DBPAN}        {SMI: "O=CC(=O)C=CC(=O)OON(=O)=O" MCM}
C5COO2NO2       =  5C +  5H +  6O +  N ; {@C5COO2NO2}         {SMI: "O=N(=O)OOC(=O)C=CC(=O)C" MCM}
NC4MDCO2H       =  5C +  5H +  5O +  N ; {@NC4MDCO2H N}       {SMI: "O=CC(=C(C)C(=O)O)N(=O)=O" MCM}
NTLFUO2         =  5C +  6H +  7O +  N ; {@NTLFUO2}           {SMI: "[O]OC1C(=O)OC(C)C1ON(=O)=O" MCM}
NTLFUOOH        =  5C +  7H +  7O +  N ; {@NTLFUOOH}          {SMI: "OOC1C(=O)OC(C)C1ON(=O)=O" MCM}
{5C (CHO) (lumped)}
LC578O2         =  5C +  9H +  5O      ; {@LC578O2}           {HOCH2-CH(OH)C(CH3)(O2)-CHO + HOCH2-C(CH3)(O2)-CH(OH)-CHO}
LC578OOH        =  5C + 10H +  5O      ; {@LC578OOH}          {HOCH2-CH(OH)C(CH3)(OOH)-CHO + HOCH2-C(CH3)(OOH)-CH(OH)-CHO}
LDISOPACO       =  5C +  9H +  2O      ; {@LISOPACO}          {}
LDISOPACO2      =  5C +  9H +  3O      ; {@LDISOPACO2}        {}
LHC4ACCHO       =  5C +  8H +  2O      ; {@LHC4ACCHO}         {HOCH2-C(CH3)=CH-CHO + HOCH2-CH=C(CH3)-CHO}
LHC4ACCO2H      =  5C +  8H +  3O      ; {@LHC4ACCO2H}        {HOCH2-C(CH3)=CH-C(O)OH + HOCH2-CH=C(CH3)-C(O)OH}
LHC4ACCO3       =  5C +  7H +  4O      ; {@LHC4ACCO3}         {HOCH2-C(CH3)=CH-C(O)O2 + HOCH2-CH=C(CH3)-C(O)O2}
LHC4ACCO3H      =  5C +  8H +  4O      ; {@LHC4ACCO3H}        {HOCH2-C(CH3)=CH-C(O)OOH + HOCH2-CH=C(CH3)-C(O)OOH}
LIEPOX          =  5C + 10H +  3O      ; {@LIEPOX}            {epoxydiol}
LISOPAB         =  5C +  9H +   O      ; {@LISOPAB}           {}
LISOPACO        =  5C +  9H +  2O      ; {@LISOPACO}          {HOCH2-C(CH3)=CH-CH2O + HOCH2-CH=C(CH3)-CH2O}
LISOPACO2       =  5C +  9H +  3O      ; {@LISOPACO2}         {HOCH2-C(CH3)=CH-CH2O2 + HOCH2-CH=C(CH3)-CH2O2}
LISOPACOOH      =  5C + 10H +  3O      ; {@LISOPACOOH}        {HOCH2-C(CH3)=CH-CH2OOH + HOCH2-CH=C(CH3)-CH2OOH}
LISOPCD         =  5C +  9H +   O      ; {@LISOPCD}           {}
LISOPEFO        =  5C +  9H +  2O      ; {@LISOPEFO}          {}
LISOPEFO2       =  5C +  9H +  3O      ; {@LISOPEFO2}         {}
LMBOABO2        =  5C + 11H +  4O      ; {@LMBOABO2}          {}
LMBOABOOH       =  5C + 12H +  4O      ; {@LMBOABOOH}         {}
LME3FURANO2     =  5C +  7H +  4O      ; {@L3METHYLFURANO2}   {hydroxy-3-methyl-furan peroxy radical}
LZCO3C23DBCOD   =  5C +  5H +  4O      ; {@LZCO3C23DBCOD}     {}
LZCO3HC23DBCOD  =  5C +  6H +  4O      ; {@LZCO3HC23DBCOD}    {C5PACALD1 + C5PACALD2}
LZCODC23DBCOOH  =  5C +  8H +  3O      ; {@LZCODC23DBCOOH}    {C5HPALD1 + C5HPALD2}
{5C (CHON) (lumped)}
LC5PAN1719      =  5C +  7H +  6O +  N ; {@LC5PAN1719}        {HOCH2-C(CH3)=CH-C(O)OONO2 + HOCH2-CH=C(CH3)C(O)OONO2}
LISOPACNO3      =  5C +  9H +  4O +  N ; {@LISOPACNO3}        {HOCH2-C(CH3)=CH-CH2ONO2 + HOCH2-CH=C(CH3)-CH2ONO2}
LISOPACNO3O2    =  5C + 10H +  7O +  N ; {@LISOPACNO3O2}      {RO2 resulting from OH-addition to ISOPANO3 and ISOPCNO3}
LMBOABNO3       =  5C + 11H +  5O +  N ; {@LMBOABNO3}         {}
LNISO3          =  5C             +  N ; {@LNISO3}            {C510O2+NC4CO3 = CHO-CH(OH)-C(CH3)(O2)-CH2ONO2 + O2NOCH2-C(CH3)=CH-C(O)O2}
LNISOOH         =  5C             +  N ; {@LNISOOH}           {CHO-CH(OH)-C(CH3)(OOH)-CH2ONO2 + O2NOCH2-C(CH3)=CH-C(O)OOH}
LNMBOABO2       =  5C +  9H +  6O +  N ; {@LNMBOABO2}         {}
LNMBOABOOH      =  5C + 10H +  6O +  N ; {@LNMBOABOOH}        {}
LZCPANC23DBCOD  =  5C +  5H +  6O +  N ; {@LZCPANC23DBCOD}    {}
{6C (CHO)}
C614CO          =  6C +  8H +  4O      ; {@C614CO}            {SMI: "OCC(=O)CC(=O)C(=O)C" MCM}
C614O2          =  6C +  9H +  5O      ; {@C614O2}            {SMI: "OCC(O[O])CC(=O)C(=O)C" MCM}
C614OOH         =  6C + 10H +  5O      ; {@C614OOH}           {SMI: "OCC(OO)CC(=O)C(=O)C" MCM}
CO235C5CHO      =  6C +  6H +  4O      ; {@CO235C5CHO}        {SMI: "O=CC(=O)CC(=O)C(=O)C" MCM}
CO235C6O2       =  6C +  7H +  5O      ; {@CO235C6O2}         {SMI: "CC(=O)C(=O)CC(=O)CO[O]" MCM}
CO235C6OOH      =  6C +  8H +  5O      ; {@CO235C6OOH}        {SMI: "CC(=O)C(=O)CC(=O)COO" MCM}
{C6 (CHO) aromatics}
BENZENE         =  6C +  6H            ; {@BENZENE}           {SMI: "c1ccccc1" MCM}
BZBIPERO2       =  6C +  7H +  5O      ; {@BZBIPERO2}         {SMI: "[O]OC1C=CC2OOC1C2O" MCM}
BZBIPEROOH      =  6C +  8H +  5O      ; {@BZBIPEROOH}        {SMI: "OOC1C=CC2OOC1C2O" MCM}
BZEMUCCO        =  6C +  6H +  5O      ; {@BZEMUCCO}          {SMI: "O=CC1OC1C(=O)C(O)C=O" MCM}
BZEMUCCO2H      =  6C +  6H +  4O      ; {@BZEMUCCO2H}        {SMI: "O=CC=CC1OC1C(=O)O" MCM}
BZEMUCCO3       =  6C +  5H +  5O      ; {@BZEMUCCO3}         {SMI: "[O]OC(=O)C1OC1C=CC=O" MCM}
BZEMUCCO3H      =  6C +  6H +  5O      ; {@BZEMUCCO3H}        {SMI: "OOC(=O)C1OC1C=CC=O" MCM}
BZEMUCO2        =  6C +  7H +  6O      ; {@BZEMUCO2}          {SMI: "O=CC(O)C(O[O])C1OC1C=O" MCM}
BZEMUCOOH       =  6C +  8H +  6O      ; {@BZEMUCOOH}         {SMI: "O=CC(O)C(OO)C1OC1C=O" MCM}
BZEPOXMUC       =  6C +  6H +  3O      ; {@BZEPOXMUC}         {SMI: "O=CC=CC1OC1C=O" MCM}
BZOBIPEROH      =  6C +  6H +  4O      ; {@BZOBIPEROH}        {SMI: "O=C1C=CC2OOC1C2O" MCM}
C5CO2DBCO3      =  6C +  5H +  5O      ; {@C5CO2DBCO3}        {SMI: "O=CC(=O)C=C(C)C(=O)O[O]" MCM}
C5CO2DCO3H      =  6C +  6H +  5O      ; {@C5CO2DCO3H}        {SMI: "O=CC(=O)C=C(C)C(=O)OO" MCM}
C5CO2OHCO3      =  6C +  5H +  6O      ; {@C5CO2OHCO3}        {SMI: "OC(C=O)C(=O)C=CC(=O)O[O]" MCM}
C5COOHCO3H      =  6C +  6H +  6O      ; {@C5COOHCO3H}        {SMI: "OC(C=O)C(=O)C=CC(=O)OO" MCM}
C6125CO         =  6C +  6H +  3O      ; {@C6125CO}           {SMI: "O=CC(=O)C=CC(=O)C" MCM: 2,5-dioxo-3-hexenal}
C615CO2O2       =  6C +  7H +  4O      ; {@C615CO2O2}         {SMI: "[O]OC(C=O)C=CC(=O)C" MCM}
C615CO2OOH      =  6C +  8H +  4O      ; {@C615CO2OOH}        {SMI: "OOC(C=O)C=CC(=O)C" MCM}
C6CO4DB         =  6C +  4H +  4O      ; {@C6CO4DB}           {SMI: "O=CC(=O)C=CC(=O)C=O" MCM}
C6H5O           =  6C +  5H +   O      ; {@C6H5O}             {SMI: "[O]c1ccccc1" MCM: phenyloxidanyl}
C6H5O2          =  6C +  5H +  2O      ; {@C6H5O2}            {SMI: "[O]Oc1ccccc1" MCM}
C6H5OOH         =  6C +  6H +  2O      ; {@C6H5OOH}           {SMI: "OOc1ccccc1" MCM: phenyl hydroperoxide}
CATEC1O         =  6C +  5H +  2O      ; {@CATEC1O}           {SMI: "[O]c1ccccc1O" MCM: 2-λ1-oxidanylphenol}
CATEC1O2        =  6C +  5H +  3O      ; {@CATEC1O2}          {SMI: "[O]Oc1ccccc1O" MCM}
CATEC1OOH       =  6C +  6H +  3O      ; {@CATEC1OOH}         {SMI: "OOc1ccccc1O" MCM}
CATECHOL        =  6C +  6H +  2O      ; {@CATECHOL}          {SMI: "Oc1ccccc1O" MCM: 1,2-dihydroxybenzene}
CPDKETENE       =  6C +  4H +   O      ; {@CPDKETENE}         {hv nitrophenol: cyclopentadiene ketene (Luc Vereecken's prediction)}
PBZQCO          =  6C +  4H +  4O      ; {@PBZQCO}            {SMI: "O=C1C=CC(=O)C(O)C1=O" MCM}
PBZQO2          =  6C +  5H +  5O      ; {@PBZQO2}            {SMI: "[O]OC1C(=O)C=CC(=O)C1O" MCM}
PBZQONE         =  6C +  4H +  2O      ; {@PBZQONE}           {SMI: "O=C1C=CC(=O)C=C1" MCM: 1,4-benzoquinone}
PBZQOOH         =  6C +  6H +  5O      ; {@PBZQOOH}           {SMI: "OOC1C(=O)C=CC(=O)C1O" MCM}
PHENO2          =  6C +  7H +  6O      ; {@PHENO2}            {SMI: "[O]OC1(O)C=CC2OOC1C2O" MCM}
PHENOL          =  6C +  6H +   O      ; {@PHENOL}            {SMI: "Oc1ccccc1" MCM}
PHENOOH         =  6C +  8H +  6O      ; {@PHENOOH}           {SMI: "OOC1(O)C=CC2OOC1C2O" MCM}
{6C (CHON)}
C614NO3         =  6C +  9H +  6O +  N ; {@C614NO3}           {SMI: "OCC(ON(=O)=O)CC(=O)C(=O)C" MCM}
{C6 (CHON) aromatics}
BZBIPERNO3      =  6C +  7H +  6O +  N ; {@BZBIPERNO3}        {SMI: "O=N(=O)OC1C=CC2OOC1C2O" MCM}
BZEMUCNO3       =  6C +  7H +  7O +  N ; {@BZEMUCNO3}         {SMI: "O=CC1OC1C(ON(=O)=O)C(O)C=O" MCM}
BZEMUCPAN       =  6C +  5H +  7O +  N ; {@BZEMUCPAN}         {SMI: "O=CC=CC1OC1C(=O)OON(=O)=O" MCM}
C5CO2DBPAN      =  6C +  5H +  7O +  N ; {@C5CO2DBPAN}        {SMI: "O=CC(=O)C=C(C)C(=O)OON(=O)=O" MCM}
C5CO2OHPAN      =  6C +  5H +  8O +  N ; {@C5CO2OHPAN}        {SMI: "O=CC(O)C(=O)C=CC(=O)OON(=O)=O" MCM}
DNPHEN          =  6C +  4H +  5O + 2N ; {@DNPHEN}            {SMI: "O=N(=O)c1ccc(O)c(c1)N(=O)=O" MCM: 2,4-dinitrophenol}
DNPHENO2        =  6C +  5H + 10O + 2N ; {@DNPHENO2}          {SMI: "[O]OC1(O)C(=CC2(OOC1C2O)N(=O)=O)N(=O)=O" MCM}
DNPHENOOH       =  6C +  6H + 10O + 2N ; {@DNPHENOOH}         {SMI: "OOC1(O)C(=CC2(OOC1C2O)N(=O)=O)N(=O)=O" MCM}
HOC6H4NO2       =  6C +  5H +  3O +  N ; {@HOC6H4NO2}         {SMI: "O=N(=O)c1ccccc1O" MCM: 2-nitrophenol}
NBZQO2          =  6C +  4H +  7O +  N ; {@NBZQO2}            {SMI: "[O]OC1C(=O)C=CC(=O)C1ON(=O)=O" MCM}
NBZQOOH         =  6C +  5H +  7O +  N ; {@NBZQOOH}           {SMI: "OOC1C(=O)C=CC(=O)C1ON(=O)=O" MCM}
NCATECHOL       =  6C +  5H +  4O +  N ; {@NCATECHOL}         {SMI: "O=N(=O)c1ccc(O)c(O)c1" MCM}
NCATECO2        =  6C +  6H +  9O +  N ; {@NCATECO2}          {SMI: "[O]OC1(O)C(=CC2(OOC1C2O)N(=O)=O)O" MCM}
NCATECOOH       =  6C +  7H +  9O +  N ; {@NCATECOOH}         {SMI: "OOC1(O)C(=CC2(OOC1C2O)N(=O)=O)O" MCM}
NCPDKETENE      =  6C +  3H +  3O +  N ; {@NCPDKETENE}        {hv nitrophenol: cyclopentadiene ketene (Luc Vereecken's prediction)}
NDNPHENO2       =  6C +  4H + 12O + 3N ; {@NDNPHENO2}         {SMI: "[O]OC1(O)C(=CC2(OOC1C2ON(=O)=O)N(=O)=O)N(=O)=O" MCM}
NDNPHENOOH      =  6C +  5H + 12O + 3N ; {@NDNPHENOOH}        {SMI: "OOC1(O)C(=CC2(OOC1C2ON(=O)=O)N(=O)=O)N(=O)=O" MCM}
NNCATECO2       =  6C +  5H + 11O + 2N ; {@NNCATECO2}         {SMI: "[O]OC1(O)C(=CC2(OOC1C2ON(=O)=O)N(=O)=O)O" MCM}
NNCATECOOH      =  6C +  6H + 11O + 2N ; {@NNCATECOOH}        {SMI: "OOC1(O)C(=CC2(OOC1C2ON(=O)=O)N(=O)=O)O" MCM}
NPHEN1O         =  6C +  4H +  3O +  N ; {@NPHEN1O}           {SMI: "O=N(=O)c1ccccc1[O]" MCM}
NPHEN1O2        =  6C +  4H +  4O +  N ; {@NPHEN1O2}          {SMI: "[O]Oc1ccccc1N(=O)=O" MCM}
NPHEN1OOH       =  6C +  5H +  4O +  N ; {@NPHEN1OOH}         {SMI: "OOc1ccccc1N(=O)=O" MCM}
NPHENO2         =  6C +  6H +  8O +  N ; {@NPHENO2}           {SMI: "[O]OC1(O)C=CC2OOC1C2ON(=O)=O" MCM}
NPHENOOH        =  6C +  7H +  8O +  N ; {@NPHENOOH}          {SMI: "OOC1(O)C=CC2OOC1C2ON(=O)=O" MCM}
{7C (CHO)}
C235C6CO3H      =  7C +  8H +  6O      ; {@C235C6CO3H}        {SMI: "OOC(=O)CC(=O)CC(=O)C(=O)C" MCM}
C716O2          =  7C +  9H +  5O      ; {@C716O2}            {SMI: "O=CCC(=O)CC(O[O])C(=O)C" MCM}
C716OOH         =  7C + 10H +  5O      ; {@C716OOH}           {SMI: "O=CCC(=O)CC(OO)C(=O)C" MCM}
C721O2          =  7C + 11H +  4O      ; {@C721O2}            {SMI: "[O]OC1CC(C(=O)O)C1(C)C" MCM}
C721OOH         =  7C + 12H +  4O      ; {@C721OOH}           {SMI: "OOC1CC(C(=O)O)C1(C)C" MCM}
C722O2          =  7C + 11H +  5O      ; {@C722O2}            {SMI: "O=CCC(C(=O)O)C(C)(C)O[O]" MCM}
C722OOH         =  7C + 12H +  5O      ; {@C722OOH}           {SMI: "O=CCC(C(=O)O)C(C)(C)OO" MCM}
CO235C6CHO      =  7C +  8H +  4O      ; {@CO235C6CHO}        {SMI: "O=CCC(=O)CC(=O)C(=O)C" MCM}
CO235C6CO3      =  7C +  7H +  6O      ; {@CO235C6CO3}        {SMI: "[O]OC(=O)CC(=O)CC(=O)C(=O)C" MCM}
MCPDKETENE      =  7C +  6H +  2O      ; {@MCPDKETENE}        {hv nitrophenol: cyclopentadiene ketene (Luc Vereecken's prediction)}
ROO6R3O         =  7C + 11H +  4O      ; {@ROO6R3O}           {from ref3019}
ROO6R3O2        =  7C + 11H +  5O      ; {@ROO6R3O2}          {ROO6R3OO from ref3019}
ROO6R5O2        =  7C + 11H +  7O      ; {@ROO6R5O2}          {ROO6R5OO from ref3019}
{C7 (CHO) aromatics}
BENZAL          =  7C +  6H +   O      ; {@BENZAL}            {SMI: "O=Cc1ccccc1" MCM}
C6CO2OHCO3      =  7C +  7H +  6O      ; {@C6CO2OHCO3}        {SMI: "CC(=CC(=O)O[O])C(=O)C(O)C=O" MCM}
C6COOHCO3H      =  7C +  8H +  6O      ; {@C6COOHCO3H}        {SMI: "CC(=CC(=O)OO)C(=O)C(O)C=O" MCM}
C6H5CH2O2       =  7C +  7H +  2O      ; {@C6H5CH2O2}         {SMI: "[O]OCc1ccccc1" MCM: benzyldioxidanyl}
C6H5CH2OOH      =  7C +  8H +  2O      ; {@C6H5CH2OOH}        {SMI: "OOCc1ccccc1" MCM: benzyl hydroperoxide}
C6H5CO3         =  7C +  5H +  3O      ; {@C6H5CO3}           {SMI: "[O]OC(=O)c1ccccc1" MCM}
C6H5CO3H        =  7C +  6H +  3O      ; {@C6H5CO3H}          {SMI: "OOC(=O)c1ccccc1" MCM: perbenzoic acid}
C7CO4DB         =  7C +  6H +  4O      ; {@C7CO4DB}           {SMI: "O=CC(=O)C=C(C)C(=O)C=O" MCM}
CRESO2          =  7C +  9H +  6O      ; {@CRESO2}            {SMI: "[O]OC1(O)C=CC2(C)OOC1C2O" MCM}
CRESOL          =  7C +  8H +   O      ; {@CRESOL}            {SMI: "Cc1ccccc1O" MCM: 2-methylphenol}
CRESOOH         =  7C + 10H +  6O      ; {@CRESOOH}           {SMI: "OOC1(O)C=CC2(C)OOC1C2O" MCM}
MCATEC1O        =  7C +  7H +  2O      ; {@MCATEC1O}          {SMI: "[O]c1c(C)cccc1O" MCM}
MCATEC1O2       =  7C +  7H +  3O      ; {@MCATEC1O2}         {SMI: "[O]Oc1c(C)cccc1O" MCM}
MCATEC1OOH      =  7C +  8H +  3O      ; {@MCATEC1OOH}        {SMI: "OOc1c(C)cccc1O" MCM}
MCATECHOL       =  7C +  8H +  2O      ; {@MCATECHOL}         {SMI: "Oc1c(C)cccc1O" MCM: 3-methylcatechol}
OXYL1O2         =  7C +  7H +  2O      ; {@OXYL1O2}           {SMI: "[O]Oc1ccccc1C" MCM: 1-methyl-2-(oxo-λ3-oxidanyl)benzene}
OXYL1OOH        =  7C +  8H +  2O      ; {@OXYL1OOH}          {SMI: "OOc1ccccc1C" MCM}
PHCOOH          =  7C +  6H +  2O      ; {@PHCOOH}            {SMI: "OC(=O)c1ccccc1" MCM: benzoic acid}
PTLQCO          =  7C +  6H +  4O      ; {@PTLQCO}            {SMI: "O=C1C(=CC(=O)C(=O)C1O)C" MCM}
PTLQO2          =  7C +  7H +  5O      ; {@PTLQO2}            {SMI: "[O]OC1C(=O)C=C(C)C(=O)C1O" MCM}
PTLQONE         =  7C +  6H +  2O      ; {@PTLQONE}           {SMI: "O=C1C=CC(=O)C(=C1)C" MCM: 2-methyl-1,4-benzoquinone}
PTLQOOH         =  7C +  8H +  5O      ; {@PTLQOOH}           {SMI: "OOC1C(=O)C=C(C)C(=O)C1O" MCM}
TLBIPERO2       =  7C +  9H +  5O      ; {@TLBIPERO2}         {SMI: "[O]OC1C=CC2(C)OOC1C2O" MCM}
TLBIPEROOH      =  7C + 10H +  5O      ; {@TLBIPEROOH}        {SMI: "OOC1C=CC2(C)OOC1C2O" MCM}
TLEMUCCO        =  7C +  8H +  5O      ; {@TLEMUCCO}          {SMI: "O=CC1OC1C(O)C(=O)C(=O)C" MCM}
TLEMUCCO2H      =  7C +  8H +  4O      ; {@TLEMUCCO2H}        {SMI: "CC(=O)C=CC1OC1C(=O)O" MCM}
TLEMUCCO3       =  7C +  7H +  5O      ; {@TLEMUCCO3}         {SMI: "CC(=O)C=CC1OC1C(=O)O[O]" MCM}
TLEMUCCO3H      =  7C +  8H +  5O      ; {@TLEMUCCO3H}        {SMI: "CC(=O)C=CC1OC1C(=O)OO" MCM}
TLEMUCO2        =  7C +  9H +  6O      ; {@TLEMUCO2}          {SMI: "[O]OC(C(=O)C)C(O)C1OC1C=O" MCM}
TLEMUCOOH       =  7C + 10H +  6O      ; {@TLEMUCOOH}         {SMI: "OOC(C(=O)C)C(O)C1OC1C=O" MCM}
TLEPOXMUC       =  7C +  8H +  3O      ; {@TLEPOXMUC}         {SMI: "O=CC1OC1C=CC(=O)C" MCM}
TLOBIPEROH      =  7C +  8H +  4O      ; {@TLOBIPEROH}        {SMI: "O=C1C=CC2(C)OOC1C2O" MCM}
TOL1O           =  7C +  7H +   O      ; {@TOL1O}             {SMI: "Cc1ccccc1[O]" MCM: (2-methylphenyl)oxidanyl}
TOLUENE         =  7C +  8H            ; {@TOLUENE}           {SMI: "Cc1ccccc1" MCM}
{7C (CHON)}
C7PAN3          =  7C +  7H +  8O +  N ; {@C7PAN3}            {SMI: "O=C(OON(=O)=O)CC(=O)CC(=O)C(=O)C" MCM}
{C7 (CHON) aromatics}
C6CO2OHPAN      =  7C +  7H +  8O +  N ; {@C6CO2OHPAN}        {SMI: "O=CC(O)C(=O)C(=CC(=O)OON(=O)=O)C" MCM}
C6H5CH2NO3      =  7C +  7H +  3O +  N ; {@C6H5CH2NO3}        {SMI: "O=N(=O)OCc1ccccc1" MCM: benzyl nitrate}
DNCRES          =  7C +  6H +  5O + 2N ; {@DNCRES}            {SMI: "O=N(=O)c1cc(C)c(O)c(c1)N(=O)=O" MCM: 2-methyl-4,6-dinitrophenol}
DNCRESO2        =  7C +  7H + 10O + 2N ; {@DNCRESO2}          {SMI: "[O]OC1(O)C(=CC2(OOC1(C)C2O)N(=O)=O)N(=O)=O" MCM}
DNCRESOOH       =  7C +  8H + 10O + 2N ; {@DNCRESOOH}         {SMI: "OOC1(O)C(=CC2(OOC1(C)C2O)N(=O)=O)N(=O)=O" MCM}
MNCATECH        =  7C +  7H +  4O +  N ; {@MNCATECH}          {SMI: "O=N(=O)c1ccc(C)c(O)c1O" MCM: 3-methyl-6-nitro-1,2-benzenediol}
MNCATECO2       =  7C +  8H +  9O +  N ; {@MNCATECO2}         {SMI: "[O]OC1(O)C(=C(N(=O)=O)C2OOC1(C)C2O)O" MCM}
MNCATECOOH      =  7C +  9H +  9O +  N ; {@MNCATECOOH}        {SMI: "OOC1(O)C(=C(N(=O)=O)C2OOC1(C)C2O)O" MCM}
MNCPDKETENE     =  7C +  5H +  3O +  N ; {@MNCPDKETENE}       {hv nitrophenol: cyclopentadiene ketene (Luc Vereecken's prediction)}
MNNCATCOOH      =  7C +  8H + 11O + 2N ; {@MNNCATCOOH}        {SMI: "OOC1(O)C(=C(N(=O)=O)C2OOC1(C)C2ON(=O)=O)O" MCM}
MNNCATECO2      =  7C +  7H + 11O + 2N ; {@MNNCATECO2}        {SMI: "[O]OC1(O)C(=C(N(=O)=O)C2OOC1(C)C2ON(=O)=O)O" MCM}
NCRES1O         =  7C +  6H +  3O +  N ; {@NCRES1O}           {SMI: "O=N(=O)c1cccc(C)c1[O]" MCM}
NCRES1O2        =  7C +  6H +  4O +  N ; {@NCRES1O2}          {SMI: "[O]Oc1c(C)cccc1N(=O)=O" MCM}
NCRES1OOH       =  7C +  7H +  4O +  N ; {@NCRES1OOH}         {SMI: "OOc1c(C)cccc1N(=O)=O" MCM}
NCRESO2         =  7C +  8H +  8O +  N ; {@NCRESO2}           {SMI: "[O]OC1(O)C=CC2(C)OOC1C2ON(=O)=O" MCM}
NCRESOOH        =  7C +  9H +  8O +  N ; {@NCRESOOH}          {SMI: "OOC1(O)C=CC2(C)OOC1C2ON(=O)=O" MCM}
NDNCRESO2       =  7C +  6H + 12O + 3N ; {@NDNCRESO2}         {SMI: "[O]OC1(O)C(=CC2(OOC1(C)C2ON(=O)=O)N(=O)=O)N(=O)=O" MCM}
NDNCRESOOH      =  7C +  7H + 12O + 3N ; {@NDNCRESOOH}        {SMI: "OOC1(O)C(=CC2(OOC1(C)C2ON(=O)=O)N(=O)=O)N(=O)=O" MCM}
NPTLQO2         =  7C +  6H +  7O +  N ; {@NPTLQO2}           {SMI: "[O]OC1C(=O)C=C(C)C(=O)C1ON(=O)=O" MCM}
NPTLQOOH        =  7C +  7H +  7O +  N ; {@NPTLQOOH}          {SMI: "OOC1C(=O)C=C(C)C(=O)C1ON(=O)=O" MCM}
PBZN            =  7C +  5H +  5O +  N ; {@PBZN}              {SMI: "O=N(=O)OOC(=O)c1ccccc1" MCM: benzoyl nitro peroxide}
TLBIPERNO3      =  7C +  9H +  6O +  N ; {@TLBIPERNO3}        {SMI: "O=N(=O)OC1C=CC2(C)OOC1C2O" MCM}
TLEMUCNO3       =  7C +  9H +  7O +  N ; {@TLEMUCNO3}         {SMI: "O=CC1OC1C(O)C(ON(=O)=O)C(=O)C" MCM}
TLEMUCPAN       =  7C +  7H +  7O +  N ; {@TLEMUCPAN}         {SMI: "O=N(=O)OOC(=O)C1OC1C=CC(=O)C" MCM}
TOL1OHNO2       =  7C +  7H +  3O +  N ; {@TOL1OHNO2}         {SMI: "O=N(=O)c1cccc(C)c1O" MCM: 2-methyl-6-nitrophenol}
{8C (CHO)}
C721CHO         =  8C + 12H +  3O      ; {@C721CHO}           {SMI: "O=CC1CC(C(=O)O)C1(C)C" MCM}
C721CO3         =  8C + 11H +  5O      ; {@C721CO3}           {SMI: "[O]OC(=O)C1CC(C(=O)O)C1(C)C" MCM}
C721CO3H        =  8C + 12H +  5O      ; {@C721CO3H}          {SMI: "OOC(=O)C1CC(C(=O)O)C1(C)C" MCM}
C810O2          =  8C + 13H +  4O      ; {@C810O2}            {SMI: "O=CCC(CC=O)C(C)(C)O[O]" MCM}
C810OOH         =  8C + 14H +  4O      ; {@C810OOH}           {SMI: "O=CCC(CC=O)C(C)(C)OO" MCM}
C811O2          =  8C + 13H +  4O      ; {@C811O2}            {SMI: "[O]OCC1CC(C(=O)O)C1(C)C" MCM}
C812O2          =  8C + 13H +  5O      ; {@C812O2}            {SMI: "OCC1CC(O[O])(C(=O)O)C1(C)C" MCM}
C812OOH         =  8C + 14H +  5O      ; {@C812OOH}           {SMI: "OCC1CC(OO)(C(=O)O)C1(C)C" MCM}
C813O2          =  8C + 13H +  6O      ; {@C813O2}            {SMI: "OCC(CC(=O)C(=O)O)C(C)(C)O[O]" MCM}
C813OOH         =  8C + 14H +  6O      ; {@C813OOH}           {SMI: "OCC(CC(=O)C(=O)O)C(C)(C)OO" MCM}
C85O2           =  8C + 13H +  3O      ; {@C85O2}             {SMI: "[O]OC1CC(C(=O)C)C1(C)C" MCM}
C85OOH          =  8C + 14H +  3O      ; {@C85OOH}            {SMI: "OOC1CC(C(=O)C)C1(C)C" MCM}
C86O2           =  8C + 13H +  4O      ; {@C86O2}             {SMI: "O=CCC(C(=O)C)C(C)(C)O[O]" MCM}
C86OOH          =  8C + 14H +  4O      ; {@C86OOH}            {SMI: "O=CCC(C(=O)C)C(C)(C)OO" MCM}
C89O2           =  8C + 13H +  3O      ; {@C89O2}             {SMI: "O=CCC1CC(O[O])C1(C)C" MCM}
C89OOH          =  8C + 14H +  3O      ; {@C89OOH}            {SMI: "O=CCC1CC(OO)C1(C)C" MCM}
C8BC            =  8C + 14H            ; {@C8BC}              {SMI: "CC1(C)C2CCC1C2" MCM}
C8BCCO          =  8C + 12H +  O       ; {@C8BCCO}            {SMI: "O=C1CC2CC1C2(C)C" MCM}
C8BCO2          =  8C + 13H +  2O      ; {@C8BCO2}            {SMI: "[O]OC1CC2CC1C2(C)C" MCM}
C8BCOOH         =  8C + 14H +  2O      ; {@C8BCOOH}           {SMI: "OOC1CC2CC1C2(C)C" MCM}
NORPINIC        =  8C + 12H +  4O      ; {@NORPINIC}          {SMI: "OC(=O)C1CC(C(=O)O)C1(C)C" MCM}
{C8 (CHO) aromatics}
EBENZ           =  8C + 10H            ; {@EBENZ}             {SMI: "CCc1ccccc1" MCM: ethylbenzene}
STYRENE         =  8C +  8H            ; {@STYRENE}           {SMI: "C=Cc1ccccc1" MCM}
STYRENO2        =  8C +  9H +  3O      ; {@STYRENO2}          {SMI: "[O]OCC(O)c1ccccc1" MCM}
STYRENOOH       =  8C + 10H +  3O      ; {@STYRENOOH}         {SMI: "OOCC(O)c1ccccc1" MCM}
{8C (CHON)}
C721PAN         =  8C + 11H +  7O +  N ; {@C721PAN}           {SMI: "O=N(=O)OOC(=O)C1CC(C(=O)O)C1(C)C" MCM}
C810NO3         =  8C + 13H +  5O +  N ; {@C810NO3}           {SMI: "O=CCC(CC=O)C(C)(C)ON(=O)=O" MCM}
C89NO3          =  8C + 13H +  4O +  N ; {@C89NO3}            {SMI: "O=CCC1CC(ON(=O)=O)C1(C)C" MCM}
C8BCNO3         =  8C + 13H +  3O +  N ; {@C8BCNO3}           {SMI: "O=N(=O)OC1CC2CC1C2(C)C" MCM}
{C8 (CHON) aromatics}
NSTYRENO2       =  8C +  8H +  5O +  N ; {@NSTYRENO2}         {SMI: "[O]OC(CON(=O)=O)c1ccccc1" MCM}
NSTYRENOOH      =  8C +  9H +  5O +  N ; {@NSTYRENOOH}        {SMI: "OOC(CON(=O)=O)c1ccccc1" MCM}
{C8 aromatics (lumped)}
LXYL            =  8C + 10H            ; {@LXYL}              {xylenes}
{9C (CHO)}
C811CO3         =  9C + 13H +  5O      ; {@C811CO3}           {SMI: "[O]OC(=O)CC1CC(C(=O)O)C1(C)C" MCM}
C811CO3H        =  9C + 14H +  5O      ; {@C811CO3H}          {SMI: "OOC(=O)CC1CC(C(=O)O)C1(C)C" MCM}
C85CO3          =  9C + 13H +  4O      ; {@C85CO3}            {SMI: "[O]OC(=O)C1CC(C(=O)C)C1(C)C" MCM}
C85CO3H         =  9C + 14H +  4O      ; {@C85CO3H}           {SMI: "OOC(=O)C1CC(C(=O)C)C1(C)C" MCM}
C89CO2H         =  9C + 14H +  3O      ; {@C89CO2H}           {SMI: "O=CCC1CC(C(=O)O)C1(C)C" MCM}
C89CO3          =  9C + 13H +  4O      ; {@C89CO3}            {SMI: "O=CCC1CC(C(=O)O[O])C1(C)C" MCM}
C89CO3H         =  9C + 14H +  4O      ; {@C89CO3H}           {SMI: "O=CCC1CC(C(=O)OO)C1(C)C" MCM}
C96O2           =  9C + 15H +  3O      ; {@C96O2}             {SMI: "[O]OCC1CC(C(=O)C)C1(C)C" MCM}
C96OOH          =  9C + 16H +  3O      ; {@C96OOH}            {SMI: "OOCC1CC(C(=O)C)C1(C)C" MCM}
C97O2           =  9C + 15H +  4O      ; {@C97O2}             {SMI: "OCC1CC(O[O])(C(=O)C)C1(C)C" MCM}
C97OOH          =  9C + 16H +  4O      ; {@C97OOH}            {SMI: "OCC1CC(OO)(C(=O)C)C1(C)C" MCM}
C98O2           =  9C + 15H +  5O      ; {@C98O2}             {SMI: "OCC(CC(=O)C(=O)C)C(C)(C)O[O]" MCM}
C98OOH          =  9C + 16H +  5O      ; {@C98OOH}            {SMI: "OCC(CC(=O)C(=O)C)C(C)(C)OO" MCM}
NOPINDCO        =  9C + 12H +  2O      ; {@NOPINDCO}          {SMI: "O=C1CC2CC(C1=O)C2(C)C" MCM}
NOPINDO2        =  9C + 13H +  3O      ; {@NOPINDO2}          {SMI: "[O]OC1CC2CC(C1=O)C2(C)C" MCM}
NOPINDOOH       =  9C + 14H +  3O      ; {@NOPINDOOH}         {SMI: "OOC1CC2CC(C1=O)C2(C)C" MCM}
NOPINONE        =  9C + 14H +   O      ; {@NOPINONE}          {SMI: "O=C1CCC2CC1C2(C)C" MCM}
NOPINOO         =  9C + 14H +  2O      ; {@NOPINOO}           {SMI: "[O-][O+]=C1CCC2CC1C2(C)C" MCM}
NORPINAL        =  9C + 14H +  2O      ; {@NORPINAL}          {SMI: "O=CC1CC(C(=O)C)C1(C)C" MCM: norpinaldehyde}
NORPINENOL      =  9C + 14H +  2O      ; {@NORPINENOL}        {}
PINIC           =  9C + 14H +  4O      ; {@PINIC}             {SMI: "OC(=O)CC1CC(C(=O)O)C1(C)C" MCM: pinic acid}
{9C (CHON)}
C811PAN         =  9C + 13H +  7O +  N ; {@C811PAN}           {SMI: "O=N(=O)OOC(=O)CC1CC(C(=O)O)C1(C)C" MCM}
C89PAN          =  9C + 13H +  6O +  N ; {@C89PAN}            {SMI: "O=CCC1CC(C(=O)OON(=O)=O)C1(C)C" MCM}
C96NO3          =  9C + 15H +  4O +  N ; {@C96NO3}            {SMI: "O=N(=O)OCC1CC(C(=O)C)C1(C)C" MCM}
C9PAN2          =  9C + 13H +  6O +  N ; {@C9PAN2}            {SMI: "O=N(=O)OOC(=O)C1CC(C(=O)C)C1(C)C" MCM}
{C9 aromatics (lumped)}
LTMB            =  9C + 12H            ; {@LTMB}              {trimethylbenzenes}
{10C (CHO)}
APINAOO         = 10C + 16H +  3O      ; {@APINAOO}           {stabilized APINOOA}
APINBOO         = 10C + 16H +  3O      ; {@APINBOO}           {SMI: "[O-][O+]=CCC1CC(C(=O)C)C1(C)C" MCM}
APINENE         = 10C + 16H            ; {@APINENE}           {SMI: "CC1=CCC2CC1C2(C)C" MCM: alpha pinene}
BPINAO2         = 10C + 17H +  3O      ; {@BPINAO2}           {SMI: "OCC1(O[O])CCC2CC1C2(C)C" MCM}
BPINAOOH        = 10C + 18H +  3O      ; {@BPINAOOH}          {SMI: "OCC1(OO)CCC2CC1C2(C)C" MCM}
BPINENE         = 10C + 16H            ; {@BPINENE}           {SMI: "C=C1CCC2CC1C2(C)C" MCM: beta pinene}
C106O2          = 10C + 15H +  5O      ; {@C106O2}            {SMI: "O=CCC(=O)CC(C(=O)C)C(C)(C)O[O]" MCM}
C106OOH         = 10C + 16H +  5O      ; {@C106OOH}           {SMI: "O=CCC(=O)CC(C(=O)C)C(C)(C)OO" MCM}
C109CO          = 10C + 14H +  3O      ; {@C109CO}            {SMI: "O=CCC1CC(C(=O)C=O)C1(C)C" MCM}
C109O2          = 10C + 15H +  4O      ; {@C109O2}            {SMI: "[O]OCC(=O)C1CC(CC=O)C1(C)C" MCM}
C109OOH         = 10C + 16H +  4O      ; {@C109OOH}           {SMI: "OOCC(=O)C1CC(CC=O)C1(C)C" MCM}
C96CO3          = 10C + 15H +  4O      ; {@C96CO3}            {SMI: "[O]OC(=O)CC1CC(C(=O)C)C1(C)C" MCM}
CAMPHENE        = 10C + 16H            ; {@CAMPHENE}          {}
CARENE          = 10C + 16H            ; {@CARENE}            {3-carene}
MENTHEN6ONE     = 10C + 16H +  3O      ; {@MENTHEN6ONE}       {8-OOH-menthen-6-one, Taraborrelli, pers. comm.}
OH2MENTHEN6ONE  = 10C + 17H +  4O      ; {@2OHMENTHEN6ONE}    {2-OH-8-OOH-menthen-6-one, Taraborrelli, pers. comm.}
OHMENTHEN6ONEO2 = 10C + 17H +  5O      ; {@OHMENTHEN6ONEO2}   {2-OH-8-OOH_menthen-6-peroxy radical, Taraborrelli, pers. comm.}
PERPINONIC      = 10C + 16H +  4O      ; {@PERPINONIC}        {SMI: "OOC(=O)CC1CC(C(=O)C)C1(C)C" MCM}
PINAL           = 10C + 16H +  2O      ; {@PINAL}             {SMI: "O=CCC1CC(C(=O)C)C1(C)C" MCM: pinonaldehyde}
PINALO2         = 10C + 15H +  4O      ; {@PINALO2}           {SMI: "O=CCC1(O[O])CC(C(=O)C)C1(C)C" MCM}
PINALOOH        = 10C + 16H +  4O      ; {@PINALOOH}          {SMI: "O=CCC1(OO)CC(C(=O)C)C1(C)C" MCM}
PINENOL         = 10C + 16H +  2O      ; {@PINEOL}            {}
PINONIC         = 10C + 16H +  3O      ; {@PINONIC}           {SMI: "OC(=O)CC1CC(C(=O)C)C1(C)C" MCM: pinonic acid}
RO6R1O2         = 10C + 17H +  4O      ; {@RO6R1O2}           {cyclo-oxy peroxy radical from BPINENE, ref3019}
RO6R3O2         = 10C + 17H +  5O      ; {@RO6R3O2}           {cyclo-oxy peroxy radical from BPINENE, ref3019}
ROO6R1O2        = 10C + 17H +  5O      ; {@ROO6R1O2}          {cyclo-peroxy peroxy radical from BPINENE based on ROO6R1 from ref3019}
SABINENE        = 10C + 16H            ; {@SABINENE}          {}
{10C (CHON)}
BPINANO3        = 10C + 17H +  4O +  N ; {@BPINANO3}          {SMI: "OCC1(CCC2CC1C2(C)C)ON(=O)=O" MCM}
C106NO3         = 10C + 15H +  6O +  N ; {@C106NO3}           {SMI: "O=CCC(=O)CC(C(=O)C)C(C)(C)ON(=O)=O" MCM}
C10PAN2         = 10C + 15H +  6O +  N ; {@C10PAN2}           {SMI: "O=N(=O)OOC(=O)CC1CC(C(=O)C)C1(C)C" MCM}
PINALNO3        = 10C + 15H +  5O +  N ; {@PINALNO3}          {SMI: "O=CCC1(ON(=O)=O)CC(C(=O)C)C1(C)C" MCM}
RO6R1NO3        = 10C + 17H +  5O +  N ; {@RO6R1NO3}          {nitrate from cyclo-oxy peroxy radical from BPINENE, ref3019}
ROO6R1NO3       = 10C + 17H +  6O +  N ; {@ROO6R1NO3}         {nitrate from cyclo-peroxy peroxy radical from BPINENE, ref3019}
{10C (lumped)}
LAPINABNO3      = 10C + 17H +  4O +  N ; {@LAPINABNO3}        {APINANO3 + APINBNO3 lumped (ratio 1:2)}
LAPINABO2       = 10C + 17H +  3O      ; {@LAPINABO2}         {APINAO2 + APINBO2 lumped (ratio 1:2)}
LAPINABOOH      = 10C + 18H +  3O      ; {@LAPINABOOH}        {APINAOOH + APINBOOH lumped (ratio 1:2)}
LNAPINABO2      = 10C + 16H +  5O +  N ; {@LNAPINABO2}        {.65 NAPINAO2 + .35 NAPINBO2}
LNAPINABOOH     = 10C + 17H +  5O +  N ; {@LNAPINABOOH}       {.65 NAPINAOOH + .35 NAPINBOOH}
LNBPINABO2      = 10C + 16H +  5O +  N ; {@LNBPINABO2}        {.8 NBPINAO2 + .2 NBPINBO2}
LNBPINABOOH     = 10C + 17H +  5O +  N ; {@LNBPINABOOH}       {.8 NBPINAO2 + .2 NBPINBO2}
{C10 aromatics (lumped)}
LHAROM          = 11C + 14H            ; {@LHAROM}            {higher aromatics: model compound DIET35TOL(from MCM)}
{------------------------------------- F ------------------------------------}

LFLUORINE       =            F         ; {@LFLUORINE}         {lumped F species}
CHF3            =  C +  H + 3F         ; {@CHF_3}             {trifluoromethane, fluoroform = HFC-23}
CHF2CF3         = 2C +  H + 5F         ; {@CHF_2CF_3}         {pentafluoroethane = HFC-125}
CH3CF3          = 2C + 3H + 3F         ; {@CH_3CF_3}          {1,1,1-trifluoroethane = HFC-143a}
CH2F2           =  C + 2H + 2F         ; {@CH_2F_2}           {difluoromethane = HFC-32}
CH3CHF2         = 2C + 4H + 2F         ; {@CH_3CHF_2}         {1,1-difluoroethane = HFC-152a}
{------------------------------------- Cl -----------------------------------}

CCl4            =  C                    + 4Cl ; {@CCl_4}             {tetrachloro methane}
CF2Cl2          =  C               + 2F + 2Cl ; {@CF_2Cl_2}          {dichlorodifluoromethane = F12}
CF2ClCF2Cl      = 2C               + 4F + 2Cl ; {@CF_2ClCF_2Cl}      {1,1,2,2-tetrafluoro-1,2-dichloroethane = CFC-114}
CF2ClCFCl2      = 2C               + 3F + 3Cl ; {@CF_2ClCFCl_2}      {1,1,2-trifluoro-1,2,2-trichloroethane = CFC-113}
CF3CF2Cl        = 2C               + 5F +  Cl ; {@CF_3CF_2Cl}        {pentafluorochloroethane = CFC-115}
CFCl3           =  C               +  F + 3Cl ; {@CFCl_3}            {trichlorofluoromethane = F11}
CH2Cl2          =  C + 2H               + 2Cl ; {@CH_2Cl_2}          {SMI: "ClCCl" MCM: dichloromethane}
CH2FCF3         = 2C + 2H          + 4F       ; {@CH_2FCF_3}         {1,1,1,2-tetrafluoroethane = HFC-134a}
CH3CCl3         = 2C + 3H               + 3Cl ; {@CH_3CCl_3}         {SMI: "CC(Cl)(Cl)Cl" MCM: 1,1,1-trichloroethane = methyl chloroform = MCF}
CH3CFCl2        = 2C + 3H          +  F + 2Cl ; {@CH_3CFCl_2}        {1,1,1-fluorodichloroethane = HCFC-141b}
CH3Cl           =  C + 3H               +  Cl ; {@CH_3Cl}            {SMI: "CCl" MCM: chloromethane}
CHCl3           =  C +  H               + 3Cl ; {@CHCl_3}            {SMI: "ClC(Cl)Cl" MCM: trichloromethane = chloroform}
CHF2Cl          =  C +  H          + 2F +  Cl ; {@CHF_2Cl}           {difluorochloromethane = HCFC-22}
Cl              =                          Cl ; {@Cl}                {chlorine atom}
Cl2             =                         2Cl ; {@Cl_2}              {chlorine}
Cl2O2           =           2O          + 2Cl ; {@Cl_2O_2}           {dichlorine dioxide}
ClNO2           =           2O + N      +  Cl ; {@ClNO_2}            {nitryl chloride}
ClNO3           =           3O + N      +  Cl ; {@ClNO_3}            {chlorine nitrate}
ClO             =            O          +  Cl ; {@ClO}               {chlorine oxide}
HCl             =       H               +  Cl ; {@HCl}               {hydrochloric acid}
HOCl            =       H +  O          +  Cl ; {@HOCl}              {hypochlorous acid}
OClO            =           2O          +  Cl ; {@OClO}              {chlorine dioxide}
LCHLORINE       =                          Cl ; {@LCHLORINE}         {lumped Cl species}

{------------------------------------- Br -----------------------------------}

Br              =                               Br ; {@Br}                {bromine atom}
Br2             =                              2Br ; {@Br_2}              {bromine}
BrCl            =                         Cl +  Br ; {@BrCl}              {bromine chloride}
BrNO2           =          2O + N            +  Br ; {@BrNO_2}            {nitryl bromide}
BrNO3           =          3O + N            +  Br ; {@BrNO_3}            {bromine nitrate}
BrO             =           O                +  Br ; {@BrO}               {bromine oxide}
CF2ClBr         = C               + 2F +  Cl +  Br ; {@CF_2ClBr}          {Halon 1211}
CF3Br           = C               + 3F       +  Br ; {@CF_3Br}            {Halon 1301}
CH2Br2          = C + 2H                     + 2Br ; {@CH_2Br_2}          {}
CH2ClBr         = C + 2H               +  Cl +  Br ; {@CH_2ClBr}          {}
CH3Br           = C + 3H                     +  Br ; {@CH_3Br}            {SMI: "CBr" MCM: bromomethane}
CHBr3           = C +  H                     + 3Br ; {@CHBr_3}            {}
CHCl2Br         = C +  H               + 2Cl +  Br ; {@CHCl_2Br}          {}
CHClBr2         = C +  H               +  Cl + 2Br ; {@CHClBr_2}          {}
HBr             =      H                     +  Br ; {@HBr}               {hydrobromic acid}
HOBr            =      H +  O                +  Br ; {@HOBr}              {hypobromous acid}
LBROMINE        =                               Br ; {@LBROMINE}          {lumped Br species}

{------------------------------------- I ------------------------------------}

C3H7I           = 3C + 7H                    +  I ; {@CH_3CHICH_3}       {2-iodopropane}
CH2ClI          =  C + 2H          + Cl      +  I ; {@CH_2ClI}           {chloroiodomethane}
CH2I2           =  C + 2H                    + 2I ; {@CH_2I_2}           {diiodomethane}
CH3I            =  C + 3H                    +  I ; {@CH_3I}             {iodomethane}
HI              =       H                    +  I ; {@HI}                {hydrogen iodide}
HIO3            =       H + 3O               +  I ; {@HIO_3}             {}
HOI             =       H +  O               +  I ; {@HOI}               {hypoiodous acid}
I               =                               I ; {@I}                 {iodine atomic ground state}
I2              =                              2I ; {@I_2}               {molecular iodine}
I2O2            =           2O               + 2I ; {@I_2O_2}            {}
IBr             =                         Br +  I ; {@IBr}               {iodine bromide}
ICl             =                    Cl +       I ; {@ICl}               {iodine chloride}
INO2            =           2O + N           +  I ; {@INO_2}             {iodine nitrite}
INO3            =           3O + N           +  I ; {@INO_3}             {iodine nitrate}
IO              =            O               +  I ; {@IO}                {iodine monoxide radical}
IPART           =                              2I ; {@I(part)}           {iodine particles}
OIO             =           2O               +  I ; {@OIO}               {}

{------------------------------------- S ------------------------------------}

CH3SO2          =  C + 3H + 2O    + S ; {@CH_3SO_2}          {SMI: "C[S](=O)=O" MCM}
CH3SO3          =  C + 3H + 3O    + S ; {@CH_3SO_3}          {SMI: "CS(=O)(=O)[O]" MCM}
CH3SO3H         =  C + 4H + 3O    + S ; {@CH_3SO_3H}         {MSA: methane sulfonic acid}
DMS             = 2C + 6H         + S ; {@DMS}               {SMI: "CSC" MCM: dimethyl sulfide}
DMSO            = 2C + 6H +  O    + S ; {@DMSO}              {SMI: "CS(=O)C" MCM: dimethyl sulfoxide: CH3SOCH3}
H2SO4           =      2H + 4O    + S ; {@H_2SO_4}           {sulfuric acid}
OCS             =  C      +  O    + S ; {@OCS}               {}
S               =                   S ; {@S}                 {sulfur atomic ground state}
SF6             =              6F + S ; {@SF_6}              {sulfur hexaflouride}
SH              =       H         + S ; {@SH}                {}
SO              =            O    + S ; {@SO}                {sulfur monoxide}
SO2             =           2O    + S ; {@SO_2}              {sulfur dioxide}
SO3             =           3O    + S ; {@SO_3}              {sulfur trioxide}
LSULFUR         =                   S ; {@LSULFUR}           {lumped S species}

{--------------------------------- Hg ---------------------------------------}

Hg              = Hg                   ; {@Hg}                {}
HgO             = Hg + O               ; {@HgO}               {}
HgCl            = Hg + Cl              ; {@HgCl}              {}
HgCl2           = Hg + 2Cl             ; {@HgCl_2}            {}
HgBr            = Hg + Br              ; {@HgBr}              {}
HgBr2           = Hg + 2Br             ; {@HgBr_2}            {}
ClHgBr          = Hg + Cl + Br         ; {@ClHgBr}            {}
BrHgOBr         = Hg + O + 2Br         ; {@BrHgOBr}           {}
ClHgOBr         = Hg + O + Cl + Br     ; {@ClHgOBr}           {}

{------------------------------- Dummies ------------------------------------}

Dummy           = IGNORE               ; {@Dummy}
PRODUCTS        = IGNORE               ; {@PRODUCTS}
M               = IGNORE               ; {@M}

{--- mz_pj_20070209+}
{------------------------- Pseudo Aerosol -----------------------------------}
NO3m_cs         = N + 3O               ; {@NO_3^-(cs)}        {}
Hp_cs           = H                    ; {@H^+(cs)}           {}
RGM_cs          = Hg                   ; {@Hg(cs)}            {from reactive gaseous Hg}
{--- mz_pj_20070209-}

{ mz_pj_20070621+}
{------------------------- O3 Budget Tracers (via eval2.3.rpl) --------------}
O3s             = 3O                   ; {@O_3(s)}            {strat. ozone}
LO3s            = IGNORE               ; {@LO_3(s)}           {lost strat. ozone}
{ mz_pj_20070621-}

{ mz_rs_20100227+}
{only for MIM1, not used in MIM2:}
ISO2            = 5C + 9H + 3O         ; {@ISO2}              {isoprene (hydroxy) peroxy radicals}
ISON            = 5C +           N     ; {@ISON}              {organic nitrates from ISO2 and C5H8+NO3}
ISOOH           = 5C + 10H + 3O        ; {@ISOOH}             {isoprene (hydro) peroxides}
LHOC3H6O2       = 3C + 7H + 3O         ; {@CH_3CH(O_2)CH_2OH} {hydroxyperoxyradical from propene+OH}
LHOC3H6OOH      = 3C + 8H + 3O         ; {@CH_3CH(OOH)CH_2OH} {C3H6OHOOH = hydroxyhydroperoxides from C3H6}
MVKO2           = 4C + 5H + 3O         ; {@MVKO2}             {SMI: "[O]OCC(=O)C=C" MCM: MVK/MACR peroxy radicals}
MVKOOH          = 4C + 6H + 3O         ; {@MVKOOH}            {SMI: "OOCC(=O)C=C" MCM: MVK hydroperoxides}
NACA            = 2C + 3H + 4O + N     ; {@NACA}              {nitro-oxy acetaldehyde}
{ mz_rs_20100227-}

{ mz_ab_20100908+}
{---------------------------------- ions ------------------------------------}
Op              =  O           + Pls   ; {@O^+}               {O+}
O2p             =  2O          + Pls   ; {@O_2^+}             {O2+}
Np              =  N           + Pls   ; {@N^+}               {N+}
N2p             =  2N          + Pls   ; {@N_2^+}             {N2+}
NOp             =  O + N       + Pls   ; {@NO^+}              {NO+}
em              =                Min   ; {@e^-}               {electron}
kJmol           =  IGNORE              ; {@kJ/mol}            {released energy}
{ mz_ab_20100908-}
{ ka_sv_20141119+, ka_tf_20160801+}
O4Sp            =  O           + Pls   ; {@O4S^+}             {O+}
O2Dp            =  O           + Pls   ; {@O2D^+}             {O+}
O2Pp            =  O           + Pls   ; {@O2P^+}             {O+}
{ ka_sv_20141119-, ka_tf_20160801-}

{ op_pj_20130723+}
{------------------------------ additional diagnostic tracers ----------------}
CFCl3_c         = C + F + 3Cl          ; {@(CFCl_3)_c}        {trichlorofluoromethane = F11}
CF2Cl2_c        = C + 2F + 2Cl         ; {@(CF_2Cl_2)_c}      {dichlorodifluoromethane = F12}
N2O_c           = O + 2N               ; {@(N_2O)_c}          {nitrous oxide}
CH3CCl3_c       = 2C + 3H + 3Cl        ; {@(CH_3CCl_3)_c}     {1,1,1-trichloroethane = methyl chloroform = MCF}
CF2ClBr_c       = Br + 2F + Cl + C     ; {@(CF_2ClBr)_c}      {Halon 1211}
CF3Br_c         = Br + 3F + C          ; {@(CF_3Br)_c}        {Halon 1301}
{ op_pj_20130723-}

{ mz_at_20131015+ needed for ORACLE.rpl}
{-----------------------Organic Condesable Gases and VOCs--------------------}
LTERP           =  IGNORE              ; {@LTERP}             {terpenes}
LALK4           =  IGNORE              ; {@LALK4}             {alkanes}
LALK5           =  IGNORE              ; {@LALK5}             {alkanes}
LARO1           =  IGNORE              ; {@LARO1}             {aromatic VOC}
LARO2           =  IGNORE              ; {@LARO2}             {aromatic VOC}
LOLE1           =  IGNORE              ; {@LOLE1}             {olefins}
LOLE2           =  IGNORE              ; {@LOLE2}             {olefins}
LfPOG02         =  IGNORE              ; {@LfPOG02}           {FF  condensable gas 2}
LfPOG03         =  IGNORE              ; {@LfPOG03}           {FF  condensable gas 3}
LfPOG04         =  IGNORE              ; {@LfPOG04}           {FF  condensable gas 4}
LfPOG05         =  IGNORE              ; {@LfPOG05}           {FF  condensable gas 5}
LbbPOG02        =  IGNORE              ; {@LbbPOG02}          {BB  condensable gas 2}
LbbPOG03        =  IGNORE              ; {@LbbPOG03}          {BB  condensable gas 3}
LbbPOG04        =  IGNORE              ; {@LbbPOG04}          {BB  condensable gas 4}
LfSOGsv01       =  IGNORE              ; {@LfSOGsv01}         {sFF condensable gas 1}
LfSOGsv02       =  IGNORE              ; {@LfSOGsv02}         {sFF condensable gas 2}
LbbSOGsv01      =  IGNORE              ; {@LbbSOGsv01}        {sBB condensable gas 1}
LbbSOGsv02      =  IGNORE              ; {@LbbSOGsv02}        {sBB condensable gas 2}
LfSOGiv01       =  IGNORE              ; {@LfSOGiv01}         {iFF condensable gas 1}
LfSOGiv02       =  IGNORE              ; {@LfSOGiv02}         {iFF condensable gas 2}
LfSOGiv03       =  IGNORE              ; {@LfSOGiv03}         {iFF condensable gas 3}
LfSOGiv04       =  IGNORE              ; {@LfSOGiv04}         {iFF condensable gas 4}
LbbSOGiv01      =  IGNORE              ; {@LbbSOGiv01}        {iBB condensable gas 1}
LbbSOGiv02      =  IGNORE              ; {@LbbSOGiv02}        {iBB condensable gas 2}
LbbSOGiv03      =  IGNORE              ; {@LbbSOGiv03}        {iBB condensable gas 3}
LbSOGv01        =  IGNORE              ; {@LbSOGv01}          {Bio condensable gas 1}
LbSOGv02        =  IGNORE              ; {@LbSOGv02}          {Bio condensable gas 2}
LbSOGv03        =  IGNORE              ; {@LbSOGv03}          {Bio condensable gas 3}
LbSOGv04        =  IGNORE              ; {@LbSOGv04}          {Bio condensable gas 4}
LbOSOGv01       =  IGNORE              ; {@LbOSOGv01}         {Bio condensable gas 1}
LbOSOGv02       =  IGNORE              ; {@LbOSOGv02}         {Bio condensable gas 2}
LbOSOGv03       =  IGNORE              ; {@LbOSOGv03}         {Bio condensable gas 3}
LaSOGv01        =  IGNORE              ; {@LaSOGv01}          {Ant condensable gas 1}
LaSOGv02        =  IGNORE              ; {@LaSOGv02}          {Ant condensable gas 2}
LaSOGv03        =  IGNORE              ; {@LaSOGv03}          {Ant condensable gas 3}
LaSOGv04        =  IGNORE              ; {@LaSOGv04}          {Ant condensable gas 4}
LaOSOGv01       =  IGNORE              ; {@LaOSOGv01}         {Ant condensable gas 1}
LaOSOGv02       =  IGNORE              ; {@LaOSOGv02}         {Ant condensable gas 2}
LaOSOGv03       =  IGNORE              ; {@LaOSOGv03}         {Ant condensable gas 3}
{ mz_at_20131015- needed for ORACLE.rpl}

{ mz_rs_20170601+ jam}
ACBZO2          =                     5H + 7C + 3O ; {@C_7H_5O_3}             {acyl peroxy radical from benzaldehyde}
ALKNO3          =               11H + 5C + 3O +  N ; {@C_5H_<11>NO_3}         {nitrate from BIGALKANE}
ALKO2           =                    11H + 5C + 2O ; {@C_5H_<11>O_2}          {peroxy radical from large alkanes}
ALKOH           =                    12H + 5C +  O ; {@C_5H_<12>O}            {alcohol from BIGALKANE}
ALKOOH          =                    12H + 5C + 2O ; {@C_5H_<12>O_2}          {peroxide from large alkanes}
BCARY           =                        24H + 15C ; {@C_<15>H_<24>}          {SMI: "C/C1=C/CCC(=C)C2CC(C)(C)C2CC\1" MCM: (1R,4E,9S)-4,11,11-trimethyl-8-methylidenebicyclo[7.2.0]undec-4-ene}
BENZO2          =                     7H + 6C + 5O ; {@C_6H_7O_5}             {peroxy radical from benzene}
BENZOOH         =                     8H + 6C + 5O ; {@C_6H_8O_5}             {peroxide from BENZO2}
BEPOMUC         =                     6H + 6C + 3O ; {@C_6H_6O_3}             {benzene eopoxy diol}
BIGALD1         =                     4H + 4C + 2O ; {@C_4H_4O_2}             {but-2-enedial}
BIGALD2         =                     6H + 5C + 2O ; {@C_5H_6O_2}             {4-oxopent-2-enal}
BIGALD3         =                     6H + 5C + 2O ; {@C_5H_6O_2}             {2-methylbut-2-enedial}
BIGALD4         =                     8H + 6C + 2O ; {@C_6H_8O_2}             {aldehyde from xylene oxidation}
BIGALKANE       =                         12H + 5C ; {@C_5H_<12>}             {large alkanes}
BIGENE          =                          8H + 4C ; {@C_4H_8}                {large alkenes}
BrONO           = IGNORE                           ; {@BrONO}
BZALD           =                     6H + 7C +  O ; {@C_7H_6O}               {benzaldehyde}
BZOO            =                     7H + 7C + 2O ; {@C_7H_7O_2}             {peroxy radical from toluene}
BZOOH           =                     8H + 7C + 2O ; {@C_7H_8O_2}             {peroxide from BZOO}
C3H7O2          =                     7H + 3C + 2O ; {@C_3H_7O_2}             {lumped peroxy radical from propane}
C3H7OOH         =                     8H + 3C + 2O ; {@C_3H_8O_2}             {lumped propyl hydro peroxide}
CFC113          =                    2C + 3F + 3Cl ; {@C_2F_3Cl_3}            {1,1,2-trichloro-1,2,2-trifluoroethane}
CFC114          =                    2C + 4F + 2Cl ; {@C_2F_4Cl_2}            {1,2-dichloro-1,1,2,2-tetrafluoro-ethane}
CFC115          =                    2C + 5F +  Cl ; {@C_2F_5Cl}              {1-chloro-1,1,2,2,2-pentafluoro-ethane}
COF2            =                      C +  O + 2F ; {@CF_2O}                 {carbonyl difluoride}
COFCL           =                C +  F +  O +  Cl ; {@CFClO}                 {carbonyl chloride fluoride}
DICARBO2        =                     5H + 5C + 4O ; {@C_5H_5O_4}             {dicarbonyl from photolysis of BIGALD2}
ELVOC           = IGNORE                           ; {@ELVOC}
ENEO2           =                     9H + 4C + 3O ; {@C_4H_9O_3}             {peroxy radical from BIGENE/OLTP}
EOOH            =                     6H + 2C + 3O ; {@C_2H_6O_3}             {2-hydroperoxyethanol}
F               =                                F ; {@F}                     {fluoride}
H1202           =                     C + 2Br + 2F ; {@CF_2Br_2}              {dibromo(difluoro)methane}
H2402           =                    2C + 2Br + 4F ; {@C_2F_4Br_2}            {1,2-dibromo-1,1,2,2-tetrafluoroethane}
HCFC141B        =               3H + 2C +  F + 2Cl ; {@C_2H_3FCl_2}           {1,1-dichloro-1-fluoroethane}
HCFC142B        =               3H + 2C + 2F +  Cl ; {@C_2H_3F_2Cl}           {1-chloro-1,1-difluoroethane}
HCFC22          =                H +  C + 2F +  Cl ; {@CHF_2Cl}               {chloro(difluoro)methane}
HF              =                           H +  F ; {@HF}                    {fluorane}
HOCH2OO         =                     3H +  C + 3O ; {@CH_3O_3}               {(hydroxymethyl)dioxidanyl}
HPALD           = IGNORE                           ; {@HPALD}
IEC1O2          =                     9H + 5C + 5O ; {@C_5H_9O_5}             {peroxy radical from LIEPOX+OH}
LIECHO          =                     8H + 5C + 3O ; {@C_5H_8O_3}             {aldehyde from LIEPOX}
LIECO3          =                     7H + 5C + 5O ; {@C_5H_7O_5}             {peroxy radical from LIECHO}
LIECO3H         =                     8H + 5C + 5O ; {@C_5H_8O_5}             {peroxide from LIECO3}
LIMON           =                        16H + 10C ; {@C_<10>H_<16>}          {1-methyl-4-prop-1-en-2-ylcyclohexene}
LISOPNO3NO3     = IGNORE                           ; {@LISOPNO3NO3}
LISOPNO3O2      = IGNORE                           ; {@LISOPNO3O2}
LISOPNO3OOH     = IGNORE                           ; {@LISOPNO3OOH}
LISOPOOHO2      = IGNORE                           ; {@LISOPOOHO2}
LISOPOOHOOH     = IGNORE                           ; {@LISOPOOHOOH}
MALO2           =                     3H + 4C + 4O ; {@C_4H_3O_4}             {peroxy radical from photolysis of BIGALD1}
MBONO3O2        =               10H + 5C + 6O +  N ; {@C_5H_<10>NO_6}         {peroxy nitrate radical from MBO+NO3}
MBOO2           =                    11H + 5C + 4O ; {@C_5H_<11>O_4}          {peroxy radical from MBO}
MBOOOH          =                    12H + 5C + 4O ; {@C_5H_<12>O_4}          {peroxide from MBO}
MDIALO2         =                     5H + 5C + 4O ; {@C_5H_5O_4}             {peroxy radical from photolysis of BIGALD3}
MEKNO3          = IGNORE                           ; {@MEKNO3}
MVKN            = IGNORE                           ; {@MVKN}
MYRC            =                        16H + 10C ; {@C_<10>H_<16>}          {2-methyl-6-methylideneocta-1,7-diene}
NTERPNO3        = IGNORE                           ; {@NTERPNO3}
NTERPO2         =              16H + 10C + 5O +  N ; {@C_<10>H_<16>NO_5}      {nitro peroxy radical from terpenes}
PACALD          = IGNORE                           ; {@PACALD}
PBZNIT          =                5H + 7C + 5O +  N ; {@C_7H_5NO_5}            {nitrate from benzaldehyde}
TEPOMUC         =                     8H + 7C + 3O ; {@C_7H_8O_3}             {epoxide from toluene}
TERP2O2         =                   15H + 10C + 4O ; {@C_<10>H_<15>O_4}       {peroxy radical from TERPROD1}
TERP2OOH        =                   16H + 10C + 4O ; {@C_<10>H_<16>O_4}       {peroxide from TERP2O2}
TERPNO3         =              17H + 10C + 4O +  N ; {@C_<10>H_<17>NO_4}      {nitrate from terpenes}
TERPO2          =                   17H + 10C + 3O ; {@C_<10>H_<17>O_3}       {peroxy radical from terpenes}
TERPOOH         =                   18H + 10C + 3O ; {@C_<10>H_<18>O_3}       {peroxide from terpenes}
TERPROD1        =                   16H + 10C + 2O ; {@C_<10>H_<16>O_2}       {terpene oxidation product C10}
TERPROD2        =                    10H + 7C + 2O ; {@C_7H_<10>O_2}          {terpene oxidation product C9}
TOLO2           =                     9H + 7C + 5O ; {@C_7H_9O_5}             {peroxy radical from toluene}
TOLOOH          =                    10H + 7C + 5O ; {@C_7H_<10>O_5}          {peroxide from toluene}
XYLENO2         =                    11H + 8C + 5O ; {@C_8H_<11>O_5}          {peroxy radical from xylene}
XYLENOOH        =                    12H + 8C + 5O ; {@C_8H_<12>O_5}          {peroxide from XYLENO2}
XYLOL           =                    10H + 8C +  O ; {@C_8H_<10>O}            {2,3-dimethylphenol}
XYLOLO2         =                    11H + 8C + 6O ; {@C_8H_<11>O_6}          {peroxy radical from xylol}
XYLOLOOH        =                    12H + 8C + 6O ; {@C_8H_<12>O_6}          {peroxide from xylol}
{ mz_rs_20170601-}

{ mz_rs_20171213+ MOZART}
O2_1D           = 2O                 ; {@O_2}               {excited molecular oxygen (singlett D state)}
O2_1S           = 2O                 ; {@O_2}               {excited molecular oxygen (singlett S state)}
ONIT            =  3C +  5H + 4O + N ; {@C_3H_5NO_4}        {organic nitrate}
C4H8            =  4C +  8H          ; {@C4H8}              {large alkenes}
C4H9O3          =  4C +  9H + 3O     ; {@C_4H_9O_3}         {peroxy radical from C4H8}
C5H12           =  5C + 12H          ; {@C5H12}             {large alkanes}
C5H11O2         =  5C + 11H + 2O     ; {@C5H11O2}           {peroxy radical from large alkanes}
C5H6O2          =  5C +  6H + 2O     ; {@C5H6O2}            {aldehyde from toluene oxidation}
HYDRALD         =  5C +  8H + 2O     ; {@C_5H_8O_2}         {lumped unsaturated hydroxycarbonyl}
ISOPO2          =  5C +  9H + 3O     ; {@C_5H_9O_3}         {lumped peroxy radical from isoprene}
C5H9O3          =  5C +  9H + 4O     ; {@C_5H_9O_4}         {peroxy radical from OH+HYDRALD}
ISOPOOH         =  5C + 10H + 3O     ; {@C_5H_10O_3}        {peroxide from isoprene}
C5H12O2         =  5C + 12H + 2O     ; {@C5H12O2}           {peroxide from large alkanes}
ONITR           =  5C +  9H + 4O + N ; {@C_5H_9NO_4}        {alkyl nitrate from ISOPO2+NO3}
C5H10O4         =  5C + 10H + 4O     ; {@C_5H_10O_4}        {peroxide from C5H9O3}
ROO6R5P         =  7C + 10H + 6O     ; {@ROO6R5P}           {from ref3019}
NH4             =        4H      + N ; {@NH_4}              {aq. ammonium ion}
SO4             = S + 4O             ; {@SO_4}              {aq. sulfate}
{ mz_rs_20171213-}

{ mz_rs_20171213+ CB05BASCOE}
HCO             =  C +   H +  O      ; {@HCO}               {CHO formyl radical}
ISPD            =  4C +  6H +  O     ; {@ISPD}              {lumped MACR MVK}
ClOO            = Cl + 2O            ; {@CLOO}              {asymmetrical chlorine dioxide radical}
Rn              = Rn                 ; {@Rn}                {radon}
Pb              = Pb                 ; {@Pb}                {lead}
XO2             = IGNORE             ; {@XO2}               {NO_to_NO2_operator}
XO2N            = IGNORE             ; {@XO2N}              {NO_to_alkyl_nitrate_operator}
ROOH            = IGNORE             ; {@ROOH}              {peroxides}
OLE             = IGNORE             ; {@OLE}               {olefins}
ROR             = IGNORE             ; {@ROR}               {organic_ethers}
ORGNTR          = IGNORE             ; {@ORGNTR}            {organic nitrates called ONIT in mocage}
ACO2            = IGNORE             ; {@ACO2}              {acetone oxidation product}
PAR             = IGNORE             ; {@PAR}               {parafins}
RXPAR           = IGNORE             ; {@RXPAR}             {olefins}
{ mz_rs_20171213-}

{ mz_rs_20191014+ hydrocarbons for Fe chamber mechanism}
DMP             = 5C + 12H           ; {@DMP}               {2,2-dimethyl propane}
DMB             = 6C + 14H           ; {@DMB}               {2,2-dimethyl butane}
TM5             = 8C + 18H           ; {@TM5}               {2,2,4-trimethyl pentane}
{ mz_rs_20191014-}

{ ka_sv_20141119+, ka_tf_20160801+}
{------------------------------- excited states -------------------------------}
OHv0          =  H +  O           ; {@OHv0}                {hydroxyl radical in vibrational state 0}
OHv1          =  H +  O           ; {@OHv1}                {hydroxyl radical in vibrational state 1}
OHv2          =  H +  O           ; {@OHv2}                {hydroxyl radical in vibrational state 2}
OHv3          =  H +  O           ; {@OHv3}                {hydroxyl radical in vibrational state 3}
OHv4          =  H +  O           ; {@OHv4}                {hydroxyl radical in vibrational state 4}
OHv5          =  H +  O           ; {@OHv5}                {hydroxyl radical in vibrational state 5}
OHv6          =  H +  O           ; {@OHv6}                {hydroxyl radical in vibrational state 6}
OHv7          =  H +  O           ; {@OHv7}                {hydroxyl radical in vibrational state 7}
OHv8          =  H +  O           ; {@OHv8}                {hydroxyl radical in vibrational state 8}
OHv9          =  H +  O           ; {@OHv9}                {hydroxyl radical in vibrational state 9}
O1S           =  O                ; {@O(^1S)}              {one singlet S Oxygen}
O21d          =  2O               ; {@O_2(1D)}             {a one singlet D molecular Oxygen}
O2b1s         =  2O               ; {@O_2(b1S)}            {b one singlet S molecular Oxygen}
O2c1s         =  2O               ; {@O_2(c1S)}            {c one singlet S molecular Oxygen}
O2x           =  2O               ; {@O_2(x)}              {dummy for mass conservation}
O2A3D         =  2O               ; {@O_2(A3D)}            {A triplet Delta molecular Oxygen}
O2A3S         =  2O               ; {@O_2(A3S)}            {A triplet Sigma molecular Oxygen}
O25P          =  2O               ; {@O_2(5P)}             {quintet Pi molecular Oxygen}
{ ka_sv_20141119-, ka_tf_20160801-}
// PART 2: New species from MCM mechanism:
C918NO3      =  9C  + 13H  +   N  +  5O         ; {@C918NO3}      {MCM: O=CCC(=O)C1CC(ON(=O)=O)C1(C)C}
C4PAN6       =  4C  +  5H  +   N  +  7O         ; {@C4PAN6}       {MCM: O=N(=O)OOC(=O)C(O)C(=O)C}
NC72O        =  7C  +  6H  +   N  +  7O         ; {@NC72O}        {MCM: O=N(=O)OC1(C)C(=O)CC(=O)C([O])C1=O}
HCC7CO       =  7C  + 10H  +  2O                ; {@HCC7CO}       {MCM: O=C1CC=C(C)C(O)C1}
HMACROOH     =  4C  +  8H  +  5O                ; {@HMACROOH}     {MCM: OCC(CO)(OO)C=O}
NC3OO        =  3C  +  5H  +   N  +  5O         ; {@NC3OO}        {MCM: [O-][O+]=C(C)CON(=O)=O}
C914OH       =  9C  + 12H  +  4O                ; {@C914OH}       {MCM: O=CC1C(=O)CC(=O)C(O)C1(C)C}
IEB1CHO      =  5C  +  8H  +  3O                ; {@IEB1CHO}      {MCM: CC1(OC1CO)C=O}
CHOPRNO3     =  3C  +  5H  +   N  +  4O         ; {@CHOPRNO3}     {MCM: O=CC(C)ON(=O)=O}
CHOCOHCO     =  3C  +  5H  +  3O                ; {@CHOCOHCO}     {MCM: [O]C(CO)C=O}
C617CO3      =  7C  +  9H  +  5O                ; {@C617CO3}      {MCM: [O]OC(=O)CC(=O)C(C)(C)C=O}
C919NO3      =  9C  + 13H  +   N  +  6O         ; {@C919NO3}      {MCM: O=CCC(=O)C(CC=O)C(C)(C)ON(=O)=O}
C524CO       =  5C  +  8H  +  3O                ; {@C524CO}       {MCM: OCC(=O)C(=C)CO}
HMVKNO3      =  4C  +  7H  +   N  +  6O         ; {@HMVKNO3}      {MCM: OCC(=O)C(CO)ON(=O)=O}
MACROO       =  4C  +  6H  +  2O                ; {@MACROO}       {MCM: [O-][O+]=CC(=C)C}
C3MCODBPAN   =  5C  +  5H  +   N  +  6O         ; {@C3MCODBPAN}   {MCM: O=CC(=CC(=O)OON(=O)=O)C}
ETHO2HNO3    =  2C  +  5H  +   N  +  5O         ; {@ETHO2HNO3}    {MCM: OOCCON(=O)=O}
C106O        = 10C  + 15H  +  4O                ; {@C106O}        {MCM: O=CCC(=O)CC(C(=O)C)C(C)(C)[O]}
C617OOH      =  6C  + 10H  +  4O                ; {@C617OOH}      {MCM: OOCC(=O)C(C)(C)C=O}
HMGLOOA      =  3C  +  4H  +  4O                ; {@HMGLOOA}      {MCM: [O-][O+]=CC(=O)CO}
C535OOH      =  5C  +  8H  +  7O                ; {@C535OOH}      {MCM: OOC(=O)C(C(C=O)(OO)C)O}
NC101O       = 10C  + 14H  +   N  +  5O         ; {@NC101O}       {MCM: O=N(=O)OC1(C)C(=O)CC2([O])CC1C2(C)C}
C96O         =  9C  + 15H  +  2O                ; {@C96O}         {MCM: [O]CC1CC(C(=O)C)C1(C)C}
C9DC         =  9C  + 12H  +  2O                ; {@C9DC}         {MCM: O=C1CC(=O)C2CC1C2(C)C}
INB1NBCO2H   =  5C  +  8H  +  2N  +  9O         ; {@INB1NBCO2H}   {MCM: OCC(ON(=O)=O)C(C)(ON(=O)=O)C(=O)O}
CO24C4CHO    =  5C  +  6H  +  3O                ; {@CO24C4CHO}    {MCM: O=CC(=O)CC(=O)C}
C512CO2H     =  6C  +  8H  +  4O                ; {@C512CO2H}     {MCM: O=CCC(=O)CCC(=O)O}
C107O2       = 10C  + 15H  +  4O                ; {@C107O2}       {MCM: O=CCC1CC(O[O])(C(=O)C)C1(C)C}
NOPINANO3    =  9C  + 13H  +   N  +  4O         ; {@NOPINANO3}    {MCM: O=N(=O)OC1CC(=O)C2CC1C2(C)C}
NOPINAOOH    =  9C  + 14H  +  3O                ; {@NOPINAOOH}    {MCM: OOC1CC(=O)C2CC1C2(C)C}
C88CHO       =  9C  + 12H  +  3O                ; {@C88CHO}       {MCM: O=CC1C(=O)CCC(=O)C1(C)C}
ACO3H        =  3C  +  4H  +  3O                ; {@ACO3H}        {MCM: OOC(=O)C=C}
INB1HPCHO    =  5C  +  9H  +   N  +  7O         ; {@INB1HPCHO}    {MCM: OOC(C=O)C(C)(CO)ON(=O)=O}
C8BCO        =  8C  + 13H  +   O                ; {@C8BCO}        {MCM: [O]C1CC2CC1C2(C)C}
NC524OOH     =  5C  + 11H  +   N  +  8O         ; {@NC524OOH}     {MCM: OCC(ON(=O)=O)C(CO)(CO)OO}
CO12C4CHO    =  5C  +  6H  +  3O                ; {@CO12C4CHO}    {MCM: O=CCCC(=O)C=O}
C718CO2H     =  8C  + 12H  +  4O                ; {@C718CO2H}     {MCM: O=CC(C)(C)C(=O)CCC(=O)O}
INAHCO3      =  5C  +  8H  +   N  +  8O         ; {@INAHCO3}      {MCM: [O]OC(=O)C(C)(O)C(O)CON(=O)=O}
C621O        =  6C  +  9H  +  5O                ; {@C621O}        {MCM: OCC([O])CC(=O)C(=O)CO}
PXYFUO       =  5C  +  7H  +  4O                ; {@PXYFUO}       {MCM: CC1([O])C(O)COC1=O}
C525OOH      =  5C  + 10H  +  6O                ; {@C525OOH}      {MCM: OCC(=O)C(CO)(CO)OO}
INAHCHO      =  5C  +  9H  +   N  +  6O         ; {@INAHCHO}      {MCM: O=CC(C)(O)C(O)CON(=O)=O}
C534OOH      =  5C  +  8H  +  7O                ; {@C534OOH}      {MCM: O=CC(C(C(=O)OO)(OO)C)O}
C615OH       =  6C  + 10H  +  3O                ; {@C615OH}       {MCM: O=CC(O)C(C)(C)C=O}
ISOPAOOH     =  5C  + 10H  +  3O                ; {@ISOPAOOH}     {MCM: OOCC=C(C)CO}
IPROPOLO     =  3C  +  7H  +  2O                ; {@IPROPOLO}     {MCM: [O]CC(C)O}
MAE          =  4C  +  6H  +  3O                ; {@MAE}          {MCM: CC1(CO1)C(=O)O}
C89O         =  8C  + 13H  +  2O                ; {@C89O}         {MCM: O=CCC1CC([O])C1(C)C}
ISOPCOOH     =  5C  + 10H  +  3O                ; {@ISOPCOOH}     {MCM: OOCC(=CCO)C}
INB1NACO3H   =  5C  +  8H  +  2N  + 10O         ; {@INB1NACO3H}   {MCM: OOC(=O)C(ON(=O)=O)C(C)(CO)ON(=O)=O}
IEACO3H      =  5C  +  8H  +  5O                ; {@IEACO3H}      {MCM: CC(O)(C1CO1)C(=O)OO}
C57NO3       =  5C  +  9H  +   N  +  6O         ; {@C57NO3}       {MCM: OCC(O)C(C)(C=O)ON(=O)=O}
C3DIOLOOH    =  3C  +  8H  +  4O                ; {@C3DIOLOOH}    {MCM: OOCC(O)CO}
APINBOOH     = 10C  + 18H  +  3O                ; {@APINBOOH}     {MCM: OOC1CC2CC(C1(C)O)C2(C)C}
INAHPCO3     =  5C  +  8H  +   N  +  9O         ; {@INAHPCO3}     {MCM: [O]OC(=O)C(C)(OO)C(O)CON(=O)=O}
CISOPA       =  5C  +  9H  +   O                ; {@CISOPA}       {MCM: C/C(=C/[CH2])/CO}
CISOPC       =  5C  +  9H  +   O                ; {@CISOPC}       {MCM: OC/C=C(\[CH2])/C}
C615CO       =  6C  +  8H  +  3O                ; {@C615CO}       {MCM: O=CC(=O)C(C)(C)C=O}
C108O        = 10C  + 15H  +  4O                ; {@C108O}        {MCM: O=CCC(CC(=O)C(=O)C)C(C)(C)[O]}
BPINCOOH     = 10C  + 18H  +  3O                ; {@BPINCOOH}     {MCM: OCC1=CCC(CC1)C(C)(C)OO}
VGLYOX       =  4C  +  4H  +  2O                ; {@VGLYOX}       {MCM: C=CC(=O)C=O}
C58OOH       =  5C  + 10H  +  5O                ; {@C58OOH}       {MCM: O=CC(O)C(C)(CO)OO}
C58NO3       =  5C  +  9H  +   N  +  6O         ; {@C58NO3}       {MCM: O=CC(O)C(C)(CO)ON(=O)=O}
C516O2       =  5C  +  7H  +  6O                ; {@C516O2}       {MCM: OCC(O[O])CC(=O)C(=O)O}
C59O         =  5C  +  9H  +  4O                ; {@C59O}         {MCM: OCC(=O)C(C)([O])CO}
C918O2       =  9C  + 13H  +  4O                ; {@C918O2}       {MCM: O=CCC(=O)C1CC(O[O])C1(C)C}
INCCO        =  5C  +  9H  +   N  +  6O         ; {@INCCO}        {MCM: OCC(=O)C(C)(O)CON(=O)=O}
CISOPCO      =  5C  +  9H  +  2O                ; {@CISOPCO}      {MCM: OC/C=C(\C[O])/C}
C524O        =  5C  +  9H  +  3O                ; {@C524O}        {MCM: OCC(=C)C([O])CO}
INB1GLYOX    =  5C  +  7H  +   N  +  6O         ; {@INB1GLYOX}    {MCM: O=CC(=O)C(C)(CO)ON(=O)=O}
CH2CHCH2O    =  3C  +  5H  +   O                ; {@CH2CHCH2O}    {MCM: [O]CC=C}
PRONO3AO2    =  3C  +  6H  +   N  +  5O         ; {@PRONO3AO2}    {MCM: [O]OCC(C)ON(=O)=O}
C527OOH      =  5C  + 10H  +  6O                ; {@C527OOH}      {MCM: OOC(C(OO)(CO)C)C=O}
CONM2CO3H    =  4C  +  5H  +   N  +  7O         ; {@CONM2CO3H}    {MCM: OOC(=O)C(C)(C=O)ON(=O)=O}
C537O2       =  5C  +  9H  +  7O                ; {@C537O2}       {MCM: OOCC(C(C=O)O[O])(OO)C}
C918OH       =  9C  + 14H  +  3O                ; {@C918OH}       {MCM: O=CCC(=O)C1CC(O)C1(C)C}
NOPINCNO3    =  9C  + 13H  +   N  +  4O         ; {@NOPINCNO3}    {MCM: O=N(=O)OC12CCC(=O)C(C1)C2(C)C}
PINALO       = 10C  + 15H  +  3O                ; {@PINALO}       {MCM: O=CCC1([O])CC(C(=O)C)C1(C)C}
C531O2       =  5C  +  5H  +  5O                ; {@C531O2}       {MCM: [O]OCC(=O)C=COC=O}
HMML         =  4C  +  6H  +  3O                ; {@HMML}         {MCM: CC1(CO)OC1=O}
C916NO3      =  9C  + 13H  +   N  +  6O         ; {@C916NO3}      {MCM: O=CCCC(=O)C(C=O)C(C)(C)ON(=O)=O}
BPINCO       = 10C  + 17H  +  2O                ; {@BPINCO}       {MCM: OCC1=CCC(CC1)C(C)(C)[O]}
C526O        =  5C  +  9H  +  5O                ; {@C526O}        {MCM: OCC(C(C=O)([O])C)OO}
PRONO3BO     =  3C  +  6H  +   N  +  4O         ; {@PRONO3BO}     {MCM: CC([O])CON(=O)=O}
CHOC2H4O     =  3C  +  5H  +  2O                ; {@CHOC2H4O}     {MCM: [O]CCC=O}
C530NO3      =  5C  +  9H  +   N  +  5O         ; {@C530NO3}      {MCM: O=CCC(O[N+](=O)[O-])(CO)C}
INCOOH       =  5C  + 11H  +   N  +  7O         ; {@INCOOH}       {MCM: OCC(OO)C(C)(O)CON(=O)=O}
C9DCNO3      =  9C  + 11H  +   N  +  5O         ; {@C9DCNO3}      {MCM: O=N(=O)OC1C2C(=O)CC(=O)C1C2(C)C}
C920OOH      =  9C  + 16H  +  4O                ; {@C920OOH}      {MCM: OOCC1CC(C(=O)CO)C1(C)C}
CH2CHCH2OOH  =  3C  +  6H  +  2O                ; {@CH2CHCH2OOH}  {MCM: OOCC=C}
BPINBOOH     = 10C  + 18H  +  3O                ; {@BPINBOOH}     {MCM: OOCC1(O)CCC2CC1C2(C)C}
INAOOH       =  5C  + 11H  +   N  +  7O         ; {@INAOOH}       {MCM: OCC(C)(OO)C(O)CON(=O)=O}
TBUTOLNO3    =  4C  +  9H  +   N  +  4O         ; {@TBUTOLNO3}    {MCM: O=N(=O)OCC(C)(C)O}
IEPOXC       =  5C  + 10H  +  3O                ; {@IEPOXC}       {MCM: CC1(CO1)C(O)CO}
NOAOO        =  3C  +  5H  +   N  +  5O         ; {@NOAOO}        {MCM: [O-][O+]=C(C)CON(=O)=O}
IEPOXA       =  5C  + 10H  +  3O                ; {@IEPOXA}       {MCM: CC(O)(CO)C1CO1}
MACROOA      =  4C  +  6H  +  2O                ; {@MACROOA}      {MCM: [O-][O+]=CC(=C)C}
C58NO3CO3    =  5C  +  8H  +   N  +  8O         ; {@C58NO3CO3}    {MCM: [O]OC(=O)C(O)C(C)(CO)ON(=O)=O}
APINCOOH     = 10C  + 18H  +  3O                ; {@APINCOOH}     {MCM: OOC(C)(C)C1CC=C(C)C(O)C1}
C922OOH      =  9C  + 16H  +  6O                ; {@C922OOH}      {MCM: OCC(=O)C(=O)CC(CO)C(C)(C)OO}
C917O2       =  9C  + 13H  +  4O                ; {@C917O2}       {MCM: [O]OC(C)(C)C1CC(=O)CCC1=O}
C811OH       =  8C  + 14H  +  3O                ; {@C811OH}       {MCM: OCC1CC(C(=O)O)C1(C)C}
INAHPCO3H    =  5C  +  9H  +   N  +  9O         ; {@INAHPCO3H}    {MCM: OOC(=O)C(C)(OO)C(O)CON(=O)=O}
CO2N3CHO     =  4C  +  5H  +   N  +  5O         ; {@CO2N3CHO}     {MCM: O=CC(ON(=O)=O)C(=O)C}
C510OH       =  5C  +  9H  +   N  +  6O         ; {@C510OH}       {MCM: O=CC(O)C(C)(O)CON(=O)=O}
C919O        =  9C  + 13H  +  4O                ; {@C919O}        {MCM: O=CCC(=O)C(CC=O)C(C)(C)[O]}
C511O        =  5C  +  7H  +  3O                ; {@C511O}        {MCM: O=CCC([O])C(=O)C}
A2PANO       =  3C  +  5H  +  4O                ; {@A2PANO}       {MCM: OCC(O)C(=O)[O]}
C57NO3PAN    =  5C  +  8H  +  2N  + 10O         ; {@C57NO3PAN}    {MCM: OCC(O)C(C)(ON(=O)=O)C(=O)OON(=O)=O}
C615O2       =  6C  +  9H  +  4O                ; {@C615O2}       {MCM: [O]OC(C=O)C(C)(C)C=O}
C515CHO      =  6C  +  6H  +  4O                ; {@C515CHO}      {MCM: O=CCC(=O)C(=O)CC=O}
C512OH       =  5C  +  8H  +  3O                ; {@C512OH}       {MCM: OCCC(=O)CC=O}
TBUTOLOOH    =  4C  + 10H  +  3O                ; {@TBUTOLOOH}    {MCM: OOCC(C)(C)O}
C87OH        =  8C  + 12H  +  4O                ; {@C87OH}        {MCM: OCC(=O)C(C=O)C(C)(C)C=O}
NAPINAO      = 10C  + 16H  +   N  +  4O         ; {@NAPINAO}      {MCM: O=N(=O)OC1CC2CC(C1(C)[O])C2(C)C}
CHOC3COO     =  4C  +  5H  +  3O                ; {@CHOC3COO}     {MCM: [O]CC(=O)CC=O}
C514OH       =  5C  +  8H  +  3O                ; {@C514OH}       {MCM: O=CCC(O)CC=O}
C916OH       =  9C  + 14H  +  4O                ; {@C916OH}       {MCM: O=CCCC(=O)C(C=O)C(C)(C)O}
PXYFUO2      =  5C  +  7H  +  5O                ; {@PXYFUO2}      {MCM: [O]OC1(C)C(O)COC1=O}
C535O2       =  5C  +  7H  +  7O                ; {@C535O2}       {MCM: OOC(=O)C(C(C=O)(O[O])C)O}
HMVKAO       =  4C  +  7H  +  3O                ; {@HMVKAO}       {MCM: CC(=O)C(O)C[O]}
CHOC2CO3H    =  4C  +  6H  +  4O                ; {@CHOC2CO3H}    {MCM: OOC(=O)CCC=O}
C917NO3      =  9C  + 13H  +   N  +  5O         ; {@C917NO3}      {MCM: O=C1CCC(=O)C(C1)C(C)(C)ON(=O)=O}
C44O         =  4C  +  5H  +  4O                ; {@C44O}         {MCM: O=CCC([O])C(=O)O}
NC91CO3      = 10C  + 14H  +   N  +  6O         ; {@NC91CO3}      {MCM: [O]OC(=O)C1(CCC2CC1C2(C)C)ON(=O)=O}
C620OH       =  6C  +  8H  +  4O                ; {@C620OH}       {MCM: O=CCC(=O)C(O)CC=O}
CO123C5CHO   =  6C  +  6H  +  4O                ; {@CO123C5CHO}   {MCM: O=CCCC(=O)C(=O)C=O}
H3C25CCO2H   =  7C  + 10H  +  5O                ; {@H3C25CCO2H}   {MCM: OC(=O)CC(=O)CC(O)C(=O)C}
CO2C3OO      =  4C  +  6H  +  3O                ; {@CO2C3OO}      {MCM: [O-][O+]=CCC(=O)C}
MGLOOA       =  3C  +  4H  +  3O                ; {@MGLOOA}       {MCM: [O-][O+]=CC(=O)C}
ACRPAN       =  3C  +  3H  +   N  +  5O         ; {@ACRPAN}       {MCM: C=CC(=O)OON(=O)=O}
H3C25C6OOH   =  6C  + 10H  +  5O                ; {@H3C25C6OOH}   {MCM: CC(=O)C(O)CC(=O)COO}
INB1O2       =  5C  + 10H  +   N  +  7O         ; {@INB1O2}       {MCM: OCC(O[O])C(C)(CO)ON(=O)=O}
C812OH       =  8C  + 14H  +  4O                ; {@C812OH}       {MCM: OCC1CC(O)(C(=O)O)C1(C)C}
ISOPCNO3     =  5C  +  9H  +   N  +  4O         ; {@ISOPCNO3}     {MCM: OCC=C(C)CON(=O)=O}
C109OH       = 10C  + 16H  +  3O                ; {@C109OH}       {MCM: O=CCC1CC(C(=O)CO)C1(C)C}
NC51O        =  5C  +  8H  +   N  +  5O         ; {@NC51O}        {MCM: [O]C(CC(=O)C)CO[N+](=O)[O-]}
NBPINBOOH    = 10C  + 17H  +   N  +  5O         ; {@NBPINBOOH}    {MCM: OOCC1(CCC2CC1C2(C)C)ON(=O)=O}
NC101CO      = 10C  + 15H  +   N  +  4O         ; {@NC101CO}      {MCM: O=N(=O)OC1(C)C(=O)CC2CC1C2(C)C}
H14CO23C4    =  4C  +  6H  +  4O                ; {@H14CO23C4}    {MCM: OCC(=O)C(=O)CO}
C510O2       =  5C  +  8H  +   N  +  7O         ; {@C510O2}       {MCM: O=CC(O)C(C)(O[O])CON(=O)=O}
DHPMPAL      =  4C  +  8H  +  5O                ; {@DHPMPAL}      {MCM: OOCC(C=O)(OO)C}
ISOP34NO3    =  5C  +  9H  +   N  +  4O         ; {@ISOP34NO3}    {MCM: [O-][N+](=O)OCC(C(=C)C)O}
HIEB2O2      =  5C  +  9H  +  6O                ; {@HIEB2O2}      {MCM: [O]OC(C=O)C(O)(CO)CO}
DHPMEK       =  4C  +  8H  +  5O                ; {@DHPMEK}       {MCM: OOCC(C(=O)C)OO}
C920CO3      = 10C  + 15H  +  5O                ; {@C920CO3}      {MCM: [O]OC(=O)CC1CC(C(=O)CO)C1(C)C}
NBPINBO2     = 10C  + 16H  +   N  +  5O         ; {@NBPINBO2}     {MCM: [O]OCC1(CCC2CC1C2(C)C)ON(=O)=O}
C87O         =  8C  + 11H  +  4O                ; {@C87O}         {MCM: [O]CC(=O)C(C=O)C(C)(C)C=O}
NC526OOH     =  5C  +  9H  +   N  +  6O         ; {@NC526OOH}     {MCM: O=CCC(CO[N+](=O)[O-])(OO)C}
INB1NACHO    =  5C  +  8H  +  2N  +  8O         ; {@INB1NACHO}    {MCM: O=CC(ON(=O)=O)C(C)(CO)ON(=O)=O}
MACRNBPAN    =  4C  +  6H  +  2N  +  9O         ; {@MACRNBPAN}    {MCM: O=N(=O)OOC(=O)C(C)(O)CON(=O)=O}
COHM2CO3H    =  4C  +  6H  +  5O                ; {@COHM2CO3H}    {MCM: CC(O)(C=O)C(=O)OO}
C515PAN      =  6C  +  5H  +   N  +  8O         ; {@C515PAN}      {MCM: O=CCC(=O)C(=O)CC(=O)OON(=O)=O}
SA = IGNORE ;
C512CO3H     =  6C  +  8H  +  5O                ; {@C512CO3H}     {MCM: OOC(=O)CCC(=O)CC=O}
ISOPANO3     =  5C  +  9H  +   N  +  4O         ; {@ISOPANO3}     {MCM: OCC(=CCON(=O)=O)C}
INANCOCHO    =  5C  +  6H  +  2N  +  8O         ; {@INANCOCHO}    {MCM: O=CC(C)(ON(=O)=O)C(=O)CON(=O)=O}
PRNO3CO3H    =  3C  +  5H  +   N  +  6O         ; {@PRNO3CO3H}    {MCM: OOC(=O)C(C)ON(=O)=O}
INB1OOH      =  5C  + 11H  +   N  +  7O         ; {@INB1OOH}      {MCM: OCC(OO)C(C)(CO)ON(=O)=O}
C31CO3       =  4C  +  3H  +  5O                ; {@C31CO3}       {MCM: O=COC=CC(=O)O[O]}
CO235C6O     =  6C  +  7H  +  4O                ; {@CO235C6O}     {MCM: [O]CC(=O)CC(=O)C(=O)C}
INANCO3H     =  5C  +  8H  +  2N  + 10O         ; {@INANCO3H}     {MCM: OOC(=O)C(C)(ON(=O)=O)C(O)CON(=O)=O}
MACRNCO2H    =  4C  +  7H  +   N  +  6O         ; {@MACRNCO2H}    {MCM: OCC(C)(ON(=O)=O)C(=O)O}
INAOH        =  5C  + 11H  +   N  +  6O         ; {@INAOH}        {MCM: OCC(C)(O)C(O)CON(=O)=O}
C811O        =  8C  + 13H  +  3O                ; {@C811O}        {MCM: [O]CC1CC(C(=O)O)C1(C)C}
H3C25C6PAN   =  7C  +  9H  +   N  +  8O         ; {@H3C25C6PAN}   {MCM: O=C(OON(=O)=O)CC(=O)CC(O)C(=O)C}
C531CO       =  5C  +  4H  +  4O                ; {@C531CO}       {MCM: O=COC=CC(=O)C=O}
NBPINAO2     = 10C  + 16H  +   N  +  5O         ; {@NBPINAO2}     {MCM: [O]OC1(CON(=O)=O)CCC2CC1C2(C)C}
C3MCODBCO3   =  5C  +  5H  +  4O                ; {@C3MCODBCO3}   {MCM: [O]OC(=O)C=C(C)C=O}
PRONO3AO     =  3C  +  6H  +   N  +  4O         ; {@PRONO3AO}     {MCM: [O]CC(C)ON(=O)=O}
IECCO3       =  5C  +  7H  +  5O                ; {@IECCO3}       {MCM: CC1(CO1)C(O)C(=O)O[O]}
PRNO3PAN     =  3C  +  4H  +  2N  +  8O         ; {@PRNO3PAN}     {MCM: O=N(=O)OOC(=O)C(C)ON(=O)=O}
H2M2C3CO3H   =  5C  + 10H  +  4O                ; {@H2M2C3CO3H}   {MCM: OOC(=O)CC(C)(C)O}
IBUTOLOHB    =  4C  + 10H  +  2O                ; {@IBUTOLOHB}    {MCM: OCC(C)(C)O}
C618O        =  6C  +  9H  +  3O                ; {@C618O}        {MCM: O=CCC(=O)C(C)(C)[O]}
C98OH        =  9C  + 16H  +  4O                ; {@C98OH}        {MCM: OCC(CC(=O)C(=O)C)C(C)(C)O}
C23O3CCO2H   =  5C  +  6H  +  5O                ; {@C23O3CCO2H}   {MCM: OC(=O)COC(=O)C(=O)C}
C515CO3      =  6C  +  5H  +  6O                ; {@C515CO3}      {MCM: [O]OC(=O)CC(=O)C(=O)CC=O}
HPC52CO3     =  5C  +  9H  +  8O                ; {@HPC52CO3}     {MCM: OOCC(C(C(=O)O[O])O)(OO)C}
ISOPAO       =  5C  +  9H  +  2O                ; {@ISOPAO}       {MCM: [O]C/C=C(/CO)C}
C88CO2H      =  9C  + 12H  +  4O                ; {@C88CO2H}      {MCM: OC(=O)C1C(=O)CCC(=O)C1(C)C}
C3DIOLO      =  3C  +  7H  +  3O                ; {@C3DIOLO}      {MCM: OCC(O)C[O]}
C718O2       =  7C  + 11H  +  4O                ; {@C718O2}       {MCM: [O]OCCC(=O)C(C)(C)C=O}
C96OH        =  9C  + 16H  +  2O                ; {@C96OH}        {MCM: OCC1CC(C(=O)C)C1(C)C}
C3MCODBCO2   =  5C  +  5H  +  3O                ; {@C3MCODBCO2}   {MCM: O=CC(=CC(=O)[O])C}
INCOH        =  5C  + 11H  +   N  +  6O         ; {@INCOH}        {MCM: OCC(O)C(C)(O)CON(=O)=O}
C67CO3       =  6C  +  9H  +  5O                ; {@C67CO3}       {MCM: [O]OC(=O)CC(=O)C(C)(C)O}
H3C25C6OH    =  6C  + 10H  +  4O                ; {@H3C25C6OH}    {MCM: CC(=O)C(O)CC(=O)CO}
INCO         =  5C  + 10H  +   N  +  6O         ; {@INCO}         {MCM: OCC([O])C(C)(O)CON(=O)=O}
CO2C3CO3H    =  4C  +  6H  +  4O                ; {@CO2C3CO3H}    {MCM: CC(=O)CC(=O)OO}
C718OH       =  7C  + 12H  +  3O                ; {@C718OH}       {MCM: OCCC(=O)C(C)(C)C=O}
INANCOCO3H   =  5C  +  6H  +  2N  + 10O         ; {@INANCOCO3H}   {MCM: OOC(=O)C(C)(ON(=O)=O)C(=O)CON(=O)=O}
H3C25C6O2    =  6C  +  9H  +  5O                ; {@H3C25C6O2}    {MCM: CC(=O)C(O)CC(=O)CO[O]}
INCO2        =  5C  + 10H  +   N  +  7O         ; {@INCO2}        {MCM: OCC(O[O])C(C)(O)CON(=O)=O}
INANCOCO3    =  5C  +  5H  +  2N  + 10O         ; {@INANCOCO3}    {MCM: [O]OC(=O)C(C)(ON(=O)=O)C(=O)CON(=O)=O}
C107O        = 10C  + 15H  +  3O                ; {@C107O}        {MCM: O=CCC1CC([O])(C(=O)C)C1(C)C}
C5PACALD1    =  5C  +  6H  +  4O                ; {@C5PACALD1}    {MCM: C/C(=C/C=O)/C(=O)OO}
MGLYOOB      =  3C  +  4H  +  3O                ; {@MGLYOOB}      {MCM: [O-][O+]=C(C)C=O}
MGLYOOA      =  3C  +  4H  +  3O                ; {@MGLYOOA}      {MCM: [O-][O+]=C(C)C=O}
HC4CO3       =  5C  +  7H  +  4O                ; {@HC4CO3}       {MCM: CC(=C)C(C(=O)O[O])O}
INCNO3       =  5C  + 10H  +  2N  +  8O         ; {@INCNO3}       {MCM: OCC(ON(=O)=O)C(C)(O)CON(=O)=O}
C615O        =  6C  +  9H  +  3O                ; {@C615O}        {MCM: O=CC([O])C(C)(C)C=O}
INB1O        =  5C  + 10H  +   N  +  6O         ; {@INB1O}        {MCM: OCC([O])C(C)(CO)ON(=O)=O}
C2OHOCO2H    =  3C  +  6H  +  4O                ; {@C2OHOCO2H}    {MCM: OCC(O)C(=O)O}
CH3CHOO      =  2C  +  4H  +  2O                ; {@CH3CHOO}      {MCM: [O-][O+]=CC}
C3MDIALO     =  4C  +  5H  +  3O                ; {@C3MDIALO}     {MCM: O=CC(C)([O])C=O}
INB2OOH      =  5C  + 11H  +   N  +  7O         ; {@INB2OOH}      {MCM: OOCC(O)C(C)(CO)ON(=O)=O}
INCNCHO      =  5C  +  8H  +  2N  +  8O         ; {@INCNCHO}      {MCM: O=CC(ON(=O)=O)C(C)(O)CON(=O)=O}
INANPAN      =  5C  +  7H  +  3N  + 12O         ; {@INANPAN}      {MCM: O=N(=O)OCC(O)C(C)(ON(=O)=O)C(=O)OON(=O)=O}
NPXYFUO2     =  5C  +  6H  +   N  +  7O         ; {@NPXYFUO2}     {MCM: [O]OC1(C)C(=O)OCC1ON(=O)=O}
INAO2        =  5C  + 10H  +   N  +  7O         ; {@INAO2}        {MCM: OCC(C)(O[O])C(O)CON(=O)=O}
HPC52CO3H    =  5C  + 10H  +  8O                ; {@HPC52CO3H}    {MCM: OOCC(C(C(=O)OO)O)(OO)C}
INCNCO3      =  5C  +  7H  +  2N  + 10O         ; {@INCNCO3}      {MCM: [O]OC(=O)C(ON(=O)=O)C(C)(O)CON(=O)=O}
C88CO3       =  9C  + 11H  +  5O                ; {@C88CO3}       {MCM: [O]OC(=O)C1C(=O)CCC(=O)C1(C)C}
H1C23C4PAN   =  5C  +  5H  +   N  +  8O         ; {@H1C23C4PAN}   {MCM: OCC(=O)C(=O)CC(=O)OON(=O)=O}
C918OOH      =  9C  + 14H  +  4O                ; {@C918OOH}      {MCM: O=CCC(=O)C1CC(OO)C1(C)C}
C619CO       =  6C  +  6H  +  3O                ; {@C619CO}       {MCM: O=C1CCC(=O)C(=O)C1}
C917O        =  9C  + 13H  +  3O                ; {@C917O}        {MCM: O=C1CCC(=O)C(C1)C(C)(C)[O]}
HIEB1O2      =  5C  +  9H  +  6O                ; {@HIEB1O2}      {MCM: OCC(O)C(CO)(O[O])C=O}
C57O         =  5C  +  9H  +  4O                ; {@C57O}         {MCM: OCC(O)C(C)([O])C=O}
INAHCO2H     =  5C  +  9H  +   N  +  7O         ; {@INAHCO2H}     {MCM: O=N(=O)OCC(O)C(C)(O)C(=O)O}
C9DCOOH      =  9C  + 12H  +  4O                ; {@C9DCOOH}      {MCM: OOC1C2C(=O)CC(=O)C1C2(C)C}
CH3C2H2O2    =  3C  +  5H  +  2O                ; {@CH3C2H2O2}    {MCM: CC(=C)O[O]}
C88O         =  8C  + 11H  +  3O                ; {@C88O}         {MCM: O=C1CCC(=O)C(C)(C)C1[O]}
BPINBNO3     = 10C  + 17H  +   N  +  4O         ; {@BPINBNO3}     {MCM: O=N(=O)OCC1(O)CCC2CC1C2(C)C}
MVKOHAO      =  4C  +  7H  +  4O                ; {@MVKOHAO}      {MCM: OCC(=O)C(O)C[O]}
C917OH       =  9C  + 14H  +  3O                ; {@C917OH}       {MCM: O=C1CCC(=O)C(C1)C(C)(C)O}
INANO3       =  5C  + 10H  +  2N  +  8O         ; {@INANO3}       {MCM: OCC(C)(ON(=O)=O)C(O)CON(=O)=O}
C918PAN      = 10C  + 15H  +   N  +  6O         ; {@C918PAN}      {MCM: O=N(=O)OOC(=O)C1(O)CCC2CC1C2(C)C}
ACO2H        =  3C  +  4H  +  2O                ; {@ACO2H}        {MCM: OC(=O)C=C}
C916OOH      =  9C  + 14H  +  5O                ; {@C916OOH}      {MCM: O=CCCC(=O)C(C=O)C(C)(C)OO}
CH3COPAN     =  3C  +  3H  +   N  +  6O         ; {@CH3COPAN}     {MCM: O=N(=O)OOC(=O)C(=O)C}
C620O2       =  6C  +  7H  +  5O                ; {@C620O2}       {MCM: O=CCC(=O)C(O[O])CC=O}
CO2N3PAN     =  4C  +  4H  +  2N  +  9O         ; {@CO2N3PAN}     {MCM: O=N(=O)OOC(=O)C(ON(=O)=O)C(=O)C}
CH3CHOOA     =  2C  +  4H  +  2O                ; {@CH3CHOOA}     {MCM: [O-][O+]=CC}
APINBOH      = 10C  + 18H  +  2O                ; {@APINBOH}      {MCM: OC1CC2CC(C1(C)O)C2(C)C}
ACRO2        =  3C  +  5H  +  4O                ; {@ACRO2}        {MCM: OCC(O[O])C=O}
MMALNACO3    =  5C  +  6H  +   N  +  8O         ; {@MMALNACO3}    {MCM: [O]OC(=O)C(O)C(C)(C=O)ON(=O)=O}
NC61CO3H     =  7C  +  7H  +   N  +  9O         ; {@NC61CO3H}     {MCM: O=CC(=O)CC(=O)C(C)(ON(=O)=O)C(=O)OO}
C616OH       =  6C  +  8H  +  4O                ; {@C616OH}       {MCM: O=CCCC(=O)C(O)C=O}
MIBKHO4CHO   =  6C  + 10H  +  3O                ; {@MIBKHO4CHO}   {MCM: O=CC(=O)CC(C)(C)O}
IECCO3H      =  5C  +  8H  +  5O                ; {@IECCO3H}      {MCM: CC1(CO1)C(O)C(=O)OO}
HC4ACHO      =  5C  +  8H  +  2O                ; {@HC4ACHO}      {MCM: CC(=CC=O)CO}
C614OH       =  6C  + 10H  +  4O                ; {@C614OH}       {MCM: CC(=O)C(=O)CC(O)CO}
H3C25CCO3H   =  7C  + 10H  +  6O                ; {@H3C25CCO3H}   {MCM: OOC(=O)CC(=O)CC(O)C(=O)C}
HMGLYOO      =  3C  +  4H  +  4O                ; {@HMGLYOO}      {MCM: [O-]/[O+]=C(\CO)/C=O}
NC4CO3       =  5C  +  6H  +   N  +  6O         ; {@NC4CO3}       {MCM: [O]OC(=O)C=C(C)CON(=O)=O}
HC4PAN       =  5C  +  7H  +   N  +  6O         ; {@HC4PAN}       {MCM: [O-][N+](=O)OOC(=O)C(C(=C)C)O}
NC71O        =  7C  +  8H  +   N  +  6O         ; {@NC71O}        {MCM: O=C1CC([O])C(C)(ON(=O)=O)C(=O)C1}
H13CO2CO3    =  4C  +  5H  +  6O                ; {@H13CO2CO3}    {MCM: OCC(=O)C(O)C(=O)O[O]}
MVKO         =  4C  +  5H  +  2O                ; {@MVKO}         {MCM: [O]CC(=O)C=C}
C618CO2H     =  7C  + 10H  +  4O                ; {@C618CO2H}     {MCM: O=CCC(=O)C(C)(C)C(=O)O}
MMALNACO3H   =  5C  +  7H  +   N  +  8O         ; {@MMALNACO3H}   {MCM: OOC(=O)C(O)C(C)(C=O)ON(=O)=O}
ACLOO        =  3C  +  6H  +  3O                ; {@ACLOO}        {MCM: [O-][O+]=C(C)CO}
C615CO2H     =  7C  + 10H  +  4O                ; {@C615CO2H}     {MCM: O=CC(C(=O)O)C(C)(C)C=O}
BPINCNO3     = 10C  + 17H  +   N  +  4O         ; {@BPINCNO3}     {MCM: OCC1=CCC(CC1)C(C)(C)ON(=O)=O}
APINOOB      = 10C  + 16H  +  3O                ; {@APINOOB}      {MCM: [O-][O+]=CCC1CC(C(=O)C)C1(C)C}
APINOOA      = 10C  + 16H  +  3O                ; {@APINOOA}      {MCM: O=CCC1CC(C(=[O+][O-])C)C1(C)C}
HC4CO3H      =  5C  +  8H  +  4O                ; {@HC4CO3H}      {MCM: CC(=C)C(C(=O)OO)O}
NC524NO3     =  5C  + 10H  +  2N  +  9O         ; {@NC524NO3}     {MCM: OCC(ON(=O)=O)C(CO)(CO)ON(=O)=O}
CONM2CO3     =  4C  +  4H  +   N  +  7O         ; {@CONM2CO3}     {MCM: [O]OC(=O)C(C)(C=O)ON(=O)=O}
C616O2       =  6C  +  7H  +  5O                ; {@C616O2}       {MCM: O=CCCC(=O)C(O[O])C=O}
APINBO2      = 10C  + 17H  +  3O                ; {@APINBO2}      {MCM: [O]OC1CC2CC(C1(C)O)C2(C)C}
C88OOH       =  8C  + 12H  +  4O                ; {@C88OOH}       {MCM: OOC1C(=O)CCC(=O)C1(C)C}
APINBNO3     = 10C  + 17H  +   N  +  4O         ; {@APINBNO3}     {MCM: O=N(=O)OC1CC2CC(C1(C)O)C2(C)C}
NOPINAO      =  9C  + 13H  +  2O                ; {@NOPINAO}      {MCM: [O]C1CC(=O)C2CC1C2(C)C}
NC102OOH     = 10C  + 15H  +   N  +  7O         ; {@NC102OOH}     {MCM: OOC(C)(C)C1CC(=O)CC(=O)C1(C)ON(=O)=O}
TISOPA       =  5C  +  9H  +   O                ; {@TISOPA}       {MCM: C/C(=C\[CH2])/CO}
TISOPC       =  5C  +  9H  +   O                ; {@TISOPC}       {MCM: OC/C=C(\C)/[CH2]}
C917OOH      =  9C  + 14H  +  4O                ; {@C917OOH}      {MCM: OOC(C)(C)C1CC(=O)CCC1=O}
ETHENO3O2    =  2C  +  4H  +   N  +  5O         ; {@ETHENO3O2}    {MCM: [O]OCCON(=O)=O}
HIEPOXB      =  5C  + 10H  +  4O                ; {@HIEPOXB}      {MCM: OCC1OC1(CO)CO}
C914O2       =  9C  + 11H  +  5O                ; {@C914O2}       {MCM: [O]OC1C(=O)CC(=O)C(C=O)C1(C)C}
HMVKAO2      =  4C  +  7H  +  4O                ; {@HMVKAO2}      {MCM: CC(=O)C(O)CO[O]}
M3FOOA       =  5C  +  6H  +  4O                ; {@M3FOOA}       {MCM: O=COC=CC(=[O+][O-])C}
CONM2CO2H    =  4C  +  5H  +   N  +  6O         ; {@CONM2CO2H}    {MCM: O=CC(C)(ON(=O)=O)C(=O)O}
C718NO3      =  7C  + 11H  +   N  +  5O         ; {@C718NO3}      {MCM: O=CC(C)(C)C(=O)CCON(=O)=O}
C619OH       =  6C  +  8H  +  3O                ; {@C619OH}       {MCM: O=C1CCC(=O)C(O)C1}
A2PAN        =  3C  +  5H  +   N  +  7O         ; {@A2PAN}        {MCM: OCC(O)C(=O)OON(=O)=O}
C515OOH      =  5C  +  6H  +  5O                ; {@C515OOH}      {MCM: OOCC(=O)C(=O)CC=O}
APINANO3     = 10C  + 17H  +   N  +  4O         ; {@APINANO3}     {MCM: O=N(=O)OC1(C)C(O)CC2CC1C2(C)C}
C515CO       =  5C  +  4H  +  4O                ; {@C515CO}       {MCM: O=CCC(=O)C(=O)C=O}
BPINAO       = 10C  + 17H  +  2O                ; {@BPINAO}       {MCM: OCC1([O])CCC2CC1C2(C)C}
H1C23C4CO3   =  5C  +  5H  +  6O                ; {@H1C23C4CO3}   {MCM: [O]OC(=O)CC(=O)C(=O)CO}
ISOP34OOH    =  5C  + 10H  +  3O                ; {@ISOP34OOH}    {MCM: CC(=C)C(COO)O}
C512CO3      =  6C  +  7H  +  5O                ; {@C512CO3}      {MCM: [O]OC(=O)CCC(=O)CC=O}
CO1M22PAN    =  5C  +  7H  +   N  +  6O         ; {@CO1M22PAN}    {MCM: O=CC(C)(C)C(=O)OON(=O)=O}
BPINBO       = 10C  + 17H  +  2O                ; {@BPINBO}       {MCM: [O]CC1(O)CCC2CC1C2(C)C}
C617O2       =  6C  +  9H  +  4O                ; {@C617O2}       {MCM: [O]OCC(=O)C(C)(C)C=O}
IPROPOLPER   =  3C  +  6H  +  4O                ; {@IPROPOLPER}   {MCM: OOC(=O)C(C)O}
C718CO3      =  8C  + 11H  +  5O                ; {@C718CO3}      {MCM: [O]OC(=O)CCC(=O)C(C)(C)C=O}
C4M2AL2OH    =  5C  +  8H  +  4O                ; {@C4M2AL2OH}    {MCM: O=CC(O)C(C)(O)C=O}
C920PAN      = 10C  + 15H  +   N  +  7O         ; {@C920PAN}      {MCM: OCC(=O)C1CC(CC(=O)OON(=O)=O)C1(C)C}
NC526O       =  5C  +  8H  +   N  +  5O         ; {@NC526O}       {MCM: O=CCC(CO[N+](=O)[O-])([O])C}
ALLYLOH      =  3C  +  6H  +   O                ; {@ALLYLOH}      {MCM: OCC=C}
C922O        =  9C  + 15H  +  5O                ; {@C922O}        {MCM: OCC(=O)C(=O)CC(CO)C(C)(C)[O]}
IECCHO       =  5C  +  8H  +  3O                ; {@IECCHO}       {MCM: CC1(CO1)C(O)C=O}
C87OOH       =  8C  + 12H  +  5O                ; {@C87OOH}       {MCM: OOCC(=O)C(C=O)C(C)(C)C=O}
C813OH       =  8C  + 14H  +  5O                ; {@C813OH}       {MCM: OCC(CC(=O)C(=O)O)C(C)(C)O}
C4CO2O       =  4C  +  5H  +  3O                ; {@C4CO2O}       {MCM: O=CC([O])C(=O)C}
MC3CODBPAN   =  5C  +  5H  +   N  +  6O         ; {@MC3CODBPAN}   {MCM: O=CC=C(C)C(=O)OON(=O)=O}
C717OOH      =  7C  + 10H  +  5O                ; {@C717OOH}      {MCM: O=CCC(OO)CC(=O)C(=O)C}
C9DCO2       =  9C  + 11H  +  4O                ; {@C9DCO2}       {MCM: [O]OC1C2C(=O)CC(=O)C1C2(C)C}
CH2OOG       =   C  +  2H  +  2O                ; {@CH2OOG}       {MCM: [O-][O+]=C}
CH2OOF       =   C  +  2H  +  2O                ; {@CH2OOF}       {MCM: [O-][O+]=C}
CH2OOE       =   C  +  2H  +  2O                ; {@CH2OOE}       {MCM: [O-][O+]=C}
C719NO3      =  7C  + 11H  +   N  +  6O         ; {@C719NO3}      {MCM: O=C1CC(O)C(C)(ON(=O)=O)C(O)C1}
CH2OOC       =   C  +  2H  +  2O                ; {@CH2OOC}       {MCM: [O-][O+]=C}
CH2OOB       =   C  +  2H  +  2O                ; {@CH2OOB}       {MCM: [O-][O+]=C}
IPROPOLO2H   =  3C  +  8H  +  3O                ; {@IPROPOLO2H}   {MCM: OOCC(C)O}
CONM2CHO     =  4C  +  5H  +   N  +  5O         ; {@CONM2CHO}     {MCM: O=CC(C)(C=O)ON(=O)=O}
APINAO       = 10C  + 17H  +  2O                ; {@APINAO}       {MCM: OC1CC2CC(C1(C)[O])C2(C)C}
HMGLYOOA     =  3C  +  4H  +  4O                ; {@HMGLYOOA}     {MCM: [O-]/[O+]=C(\CO)/C=O}
C23O3CCO3    =  5C  +  5H  +  6O                ; {@C23O3CCO3}    {MCM: [O]OC(=O)COC(=O)C(=O)C}
MACRNB       =  4C  +  7H  +   N  +  5O         ; {@MACRNB}       {MCM: O=CC(C)(O)CON(=O)=O}
NC91CHO      = 10C  + 15H  +   N  +  4O         ; {@NC91CHO}      {MCM: O=CC1(CCC2CC1C2(C)C)ON(=O)=O}
INB1NBCHO    =  5C  +  8H  +  2N  +  8O         ; {@INB1NBCHO}    {MCM: OCC(ON(=O)=O)C(C)(C=O)ON(=O)=O}
NC4OOA       =  4C  +  7H  +   N  +  6O         ; {@NC4OOA}       {MCM: OCC(ON(=O)=O)C(=[O+][O-])C}
C47CO3       =  5C  +  6H  +   N  +  8O         ; {@C47CO3}       {MCM: O=CC(C(C(=O)O[O])(O)C)O[N+](=O)[O-]}
C922O2       =  9C  + 15H  +  6O                ; {@C922O2}       {MCM: OCC(=O)C(=O)CC(CO)C(C)(C)O[O]}
H1C23C4CHO   =  5C  +  6H  +  4O                ; {@H1C23C4CHO}   {MCM: OCC(=O)C(=O)CC=O}
NC71CO       =  7C  +  7H  +   N  +  6O         ; {@NC71CO}       {MCM: O=C1CC(=O)C(C)(ON(=O)=O)C(=O)C1}
MACRNOO      =  4C  +  7H  +   N  +  6O         ; {@MACRNOO}      {MCM: [O-][O+]=CC(C)(CO)ON(=O)=O}
HC23C4CO3H   =  5C  +  6H  +  6O                ; {@HC23C4CO3H}   {MCM: OOC(=O)CC(=O)C(=O)CO}
C5PACALD2    =  5C  +  6H  +  4O                ; {@C5PACALD2}    {MCM: OOC(=O)/C=C(\C=O)/C}
C717NO3      =  7C  +  9H  +   N  +  6O         ; {@C717NO3}      {MCM: O=CCC(ON(=O)=O)CC(=O)C(=O)C}
C510O        =  5C  +  8H  +   N  +  6O         ; {@C510O}        {MCM: O=CC(O)C(C)([O])CON(=O)=O}
APINCNO3     = 10C  + 17H  +   N  +  4O         ; {@APINCNO3}     {MCM: O=N(=O)OC(C)(C)C1CC=C(C)C(O)C1}
C619O2       =  6C  +  7H  +  4O                ; {@C619O2}       {MCM: [O]OC1CC(=O)CCC1=O}
OCCOHCOOH    =  3C  +  6H  +  4O                ; {@OCCOHCOOH}    {MCM: OC(COO)C=O}
C97O         =  9C  + 15H  +  3O                ; {@C97O}         {MCM: OCC1CC([O])(C(=O)C)C1(C)C}
CO1M22CO3    =  5C  +  7H  +  4O                ; {@CO1M22CO3}    {MCM: [O]OC(=O)C(C)(C)C=O}
PROPGLY      =  3C  +  8H  +  2O                ; {@PROPGLY}      {MCM: OCC(C)O}
ISOP34O2     =  5C  +  9H  +  3O                ; {@ISOP34O2}     {MCM: CC(=C)C(CO[O])O}
HMACRO2      =  4C  +  7H  +  5O                ; {@HMACRO2}      {MCM: OCC(CO)(O[O])C=O}
C67CO3H      =  6C  + 10H  +  5O                ; {@C67CO3H}      {MCM: OOC(=O)CC(=O)C(C)(C)O}
C618O2       =  6C  +  9H  +  4O                ; {@C618O2}       {MCM: O=CCC(=O)C(C)(C)O[O]}
C717O2       =  7C  +  9H  +  5O                ; {@C717O2}       {MCM: O=CCC(O[O])CC(=O)C(=O)C}
NOPINBO      =  9C  + 13H  +  2O                ; {@NOPINBO}      {MCM: O=C1CCC2C([O])C1C2(C)C}
HMVKNGLYOX   =  4C  +  5H  +   N  +  6O         ; {@HMVKNGLYOX}   {MCM: OCC(ON(=O)=O)C(=O)C=O}
C57NO3CO3H   =  5C  +  9H  +   N  +  8O         ; {@C57NO3CO3H}   {MCM: OCC(O)C(C)(ON(=O)=O)C(=O)OO}
C526O2       =  5C  +  9H  +  6O                ; {@C526O2}       {MCM: OCC(C(C=O)(O[O])C)OO}
C719O2       =  7C  + 11H  +  5O                ; {@C719O2}       {MCM: [O]OC1(C)C(O)CC(=O)CC1O}
CH3CHOHCHO   =  3C  +  6H  +  2O                ; {@CH3CHOHCHO}   {MCM: CC(O)C=O}
C97OH        =  9C  + 16H  +  3O                ; {@C97OH}        {MCM: OCC1CC(O)(C(=O)C)C1(C)C}
NISOPNO3     =  5C  +  8H  +  2N  +  6O         ; {@NISOPNO3}     {MCM: CC(=CCON(=O)=O)CON(=O)=O}
IEC2OOH      =  5C  +  8H  +  5O                ; {@IEC2OOH}      {MCM: OCC(=O)C(C)(OO)C=O}
MVKOHAOH     =  4C  +  8H  +  4O                ; {@MVKOHAOH}     {MCM: OCC(=O)C(O)CO}
APINBCO      = 10C  + 16H  +  2O                ; {@APINBCO}      {MCM: O=C1CC2CC(C2(C)C)C1(C)O}
MVKOHBO2     =  4C  +  7H  +  5O                ; {@MVKOHBO2}     {MCM: OCC(=O)C(CO)O[O]}
MGLOO        =  3C  +  4H  +  3O                ; {@MGLOO}        {MCM: [O-][O+]=CC(=O)C}
PXYFUOH      =  5C  +  8H  +  4O                ; {@PXYFUOH}      {MCM: CC1(O)C(O)COC1=O}
INDHPCO3     =  5C  +  8H  +   N  +  9O         ; {@INDHPCO3}     {MCM: [O]OC(=O)C(C)(OO)C(CO)ON(=O)=O}
C915O        =  9C  + 13H  +  3O                ; {@C915O}        {MCM: O=CC1C(=O)CCC([O])C1(C)C}
C720O        =  7C  + 11H  +  2O                ; {@C720O}        {MCM: CC1=CCC([O])CC1O}
INDOH        =  5C  + 11H  +   N  +  6O         ; {@INDOH}        {MCM: OCC(ON(=O)=O)C(C)(O)CO}
MVKOHAOOH    =  4C  +  8H  +  5O                ; {@MVKOHAOOH}    {MCM: OOCC(O)C(=O)CO}
C617CHO      =  7C  + 10H  +  3O                ; {@C617CHO}      {MCM: O=CCC(=O)C(C)(C)C=O}
MGLYOO       =  3C  +  4H  +  3O                ; {@MGLYOO}       {MCM: [O-][O+]=C(C)C=O}
C58NO3CO2H   =  5C  +  9H  +   N  +  7O         ; {@C58NO3CO2H}   {MCM: OCC(C)(ON(=O)=O)C(O)C(=O)O}
C524O2       =  5C  +  9H  +  4O                ; {@C524O2}       {MCM: OCC(=C)C(CO)O[O]}
NOAOOA       =  3C  +  5H  +   N  +  5O         ; {@NOAOOA}       {MCM: [O-][O+]=C(C)CON(=O)=O}
H13CO2CO3H   =  4C  +  6H  +  6O                ; {@H13CO2CO3H}   {MCM: OCC(=O)C(O)C(=O)OO}
C88CO        =  8C  + 10H  +  3O                ; {@C88CO}        {MCM: O=C1CCC(=O)C(C)(C)C1=O}
INB1NACO2H   =  5C  +  8H  +  2N  +  9O         ; {@INB1NACO2H}   {MCM: OCC(C)(ON(=O)=O)C(ON(=O)=O)C(=O)O}
IEAPAN       =  5C  +  7H  +   N  +  7O         ; {@IEAPAN}       {MCM: O=N(=O)OOC(=O)C(C)(O)C1OC1}
IEB4CHO      =  5C  +  8H  +  3O                ; {@IEB4CHO}      {MCM: CC1(CO)OC1C=O}
C621OOH      =  6C  + 10H  +  6O                ; {@C621OOH}      {MCM: OCC(OO)CC(=O)C(=O)CO}
C524OH       =  5C  + 10H  +  3O                ; {@C524OH}       {MCM: OCC(=C)C(O)CO}
C9DCOH       =  9C  + 12H  +  3O                ; {@C9DCOH}       {MCM: O=C1CC(=O)C2C(O)C1C2(C)C}
C109O        = 10C  + 15H  +  3O                ; {@C109O}        {MCM: O=CCC1CC(C(=O)C[O])C1(C)C}
CO1M22CO2H   =  5C  +  8H  +  3O                ; {@CO1M22CO2H}   {MCM: O=CC(C)(C)C(=O)O}
C719OH       =  7C  + 12H  +  4O                ; {@C719OH}       {MCM: O=C1CC(O)C(C)(O)C(O)C1}
MVKOHAO2     =  4C  +  7H  +  5O                ; {@MVKOHAO2}     {MCM: [O]OCC(O)C(=O)CO}
INANCOPAN    =  5C  +  5H  +  3N  + 12O         ; {@INANCOPAN}    {MCM: O=N(=O)OCC(=O)C(C)(ON(=O)=O)C(=O)OON(=O)=O}
HC4CCHO      =  5C  +  8H  +  2O                ; {@HC4CCHO}      {MCM: CC(=CCO)C=O}
INDOOH       =  5C  + 11H  +   N  +  7O         ; {@INDOOH}       {MCM: OCC(ON(=O)=O)C(C)(CO)OO}
C615CO3H     =  7C  + 10H  +  5O                ; {@C615CO3H}     {MCM: OOC(=O)C(C=O)C(C)(C)C=O}
C717OH       =  7C  + 10H  +  4O                ; {@C717OH}       {MCM: O=CCC(O)CC(=O)C(=O)C}
MMALNBCO2H   =  5C  +  7H  +   N  +  7O         ; {@MMALNBCO2H}   {MCM: O=CC(O)C(C)(ON(=O)=O)C(=O)O}
C617O        =  6C  +  9H  +  3O                ; {@C617O}        {MCM: [O]CC(=O)C(C)(C)C=O}
C918CHO      = 10C  + 16H  +  2O                ; {@C918CHO}      {MCM: O=CC1(O)CCC2CC1C2(C)C}
C919OOH      =  9C  + 14H  +  5O                ; {@C919OOH}      {MCM: O=CCC(=O)C(CC=O)C(C)(C)OO}
MACRNBCO3H   =  4C  +  7H  +   N  +  6O         ; {@MACRNBCO3H}   {MCM: O=N(=O)OCC(C)(O)C(=O)O}
ISOPDO       =  5C  +  9H  +  2O                ; {@ISOPDO}       {MCM: CC(=C)C([O])CO}
H1CO23CHO    =  4C  +  4H  +  4O                ; {@H1CO23CHO}    {MCM: OCC(=O)C(=O)C=O}
PACLOOA      =  3C  +  6H  +  4O                ; {@PACLOOA}      {MCM: [O-][O+]=C(COO)C}
C811NO3      =  8C  + 13H  +   N  +  5O         ; {@C811NO3}      {MCM: O=N(=O)OCC1CC(C(=O)O)C1(C)C}
APINBO       = 10C  + 17H  +  2O                ; {@APINBO}       {MCM: [O]C1CC2CC(C1(C)O)C2(C)C}
INDHCO3H     =  5C  +  9H  +   N  +  8O         ; {@INDHCO3H}     {MCM: OCC(ON(=O)=O)C(C)(O)C(=O)OO}
APINCOH      = 10C  + 18H  +  2O                ; {@APINCOH}      {MCM: CC1=CCC(CC1O)C(C)(C)O}
C810O        =  8C  + 13H  +  3O                ; {@C810O}        {MCM: O=CCC(CC=O)C(C)(C)[O]}
C98NO3       =  9C  + 15H  +   N  +  6O         ; {@C98NO3}       {MCM: OCC(CC(=O)C(=O)C)C(C)(C)ON(=O)=O}
C6PAN9       =  6C  +  9H  +   N  +  7O         ; {@C6PAN9}       {MCM: O=N(=O)OOC(=O)CC(=O)C(C)(C)O}
C51NO3       =  5C  +  9H  +   N  +  5O         ; {@C51NO3}       {MCM: OCC(CC(=O)C)ON(=O)=O}
GAOO         =  2C  +  4H  +  3O                ; {@GAOO}         {MCM: [O-][O+]=CCO}
C87CO2H      =  9C  + 12H  +  5O                ; {@C87CO2H}      {MCM: O=CC(C(=O)CC(=O)O)C(C)(C)C=O}
NC41OO       =  4C  +  7H  +   N  +  6O         ; {@NC41OO}       {MCM: OC(C(=[O+][O-])C)CON(=O)=O}
MACRNBCO3    =  4C  +  6H  +   N  +  7O         ; {@MACRNBCO3}    {MCM: [O]OC(=O)C(C)(O)CON(=O)=O}
H3C25C6O     =  6C  +  9H  +  4O                ; {@H3C25C6O}     {MCM: CC(=O)C(O)CC(=O)C[O]}
IEACO3       =  5C  +  7H  +  5O                ; {@IEACO3}       {MCM: CC(O)(C1CO1)C(=O)O[O]}
HMGLOO       =  3C  +  4H  +  4O                ; {@HMGLOO}       {MCM: [O-][O+]=CC(=O)CO}
C23O3CPAN    =  5C  +  5H  +   N  +  8O         ; {@C23O3CPAN}    {MCM: O=C(OON(=O)=O)COC(=O)C(=O)C}
IEPOXB       =  5C  + 10H  +  3O                ; {@IEPOXB}       {MCM: OCC1OC1(C)CO}
C57O2        =  5C  +  9H  +  5O                ; {@C57O2}        {MCM: OCC(O)C(C)(O[O])C=O}
INCGLYOX     =  5C  +  7H  +   N  +  6O         ; {@INCGLYOX}     {MCM: O=CC(=O)C(C)(O)CON(=O)=O}
C617OH       =  6C  + 10H  +  3O                ; {@C617OH}       {MCM: OCC(=O)C(C)(C)C=O}
DNC524CO     =  5C  +  8H  +  2N  +  9O         ; {@DNC524CO}     {MCM: OCC(ON(=O)=O)C(CO)(C=O)ON(=O)=O}
OCCOHCOH     =  3C  +  6H  +  3O                ; {@OCCOHCOH}     {MCM: OC(CO)C=O}
C51O2        =  5C  +  9H  +  4O                ; {@C51O2}        {MCM: OCC(O[O])CC(=O)C}
IECPAN       =  5C  +  7H  +   N  +  7O         ; {@IECPAN}       {MCM: O=N(=O)OOC(=O)C(O)C1(C)OC1}
NOPINBOH     =  9C  + 14H  +  2O                ; {@NOPINBOH}     {MCM: O=C1CCC2C(O)C1C2(C)C}
HIEB1O       =  5C  +  9H  +  5O                ; {@HIEB1O}       {MCM: OCC(O)C([O])(CO)C=O}
C2OHOCOOH    =  3C  +  6H  +  5O                ; {@C2OHOCOOH}    {MCM: OCC(O)C(=O)OO}
C513O        =  5C  +  7H  +  4O                ; {@C513O}        {MCM: [O]C(C=O)C(=O)CCO}
INB1HPCO3H   =  5C  +  9H  +   N  +  9O         ; {@INB1HPCO3H}   {MCM: OOC(=O)C(OO)C(C)(CO)ON(=O)=O}
C719O        =  7C  + 11H  +  4O                ; {@C719O}        {MCM: O=C1CC(O)C(C)([O])C(O)C1}
NOPINBO2     =  9C  + 13H  +  3O                ; {@NOPINBO2}     {MCM: [O]OC1C2CCC(=O)C1C2(C)C}
C510OOH      =  5C  +  9H  +   N  +  7O         ; {@C510OOH}      {MCM: O=CC(O)C(C)(OO)CON(=O)=O}
TBUTOLO2     =  4C  +  9H  +  3O                ; {@TBUTOLO2}     {MCM: [O]OCC(C)(C)O}
MACROHO      =  4C  +  7H  +  3O                ; {@MACROHO}      {MCM: CC(O)(C[O])C=O}
C51OH        =  5C  + 10H  +  3O                ; {@C51OH}        {MCM: CC(=O)CC(O)CO}
INDO2        =  5C  + 10H  +   N  +  7O         ; {@INDO2}        {MCM: OCC(ON(=O)=O)C(C)(CO)O[O]}
INB1HPCO2H   =  5C  +  9H  +   N  +  8O         ; {@INB1HPCO2H}   {MCM: OOC(C(=O)O)C(C)(CO)ON(=O)=O}
C536O        =  5C  +  9H  +  6O                ; {@C536O}        {MCM: OOCC(C(C=O)([O])C)OO}
IPROPOLO2    =  3C  +  7H  +  3O                ; {@IPROPOLO2}    {MCM: [O]OCC(C)O}
CONM2PAN     =  4C  +  4H  +  2N  +  9O         ; {@CONM2PAN}     {MCM: O=CC(C)(ON(=O)=O)C(=O)OON(=O)=O}
C86O         =  8C  + 13H  +  3O                ; {@C86O}         {MCM: O=CCC(C(=O)C)C(C)(C)[O]}
INB1HPPAN    =  5C  +  8H  +  2N  + 11O         ; {@INB1HPPAN}    {MCM: OOC(C(=O)OON(=O)=O)C(C)(CO)ON(=O)=O}
C914O        =  9C  + 11H  +  4O                ; {@C914O}        {MCM: O=CC1C(=O)CC(=O)C([O])C1(C)C}
CO2C3CO2H    =  4C  +  6H  +  3O                ; {@CO2C3CO2H}    {MCM: CC(=O)CC(=O)O}
C813NO3      =  8C  + 13H  +   N  +  7O         ; {@C813NO3}      {MCM: OCC(CC(=O)C(=O)O)C(C)(C)ON(=O)=O}
MMALNBPAN    =  5C  +  6H  +  2N  + 10O         ; {@MMALNBPAN}    {MCM: O=CC(O)C(C)(ON(=O)=O)C(=O)OON(=O)=O}
C3MDIALOOH   =  4C  +  6H  +  4O                ; {@C3MDIALOOH}   {MCM: OOC(C)(C=O)C=O}
HPNC524CO    =  5C  +  9H  +   N  +  8O         ; {@HPNC524CO}    {MCM: OCC(ON(=O)=O)C(CO)(OO)C=O}
C47CO3H      =  5C  +  7H  +   N  +  8O         ; {@C47CO3H}      {MCM: O=CC(C(C(=O)OO)(O)C)O[N+](=O)[O-]}
NAPINBO      = 10C  + 16H  +   N  +  4O         ; {@NAPINBO}      {MCM: O=N(=O)OC1(C)C([O])CC2CC1C2(C)C}
C45OOH       =  4C  +  8H  +  2O                ; {@C45OOH}       {MCM: CC(=C)COO}
INAHPCO2H    =  5C  +  9H  +   N  +  8O         ; {@INAHPCO2H}    {MCM: OOC(C)(C(=O)O)C(O)CON(=O)=O}
APINCO2      = 10C  + 17H  +  3O                ; {@APINCO2}      {MCM: [O]OC(C)(C)C1CC=C(C)C(O)C1}
CHOC2CO2H    =  4C  +  6H  +  3O                ; {@CHOC2CO2H}    {MCM: O=CCCC(=O)O}
HMVKBO       =  4C  +  7H  +  3O                ; {@HMVKBO}       {MCM: CC(=O)C([O])CO}
GAOOB        =  2C  +  4H  +  3O                ; {@GAOOB}        {MCM: [O-][O+]=CCO}
C618CO3H     =  7C  + 10H  +  5O                ; {@C618CO3H}     {MCM: O=CCC(=O)C(C)(C)C(=O)OO}
MMALNBCO3H   =  5C  +  7H  +   N  +  8O         ; {@MMALNBCO3H}   {MCM: O=CC(O)C(C)(ON(=O)=O)C(=O)OO}
NC101O2      = 10C  + 14H  +   N  +  6O         ; {@NC101O2}      {MCM: [O]OC12CC(=O)C(C)(ON(=O)=O)C(C1)C2(C)C}
HMVKANO3     =  4C  +  7H  +   N  +  5O         ; {@HMVKANO3}     {MCM: O=N(=O)OCC(O)C(=O)C}
MACROHO2     =  4C  +  7H  +  4O                ; {@MACROHO2}     {MCM: CC(O)(CO[O])C=O}
HMVKBO2      =  4C  +  7H  +  4O                ; {@HMVKBO2}      {MCM: OCC(O[O])C(=O)C}
IBUTALCO2    =  4C  +  7H  +  3O                ; {@IBUTALCO2}    {MCM: [O]OC(C)(C)C=O}
NPXYFUO      =  5C  +  6H  +   N  +  6O         ; {@NPXYFUO}      {MCM: O=N(=O)OC1COC(=O)C1(C)[O]}
HYPROPO      =  3C  +  7H  +  2O                ; {@HYPROPO}      {MCM: OCC(C)[O]}
C534O        =  5C  +  7H  +  6O                ; {@C534O}        {MCM: CC(C(=O)OO)(C(C=O)O)[O]}
INB1NBCO3H   =  5C  +  8H  +  2N  + 10O         ; {@INB1NBCO3H}   {MCM: OOC(=O)C(C)(ON(=O)=O)C(CO)ON(=O)=O}
H13CO2CHO    =  4C  +  6H  +  4O                ; {@H13CO2CHO}    {MCM: OC(C=O)C(=O)CO}
APINAO2      = 10C  + 17H  +  3O                ; {@APINAO2}      {MCM: [O]OC1(C)C(O)CC2CC1C2(C)C}
COHM2CO3     =  4C  +  5H  +  5O                ; {@COHM2CO3}     {MCM: CC(O)(C=O)C(=O)O[O]}
HC4CCO2H     =  5C  +  8H  +  3O                ; {@HC4CCO2H}     {MCM: OCC=C(C)C(=O)O}
C515O        =  5C  +  5H  +  4O                ; {@C515O}        {MCM: [O]CC(=O)C(=O)CC=O}
C614O        =  6C  +  9H  +  4O                ; {@C614O}        {MCM: CC(=O)C(=O)CC([O])CO}
IBUTALO2H    =  4C  +  8H  +  3O                ; {@IBUTALO2H}    {MCM: OOC(C)(C)C=O}
HMACROH      =  4C  +  8H  +  4O                ; {@HMACROH}      {MCM: OCC(O)(CO)C=O}
HSO3 = IGNORE ;
C57NO3CO3    =  5C  +  8H  +   N  +  8O         ; {@C57NO3CO3}    {MCM: OCC(O)C(C)(ON(=O)=O)C(=O)O[O]}
ISOPCO2      =  5C  +  9H  +  3O                ; {@ISOPCO2}      {MCM: [O]OC/C(=C/CO)/C}
C718OOH      =  7C  + 12H  +  4O                ; {@C718OOH}      {MCM: OOCCC(=O)C(C)(C)C=O}
C537O        =  5C  +  9H  +  6O                ; {@C537O}        {MCM: OOCC(C(C=O)[O])(OO)C}
NOPINDOH     =  9C  + 14H  +  2O                ; {@NOPINDOH}     {MCM: OC1CC2CC(C1=O)C2(C)C}
IPROPOLPAN   =  3C  +  5H  +   N  +  6O         ; {@IPROPOLPAN}   {MCM: O=N(=O)OOC(=O)C(C)O}
C57AOOH      =  5C  + 10H  +  5O                ; {@C57AOOH}      {MCM: OCC(C(C=O)(O)C)OO}
MACRNCO3     =  4C  +  6H  +   N  +  7O         ; {@MACRNCO3}     {MCM: [O]OC(=O)C(C)(CO)ON(=O)=O}
BPINBO2      = 10C  + 17H  +  3O                ; {@BPINBO2}      {MCM: [O]OCC1(O)CCC2CC1C2(C)C}
C918O        =  9C  + 13H  +  3O                ; {@C918O}        {MCM: O=CCC(=O)C1CC([O])C1(C)C}
NAPINBOOH    = 10C  + 17H  +   N  +  5O         ; {@NAPINBOOH}    {MCM: OOC1CC2CC(C1(C)ON(=O)=O)C2(C)C}
INB1NO3      =  5C  + 10H  +  2N  +  8O         ; {@INB1NO3}      {MCM: OCC(ON(=O)=O)C(C)(CO)ON(=O)=O}
GLYOO        =  2C  +  2H  +  3O                ; {@GLYOO}        {MCM: [O-][O+]=CC=O}
C524NO3      =  5C  +  9H  +   N  +  5O         ; {@C524NO3}      {MCM: OCC(=C)C(CO)ON(=O)=O}
C531O        =  5C  +  5H  +  4O                ; {@C531O}        {MCM: O=COC=CC(=O)C[O]}
INDHCO3      =  5C  +  8H  +   N  +  8O         ; {@INDHCO3}      {MCM: OCC(ON(=O)=O)C(C)(O)C(=O)O[O]}
C616O        =  6C  +  7H  +  4O                ; {@C616O}        {MCM: O=CCCC(=O)C([O])C=O}
ISOPAO2      =  5C  +  9H  +  3O                ; {@ISOPAO2}      {MCM: [O]OC/C=C(/CO)C}
HOCHOCOOH    =  3C  +  6H  +  4O                ; {@HOCHOCOOH}    {MCM: OCC(OO)C=O}
HC4CHO       =  5C  +  8H  +  2O                ; {@HC4CHO}       {MCM: CC(=C)C(C=O)O}
A2PANOO      =  3C  +  5H  +  5O                ; {@A2PANOO}      {MCM: OCC(O)C(=O)O[O]}
C617CO3H     =  7C  + 10H  +  5O                ; {@C617CO3H}     {MCM: OOC(=O)CC(=O)C(C)(C)C=O}
HIEB1OOH     =  5C  + 10H  +  6O                ; {@HIEB1OOH}     {MCM: OCC(O)C(CO)(OO)C=O}
C721O        =  7C  + 11H  +  3O                ; {@C721O}        {MCM: OC(=O)C1CC([O])C1(C)C}
NBPINBO      = 10C  + 16H  +   N  +  4O         ; {@NBPINBO}      {MCM: [O]CC1(CCC2CC1C2(C)C)ON(=O)=O}
ISOP34O      =  5C  +  9H  +  2O                ; {@ISOP34O}      {MCM: CC(=C)C(C[O])O}
HC4CCO3      =  5C  +  7H  +  4O                ; {@HC4CCO3}      {MCM: OCC=C(C)C(=O)O[O]}
HMACR        =  4C  +  6H  +  2O                ; {@HMACR}        {MCM: OCC(=C)C=O}
INCNCO2H     =  5C  +  8H  +  2N  +  9O         ; {@INCNCO2H}     {MCM: O=N(=O)OCC(C)(O)C(ON(=O)=O)C(=O)O}
APINAOOH     = 10C  + 18H  +  3O                ; {@APINAOOH}     {MCM: OOC1(C)C(O)CC2CC1C2(C)C}
CO2N3CO3H    =  4C  +  5H  +   N  +  7O         ; {@CO2N3CO3H}    {MCM: OOC(=O)C(ON(=O)=O)C(=O)C}
C920CO3H     = 10C  + 16H  +  5O                ; {@C920CO3H}     {MCM: OOC(=O)CC1CC(C(=O)CO)C1(C)C}
HOPINONIC    = 10C  + 16H  +  4O                ; {@HOPINONIC}    {MCM: OCC(=O)C1CC(CC(=O)O)C1(C)C}
C719OOH      =  7C  + 12H  +  5O                ; {@C719OOH}      {MCM: OOC1(C)C(O)CC(=O)CC1O}
HC4ACO3      =  5C  +  7H  +  4O                ; {@HC4ACO3}      {MCM: OCC(=CC(=O)O[O])C}
MACROHOOH    =  4C  +  8H  +  4O                ; {@MACROHOOH}    {MCM: CC(O)(COO)C=O}
NC91CO3H     = 10C  + 15H  +   N  +  6O         ; {@NC91CO3H}     {MCM: OOC(=O)C1(CCC2CC1C2(C)C)ON(=O)=O}
C921O2       =  9C  + 15H  +  5O                ; {@C921O2}       {MCM: OCC(=O)C1(O[O])CC(CO)C1(C)C}
C920O2       =  9C  + 15H  +  4O                ; {@C920O2}       {MCM: [O]OCC1CC(C(=O)CO)C1(C)C}
C527O2       =  5C  +  9H  +  6O                ; {@C527O2}       {MCM: [O]OC(C(OO)(CO)C)C=O}
CO23C4NO3    =  4C  +  5H  +   N  +  5O         ; {@CO23C4NO3}    {MCM: O=N(=O)OCC(=O)C(=O)C}
C512NO3      =  5C  +  7H  +   N  +  5O         ; {@C512NO3}      {MCM: O=CCC(=O)CCON(=O)=O}
C57OOH       =  5C  + 10H  +  5O                ; {@C57OOH}       {MCM: OCC(O)C(C)(OO)C=O}
C615CO3      =  7C  +  9H  +  5O                ; {@C615CO3}      {MCM: [O]OC(=O)C(C=O)C(C)(C)C=O}
COHM2PAN     =  4C  +  5H  +   N  +  7O         ; {@COHM2PAN}     {MCM: O=CC(C)(O)C(=O)OON(=O)=O}
CH3CHOHCO3   =  3C  +  5H  +  4O                ; {@CH3CHOHCO3}   {MCM: [O]OC(=O)C(C)O}
NC41OOA      =  4C  +  7H  +   N  +  6O         ; {@NC41OOA}      {MCM: OC(C(=[O+][O-])C)CON(=O)=O}
COHM2CO2H    =  4C  +  6H  +  4O                ; {@COHM2CO2H}    {MCM: O=CC(C)(O)C(=O)O}
C620OOH      =  6C  +  8H  +  5O                ; {@C620OOH}      {MCM: O=CCC(=O)C(OO)CC=O}
C98O         =  9C  + 15H  +  4O                ; {@C98O}         {MCM: OCC(CC(=O)C(=O)C)C(C)(C)[O]}
H1C23C4O2    =  4C  +  5H  +  5O                ; {@H1C23C4O2}    {MCM: [O]OCC(=O)C(=O)CO}
INB1HPCO3    =  5C  +  8H  +   N  +  9O         ; {@INB1HPCO3}    {MCM: [O]OC(=O)C(OO)C(C)(CO)ON(=O)=O}
NC102O       = 10C  + 14H  +   N  +  6O         ; {@NC102O}       {MCM: O=C1CC(=O)C(C)(ON(=O)=O)C(C1)C(C)(C)[O]}
C514O        =  5C  +  7H  +  3O                ; {@C514O}        {MCM: O=CCC([O])CC=O}
C23O3CCHO    =  5C  +  6H  +  4O                ; {@C23O3CCHO}    {MCM: O=CCOC(=O)C(=O)C}
C5PAN19      =  5C  +  7H  +   N  +  6O         ; {@C5PAN19}      {MCM: OCC=C(C)C(=O)OON(=O)=O}
C5PAN18      =  5C  +  6H  +  2N  +  8O         ; {@C5PAN18}      {MCM: O=N(=O)OCC(=CC(=O)OON(=O)=O)C}
PXYFUOOH     =  5C  +  8H  +  5O                ; {@PXYFUOOH}     {MCM: OOC1(C)C(O)COC1=O}
C5PAN11      =  5C  +  9H  +   N  +  6O         ; {@C5PAN11}      {MCM: O=N(=O)OOC(=O)CC(C)(C)O}
CO1M22CHO    =  5C  +  8H  +  2O                ; {@CO1M22CHO}    {MCM: O=CC(C)(C)C=O}
C5PAN17      =  5C  +  7H  +   N  +  6O         ; {@C5PAN17}      {MCM: OCC(=CC(=O)OON(=O)=O)C}
C55OOH       =  5C  + 10H  +  4O                ; {@C55OOH}       {MCM: OOCC(=O)C(C)(C)O}
C921OOH      =  9C  + 16H  +  5O                ; {@C921OOH}      {MCM: OCC(=O)C1(OO)CC(CO)C1(C)C}
CHOC2H4O2    =  3C  +  5H  +  3O                ; {@CHOC2H4O2}    {MCM: [O]OCCC=O}
C525O2       =  5C  +  9H  +  6O                ; {@C525O2}       {MCM: OCC(=O)C(CO)(CO)O[O]}
INB1NBCO3    =  5C  +  7H  +  2N  + 10O         ; {@INB1NBCO3}    {MCM: [O]OC(=O)C(C)(ON(=O)=O)C(CO)ON(=O)=O}
NC101OOH     = 10C  + 15H  +   N  +  6O         ; {@NC101OOH}     {MCM: OOC12CC(=O)C(C)(ON(=O)=O)C(C1)C2(C)C}
NOPINBOOH    =  9C  + 14H  +  3O                ; {@NOPINBOOH}    {MCM: OOC1C2CCC(=O)C1C2(C)C}
C533OOH      =  5C  +  8H  +  6O                ; {@C533OOH}      {MCM: O=COC(C(C(=O)C)OO)O}
MACRNOOA     =  4C  +  7H  +   N  +  6O         ; {@MACRNOOA}     {MCM: [O-][O+]=CC(C)(CO)ON(=O)=O}
HMACO3H      =  4C  +  6H  +  4O                ; {@HMACO3H}      {MCM: OCC(=C)C(=O)OO}
C57AO2       =  5C  +  9H  +  5O                ; {@C57AO2}       {MCM: OCC(C(C=O)(O)C)O[O]}
C87CO3       =  9C  + 11H  +  6O                ; {@C87CO3}       {MCM: [O]OC(=O)CC(=O)C(C=O)C(C)(C)C=O}
H3C2C4CO3    =  5C  +  7H  +  5O                ; {@H3C2C4CO3}    {MCM: CC(=O)C(O)CC(=O)O[O]}
HCOCH2O      =  2C  +  3H  +  2O                ; {@HCOCH2O}      {MCM: [O]CC=O}
C31PAN       =  4C  +  3H  +   N  +  7O         ; {@C31PAN}       {MCM: O=COC=CC(=O)OO[N+](=O)[O-]}
C525O        =  5C  +  9H  +  5O                ; {@C525O}        {MCM: OCC(=O)C([O])(CO)CO}
INANCO       =  5C  +  8H  +  2N  +  8O         ; {@INANCO}       {MCM: OCC(C)(ON(=O)=O)C(=O)CON(=O)=O}
C5HPALD2     =  5C  +  8H  +  3O                ; {@C5HPALD2}     {MCM: C/C(=C/C=O)/COO}
C5HPALD1     =  5C  +  8H  +  3O                ; {@C5HPALD1}     {MCM: C/C(=C/COO)/C=O}
CO2C3PAN     =  4C  +  5H  +   N  +  6O         ; {@CO2C3PAN}     {MCM: CC(=O)CC(=O)OON(=O)=O}
CO1M22CO3H   =  5C  +  8H  +  4O                ; {@CO1M22CO3H}   {MCM: OOC(=O)C(C)(C)C=O}
C88PAN       =  9C  + 11H  +   N  +  7O         ; {@C88PAN}       {MCM: O=N(=O)OOC(=O)C1C(=O)CCC(=O)C1(C)C}
BIACETO      =  4C  +  5H  +  3O                ; {@BIACETO}      {MCM: CC(=O)C(=O)C[O]}
C530O        =  5C  +  9H  +  3O                ; {@C530O}        {MCM: CC(CO)(CC=O)[O]}
C720OH       =  7C  + 12H  +  2O                ; {@C720OH}       {MCM: CC1=CCC(O)CC1O}
C618PAN      =  7C  +  9H  +   N  +  7O         ; {@C618PAN}      {MCM: O=CCC(=O)C(C)(C)C(=O)OON(=O)=O}
NOPINCOH     =  9C  + 14H  +  2O                ; {@NOPINCOH}     {MCM: O=C1CCC2(O)CC1C2(C)C}
C3DIOLO2     =  3C  +  7H  +  4O                ; {@C3DIOLO2}     {MCM: [O]OCC(O)CO}
INB2O2       =  5C  + 10H  +   N  +  7O         ; {@INB2O2}       {MCM: [O]OCC(O)C(C)(CO)ON(=O)=O}
C718PAN      =  8C  + 11H  +   N  +  7O         ; {@C718PAN}      {MCM: O=CC(C)(C)C(=O)CCC(=O)OON(=O)=O}
MACRNBCO2H   =  4C  +  7H  +   N  +  6O         ; {@MACRNBCO2H}   {MCM: O=N(=O)OCC(C)(O)C(=O)O}
NOPINCOOH    =  9C  + 14H  +  3O                ; {@NOPINCOOH}    {MCM: OOC12CCC(=O)C(C1)C2(C)C}
C512O        =  5C  +  7H  +  3O                ; {@C512O}        {MCM: [O]CCC(=O)CC=O}
NC102O2      = 10C  + 14H  +   N  +  7O         ; {@NC102O2}      {MCM: [O]OC(C)(C)C1CC(=O)CC(=O)C1(C)ON(=O)=O}
NO3CH2CO2H   =  2C  +  3H  +   N  +  5O         ; {@NO3CH2CO2H}   {MCM: OC(=O)CON(=O)=O}
NOPINCO2     =  9C  + 13H  +  3O                ; {@NOPINCO2}     {MCM: [O]OC12CCC(=O)C(C1)C2(C)C}
C9DCO        =  9C  + 11H  +  3O                ; {@C9DCO}        {MCM: O=C1CC(=O)C2C([O])C1C2(C)C}
C516O        =  5C  +  7H  +  5O                ; {@C516O}        {MCM: OCC([O])CC(=O)C(=O)O}
HPC52OOH     =  5C  + 10H  +  6O                ; {@HPC52OOH}     {MCM: OOCC(C(C=O)O)(OO)C}
C720O2       =  7C  + 11H  +  3O                ; {@C720O2}       {MCM: [O]OC1CC=C(C)C(O)C1}
INAHPPAN     =  5C  +  8H  +  2N  + 11O         ; {@INAHPPAN}     {MCM: OOC(C)(C(O)CON(=O)=O)C(=O)OON(=O)=O}
C512PAN      =  6C  +  7H  +   N  +  7O         ; {@C512PAN}      {MCM: O=CCC(=O)CCC(=O)OON(=O)=O}
MCOCOMOXO2   =  4C  +  5H  +  5O                ; {@MCOCOMOXO2}   {MCM: CC(=O)C(=O)OCO[O]}
MMALNACO2H   =  5C  +  7H  +   N  +  7O         ; {@MMALNACO2H}   {MCM: O=CC(C)(ON(=O)=O)C(O)C(=O)O}
NAPINAOOH    = 10C  + 17H  +   N  +  5O         ; {@NAPINAOOH}    {MCM: OOC1(C)C(ON(=O)=O)CC2CC1C2(C)C}
C42AOH       =  3C  +  5H  +   N  +  5O         ; {@C42AOH}       {MCM: O=CC(O)CON(=O)=O}
M2PROPAL2O   =  4C  +  7H  +  2O                ; {@M2PROPAL2O}   {MCM: O=CC(C)(C)[O]}
C51OOH       =  5C  + 10H  +  4O                ; {@C51OOH}       {MCM: OCC(OO)CC(=O)C}
PPGAOOB      =  2C  +  2H  +  5O                ; {@PPGAOOB}      {MCM: [O-][O+]=CC(=O)OO}
HC4ACO2H     =  5C  +  8H  +  3O                ; {@HC4ACO2H}     {MCM: OCC(=CC(=O)O)C}
C45NO3       =  4C  +  7H  +   N  +  3O         ; {@C45NO3}       {MCM: [O-][N+](=O)OCC(=C)C}
C55O2        =  5C  +  9H  +  4O                ; {@C55O2}        {MCM: [O]OCC(=O)C(C)(C)O}
PGAOOB       =  2C  +  4H  +  4O                ; {@PGAOOB}       {MCM: [O-][O+]=CCOO}
NPXYFUOOH    =  5C  +  7H  +   N  +  7O         ; {@NPXYFUOOH}    {MCM: OOC1(C)C(=O)OCC1ON(=O)=O}
C618OOH      =  6C  + 10H  +  4O                ; {@C618OOH}      {MCM: O=CCC(=O)C(C)(C)OO}
C718O        =  7C  + 11H  +  3O                ; {@C718O}        {MCM: [O]CCC(=O)C(C)(C)C=O}
C58AOOH      =  5C  + 10H  +  5O                ; {@C58AOOH}      {MCM: OOC(C=O)C(C)(O)CO}
NOPINAO2     =  9C  + 13H  +  3O                ; {@NOPINAO2}     {MCM: [O]OC1CC(=O)C2CC1C2(C)C}
C55O         =  5C  +  9H  +  3O                ; {@C55O}         {MCM: [O]CC(=O)C(C)(C)O}
HIEB2OOH     =  5C  + 10H  +  6O                ; {@HIEB2OOH}     {MCM: OOC(C=O)C(O)(CO)CO}
PINALOH      = 10C  + 16H  +  3O                ; {@PINALOH}      {MCM: O=CCC1(O)CC(C(=O)C)C1(C)C}
NC71OOH      =  7C  +  9H  +   N  +  7O         ; {@NC71OOH}      {MCM: OOC1CC(=O)CC(=O)C1(C)ON(=O)=O}
ETHENO3O     =  2C  +  4H  +   N  +  4O         ; {@ETHENO3O}     {MCM: [O]CCON(=O)=O}
HMACO2H      =  4C  +  6H  +  3O                ; {@HMACO2H}      {MCM: OCC(=C)C(=O)O}
HNC524CO     =  5C  +  9H  +   N  +  7O         ; {@HNC524CO}     {MCM: OCC(ON(=O)=O)C(O)(CO)C=O}
HPC52PAN     =  5C  +  9H  +   N  + 10O         ; {@HPC52PAN}     {MCM: OOCC(C(C(=O)OO[N+](=O)[O-])O)(OO)C}
HCOCH2OOH    =  2C  +  4H  +  3O                ; {@HCOCH2OOH}    {MCM: OOCC=O}
MCOCOMOOOH   =  4C  +  6H  +  5O                ; {@MCOCOMOOOH}   {MCM: CC(=O)C(=O)OCOO}
BPINCOH      = 10C  + 18H  +  2O                ; {@BPINCOH}      {MCM: OCC1=CCC(CC1)C(C)(C)O}
CHOCOCH2O    =  3C  +  3H  +  3O                ; {@CHOCOCH2O}    {MCM: [O]CC(=O)C=O}
C716OH       =  7C  + 10H  +  4O                ; {@C716OH}       {MCM: O=CCC(=O)CC(O)C(=O)C}
C87CO        =  8C  + 10H  +  4O                ; {@C87CO}        {MCM: O=CC(=O)C(C=O)C(C)(C)C=O}
C720OOH      =  7C  + 12H  +  3O                ; {@C720OOH}      {MCM: OOC1CC=C(C)C(O)C1}
C9DCCO       =  9C  + 10H  +  3O                ; {@C9DCCO}       {MCM: O=C1CC(=O)C2C(=O)C1C2(C)C}
C58O2        =  5C  +  9H  +  5O                ; {@C58O2}        {MCM: O=CC(O)C(C)(CO)O[O]}
C915OOH      =  9C  + 14H  +  4O                ; {@C915OOH}      {MCM: OOC1CCC(=O)C(C=O)C1(C)C}
MC3CODBCO3   =  5C  +  5H  +  4O                ; {@MC3CODBCO3}   {MCM: CC(=CC=O)C(=O)O[O]}
MC3CODBCO2   =  5C  +  5H  +  3O                ; {@MC3CODBCO2}   {MCM: O=CC=C(C)C(=O)[O]}
INDHPPAN     =  5C  +  8H  +  2N  + 11O         ; {@INDHPPAN}     {MCM: OCC(ON(=O)=O)C(C)(OO)C(=O)OON(=O)=O}
C108NO3      = 10C  + 15H  +   N  +  6O         ; {@C108NO3}      {MCM: O=CCC(CC(=O)C(=O)C)C(C)(C)ON(=O)=O}
NO3CH2CO3H   =  2C  +  3H  +   N  +  6O         ; {@NO3CH2CO3H}   {MCM: OOC(=O)CON(=O)=O}
M3BU3ECO3H   =  5C  +  8H  +  3O                ; {@M3BU3ECO3H}   {MCM: CC(=C)CC(=O)OO}
C918CO3H     = 10C  + 16H  +  4O                ; {@C918CO3H}     {MCM: OOC(=O)C1(O)CCC2CC1C2(C)C}
HPC52O2      =  5C  +  9H  +  6O                ; {@HPC52O2}      {MCM: OOCC(C(C=O)O)(O[O])C}
C58OH        =  5C  + 10H  +  4O                ; {@C58OH}        {MCM: O=CC(O)C(C)(O)CO}
CISOPAO      =  5C  +  9H  +  2O                ; {@CISOPAO}      {MCM: [O]C/C=C(\CO)/C}
NOPINCO      =  9C  + 13H  +  2O                ; {@NOPINCO}      {MCM: O=C1CCC2([O])CC1C2(C)C}
BPINCO2      = 10C  + 17H  +  3O                ; {@BPINCO2}      {MCM: OCC1=CCC(CC1)C(C)(C)O[O]}
C47PAN       =  5C  +  6H  +  2N  + 10O         ; {@C47PAN}       {MCM: O=CC(C(C(=O)OO[N+](=O)[O-])(O)C)O[N+](=O)[O-]}
C621O2       =  6C  +  9H  +  6O                ; {@C621O2}       {MCM: OCC(O[O])CC(=O)C(=O)CO}
HMACRO       =  4C  +  7H  +  4O                ; {@HMACRO}       {MCM: OCC([O])(CO)C=O}
C57NO3CO2H   =  5C  +  9H  +   N  +  7O         ; {@C57NO3CO2H}   {MCM: OCC(O)C(C)(ON(=O)=O)C(=O)O}
NOPINOOA     =  9C  + 14H  +  2O                ; {@NOPINOOA}     {MCM: [O-][O+]=C1CCC2CC1C2(C)C}
NC71O2       =  7C  +  8H  +   N  +  7O         ; {@NC71O2}       {MCM: [O]OC1CC(=O)CC(=O)C1(C)ON(=O)=O}
CHOC2PAN     =  4C  +  5H  +   N  +  6O         ; {@CHOC2PAN}     {MCM: O=CCCC(=O)OON(=O)=O}
HMVKAOOH     =  4C  +  8H  +  4O                ; {@HMVKAOOH}     {MCM: CC(=O)C(O)COO}
INAHCO3H     =  5C  +  9H  +   N  +  8O         ; {@INAHCO3H}     {MCM: OOC(=O)C(C)(O)C(O)CON(=O)=O}
NC4CO3H      =  5C  +  7H  +   N  +  6O         ; {@NC4CO3H}      {MCM: OOC(=O)C=C(C)CON(=O)=O}
H1C23C4OOH   =  4C  +  6H  +  5O                ; {@H1C23C4OOH}   {MCM: OOCC(=O)C(=O)CO}
NOPINAOH     =  9C  + 14H  +  2O                ; {@NOPINAOH}     {MCM: OC1CC(=O)C2CC1C2(C)C}
C810OH       =  8C  + 14H  +  3O                ; {@C810OH}       {MCM: O=CCC(CC=O)C(C)(C)O}
C58NO3CO3H   =  5C  +  9H  +   N  +  8O         ; {@C58NO3CO3H}   {MCM: OOC(=O)C(O)C(C)(CO)ON(=O)=O}
INANCOCO2H   =  5C  +  6H  +  2N  +  9O         ; {@INANCOCO2H}   {MCM: O=N(=O)OCC(=O)C(C)(ON(=O)=O)C(=O)O}
CHOC2H4OOH   =  3C  +  6H  +  3O                ; {@CHOC2H4OOH}   {MCM: OOCCC=O}
C526NO3      =  5C  +  9H  +   N  +  7O         ; {@C526NO3}      {MCM: OCC(C(O[N+](=O)[O-])(C=O)C)OO}
NOPINBNO3    =  9C  + 13H  +   N  +  4O         ; {@NOPINBNO3}    {MCM: O=N(=O)OC1C2CCC(=O)C1C2(C)C}
C87PAN       =  9C  + 11H  +   N  +  8O         ; {@C87PAN}       {MCM: O=CC(C(=O)CC(=O)OON(=O)=O)C(C)(C)C=O}
INDHCHO      =  5C  +  9H  +   N  +  6O         ; {@INDHCHO}      {MCM: OCC(ON(=O)=O)C(C)(O)C=O}
HMACO3       =  4C  +  5H  +  4O                ; {@HMACO3}       {MCM: OCC(=C)C(=O)O[O]}
INDHPCHO     =  5C  +  9H  +   N  +  7O         ; {@INDHPCHO}     {MCM: OCC(ON(=O)=O)C(C)(OO)C=O}
CH3COCH2O    =  3C  +  5H  +  2O                ; {@CH3COCH2O}    {MCM: CC(=O)C[O]}
INAHPAN      =  5C  +  8H  +  2N  + 10O         ; {@INAHPAN}      {MCM: O=N(=O)OCC(O)C(C)(O)C(=O)OON(=O)=O}
INB1NAPAN    =  5C  +  7H  +  3N  + 12O         ; {@INB1NAPAN}    {MCM: OCC(C)(ON(=O)=O)C(ON(=O)=O)C(=O)OON(=O)=O}
C57AO        =  5C  +  9H  +  4O                ; {@C57AO}        {MCM: OCC(C(C=O)(O)C)[O]}
M3BU3ECO3    =  5C  +  7H  +  3O                ; {@M3BU3ECO3}    {MCM: CC(=C)CC(=O)O[O]}
C533O2       =  5C  +  7H  +  6O                ; {@C533O2}       {MCM: O=COC(C(C(=O)C)O[O])O}
CISOPCO2     =  5C  +  9H  +  3O                ; {@CISOPCO2}     {MCM: [O]OC/C(=C\CO)/C}
ACLOOA       =  3C  +  6H  +  3O                ; {@ACLOOA}       {MCM: [O-][O+]=C(C)CO}
INAO         =  5C  + 10H  +   N  +  6O         ; {@INAO}         {MCM: OCC(C)([O])C(O)CON(=O)=O}
C617CO2H     =  7C  + 10H  +  4O                ; {@C617CO2H}     {MCM: O=CC(C)(C)C(=O)CC(=O)O}
C916O        =  9C  + 13H  +  4O                ; {@C916O}        {MCM: O=CCCC(=O)C(C=O)C(C)(C)[O]}
INAHPCHO     =  5C  +  9H  +   N  +  7O         ; {@INAHPCHO}     {MCM: OOC(C)(C=O)C(O)CON(=O)=O}
INANCHO      =  5C  +  8H  +  2N  +  8O         ; {@INANCHO}      {MCM: O=CC(C)(ON(=O)=O)C(O)CON(=O)=O}
INCNPAN      =  5C  +  7H  +  3N  + 12O         ; {@INCNPAN}      {MCM: O=N(=O)OOC(=O)C(ON(=O)=O)C(C)(O)CON(=O)=O}
C722O        =  7C  + 11H  +  4O                ; {@C722O}        {MCM: O=CCC(C(=O)O)C(C)(C)[O]}
C914OOH      =  9C  + 12H  +  5O                ; {@C914OOH}      {MCM: OOC1C(=O)CC(=O)C(C=O)C1(C)C}
NC524O       =  5C  + 10H  +   N  +  7O         ; {@NC524O}       {MCM: OCC(ON(=O)=O)C([O])(CO)CO}
C4CO2O2      =  4C  +  5H  +  4O                ; {@C4CO2O2}      {MCM: [O]OC(C=O)C(=O)C}
APINCO       = 10C  + 17H  +  2O                ; {@APINCO}       {MCM: CC1=CCC(CC1O)C(C)(C)[O]}
MVKOHBO      =  4C  +  7H  +  4O                ; {@MVKOHBO}      {MCM: OCC(=O)C([O])CO}
BPINAOH      = 10C  + 18H  +  2O                ; {@BPINAOH}      {MCM: OCC1(O)CCC2CC1C2(C)C}
C4CO2OOH     =  4C  +  6H  +  4O                ; {@C4CO2OOH}     {MCM: OOC(C=O)C(=O)C}
C87CO3H      =  9C  + 12H  +  6O                ; {@C87CO3H}      {MCM: OOC(=O)CC(=O)C(C=O)C(C)(C)C=O}
C619O        =  6C  +  7H  +  3O                ; {@C619O}        {MCM: O=C1CCC(=O)C([O])C1}
C716O        =  7C  +  9H  +  4O                ; {@C716O}        {MCM: O=CCC(=O)CC([O])C(=O)C}
C107OOH      = 10C  + 16H  +  4O                ; {@C107OOH}      {MCM: O=CCC1CC(OO)(C(=O)C)C1(C)C}
C620O        =  6C  +  7H  +  4O                ; {@C620O}        {MCM: O=CCC(=O)C([O])CC=O}
GLYOOB       =  2C  +  2H  +  3O                ; {@GLYOOB}       {MCM: [O-][O+]=CC=O}
HMVKBOOH     =  4C  +  8H  +  4O                ; {@HMVKBOOH}     {MCM: OCC(OO)C(=O)C}
C718CO3H     =  8C  + 12H  +  5O                ; {@C718CO3H}     {MCM: OOC(=O)CCC(=O)C(C)(C)C=O}
NC91PAN      = 10C  + 14H  +  2N  +  8O         ; {@NC91PAN}      {MCM: O=N(=O)OOC(=O)C1(CCC2CC1C2(C)C)ON(=O)=O}
C615OOH      =  6C  + 10H  +  4O                ; {@C615OOH}      {MCM: OOC(C=O)C(C)(C)C=O}
GLYOOC       =  2C  +  2H  +  3O                ; {@GLYOOC}       {MCM: [O-][O+]=CC=O}
C67CHO       =  6C  + 10H  +  3O                ; {@C67CHO}       {MCM: O=CCC(=O)C(C)(C)O}
C535O        =  5C  +  7H  +  6O                ; {@C535O}        {MCM: CC(C(C(=O)OO)O)(C=O)[O]}
HIEB2O       =  5C  +  9H  +  5O                ; {@HIEB2O}       {MCM: O=CC([O])C(O)(CO)CO}
C51O         =  5C  +  9H  +  3O                ; {@C51O}         {MCM: CC(=O)CC([O])CO}
PR1O2HNO3    =  3C  +  7H  +   N  +  5O         ; {@PR1O2HNO3}    {MCM: OOCC(C)ON(=O)=O}
PROPALO      =  3C  +  5H  +  2O                ; {@PROPALO}      {MCM: CC([O])C=O}
PXYFUONE     =  5C  +  6H  +  2O                ; {@PXYFUONE}     {MCM: O=C1OCC=C1C}
C45O         =  4C  +  7H  +   O                ; {@C45O}         {MCM: CC(=C)C[O]}
C107OH       = 10C  + 16H  +  3O                ; {@C107OH}       {MCM: O=CCC1CC(O)(C(=O)C)C1(C)C}
C8BCOH       =  8C  + 14H  +   O                ; {@C8BCOH}       {MCM: OC1CC2CC1C2(C)C}
H3C25C6CO3   =  7C  +  9H  +  6O                ; {@H3C25C6CO3}   {MCM: [O]OC(=O)CC(=O)CC(O)C(=O)C}
NOPINDO      =  9C  + 13H  +  2O                ; {@NOPINDO}      {MCM: [O]C1CC2CC(C1=O)C2(C)C}
PE4E2CO      =  5C  +  8H  +   O                ; {@PE4E2CO}      {MCM: CC(=O)CC=C}
C916O2       =  9C  + 13H  +  5O                ; {@C916O2}       {MCM: O=CCCC(=O)C(C=O)C(C)(C)O[O]}
ME3BU3ECHO   =  5C  +  8H  +   O                ; {@ME3BU3ECHO}   {MCM: CC(=C)CC=O}
C915OH       =  9C  + 14H  +  3O                ; {@C915OH}       {MCM: O=CC1C(=O)CCC(O)C1(C)C}
NC4OO        =  4C  +  7H  +   N  +  6O         ; {@NC4OO}        {MCM: OCC(ON(=O)=O)C(=[O+][O-])C}
CO2C3OOA     =  4C  +  6H  +  3O                ; {@CO2C3OOA}     {MCM: [O-][O+]=CCC(=O)C}
CO2C3OOB     =  4C  +  6H  +  3O                ; {@CO2C3OOB}     {MCM: [O-][O+]=C(CC=O)C}
IEACHO       =  5C  +  8H  +  3O                ; {@IEACHO}       {MCM: CC(O)(C=O)C1CO1}
CO2N3CO3     =  4C  +  4H  +   N  +  7O         ; {@CO2N3CO3}     {MCM: [O]OC(=O)C(ON(=O)=O)C(=O)C}
C536OOH      =  5C  + 10H  +  7O                ; {@C536OOH}      {MCM: OOCC(C(C=O)(OO)C)OO}
C58NO3PAN    =  5C  +  8H  +  2N  + 10O         ; {@C58NO3PAN}    {MCM: OCC(C)(ON(=O)=O)C(O)C(=O)OON(=O)=O}
HO1CO24C5    =  5C  +  8H  +  3O                ; {@HO1CO24C5}    {MCM: CC(=O)CC(=O)CO}
NAPINAO2     = 10C  + 16H  +   N  +  5O         ; {@NAPINAO2}     {MCM: [O]OC1(C)C(ON(=O)=O)CC2CC1C2(C)C}
INCNCO3H     =  5C  +  8H  +  2N  + 10O         ; {@INCNCO3H}     {MCM: OOC(=O)C(ON(=O)=O)C(C)(O)CON(=O)=O}
C813O        =  8C  + 13H  +  5O                ; {@C813O}        {MCM: OCC(CC(=O)C(=O)O)C(C)(C)[O]}
MCOCOMOXO    =  4C  +  5H  +  4O                ; {@MCOCOMOXO}    {MCM: CC(=O)C(=O)OC[O]}
NC6PAN1      =  7C  +  6H  +  2N  + 11O         ; {@NC6PAN1}      {MCM: O=CC(=O)CC(=O)C(C)(ON(=O)=O)C(=O)OON(=O)=O}
OCCOHCO2     =  3C  +  5H  +  4O                ; {@OCCOHCO2}     {MCM: OC(CO[O])C=O}
NBPINAO      = 10C  + 16H  +   N  +  4O         ; {@NBPINAO}      {MCM: O=N(=O)OCC1([O])CCC2CC1C2(C)C}
INB1NACO3    =  5C  +  7H  +  2N  + 10O         ; {@INB1NACO3}    {MCM: [O]OC(=O)C(ON(=O)=O)C(C)(CO)ON(=O)=O}
C615PAN      =  7C  +  9H  +   N  +  7O         ; {@C615PAN}      {MCM: O=CC(C(=O)OON(=O)=O)C(C)(C)C=O}
C31CO3H      =  4C  +  4H  +  5O                ; {@C31CO3H}      {MCM: O=COC=CC(=O)OO}
C915O2       =  9C  + 13H  +  4O                ; {@C915O2}       {MCM: [O]OC1CCC(=O)C(C=O)C1(C)C}
C58AO2       =  5C  +  9H  +  5O                ; {@C58AO2}       {MCM: [O]OC(C(CO)(O)C)C=O}
MVKOH        =  4C  +  6H  +  2O                ; {@MVKOH}        {MCM: OCC(=O)C=C}
NC3OOA       =  3C  +  5H  +   N  +  5O         ; {@NC3OOA}       {MCM: [O-][O+]=C(C)CON(=O)=O}
ACO3         =  3C  +  3H  +  3O                ; {@ACO3}         {MCM: [O]OC(=O)C=C}
C89CO2       =  9C  + 13H  +  3O                ; {@C89CO2}       {MCM: O=CCC1CC(C(=O)[O])C1(C)C}
PROLNO3      =  3C  +  7H  +   N  +  4O         ; {@PROLNO3}      {MCM: CC(O)CON(=O)=O}
MVKOO        =  4C  +  6H  +  2O                ; {@MVKOO}        {MCM: [O-][O+]=C(C)C=C}
CHOC2CO3     =  4C  +  5H  +  4O                ; {@CHOC2CO3}     {MCM: [O]OC(=O)CCC=O}
NC61CO3      =  7C  +  6H  +   N  +  9O         ; {@NC61CO3}      {MCM: O=CC(=O)CC(=O)C(C)(ON(=O)=O)C(=O)O[O]}
C527O        =  5C  +  9H  +  5O                ; {@C527O}        {MCM: O=CC(C(OO)(CO)C)[O]}
C532CO       =  5C  +  6H  +  3O                ; {@C532CO}       {MCM: O=COC=CC(=O)C}
CHOMOHCO3    =  4C  +  5H  +  5O                ; {@CHOMOHCO3}    {MCM: CC(O)(C=O)C(=O)O[O]}
C58O         =  5C  +  9H  +  4O                ; {@C58O}         {MCM: O=CC(O)C(C)([O])CO}
NC51OOH      =  5C  +  9H  +   N  +  6O         ; {@NC51OOH}      {MCM: OOC(CC(=O)C)CO[N+](=O)[O-]}
NC2OO        =  2C  +  3H  +   N  +  5O         ; {@NC2OO}        {MCM: [O-][O+]=CCON(=O)=O}
HC4CCO3H     =  5C  +  8H  +  4O                ; {@HC4CCO3H}     {MCM: OCC=C(C)C(=O)OO}
M3F          =  5C  +  6H  +   O                ; {@M3F}          {MCM: Cc1cocc1}
OCCOHCO      =  3C  +  5H  +  3O                ; {@OCCOHCO}      {MCM: OC(C[O])C=O}
NMGLYOX      =  3C  +  3H  +   N  +  5O         ; {@NMGLYOX}      {MCM: O=CC(=O)CON(=O)=O}
C530OOH      =  5C  + 10H  +  4O                ; {@C530OOH}      {MCM: O=CCC(OO)(CO)C}
CO2C3CO3     =  4C  +  5H  +  4O                ; {@CO2C3CO3}     {MCM: CC(=O)CC(=O)O[O]}
INB2O        =  5C  + 10H  +   N  +  6O         ; {@INB2O}        {MCM: [O]CC(O)C(C)(CO)ON(=O)=O}
CH2CHCH2NO3  =  3C  +  5H  +   N  +  3O         ; {@CH2CHCH2NO3}  {MCM: [O-][N+](=O)OCC=C}
MMALNBCO3    =  5C  +  6H  +   N  +  8O         ; {@MMALNBCO3}    {MCM: O=CC(O)C(C)(ON(=O)=O)C(=O)O[O]}
HOCH2COCO2H  =  3C  +  4H  +  4O                ; {@HOCH2COCO2H}  {MCM: OCC(=O)C(=O)O}
ACR          =  3C  +  4H  +   O                ; {@ACR}          {MCM: C=CC=O}
H3C25C5CHO   =  6C  +  8H  +  4O                ; {@H3C25C5CHO}   {MCM: O=CC(=O)CC(O)C(=O)C}
INDHPAN      =  5C  +  8H  +  2N  + 10O         ; {@INDHPAN}      {MCM: OCC(ON(=O)=O)C(C)(O)C(=O)OON(=O)=O}
C619OOH      =  6C  +  8H  +  4O                ; {@C619OOH}      {MCM: OOC1CC(=O)CCC1=O}
C914CO       =  9C  + 10H  +  4O                ; {@C914CO}       {MCM: O=CC1C(=O)CC(=O)C(=O)C1(C)C}
MMALNHY2OH   =  5C  +  6H  +  5O                ; {@MMALNHY2OH}   {MCM: O=C1OC(=O)C(C)(O)C1O}
INB1NBPAN    =  5C  +  7H  +  3N  + 12O         ; {@INB1NBPAN}    {MCM: OCC(ON(=O)=O)C(C)(ON(=O)=O)C(=O)OON(=O)=O}
C616OOH      =  6C  +  8H  +  5O                ; {@C616OOH}      {MCM: O=CCCC(=O)C(OO)C=O}
CH2CHCH2O2   =  3C  +  5H  +  2O                ; {@CH2CHCH2O2}   {MCM: [O]OCC=C}
NA = IGNORE ;
H2M2C3CO3    =  5C  +  9H  +  4O                ; {@H2M2C3CO3}    {MCM: [O]OC(=O)CC(C)(C)O}
HC4ACO3H     =  5C  +  8H  +  4O                ; {@HC4ACO3H}     {MCM: OCC(=CC(=O)OO)C}
C88O2        =  8C  + 11H  +  4O                ; {@C88O2}        {MCM: [O]OC1C(=O)CCC(=O)C1(C)C}
C527NO3      =  5C  +  9H  +   N  +  7O         ; {@C527NO3}      {MCM: O=CC(C(OO)(CO)C)O[N+](=O)[O-]}
C89OH        =  8C  + 14H  +  2O                ; {@C89OH}        {MCM: O=CCC1CC(O)C1(C)C}
C57OH        =  5C  + 10H  +  4O                ; {@C57OH}        {MCM: OCC(O)C(C)(O)C=O}
C4M2ALOHO2   =  5C  +  7H  +  5O                ; {@C4M2ALOHO2}   {MCM: O=CC(O)C(C)(O[O])C=O}
C531OOH      =  5C  +  6H  +  5O                ; {@C531OOH}      {MCM: OOCC(=O)C=COC=O}
NC524OH      =  5C  + 11H  +   N  +  7O         ; {@NC524OH}      {MCM: OCC(ON(=O)=O)C(O)(CO)CO}
NC524O2      =  5C  + 10H  +   N  +  8O         ; {@NC524O2}      {MCM: OCC(ON(=O)=O)C(CO)(CO)O[O]}
C4M2ALOHNO3  =  5C  +  7H  +   N  +  6O         ; {@C4M2ALOHNO3}  {MCM: O=CC(O)C(C)(C=O)ON(=O)=O}
C536O2       =  5C  +  9H  +  7O                ; {@C536O2}       {MCM: OOCC(C(C=O)(O[O])C)OO}
C717O        =  7C  +  9H  +  4O                ; {@C717O}        {MCM: O=CCC([O])CC(=O)C(=O)C}
MVKOOA       =  4C  +  6H  +  2O                ; {@MVKOOA}       {MCM: [O-][O+]=C(C)C=C}
NC72OOH      =  7C  +  7H  +   N  +  8O         ; {@NC72OOH}      {MCM: OOC1C(=O)CC(=O)C(C)(ON(=O)=O)C1=O}
MMALNAPAN    =  5C  +  6H  +  2N  + 10O         ; {@MMALNAPAN}    {MCM: O=CC(C)(ON(=O)=O)C(O)C(=O)OON(=O)=O}
C919OH       =  9C  + 14H  +  4O                ; {@C919OH}       {MCM: O=CCC(=O)C(CC=O)C(C)(C)O}
NISOPO       =  5C  +  8H  +   N  +  4O         ; {@NISOPO}       {MCM: [O]CC=C(C)CON(=O)=O}
C537OOH      =  5C  + 10H  +  7O                ; {@C537OOH}      {MCM: OOCC(C(C=O)OO)(OO)C}
C530O2       =  5C  +  9H  +  4O                ; {@C530O2}       {MCM: O=CCC(O[O])(CO)C}
NOPINBCO     =  9C  + 12H  +  2O                ; {@NOPINBCO}     {MCM: O=C1CCC2C(=O)C1C2(C)C}
C87O2        =  8C  + 11H  +  5O                ; {@C87O2}        {MCM: [O]OCC(=O)C(C=O)C(C)(C)C=O}
PRNO3CO3     =  3C  +  4H  +   N  +  6O         ; {@PRNO3CO3}     {MCM: [O]OC(=O)C(C)ON(=O)=O}
MVKOHANO3    =  4C  +  7H  +   N  +  6O         ; {@MVKOHANO3}    {MCM: OCC(=O)C(O)CON(=O)=O}
C811OOH      =  8C  + 14H  +  4O                ; {@C811OOH}      {MCM: OOCC1CC(C(=O)O)C1(C)C}
NC526O2      =  5C  +  8H  +   N  +  6O         ; {@NC526O2}      {MCM: O=CCC(CO[N+](=O)[O-])(O[O])C}
C58ANO3      =  5C  +  9H  +   N  +  6O         ; {@C58ANO3}      {MCM: [O-][N+](=O)OC(C(CO)(O)C)C=O}
C812O        =  8C  + 13H  +  4O                ; {@C812O}        {MCM: OCC1CC([O])(C(=O)O)C1(C)C}
INDHPCO3H    =  5C  +  9H  +   N  +  9O         ; {@INDHPCO3H}    {MCM: OOC(=O)C(C)(OO)C(CO)ON(=O)=O}
C85O         =  8C  + 13H  +  2O                ; {@C85O}         {MCM: CC(=O)C1CC([O])C1(C)C}
C23O3CCO3H   =  5C  +  6H  +  6O                ; {@C23O3CCO3H}   {MCM: OOC(=O)COC(=O)C(=O)C}
H1C23C4O     =  4C  +  5H  +  4O                ; {@H1C23C4O}     {MCM: [O]CC(=O)C(=O)CO}
INANCO3      =  5C  +  7H  +  2N  + 10O         ; {@INANCO3}      {MCM: [O]OC(=O)C(C)(ON(=O)=O)C(O)CON(=O)=O}
C3MDIALO2    =  4C  +  5H  +  4O                ; {@C3MDIALO2}    {MCM: [O]OC(C)(C=O)C=O}
H3C2C4PAN    =  5C  +  7H  +   N  +  7O         ; {@H3C2C4PAN}    {MCM: O=N(=O)OOC(=O)CC(O)C(=O)C}
C4MALOHOOH   =  5C  +  8H  +  5O                ; {@C4MALOHOOH}   {MCM: O=CC(O)C(C)(OO)C=O}
C23O3CHO     =  4C  +  4H  +  4O                ; {@C23O3CHO}     {MCM: O=COC(=O)C(=O)C}
C47CHO       =  5C  +  7H  +   N  +  6O         ; {@C47CHO}       {MCM: O=CC(C(C=O)(O)C)O[N+](=O)[O-]}
C515CO3H     =  6C  +  6H  +  6O                ; {@C515CO3H}     {MCM: OOC(=O)CC(=O)C(=O)CC=O}
C106OH       = 10C  + 16H  +  4O                ; {@C106OH}       {MCM: O=CCC(=O)CC(C(=O)C)C(C)(C)O}
HPC52O       =  5C  +  9H  +  5O                ; {@HPC52O}       {MCM: CC(C(C=O)O)(COO)[O]}
CO13C3CO2H   =  4C  +  4H  +  4O                ; {@CO13C3CO2H}   {MCM: O=CCC(=O)C(=O)O}
INB1OH       =  5C  + 11H  +   N  +  6O         ; {@INB1OH}       {MCM: OCC(O)C(C)(CO)ON(=O)=O}
MVKOHBOOH    =  4C  +  8H  +  5O                ; {@MVKOHBOOH}    {MCM: OCC(=O)C(CO)OO}
C617PAN      =  7C  +  9H  +   N  +  7O         ; {@C617PAN}      {MCM: O=CC(C)(C)C(=O)CC(=O)OON(=O)=O}
C58AO        =  5C  +  9H  +  4O                ; {@C58AO}        {MCM: O=CC([O])C(C)(O)CO}
C88OH        =  8C  + 12H  +  3O                ; {@C88OH}        {MCM: O=C1CCC(=O)C(C)(C)C1O}
H13CO2C3     =  3C  +  6H  +  3O                ; {@H13CO2C3}     {MCM: OCC(=O)CO}
C108O2       = 10C  + 15H  +  5O                ; {@C108O2}       {MCM: O=CCC(CC(=O)C(=O)C)C(C)(C)O[O]}
C618CO3      =  7C  +  9H  +  5O                ; {@C618CO3}      {MCM: O=CCC(=O)C(C)(C)C(=O)O[O]}
TBUTOLO      =  4C  +  9H  +  2O                ; {@TBUTOLO}      {MCM: [O]CC(C)(C)O}
CHOMOHCO3H   =  4C  +  6H  +  5O                ; {@CHOMOHCO3H}   {MCM: CC(O)(C=O)C(=O)OO}
NC51O2       =  5C  +  8H  +   N  +  6O         ; {@NC51O2}       {MCM: [O]OC(CC(=O)C)CO[N+](=O)[O-]}
C919O2       =  9C  + 13H  +  5O                ; {@C919O2}       {MCM: O=CCC(=O)C(CC=O)C(C)(C)O[O]}
C534O2       =  5C  +  7H  +  7O                ; {@C534O2}       {MCM: O=CC(C(C(=O)OO)(O[O])C)O}
C720NO3      =  7C  + 11H  +   N  +  4O         ; {@C720NO3}      {MCM: O=N(=O)OC1CC=C(C)C(O)C1}
C915NO3      =  9C  + 13H  +   N  +  5O         ; {@C915NO3}      {MCM: O=CC1C(=O)CCC(ON(=O)=O)C1(C)C}
NC4CO2H      =  5C  +  7H  +   N  +  5O         ; {@NC4CO2H}      {MCM: O=N(=O)OCC(=CC(=O)O)C}
C108OOH      = 10C  + 16H  +  5O                ; {@C108OOH}      {MCM: O=CCC(CC(=O)C(=O)C)C(C)(C)OO}
PPACLOOA     =  3C  +  4H  +  5O                ; {@PPACLOOA}     {MCM: [O-][O+]=C(C(=O)OO)C}
C513OH       =  5C  +  8H  +  4O                ; {@C513OH}       {MCM: OC(C=O)C(=O)CCO}
NAPINBO2     = 10C  + 16H  +   N  +  5O         ; {@NAPINBO2}     {MCM: [O]OC1CC2CC(C1(C)ON(=O)=O)C2(C)C}
PRNO3CO2H    =  3C  +  5H  +   N  +  5O         ; {@PRNO3CO2H}    {MCM: O=N(=O)OC(C)C(=O)O}
H3C2C4CO2H   =  5C  +  8H  +  4O                ; {@H3C2C4CO2H}   {MCM: OC(=O)CC(O)C(=O)C}
C920O        =  9C  + 15H  +  3O                ; {@C920O}        {MCM: OCC(=O)C1CC(C[O])C1(C)C}
INANCO2H     =  5C  +  8H  +  2N  +  9O         ; {@INANCO2H}     {MCM: O=N(=O)OCC(O)C(C)(ON(=O)=O)C(=O)O}
MACRNCO3H    =  4C  +  7H  +   N  +  7O         ; {@MACRNCO3H}    {MCM: OOC(=O)C(C)(CO)ON(=O)=O}
H3C2C4CO3H   =  5C  +  8H  +  5O                ; {@H3C2C4CO3H}   {MCM: CC(=O)C(O)CC(=O)OO}
C108OH       = 10C  + 16H  +  4O                ; {@C108OH}       {MCM: O=CCC(CC(=O)C(=O)C)C(C)(C)O}
C921O        =  9C  + 15H  +  4O                ; {@C921O}        {MCM: OCC(=O)C1([O])CC(CO)C1(C)C}
M3BU3EPAN    =  5C  +  7H  +   N  +  5O         ; {@M3BU3EPAN}    {MCM: [O-][N+](=O)OOC(=O)CC(=C)C}
C3MDIALOH    =  4C  +  6H  +  3O                ; {@C3MDIALOH}    {MCM: O=CC(C)(O)C=O}
C4M2ALOHO    =  5C  +  7H  +  4O                ; {@C4M2ALOHO}    {MCM: O=CC(O)C(C)([O])C=O}
INB1CO       =  5C  +  9H  +   N  +  6O         ; {@INB1CO}       {MCM: OCC(=O)C(C)(CO)ON(=O)=O}
NC2OOA       =  2C  +  3H  +   N  +  5O         ; {@NC2OOA}       {MCM: [O-][O+]=CCON(=O)=O}
C918CO3      = 10C  + 15H  +  4O                ; {@C918CO3}      {MCM: [O]OC(=O)C1(O)CCC2CC1C2(C)C}
C4PAN10      =  4C  +  5H  +   N  +  8O         ; {@C4PAN10}      {MCM: OCC(=O)C(O)C(=O)OON(=O)=O}
CISOPAO2     =  5C  +  9H  +  3O                ; {@CISOPAO2}     {MCM: [O]OC/C=C(\CO)/C}
C516OOH      =  5C  +  8H  +  6O                ; {@C516OOH}      {MCM: OCC(OO)CC(=O)C(=O)O}
C524OOH      =  5C  + 10H  +  4O                ; {@C524OOH}      {MCM: OCC(=C)C(CO)OO}
M3FOO        =  5C  +  6H  +  4O                ; {@M3FOO}        {MCM: O=COC=CC(=[O+][O-])C}
MACRNPAN     =  4C  +  6H  +  2N  +  9O         ; {@MACRNPAN}     {MCM: OCC(C)(ON(=O)=O)C(=O)OON(=O)=O}
C45O2        =  4C  +  7H  +  2O                ; {@C45O2}        {MCM: CC(=C)CO[O]}
MMALANHYO    =  5C  +  5H  +  5O                ; {@MMALANHYO}    {MCM: O=C1OC(=O)C(C)([O])C1O}
CHOMOHPAN    =  4C  +  5H  +   N  +  7O         ; {@CHOMOHPAN}    {MCM: O=CC(C)(O)C(=O)OON(=O)=O}
HMPAN        =  4C  +  5H  +   N  +  6O         ; {@HMPAN}        {MCM: OCC(=C)C(=O)OON(=O)=O}
NC72O2       =  7C  +  6H  +   N  +  8O         ; {@NC72O2}       {MCM: [O]OC1C(=O)CC(=O)C(C)(ON(=O)=O)C1=O}
C515O2       =  5C  +  5H  +  5O                ; {@C515O2}       {MCM: [O]OCC(=O)C(=O)CC=O}
C88CO3H      =  9C  + 12H  +  5O                ; {@C88CO3H}      {MCM: OOC(=O)C1C(=O)CCC(=O)C1(C)C}
C533O        =  5C  +  7H  +  5O                ; {@C533O}        {MCM: O=COC(C(C(=O)C)[O])O}
NBPINAOOH    = 10C  + 17H  +   N  +  5O         ; {@NBPINAOOH}    {MCM: OOC1(CON(=O)=O)CCC2CC1C2(C)C}
INDO         =  5C  + 10H  +   N  +  6O         ; {@INDO}         {MCM: OCC(ON(=O)=O)C(C)([O])CO}
CHOOCHO      =  2C  +  2H  +  3O                ; {@CHOOCHO}      {MCM: O=COC=O}
C526OOH      =  5C  + 10H  +  6O                ; {@C526OOH}      {MCM: OCC(C(C=O)(OO)C)OO}
ISOPBO       =  5C  +  9H  +  2O                ; {@ISOPBO}       {MCM: CC([O])(CO)C=C}
