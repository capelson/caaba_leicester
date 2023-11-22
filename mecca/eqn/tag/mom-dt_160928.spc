{Time-stamp: <2019-01-07 11:58:58 sander>}

{----------------------------------------------------------------------------}

#INCLUDE atoms
Min; {minus (negative charge as pseudo-atom for charge balance)}
Pls; {plus  (positive charge as pseudo-atom for charge balance)}
{end of atom definitions}

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

{1C}
CO              =   C       +   O      ; {@CO}                {carbon monoxide}
CO2             =   C       +  2O      ; {@CO_2}              {carbon dioxide}
HCHO            =   C +  2H +   O      ; {@HCHO}              {methanal (formaldehyde)}
HCOOH           =   C +  2H +  2O      ; {@HCOOH}             {formic acid}
CH2OO           =   C +  2H +  2O      ; {@CH_2OO}            {carbonyl oxide - stabilized Criegee Intermediate}
CH2OOA          =   C +  2H +  2O      ; {@CH_2OO^*}          {carbonyl oxide - excited Criegee Intermediate}
CH3             =   C +  3H            ; {@CH_3}              {methyl radical}
CH3O            =   C +  3H +   O      ; {@CH_3O}             {methoxy radical}
CH3O2           =   C +  3H +  2O      ; {@CH_3O_2}           {methylperoxy radical}
HOCH2O2         =   C +  3H +  3O      ; {@HOCH_2O_2}         {hydroxy methyl peroxy radical}
CH4             =   C +  4H            ; {@CH_4}              {methane}
CH3OH           =   C +  4H +   O      ; {@CH_3OH}            {methanol}
CH3OOH          =   C +  4H +  2O      ; {@CH_3OOH}           {methyl peroxide}
HOCH2OOH        =   C +  4H +  3O      ; {@HOCH_2OOH}         {hydroxy methyl hydroperoxide}
HOCH2OH         =   C +  4H +  2O      ; {@HOCH_2OH}          {dyhydroxy methane}
{1C (CHON)}
CH3ONO          =   C +  3H +  2O +  N ; {@CH_3ONO}           {methylnitrite}
CH3NO3          =   C +  3H +  3O +  N ; {@CH_3ONO_2}         {methylnitrate}
CH3O2NO2        =   C +  3H +  4O +  N ; {@CH_3O_2NO_2}       {peroxy methylnitrate}
HOCH2O2NO2      =   C +  3H +  5O +  N ; {@HOCH_2O_2NO_2}     {hydroxy methyl peroxy nitrate}
HCN             =   C +   H       +  N ; {@HCN}               {}
CN              =   C             +  N ; {@CN}                {}
NCO             =   C       +   O +  N ; {@NCO}               {}
{1C (lumped)}
LCARBON         =   C                  ; {@LCARBON}           {lumped C1 species}
{2C (CHO)}
HCOCO3          =  2C +   H +  4O      ; {@HCOCO_3}           {MCM}
HCOCO           =  2C +   H +  2O      ; {@HCOCO}             {MOM}
C2H2            =  2C +  2H            ; {@C_2H_2}            {MCM: ethyne}
CH2CO           =  2C +  2H +   O      ; {@CH2CO}             {CH2CO, ketene}
GLYOX           =  2C +  2H +  2O      ; {@GLYOX}             {MCM: CHOCHO = glyoxal}
HCOCO2H         =  2C +  2H +  3O      ; {@HCOCO_2H}          {MCM: oxoethanoic acid}
HCOCO3H         =  2C +  2H +  4O      ; {@HCOCO_3H}          {MCM}
CH3CO           =  2C +  3H +  2O      ; {@CH_3C(O)}          {MCM: acetyl radical}
HOCH2CO         =  2C +  3H +  2O      ; {@HOCH2CO}           {HOCH2CO}
HOCHCHO         =  2C +  3H +  2O      ; {@HOCHCHO}           {HOCHCHO}
HCOCH2O2        =  2C +  3H +  3O      ; {@HCOCH_2O_2}        {MCM: HCOCH2O2}
CH3CO3          =  2C +  3H +  3O      ; {@CH_3C(O)OO}        {MCM: peroxy acetyl radical}
HOCH2CO3        =  2C +  3H +  4O      ; {@HOCH_2CO_3}        {MCM}
HOOCH2CO3       =  2C +  3H +  5O      ; {@HOOCH_2CO_3}       {MIM3}
C2H4            =  2C +  4H            ; {@C_2H_4}            {MCM: ethene}
CH2CHOH         =  2C +  4H +   O      ; {@CH_2CHOH}          {vinyl alcohol}
CH3CHO          =  2C +  4H +   O      ; {@CH_3CHO}           {MCM: acetaldehyde}
CH3CO2H         =  2C +  4H +  2O      ; {@CH_3COOH}          {MCM: acetic acid}
HOCH2CHO        =  2C +  4H +  2O      ; {@HOCH_2CHO}         {MCM: glycolaldehyde}
HOOCH2CHO       =  2C +  4H +  3O      ; {@HOOCH2CHO}         {HOOCH2CHO}
CH3CO3H         =  2C +  4H +  3O      ; {@CH_3C(O)OOH}       {MCM: peroxy acetic acid}
HOCH2CO2H       =  2C +  4H +  3O      ; {@HOCH_2CO_2H}       {MCM: hydroxyethanoic acid}
HOCH2CO3H       =  2C +  4H +  4O      ; {@HOCH_2CO_3H}       {MCM}
HOOCH2CO2H      =  2C +  4H +  4O      ; {@HOOCH2CO2H}        {HOOCH2CO2H}
HOOCH2CO3H      =  2C +  4H +  5O      ; {@HOOCH2CO3H}        {HOOCH2CO3H}
C2H5O2          =  2C +  5H +  2O      ; {@C_2H_5O_2}         {MCM: ethylperoxy radical}
HOCH2CH2O       =  2C +  5H +  2O      ; {@HOCH_2CH_2O}       {MCM}
HOCH2CH2O2      =  2C +  5H +  3O      ; {@HOCH_2CH_2O_2}     {MCM}
CH3CHOHO2       =  2C +  5H +  3O      ; {@CH3CHOHO2}         {CH3CHOHO2}
C2H6            =  2C +  6H            ; {@C_2H_6}            {MCM: ethane}
C2H5OH          =  2C +  6H +   O      ; {@C_2H_5OH}          {MCM: ethyl alcohol}
C2H5OOH         =  2C +  6H +  2O      ; {@C_2H_5OOH}         {MCM: ethyl hydro peroxide}
ETHGLY          =  2C +  6H +  2O      ; {@ETHGLY}            {MCM: HOCH2CH2OH}
HYETHO2H        =  2C +  6H +  3O      ; {@HYETHO2H}          {MCM: HOCH2CH2OOH}
CH3CHOHOOH      =  2C +  6H +  3O      ; {@CH3CHOHOOH}        {CH3CHOHOOH}
HOCHCHOH        =  2C +  4H +  2O      ; {@HOCHCHOH}          
OH2CHCHO        =  2C +  4H +  3O      ; {@OH2CHCHO}
OH2CHCO3        =  2C +  3H +  5O      ; {@OH2CHCO3}
OH2CHCO2H       =  2C +  4H +  4O      ; {@OH2CHCO2H}
OH2CHCO3H       =  2C +  4H +  5O      ; {@OH2CHCO3H}
OH2CHPAN        =  2C +  3H +  7O + N  ; {@OH2CHPAN}
CO2HCO2H        =  2C +  2H +  4O      ; {@CO2HCO2H}
CO2HCO3H        =  2C +  2H +  5O      ; {@CO2HCO3H}
{2C (CHON)}
NCCH2O2         =  2C +  2H +  2O +  N ; {@NCCH_2O_2}         {}
NO3CH2CO3       =  2C +  2H +  6O +  N ; {@NO_3CH2CO_3}       {MCM: NO3CH2CO3}
NO3CH2PAN       =  2C +  2H +  8O + 2N ; {@NO_3CH2CHO}        {MCM: NO3CH2PAN}
CH3CN           =  2C +  3H       +  N ; {@CH_3CN}            {}
NO3CH2CHO       =  2C +  3H +  4O +  N ; {@NO_3CH2CHO}        {MCM: NO3CH2CHO}
PAN             =  2C +  3H +  5O +  N ; {@PAN}               {MCM: CH3C(O)OONO2 = peroxyacetylnitrate}
PHAN            =  2C +  3H +  6O +  N ; {@PHAN}              {MCM: HOCH2C(O)OONO2}
ETHOHNO3        =  2C +  5H +  4O +  N ; {@ETHOHNO3}          {MCM: HOCH2CH2ONO2}
C2H5NO3         =  2C +  5H +  3O +  N ; {@C_2H_5ONO_2}       {ethyl nitrate}
C2H5O2NO2       =  2C +  5H +  4O +  N ; {@C_2H_5O_2NO_2}     {ethyl peroxy nitrate}
{3C (CHO)}
C33CO           =  3C +  2H +  3O      ; {@HCOCOCHO}          {MCM}
CHOCOCH2O2      =  3C +  3H +  4O      ; {@HCOCOCH_2O_2}      {MCM}
HCOCH2CO3       =  3C +  3H +  5O      ; {@HCOCH2CO3}         {MCM: HCOCH2CO3}
ALCOCH2OOH      =  3C +  4H +  4O      ; {@HCOCOCH_2OOH}      {MCM}
MGLYOX          =  3C +  4H +  2O      ; {@MGLYOX}            {MCM: CH3COCHO = methylglyoxal}
HOCH2COCHO      =  3C +  4H +  3O      ; {@HOCH2COCHO}        {MCM}
HCOCH2CHO       =  3C +  4H +  3O      ; {@HCOCH2CHO}         {MCM: HCOCH2CHO}
HCOCH2CO2H      =  3C +  4H +  4O      ; {@HCOCH2CO2H}        {MCM: HCOCH2CO2H}
HCOCH2CO3H      =  3C +  4H +  5O      ; {@HCOCH2CO3H}        {MCM: HCOCH2CO3H}
CH3COCH2O2      =  3C +  5H +  3O      ; {@CH_3COCH_2O_2}     {MCM: peroxyradical from acetone}
HOC2H4CO3       =  3C +  5H +  4O      ; {@HOC_2H_4CO_3}      {MCM: HOC2H4CO3}
C3H6            =  3C +  6H            ; {@C_3H_6}            {MCM: propene}
CH3COCH3        =  3C +  6H +   O      ; {@CH_3COCH_3}        {MCM: acetone}
ACETOL          =  3C +  6H +  2O      ; {@CH_3COCH_2OH}      {MCM: HO-CH2-CO-CH3 = hydroxy acetone}
HYPERACET       =  3C +  6H +  3O      ; {@CH_3COCH_2O_2H}    {MCM: hydroperoxide from CH3COCH2O2}
HOC2H4CO2H      =  3C +  6H +  3O      ; {@HOC2H4CO2H}        {MCM: HOC2H4CO2H}
HOC2H4CO3H      =  3C +  6H +  4O      ; {@HOC2H4CO3H}        {MCM: HOC2H4CO3H}
IC3H7O2         =  3C +  7H +  2O      ; {@iC_3H_7O_2}        {MCM: isopropylperoxy radical}
HYPROPO2        =  3C +  7H +  3O      ; {@HYPROPO2}          {MCM: CH3CH(O2)CH2OH}
C3H8            =  3C +  8H            ; {@C_3H_8}            {MCM: propane}
IC3H7OOH        =  3C +  8H +  2O      ; {@iC_3H_7OOH}        {MCM: isopropyl hydro peroxide}
HYPROPO2H       =  3C +  8H +  3O      ; {@HYPROPO2H}         {MCM: CH3CH(OOH)CH2OH}
CH3COCO3        =  3C +  3H +  4O      ; {@CH_3COCO_3}        {CH3COCO3H}
CH3CHCO         =  3C +  4H +   O      ; {@CH3CHCO}           {CH3CHCO}
CH3COCO2H       =  3C +  4H +  3O      ; {@CH_3COCO_2H}       {CH3COCO2H, pyruvic acid}
CH3COCO3H       =  3C +  4H +  4O      ; {@CH_3COCO_3H}       {CH3COCO3H}
HCOCOCH2OOH     =  3C +  4H +  4O      ; {@HCOCOCH_2OOH}      {HCOCOCH2OOH}
C2H5CO3         =  3C +  5H +  3O      ; {@C_2H_5CO_3}        {MCM: CH_3CH_2CO_3}
HOCH2COCH2O2    =  3C +  5H +  4O      ; {@HOCH2COCH2O2}      {HOCH2COCH2O2}
C2H5CHO         =  3C +  6H +   O      ; {@C_2H_5CHO}         {MCM: propanal}
PROPENOL        =  3C +  6H +   O      ; {@CH_2CHCH_2OH}      {propenol}
PROPACID        =  3C +  6H +  2O      ; {@C_2H_5CO_2H}       {MCM: CH_3CH_2CO_2H}
PERPROACID        =  3C +  6H +  3O      ; {@C_2H_5CO_3H}       {MCM: CH_3CH_2CO_3H}
HOCH2COCH2OOH   =  3C +  6H +  4O      ; {@HOCH2COCH2OOH}     {HOCH2COCH2OOH}
NC3H7O2         =  3C +  7H +  2O      ; {@C_3H_7O_2}         {MCM: propylperoxy radical}
IPROPOL         =  3C +  8H +   O      ; {@IPROPOL}           {MCM: isopropylic alcohol}
NPROPOL         =  3C +  8H +   O      ; {@NPROPOL}           {MCM: n-propylic alcohol}
NC3H7OOH        =  3C +  8H +  2O      ; {@C_3H_7OOH}         {MCM: propyl hydro peroxide}
{3C (CHO) aromatics}
C3DIALOOH       =  3C +  4H +  4O      ; {@C3DIALOOH}         {}
C3DIALO2        =  3C +  3H +  4O      ; {@C3DIALO2}          {}
HCOCOHCO3       =  3C +  3H +  5O      ; {@HCOCOHCO3}         {}
METACETHO       =  3C +  4H +  3O      ; {@METACETHO}         {Acetic formic anhydride}
C32OH13CO       =  3C +  4H +  3O      ; {@C32OH13CO}         {Hydroxymalonaldehyde}
HCOCOHCO3H      =  3C +  4H +  5O      ; {@HCOCOHCO3H}        {}
{3C (CHON)}
C3PAN2          =  3C +  3H +  6O +  N ; {@C_3PAN2}           {MCM}
NOA             =  3C +  5H +  4O +  N ; {@NOA}               {MCM: CH3-CO-CH2ONO2 = nitro-oxy-acetone}
CH3COCH2O2NO2   =  3C +  5H +  5O +  N ; {@CH_3COCH_2OONO_2}  {CH3-C(O)-CH2-OONO2}
PPN             =  3C +  5H +  5O +  N ; {@PPN}               {MCM: CH3CH2C(O)OONO2}
C3PAN1          =  3C +  5H +  6O +  N ; {@C_3PAN1}           {MCM}
PRONO3BO2       =  3C +  6H +  5O +  N ; {@PRONO3BO2}         {MCM: CH3-CH(O2)-CH2ONO2}
NC3H7NO3        =  3C +  7H +  3O +  N ; {@C_3H_7ONO_2}       {MCM: propyl nitrate}
IC3H7NO3        =  3C +  7H +  3O +  N ; {@iC_3H_7ONO_2}      {MCM: isopropyl nitrate}
PROPOLNO3       =  3C +  7H +  4O +  N ; {@PROPOLNO3}         {MCM: HOCH2-CH(CH3)ONO2)}
PR2O2HNO3       =  3C +  7H +  5O +  N ; {@PR2O2HNO3}         {MCM: CH3-CH(OOH)-CH2ONO2}
{3C (CHON) aromatics}
HCOCOHPAN       =  3C +  3H +  7O +  N ; {@HCOCOHPAN}         {}
{4C (CHO)}
C312COCO3       =  4C +  3H +  5O      ; {@C312COCO3}         {MCM}
HCOCCH3CO       =  4C +  4H +  2O      ; {@HCOCCH_3CO}        {HCOCCH3CO}
CH3COCHCO       =  4C +  4H +  2O      ; {@CH_3COCHCO}        {CH3COCHCO}
C4CODIAL        =  4C +  4H +  3O      ; {@C4CODIAL}          {MCM}
CO23C3CHO       =  4C +  4H +  3O      ; {@CH_3COCOCHO}       {MCM}
C312COCO3H      =  4C +  4H +  5O      ; {@C312COCO3H}        {MCM}
MACO2           =  4C +  5H +  2O      ; {@MACO2}             {MACO2}
EZCH3CO2CHCHO   =  4C +  5H +  3O      ; {@EZCH3CO2CHCHO}     {EZCH3CO2CHCHO}
EZCHOCCH3CHO2   =  4C +  5H +  3O      ; {@EZCHOCCH3CHO2}     {EZCHOCCH3CHO2}
CO2H3CHO        =  4C +  5H +  3O      ; {@CO2H3CHO}          {MCM: CH3-CO-CH(OH)-CHO}
MACO3           =  4C +  5H +  3O      ; {@MACO3}             {MCM: CH2=C(CH3)C(O)O2}
CH3COCHO2CHO    =  4C +  5H +  4O      ; {@CH_3COCHO_2CHO}    {}
HCOCO2CH3CHO    =  4C +  5H +  4O      ; {@HCOCO_2CH_3CHO}    {}
BIACETO2        =  4C +  5H +  4O      ; {@CH_3COCOCH_2O_2}   {MCM}
CHOC3COO2       =  4C +  5H +  4O      ; {@CHOC3COO2}         {MCM}
C44O2           =  4C +  5H +  5O      ; {@C44O2}             {MCM}
CO2H3CO3        =  4C +  5H +  5O      ; {@CO2H3CO3}          {MCM: CH3-CO-CH(OH)-C(O)O2}
MACR            =  4C +  6H +   O      ; {@MACR}              {MCM: CH2=C(CH3)CHO = methacrolein}
MVK             =  4C +  6H +   O      ; {@MVK}               {MCM: CH3-CO-CH=CH2 = methyl vinyl ketone}
BIACET          =  4C +  6H +  2O      ; {@BIACET}            {MCM: CH3-CO-CO-CH3}
MACO2H          =  4C +  6H +  2O      ; {@MACO2H}            {MCM: CH2=C(CH3)COOH}
HVMK            =  4C +  6H +  2O      ; {@HVMK}              {CH3COCHCHOH MCM = hydroxy vinyl methyl ketone}
HMAC            =  4C +  6H +  2O      ; {@HMAC}              {HCOC(CH3)CHOH MCM }
CO2C3CHO        =  4C +  6H +  2O      ; {@CO2C3CHO}          {CH3COCH2CHO MCM }
IBUTDIAL        =  4C +  6H +  2O      ; {@IBUTDIAL}          {HCOC(CH3)CHO MCM }
MACO3H          =  4C +  6H +  3O      ; {@MACO3H}            {MCM: CH2=C(CH3)C(O)OOH}
BIACETOH        =  4C +  6H +  3O      ; {@BIACETOH}          {MCM: CH3-CO-CO-CH2OH}
CH3COOHCHCHO    =  4C +  6H +  3O      ; {@CH_3COOHCHCHO}
HCOCCH3CHOOH    =  4C +  6H +  3O      ; {@HCOCCH_3CHOOH}
C413COOOH       =  4C +  6H +  4O      ; {@C413COOOH}         {MCM}
BIACETOOH       =  4C +  6H +  4O      ; {@CH_3COCOCH_2OOH}   {MCM}
CH3COCOCO2H     =  4C +  6H +  4O      ; {@CH3COCOCO2H}       {CH3COCOCO2H}
CO2H3CO2H       =  4C +  6H +  5O      ; {@CO2H3CO2H}         {CO2H3CO2H}
C44OOH          =  4C +  6H +  5O      ; {@C44OOH}            {MCM}
CO2H3CO3H       =  4C +  6H +  5O      ; {@CO2H3CO3H}         {MCM: CH3-CO-CH(OH)-C(O)OOH}
MACRO           =  4C +  7H +  3O      ; {@MACRO}             {MACRO}
IPRCO3          =  4C +  7H +  3O      ; {@IPRCO3}            {MCM: (CH3)2CHCO3}
MACRO2          =  4C +  7H +  4O      ; {@MACRO2}            {MCM: HOCH2C(OO)(CH3)CHO}
IPRHOCO3        =  4C +  7H +  4O      ; {@IPRHOCO3}          {IPRHOCO3}
MACRNO3           =  4C +  7H +  5O +  N ; {@MACRNO3}             {MACRNO3}
MVKNO3          =  4C +  7H +  5O +  N ; {@MVKNO3}            {MVKNO3}
PIPN            =  4C +  7H +  5O +  N ; {@PIPN}              {(CH3)2CHCO3 MCM } 
MEK             =  4C +  8H +   O      ; {@MEK}               {MCM: CH3-CO-CH2-CH3 = methyl ethyl ketone}
HO12CO3C4       =  4C +  8H +  3O      ; {@HO12CO3C4}         {MCM: CH3-CO-CH(OH)-CH2OH}
MACROH          =  4C +  8H +  3O      ; {@MACROH}            {MCM: HOCH2C(OH)(CH3)CHO}
MACROOH         =  4C +  8H +  4O      ; {@MACROOH}           {MCM: HOCH2C(OOH)(CH3)CHO}
MEPROPENE       =  4C +  8H            ; {@MEPROPENE}
BUT1ENE         =  4C +  8H            ; {@BUT1ENE}
CBUT2ENE        =  4C +  8H            ; {@CBUT2ENE}
TBUT2ENE        =  4C +  8H            ; {@TBUT2ENE}
BUTENOL         =  4C +  8H +   O      ; {@BUTENOL}           {CH3CH2CHCHOH MCM : n-butenol}
C3H7CHO         =  4C +  8H +   O      ; {@C_3H_7CHO}         {CH3CH2CH2CHO MCM : n-butanal}
IPRCHO          =  4C +  8H +   O      ; {@IPRCHO}            {(CH3)2CHCHO MCM : methylpropanal}
MPROPENOL       =  4C +  8H +   O      ; {@MPROPENOL}         {(CH3)2CCHOH MCM : methylpropenol}
IBUTALOH        =  4C +  8H +  2O      ; {@IBUTALOH}          {IBUTALOH}
MBOOO           =  4C +  8H +  3O      ; {@MBOOO}             {MBOOO}
BUT2OLO         =  4C +  8H +  3O      ; {@BUT2OLO}
PERIBUACID      =  4C +  8H +  3O      ; {@PERIBUACID}        {(CH3)2CHCO3H MCM }
IPRHOCO2H       =  4C +  8H +  3O      ; {@IPRHOCO2H}         {IPRHOCO2H}
IPRHOCO3H       =  4C +  8H +  4O      ; {@IPRHOCO3H}         {IPRHOCO3H}
IBUTOLBO2       =  4C +  9H +  2O      ; {@IBUTOLBO2}
BUT2OLO2        =  4C +  9H +  2O      ; {@BUT2OLO2}
TC4H9O2         =  4C +  9H +  2O      ; {@TC_4H_9O_2}        {(CH3)3-CO2 MCM: TC4H9O2}
IC4H9O2         =  4C +  9H +  2O      ; {@IC_4H_9O_2}        {(CH3)2-CHCH2O2 MCM: IC4H9O2}
IC4H9NO3        =  4C +  9H +  3O +  N ; {@IC4H9NO3}          {MCM: IC4H9NO3}
TC4H9NO3        =  4C +  9H +  3O +  N ; {@TC4H9NO3}          {MCM: TC4H9NO3}
BUT2OLNO3       =  4C +  9H +  5O +  N ; {@BUT2OLNO3}
NC4H10          =  4C + 10H            ; {@C_4H_<10>}         {MCM: CH3-CH2-CH2-CH3 = n-butane}
IC4H10          =  4C + 10H            ; {@iC_4H_<10>}        {MCM: (CH3)3-CH = i-butane}
TC4H9OOH        =  4C + 10H +  2O      ; {@TC_4H_9OOH}        {(CH3)3-COOH MCM: TC4H9OOH}
IC4H9OOH        =  4C + 10H +  2O      ; {@IC_4H_9OOH}        {(CH3)2-CHCH2OOH MCM: IC4H9OOH}
IBUTOLBOOH      =  4C + 10H +  3O      ; {@IBUTOLBOOH}
BUT2OLOOH       =  4C + 10H +  3O      ; {@BUT2OLOOH}
{4C (CHO) aromatics}
MALANHY         =  4C +  2H +  3O      ; {@MALANHY}           {maleic anhydride}
CO2C4DIAL       =  4C +  2H +  4O      ; {@CO2C4DIAL}         {2,3-Dioxosuccinaldehyde}
MALNHYOHCO      =  4C +  2H +  5O      ; {@MALNHYOHCO}        {}
MALDIALCO3      =  4C +  3H +  4O      ; {@MALDIALCO3}        {}
EPXDLCO3        =  4C +  3H +  5O      ; {@EPXDLCO3}          {}
MALANHYO2       =  4C +  3H +  6O      ; {@MALANHYO2}         {}
BZFUONE         =  4C +  4H +  2O      ; {@BZFUONE}           {2(5H)-Furanone}
MALDIAL         =  4C +  4H +  2O      ; {@MALDIAL}           {2-Butenedial}
MALDALCO2H      =  4C +  4H +  3O      ; {@MALDALCO2H}        {4-Oxo-2-butenoic acid}
EPXC4DIAL       =  4C +  4H +  3O      ; {@EPXC4DIAL}         {}
HOCOC4DIAL      =  4C +  4H +  4O      ; {@HOCOC4DIAL}        {2-Hydroxy-3-oxosuccinaldehyde}
MALDALCO3H      =  4C +  4H +  4O      ; {@MALDALCO3H}        {}
BZFUCO          =  4C +  4H +  4O      ; {@BZFUCO}            {}
EPXDLCO2H       =  4C +  4H +  4O      ; {@EPXDLCO2H}         {}
CO14O3CHO       =  4C +  4H +  4O      ; {@CO14O3CHO}         {}
CO14O3CO2H      =  4C +  4H +  5O      ; {@CO14O3CO2H}        {}
EPXDLCO3H       =  4C +  4H +  5O      ; {@EPXDLCO3H}         {}
MALANHYOOH      =  4C +  4H +  6O      ; {@MALANHYOOH}        {}
BZFUO2          =  4C +  5H +  3O      ; {@BZFUO2}            {}
MECOACETO2      =  4C +  5H +  5O      ; {@MECOACETO2}        {}
MALDIALO2       =  4C +  5H +  5O      ; {@MALDIALO2}         {}
MALDIALOOH      =  4C +  6H +  5O      ; {@MALDIALOOH}        {}
BZFUOOH         =  4C +  6H +  5O      ; {@BZFUOOH}           {}
MECOACEOOH      =  4C +  6H +  5O      ; {@MECOACEOOH}        {}
{4C (CHON)}
C312COPAN       =  4C +  3H +  7O +  N ; {@C312COPAN}         {MCM}
MPAN            =  4C +  5H +  5O +  N ; {@MPAN}              {MCM: CH2=C(CH3)C(O)OONO2 = peroxymethacryloyl nitrate, peroxymethacrylic nitric anhydride}
IBUTOLBNO3      =  4C +  9H +  4O +  N ; {@IBUTOLBNO3}        {}
C4PAN5          =  4C +  7H +  6O +  N ; {@C4PAN5}            {MCM}
{4C (CHON) aromatics}
NC4DCO2H        =  4C +  3H +  5O +  N ; {@NC4DCO2H}          {}
MALDIALPAN      =  4C +  3H +  6O +  N ; {@MALDIALPAN}        {}
NBZFUONE        =  4C +  3H +  6O +  N ; {@NBZFUONE}          {}
EPXDLPAN        =  4C +  3H +  7O +  N ; {@EPXDLPAN}          {}
NBZFUO2         =  4C +  4H +  7O +  N ; {@NBZFUO2}           {}
NBZFUOOH        =  4C +  5H +  7O +  N ; {@NBZFUOOH}          {}
{4C (CHO) (lumped)}
LMEKO2          =  4C +  7H +  3O      ; {@LMEKO2}            {CH3-CO-CH2-CH2-OO + CH3-CO-CH(O2)-CH3}
LHMVKABO2       =  4C +  7H +  4O      ; {@LHMVKABO2}         {HOCH2-CH(O2)-CO-CH3 + CH2(O2)-CH(OH)-CO-CH3}
LMEKOOH         =  4C +  8H +  3O      ; {@LMEKOOH}           {CH3-CO-CH2-CH2-OOH + CH3-CO-CH(OOH)-CH3}
LHMVKABOOH      =  4C +  8H +  4O      ; {@LHMVKABOOH}        {HOCH2-CH(OOH)-CO-CH3 + CH2(OOH)-CH(OH)-CO-CH3}
LC4H9O2         =  4C +  9H +  2O      ; {@LC_4H_9O_2}        {CH3-CH2-CH(O2)-CH3 + CH3-CH2-CH2-CH2O2 MCM: NC4H9O2 and SC4H9O2}
LC4H9OOH        =  4C + 10H +  2O      ; {@LC_4H_9OOH}        {CH3-CH2-CH(OOH)-CH3 + CH3-CH2-CH2-CH2OOH MCM: NC4H9OOH and SC4H9OOH}
LBUT1ENO2       =  4C +  9H +  2O      ; {@LBUT1ENO2}         {HO3C4O2 and NBUTOLAO2}
LBUT1ENOOH      =  4C + 10H +  3O      ; {@LBUT1ENOOH}        {HO3C4OOH and NBUTOLAOOH}
{4C (CHON) (lumped)}
LMEKNO3         =  4C +  7H +  5O +  N ; {@LMEKNO3}           {CH3-CO-CH2-CH2-ONO2 + CH3-CO-CH(ONO2)-CH3}
LC4H9NO3        =  4C +  9H +  3O +  N ; {@LC4H9NO3}          {MCM: NC4H9NO3 and SC4H9NO3}
LBUT1ENNO3      =  4C +  9H +  5O +  N ; {@LBUT1ENNO3}        {HO3C4NO3 and NBUTOLANO3}
{5C (CHO)}
LZCO3C23DBCOD    =  5C +  5H +  4O      ; {@LZCO3C23DBCOD}      {LZCO3C23DBCOD}
CHOC3COCO3      =  5C +  5H +  5O      ; {@CHOC3COCO3}        {MCM}
CO23C4CO3       =  5C +  5H +  5O      ; {@CO23C4CO3}         {MCM}
ME3FURAN        =  5C +  6H +   O      ; {@3METHYLFURAN}      {3-methyl-furan}
C4MDIAL    =  5C +  6H +  2O      ; {@C4MDIAL}      {2-methyl-butenedial, MCM name C4MDIAL}
CO13C4CHO       =  5C +  6H +  3O      ; {@CO13C4CHO}         {MCM}
CO23C4CHO       =  5C +  6H +  3O      ; {@CO23C4CHO}         {MCM}
LZCO3HC23DBCOD   =  5C +  6H +  4O      ; {@LZCO3HC23DBCOD}     {LZCO3HC23DBCOD in MCM LZCO3HC23DBCOD}
C513CO          =  5C +  6H +  4O      ; {@C513CO}            {MCM}
CHOC3COOOH      =  5C +  6H +  4O      ; {@CHOC3COOOH}        {MCM}
CO23C4CO3H      =  5C +  6H +  5O      ; {@CO23C4CO3H}        {MCM}
C511O2          =  5C +  7H +  4O      ; {@C511O2}            {MCM}
C512O2          =  5C +  7H +  4O      ; {@C512O2}            {MCM}
C514O2          =  5C +  7H +  4O      ; {@C514O2}            {MCM}
C1ODC2O2C4OD    =  5C +  7H +  4O      ; {@C1ODC2O2C4OD}      {C1ODC2O2C4OD}
C513O2          =  5C +  7H +  5O      ; {@C513O2}            {MCM}
C5H8            =  5C +  8H            ; {@C_5H_8}            {MCM: CH2=C(CH3)CH=CH2 = isoprene}
HCOC5           =  5C +  8H +  2O      ; {@HCOC5}             {MCM: HOCH2-CO-C(CH3)=CH2}
LZCODC23DBCOOH   =  5C +  8H +  3O      ; {@LZCODC23DBCOOH}     {LZCODC23DBCOOH}
MBOCOCO         =  5C +  8H +  3O      ; {@MBOCOCO}           {MBOCOCO}
C511OOH         =  5C +  8H +  4O      ; {@C511OOH}           {MCM}
C514OOH         =  5C +  8H +  4O      ; {@C514OOH}           {MCM}
C512OOH         =  5C +  8H +  4O      ; {@C512OOH}           {MCM}
C1ODC2OOHC4OD   =  5C +  8H +  4O      ; {@C1ODC2OOHC4OD}     {C1ODC2OOHC4OD}
C513OOH         =  5C +  8H +  5O      ; {@C513OOH}           {MCM}
LISOPAB          =  5C +  9H +   O      ; {@LISOPAB}            {LISOPAB}
LISOPCD          =  5C +  9H +   O      ; {@LISOPCD}            {LISOPCD}
ISOPBO2         =  5C +  9H +  3O      ; {@ISOPBO2}           {MCM: HOCH2-C(CH3)(O2)-CH=CH2}
ISOPDO2         =  5C +  9H +  3O      ; {@ISOPDO2}           {MCM: CH2=C(CH3)CH(O2)-CH2OH}
DB1O            =  5C +  9H +  3O      ; {@DB1O2}             {Alkoxy radical which undergoes the double H-shift predicted by T. Dibble and confirmed by F. Paulot}
DB1O2           =  5C +  9H +  4O      ; {@DB1O2}             {Peroxy radical with a vinyl alcohol part}
C1ODC2O2C4OOH   =  5C +  9H +  5O      ; {@C1ODC2O2C4OOH}     {C1ODC2O2C4OOH}
C1OOHC3O2C4OD   =  5C +  9H +  5O      ; {@C1OOHC3O2C4OD}     {C1OOHC3O2C4OD}
C59O2           =  5C +  9H +  5O      ; {@C59O2}             {MCM: HOCH2-CO-C(CH3)(O2)-CH2OH}
DB2O2           =  5C +  9H +  5O      ; {@DB1O2}             {}
C1ODC3O2C4OOH   =  5C +  9H +  5O      ; {@C1ODC3O2C4OOH}     {C1ODC3O2C4OOH}
C1OOHC2O2C4OD   =  5C +  9H +  5O      ; {@C1OOHC2O2C4OD}     {C1OOHC2O2C4OD}
MBO             =  5C + 10H +   O      ; {@MBO}               {2-methyl-3-buten-2-ol}
ISOPAOH         =  5C + 10H +  2O      ; {@ISOPAOH}           {MCM: HOCH2-C(CH3)=CH-CH2OH}
ISOPBOH         =  5C + 10H +  2O      ; {@ISOPBOH}           {MCM: HOCH2-C(CH3)(OH)-CH=CH2}
ISOPDOH         =  5C + 10H +  2O      ; {@ISOPDOH}           {MCM: CH2=C(CH3)CH(OH)-CH2OH}
ISOPBOOH        =  5C + 10H +  3O      ; {@ISOPBOOH}          {MCM: HOCH2-C(CH3)(OOH)-CH=CH2}
ISOPDOOH        =  5C + 10H +  3O      ; {@ISOPDOOH}          {MCM: CH2=C(CH3)CH(OOH)-CH2OH}
MBOACO          =  5C + 10H +  3O      ; {@MBOACO}            {MBOACO}
DB1OOH          =  5C + 10H +  4O      ; {@DB1OOH}            {}
C59OOH          =  5C + 10H +  5O      ; {@C59OOH}            {MCM: HOCH2-CO-C(CH3)(OOH)-CH2OH}
C1OOHC2OOHC4OD  =  5C + 10H +  5O      ; {@C1OOHC2OOHC4OD}    {C1OOHC2OOHC4OD}
DB2OOH          =  5C + 10H +  5O      ; {@DB2OOH}            {}
{5C aromatics (CHO)}
C4CO2DBCO3      =  5C +  3H +  5O      ; {@C4CO2DBCO3}        {MCM}
MMALANHY        =  5C +  4H +  3O      ; {@MMALANHY}          {MCM: 3-Methyl-2,5-furandione}
C54CO           =  5C +  4H +  4O      ; {@C54CO}             {MCM: 2,3,4-Trioxopentanal}
C4CO2DCO3H      =  5C +  4H +  5O      ; {@C4CO2DCO3H}        {MCM}
C5DIALCO        =  5C +  5H +  3O      ; {@C5DIALCO}          {MCM}
C5DIALO2        =  5C +  5H +  4O      ; {@C5DIALO2}          {MCM}
C5CO14O2        =  5C +  5H +  4O      ; {@C5CO14O2}          {MCM}
ACCOMECO3       =  5C +  5H +  6O      ; {@ACCOMECO3}         {MCM}
MMALANHYO2      =  5C +  5H +  6O      ; {@MMALANHYO2}        {MCM}
TLFUONE         =  5C +  6H +  2O      ; {@TLFUONE}           {MCM: 5-Methyl-2(5H)-furanone}
C5DICARB        =  5C +  6H +  2O      ; {@C5DICARB}          {MCM: 4-Oxo-2-pentenal}
MC3ODBCO2H      =  5C +  6H +  3O      ; {@MC3ODBCO2H}        {MCM}
C5CO14OH        =  5C +  6H +  3O      ; {@C5CO14OH}          {MCM: 4-Oxo-2-pentenoic acid}
C5134CO2OH      =  5C +  6H +  4O      ; {@C5134CO2OH}        {MCM: 2-Hydroxy-3,4-dioxopentanal}
C5DIALOOH       =  5C +  6H +  4O      ; {@C5DIALOOH}         {MCM}
ACCOMECHO       =  5C +  6H +  4O      ; {@ACCOMECHO}         {MCM}
C5CO14OOH       =  5C +  6H +  4O      ; {@C5CO14OOH}         {MCM}
C24O3CCO2H      =  5C +  6H +  5O      ; {@C24O3CCO2H}        {MCM}
MMALNHYOOH      =  5C +  6H +  6O      ; {@MMALNHYOOH}        {MCM}
ACCOMECO3H      =  5C +  6H +  6O      ; {@ACCOMECO3H}        {MCM}
C5DICARBO2      =  5C +  7H +  5O      ; {@C5DICARBO2}        {MCM: Carboxy(hydroxy)acetate}
TLFUO2          =  5C +  7H +  5O      ; {@TLFUO2}            {MCM}
TLFUOOH         =  5C +  8H +  5O      ; {@TLFUOOH}           {MCM}
C5DICAROOH      =  5C +  8H +  5O      ; {@C5DICAROOH}        {MCM}
{5C (CHON)}
CHOC3COPAN      =  5C +  5H +  5O +  N ; {@CHOC3COPAN}        {MCM}
LZCPANC23DBCOD   =  5C +  5H +  6O +  N ; {@LZCPANC23DBCOD}     {LZCPANC23DBCOD}
C5PAN9          =  5C +  5H +  7O +  N ; {@C5PAN9}            {MCM}
NC4CHO          =  5C +  7H +  4O +  N ; {@NC4CHO}            {MCM: O2NOCH2-C(CH3)=CH-CHO}
C514NO3         =  5C +  7H +  5O +  N ; {@C514NO3}           {MCM}
NISOPO2         =  5C +  8H +  5O +  N ; {@NISOPO2}           {MCM: O2NOCH2-C(CH3)=CH-CH2O2}
NC4OHCO3        =  5C +  8H +  6O +  N ; {@NC4OHCO3}          {MCM: NC4OHCO3}
NC4OHCPAN       =  5C +  8H +  8O + 2N ; {@NC4OHCPAN}         {NC4OHCPAN}
ISOPBNO3        =  5C +  9H +  4O +  N ; {@ISOPBNO3}          {MCM: HOCH2-C(CH3)(ONO2)-CH=CH2}
ISOPDNO3        =  5C +  9H +  4O +  N ; {@ISOPDNO3}          {MCM: CH2=C(CH3)CH(ONO2)-CH2OH}
NISOPOOH        =  5C +  9H +  5O +  N ; {@NISOPOOH}          {MCM: O2NOCH2-C(CH3)=CH-CH2OOH}
NMBOBCO         =  5C +  9H +  5O +  N ; {@NMBOBCO}           {NMBOBCO}
C4MCONO3OH      =  5C +  9H +  5O +  N ; {@C4MCONO3OH}        {MCM}
DB1NO3          =  5C +  9H +  6O +  N ; {@DB1NO3}            {}
NC4OHCO3H       =  5C +  9H +  6O +  N ; {@NC4OHCO3H}         {MCM: NC4OHCO3H}
ISOPBDNO3O2     =  5C + 10H +  7O +  N ; {@ISOPBDNO3O2}       {ISOPBDNO3O2}
{5C aromatics (CHON)}
C4CO2DBPAN      =  5C +  3H +  7O +  N ; {@C4CO2DBPAN}        {MCM}
NC4MDCO2H       =  5C +  5H +  5O +  N ; {@NC4MDCO2H N}       {MCM}
C5COO2NO2       =  5C +  5H +  6O +  N ; {@C5COO2NO2}         {MCM}
ACCOMEPAN       =  5C +  5H +  6O +  N ; {@ACCOMEPAN}         {MCM}
NTLFUO2         =  5C +  6H +  7O +  N ; {@NTLFUO2}           {MCM}
NTLFUOOH        =  5C +  7H +  6O +  N ; {@NTLFUOOH}          {MCM}
{5C (CHO) (lumped)}
LME3FURANO2     =  5C +  7H +  4O      ; {@L3METHYLFURANO2}   {hydroxy-3-methyl-furan peroxy radical}
LHC4ACCO3       =  5C +  7H +  4O      ; {@LHC4ACCO3}         {HOCH2-C(CH3)=CH-C(O)O2 + HOCH2-CH=C(CH3)-C(O)O2}
LHC4ACCHO       =  5C +  8H +  2O      ; {@LHC4ACCHO}         {HOCH2-C(CH3)=CH-CHO + HOCH2-CH=C(CH3)-CHO}
LHC4ACCO2H      =  5C +  8H +  3O      ; {@LHC4ACCO2H}        {HOCH2-C(CH3)=CH-C(O)OH + HOCH2-CH=C(CH3)-C(O)OH}
LHC4ACCO3H      =  5C +  8H +  4O      ; {@LHC4ACCO3H}        {HOCH2-C(CH3)=CH-C(O)OOH + HOCH2-CH=C(CH3)-C(O)OOH}
LISOPACO        =  5C +  9H +  2O      ; {@LISOPACO}          {HOCH2-C(CH3)=CH-CH2O + HOCH2-CH=C(CH3)-CH2O}
LDISOPACO       =  5C +  9H +  2O      ; {@LISOPACO}          {LDISOPACO}
LISOPEFO        =  5C +  9H +  2O      ; {@LISOPEFO}          {LISOPEFO}
LISOPACO2       =  5C +  9H +  3O      ; {@LISOPACO2}         {HOCH2-C(CH3)=CH-CH2O2 + HOCH2-CH=C(CH3)-CH2O2}
LDISOPACO2      =  5C +  9H +  3O      ; {@LDISOPACO2}        {LDISOPACO2}
LISOPEFO2       =  5C +  9H +  3O      ; {@LISOPEFO2}         {LISOPEFO2}
LC578O2         =  5C +  9H +  5O      ; {@LC578O2}           {HOCH2-CH(OH)C(CH3)(O2)-CHO + HOCH2-C(CH3)(O2)-CH(OH)-CHO}
LIEPOX          =  5C + 10H +  3O      ; {@LIEPOX}            {epoxydiol}
LISOPACOOH      =  5C + 10H +  3O      ; {@LISOPACOOH}        {HOCH2-C(CH3)=CH-CH2OOH + HOCH2-CH=C(CH3)-CH2OOH}
LC578OOH        =  5C + 10H +  5O      ; {@LC578OOH}          {HOCH2-CH(OH)C(CH3)(OOH)-CHO + HOCH2-C(CH3)(OOH)-CH(OH)-CHO}
LMBOABO2        =  5C + 11H +  4O      ; {@LMBOABO2}          {LMBOABO2}
LMBOABOOH       =  5C + 12H +  4O      ; {@LMBOABOOH}         {LMBOABOOH}
{5C (CHON) (lumped)}
LC5PAN1719      =  5C +  7H +  6O +  N ; {@LC5PAN1719}        {HOCH2-C(CH3)=CH-C(O)OONO2 + HOCH2-CH=C(CH3)C(O)OONO2}
LISOPACNO3      =  5C +  9H +  4O +  N ; {@LISOPACNO3}        {HOCH2-C(CH3)=CH-CH2ONO2 + HOCH2-CH=C(CH3)-CH2ONO2}
LNMBOABO2       =  5C +  9H +  6O +  N ; {@LNMBOABO2}         {LNMBOABO2}
LNMBOABOOH      =  5C + 10H +  6O +  N ; {@LNMBOABOOH}        {LNMBOABOOH}
LISOPACNO3O2    =  5C + 10H +  7O +  N ; {@LISOPACNO3O2}      {RO2 resulting from OH-addition to ISOPANO3 and ISOPCNO3}
LMBOABNO3       =  5C + 11H +  5O +  N ; {@LMBOABNO3}         {LMBOABNO3}
LNISO3          =  5C             +  N ; {@LNISO3}            {C510O2+NC4CO3 = CHO-CH(OH)-C(CH3)(O2)-CH2ONO2 + O2NOCH2-C(CH3)=CH-C(O)O2}
LNISOOH         =  5C             +  N ; {@LNISOOH}           {CHO-CH(OH)-C(CH3)(OOH)-CH2ONO2 + O2NOCH2-C(CH3)=CH-C(O)OOH}
{6C (CHO)}
CO235C5CHO      =  6C +  6H +  4O      ; {@CO235C5CHO}        {MCM}
CO235C6O2       =  6C +  7H +  5O      ; {@CO235C6O2}         {MCM}
C614CO          =  6C +  8H +  4O      ; {@C614CO}            {MCM}
CO235C6OOH      =  6C +  8H +  5O      ; {@CO235C6OOH}        {MCM}
C614O2          =  6C +  9H +  5O      ; {@C614O2}            {MCM}
C614OOH         =  6C + 10H +  5O      ; {@C614OOH}           {MCM}
{C6 (CHO) aromatics}
PBZQONE         =  6C +  4H +  2O      ; {@PBZQONE}           {1,4-benzoquinone}
CATECHOL        =  6C +  4H +  2O      ; {@CATECHOL}          {catechol}
C6CO4DB         =  6C +  4H +  4O      ; {@C6CO4DB}           {}
PBZQCO          =  6C +  4H +  4O      ; {@PBZQCO}            {}
C6H5O           =  6C +  5H +   O      ; {@C6H5O}             {phenyloxidanyl}
CATEC1O         =  6C +  5H +  2O      ; {@CATEC1O}           {2-λ1-oxidanylphenol}
C6H5O2          =  6C +  5H +  2O      ; {@C6H5O2}            {}
CATEC1O2        =  6C +  5H +  3O      ; {@CATEC1O2}          {}
C5CO2DBCO3      =  6C +  5H +  5O      ; {@C5CO2DBCO3}        {}
PBZQO2          =  6C +  5H +  5O      ; {@PBZQO2}            {}
BZEMUCCO3       =  6C +  5H +  5O      ; {@BZEMUCCO3}         {}
C5CO2DCO3H      =  6C +  6H +  5O      ; {@C5CO2DCO3H}        {}
C5CO2OHCO3      =  6C +  5H +  6O      ; {@C5CO2OHCO3}        {}
BENZENE         =  6C +  6H            ; {@BENZENE}           {benzene}
PHENOL          =  6C +  6H +   O      ; {@PHENOL}            {}
C6H5OOH         =  6C +  6H +  2O      ; {@C6H5OOH}           {phenyl hydroperoxide}
BZEPOXMUC       =  6C +  6H +  3O      ; {@BZEPOXMUC}         {}
C6125CO         =  6C +  6H +  3O      ; {@C6125CO}           {2,5-Dioxo-3-hexenal}
CATEC1OOH       =  6C +  6H +  3O      ; {@CATEC1OOH}         {}
BZEMUCCO2H      =  6C +  6H +  4O      ; {@BZEMUCCO2H}        {}
BZOBIPEROH      =  6C +  6H +  4O      ; {@BZOBIPEROH}        {}
BZEMUCCO        =  6C +  6H +  5O      ; {@BZEMUCCO}          {}
PBZQOOH         =  6C +  6H +  5O      ; {@PBZQOOH}           {}
BZEMUCCO3H      =  6C +  6H +  5O      ; {@BZEMUCCO3H}        {}
C5COOHCO3H      =  6C +  6H +  6O      ; {@C5COOHCO3H}        {}
C615CO2O2       =  6C +  7H +  4O      ; {@C615CO2O2}         {}
BZBIPERO2       =  6C +  7H +  5O      ; {@BZBIPERO2}         {}
PHENO2          =  6C +  7H +  6O      ; {@PHENO2}            {}
BZEMUCO2        =  6C +  7H +  6O      ; {@BZEMUCO2}          {}
C615CO2OOH      =  6C +  8H +  4O      ; {@C615CO2OOH}        {}
BZBIPEROOH      =  6C +  8H +  5O      ; {@BZBIPEROOH}        {}
PHENOOH         =  6C +  8H +  6O      ; {@PHENOOH}           {}
BZEMUCOOH       =  6C +  8H +  6O      ; {@BZEMUCOOH}         {}
CPDKETENE       =  6C +  4H +   O      ; {@CPDKETENE}         {hv nitrophenol: cyclopentadiene ketene (Luc Vereecken's prediction)}
{6C (CHON)}
C614NO3         =  6C +  9H +  6O +  N ; {@C614NO3}           {MCM}
{C6 (CHON) aromatics}
NCPDKETENE      =  6C +  3H +  3O +  N ; {@NCPDKETENE}        {hv nitrophenol: cyclopentadiene ketene (Luc Vereecken's prediction)}
NPHEN1O         =  6C +  4H +  3O +  N ; {@NPHEN1O}           {}
NPHEN1O2        =  6C +  4H +  4O +  N ; {@NPHEN1O2}          {}
DNPHEN          =  6C +  4H +  5O + 2N ; {@DNPHEN}            {2,4-dinitrophenol}
NBZQO2          =  6C +  4H +  7O +  N ; {@NBZQO2}            {}
NDNPHENO2       =  6C +  4H + 12O + 3N ; {@NDNPHENO2}         {}
HOC6H4NO2       =  6C +  5H +  3O +  N ; {@HOC6H4NO2}         {2-nitrophenol}
NCATECHOL       =  6C +  5H +  4O +  N ; {@NCATECHOL}         {}
NPHEN1OOH       =  6C +  5H +  4O +  N ; {@NPHEN1OOH}         {}
BZEMUCPAN       =  6C +  5H +  7O +  N ; {@BZEMUCPAN}         {}
C5CO2DBPAN      =  6C +  5H +  7O +  N ; {@C5CO2DBPAN}        {}
NBZQOOH         =  6C +  5H +  7O +  N ; {@NBZQOOH}           {}
C5CO2OHPAN      =  6C +  5H +  8O +  N ; {@C5CO2OHPAN}        {}
DNPHENO2        =  6C +  5H + 10O + 2N ; {@DNPHENO2}          {}
NNCATECO2       =  6C +  5H + 11O + 2N ; {@NNCATECO2}         {}
NDNPHENOOH      =  6C +  5H + 12O + 3N ; {@NDNPHENOOH}        {}
NPHENO2         =  6C +  6H +  8O +  N ; {@NPHENO2}           {}
NCATECO2        =  6C +  6H +  9O +  N ; {@NCATECO2}          {}
DNPHENOOH       =  6C +  6H + 10O + 2N ; {@DNPHENOOH}         {}
NNCATECOOH      =  6C +  6H + 11O + 2N ; {@NNCATECOOH}        {}
BZBIPERNO3      =  6C +  7H +  6O +  N ; {@BZBIPERNO3}        {}
BZEMUCNO3       =  6C +  7H +  7O +  N ; {@BZEMUCNO3}         {}
NPHENOOH        =  6C +  7H +  8O +  N ; {@NPHENOOH}          {}
NCATECOOH       =  6C +  7H +  9O +  N ; {@NCATECOOH}         {}
{7C (CHO)}
MCPDKETENE      =  7C +  6H +  2O      ; {@MCPDKETENE}        {hv nitrophenol: cyclopentadiene ketene (Luc Vereecken's prediction)}
CO235C6CO3      =  7C +  7H +  6O      ; {@CO235C6CO3}        {MCM}
CO235C6CHO      =  7C +  8H +  4O      ; {@CO235C6CHO}        {MCM}
C235C6CO3H      =  7C +  8H +  6O      ; {@C235C6CO3H}        {MCM}
C716O2          =  7C +  9H +  5O      ; {@C716O2}            {MCM}
C716OOH         =  7C + 10H +  5O      ; {@C716OOH}           {MCM}
ROO6R3O         =  7C + 11H +  4O      ; {@ROO6R3O}           {from ref3019}
C721O2          =  7C + 11H +  4O      ; {@C721O2}            {MCM}
C722O2          =  7C + 11H +  5O      ; {@C722O2}            {MCM}
ROO6R3O2        =  7C + 11H +  5O      ; {@ROO6R3O2}          {ROO6R3OO from ref3019}
ROO6R5O2        =  7C + 11H +  7O      ; {@ROO6R5O2}          {ROO6R5OO from ref3019}
C721OOH         =  7C + 12H +  4O      ; {@C721OOH}           {MCM}
C722OOH         =  7C + 12H +  5O      ; {@C722OOH}           {MCM}
{C7 (CHO) aromatics}
C6H5CO3         =  7C +  5H +  3O      ; {@C6H5CO3}           {}
BENZAL          =  7C +  6H +   O      ; {@BENZAL}            {}
PHCOOH          =  7C +  6H +  2O      ; {@PHCOOH}            {Benzoic acid}
APTLQONE        =  7C +  6H +  2O      ; {@APTLQONE}          {2-Methyl-1,4-benzoquinone}
C6H5CO3H        =  7C +  6H +  3O      ; {@C6H5CO3H}          {Perbenzoic acid}
C7CO4DB         =  7C +  6H +  4O      ; {@C7CO4DB}           {}
APTLQCO         =  7C +  6H +  4O      ; {@APTLQCO}           {}
TOL1O           =  7C +  7H +   O      ; {@TOL1O}             {(2-Methylphenyl)oxidanyl}
OXYL1O2         =  7C +  7H +  2O      ; {@OXYL1O2}           {1-methyl-2-(oxo-λ3-oxidanyl)benzene}
C6H5CH2O2       =  7C +  7H +  2O      ; {@C6H5CH2O2}         {Benzyldioxidanyl}
MCATEC1O        =  7C +  7H +  2O      ; {@MCATEC1O}          {}
MCATEC1O2       =  7C +  7H +  3O      ; {@MCATEC1O2}         {}
APTLQO2         =  7C +  7H +  5O      ; {@APTLQO2}           {}
TLEMUCCO3       =  7C +  7H +  5O      ; {@TLEMUCCO3}         {}
C6CO2OHCO3      =  7C +  7H +  6O      ; {@C6CO2OHCO3}        {}
TOLUENE         =  7C +  8H            ; {@TOLUENE}           {toluene}
CRESOL          =  7C +  8H +   O      ; {@CRESOL}            {}
OXYL1OOH        =  7C +  8H +  2O      ; {@OXYL1OOH}          {}
C6H5CH2OOH      =  7C +  8H +  2O      ; {@C6H5CH2OOH}        {Benzyl hydroperoxide}
MCATECHOL       =  7C +  8H +  2O      ; {@MCATECHOL}         {3-Methylcatechol}
TLEPOXMUC       =  7C +  8H +  3O      ; {@TLEPOXMUC}         {}
MCATEC1OOH      =  7C +  8H +  3O      ; {@MCATEC1OOH}        {}
TLEMUCCO2H      =  7C +  8H +  4O      ; {@TLEMUCCO2H}        {}
TLOBIPEROH      =  7C +  8H +  4O      ; {@TLOBIPEROH}        {}
APTLQOOH        =  7C +  8H +  5O      ; {@APTLQOOH}          {}
TLEMUCCO        =  7C +  8H +  5O      ; {@TLEMUCCO}          {}
TLEMUCCO3H      =  7C +  8H +  5O      ; {@TLEMUCCO3H}        {}
C6COOHCO3H      =  7C +  8H +  6O      ; {@C6COOHCO3H}        {}
TLBIPERO2       =  7C +  9H +  5O      ; {@TLBIPERO2}         {}
TLEMUCO2        =  7C +  9H +  6O      ; {@TLEMUCO2}          {}
CRESO2          =  7C +  9H +  6O      ; {@CRESO2}            {}
TLBIPEROOH      =  7C + 10H +  5O      ; {@TLBIPEROOH}        {}
CRESOOH         =  7C + 10H +  6O      ; {@CRESOOH}           {}
TLEMUCOOH       =  7C + 10H +  6O      ; {@TLEMUCOOH}         {}
{7C (CHON)}
C7PAN3          =  7C +  7H +  8O +  N ; {@C7PAN3}            {MCM}
{C7 (CHON) aromatics}
MNCPDKETENE     =  7C +  5H +  3O +  N ; {@MNCPDKETENE}       {hv nitrophenol: cyclopentadiene ketene (Luc Vereecken's prediction)}
PBZN            =  7C +  5H +  5O +  N ; {@PBZN}              {benzoyl nitro peroxide}
NDNCRESO2       =  7C +  6H +  2O + 3N ; {@NDNCRESO2}         {}
NCRES1O         =  7C +  6H +  3O +  N ; {@NCRES1O}           {}
NCRES1O2        =  7C +  6H +  4O +  N ; {@NCRES1O2}          {}
DNCRES          =  7C +  6H +  5O + 2N ; {@DNCRES}            {2-methyl-4,6-dinitrophenol}
NAPTLQO2        =  7C +  6H +  7O +  N ; {@NAPTLQO2}          {}
TOL1OHNO2       =  7C +  7H +  3O +  N ; {@TOL1OHNO2}         {2-methyl-6-nitrophenol}
C6H5CH2NO3      =  7C +  7H +  3O +  N ; {@C6H5CH2NO3}        {Benzyl nitrate}
MNCATECH        =  7C +  7H +  4O +  N ; {@MNCATECH}          {3-methyl-6-nitro-1,2-benzenediol}
NCRES1OOH       =  7C +  7H +  4O +  N ; {@NCRES1OOH}         {}
NAPTLQOOH       =  7C +  7H +  7O +  N ; {@NAPTLQOOH}         {}
TLEMUCPAN       =  7C +  7H +  7O +  N ; {@TLEMUCPAN}         {}
C6CO2OHPAN      =  7C +  7H +  8O +  N ; {@C6CO2OHPAN}        {}
DNCRESO2        =  7C +  7H + 10O + 2N ; {@DNCRESO2}          {}
MNNCATECO2      =  7C +  7H + 11O + 2N ; {@MNNCATECO2}        {}
NDNCRESOOH      =  7C +  7H + 12O + 3N ; {@NDNCRESOOH}        {}
NCRESO2         =  7C +  8H +  8O +  N ; {@NCRESO2}           {}
MNCATECO2       =  7C +  8H +  9O +  N ; {@MNCATECO2}         {}
DNCRESOOH       =  7C +  8H + 10O + 2N ; {@DNCRESOOH}         {}
MNNCATCOOH      =  7C +  8H + 11O + 2N ; {@MNNCATCOOH}        {}
TLBIPERNO3      =  7C +  9H +  6O +  N ; {@TLBIPERNO3}        {}
TLEMUCNO3       =  7C +  9H +  7O +  N ; {@TLEMUCNO3}         {}
NCRESOOH        =  7C +  9H +  8O +  N ; {@NCRESOOH}          {}
MNCATECOOH      =  7C +  9H +  9O +  N ; {@MNCATECOOH}        {}
{8C (CHO)}
C8BCO2          =  8C + 11H +  2O      ; {@C8BCO2}            {MCM}
C721CO3         =  8C + 11H +  5O      ; {@C721CO3}           {MCM}
C8BCCO          =  8C + 12H +  O       ; {@C8BCCO}            {MCM}
C8BCOOH         =  8C + 12H +  2O      ; {@C8BCOOH}           {MCM}
C721CHO         =  8C + 12H +  3O      ; {@C721CHO}           {MCM}
NORPINIC        =  8C + 12H +  4O      ; {@NORPINIC}          {MCM}
C721CO3H        =  8C + 12H +  5O      ; {@C721CO3H}          {MCM}
C85O2           =  8C + 13H +  3O      ; {@C85O2}             {MCM}
C89O2           =  8C + 13H +  3O      ; {@C89O2}             {MCM}
C811O2          =  8C + 13H +  4O      ; {@C811O2}            {MCM}
C86O2           =  8C + 13H +  4O      ; {@C86O2}             {MCM}
C812O2          =  8C + 13H +  5O      ; {@C812O2}            {MCM}
C813O2          =  8C + 13H +  5O      ; {@C813O2}            {MCM}
C8BC            =  8C + 14H            ; {@C8BC}              {MCM}
C85OOH          =  8C + 14H +  3O      ; {@C85OOH}            {MCM}
C811OOH         =  8C + 14H +  4O      ; {@C811OOH}           {MCM}
C86OOH          =  8C + 14H +  4O      ; {@C86OOH}            {MCM}
C812OOH         =  8C + 14H +  5O      ; {@C812OOH}           {MCM}
C813OOH         =  8C + 14H +  5O      ; {@C813OOH}           {MCM}
C89OOH          =  8C + 14H +  3O      ; {@C89OOH}            {MCM}
C810OOH         =  8C + 14H +  4O      ; {@C810OOH}           {MCM}
C810O2          =  8C + 13H +  4O      ; {@C810O2}            {MCM}
{C8 (CHO) aromatics}
STYRENE         =  8C +  8H            ; {@STYRENE}           {styrene}
STYRENO2        =  8C +  9H +  3O      ; {@STYRENO2}          {}
LXYL            =  8C + 10H            ; {@LXYL}              {xylene}
EBENZ           =  8C + 10H            ; {@EBENZ}             {ethylbenzene}
STYRENOOH       =  8C + 10H +  3O      ; {@STYRENOOH}         {}
{8C (CHON)}
C8BCNO3         =  8C + 11H +  3O +  N ; {@C8BCNO3}           {MCM}
C721PAN         =  8C + 11H +  7O +  N ; {@C721PAN}           {MCM}
C89NO3          =  8C + 13H +  4O +  N ; {@C89NO3}            {MCM}
C810NO3         =  8C + 14H +  5O +  N ; {@C810NO3}           {MCM}
{C8 (CHON) aromatics}
NSTYRENO2       =  8C +  8H +  5O +  N ; {@NSTYRENO2}         {}
NSTYRENOOH      =  8C +  9H +  5O +  N ; {@NSTYRENOOH}        {}
{9C (CHO)}
C85CO3          =  9C + 11H +  4O      ; {@C85CO3}            {MCM}
NOPINDCO        =  9C + 12H +  2O      ; {@NOPINDCO}          {MCM}
C85CO3H         =  9C + 12H +  4O      ; {@C85CO3H}           {MCM}
NOPINDO2        =  9C + 13H +  3O      ; {@NOPINDO2}          {MCM}
C89CO3          =  9C + 13H +  4O      ; {@C89CO3}            {MCM}
C811CO3         =  9C + 13H +  5O      ; {@C811CO3}           {MCM}
NOPINONE        =  9C + 14H +   O      ; {@NOPINONE}          {MCM: nopinone}
NOPINOO         =  9C + 14H +  2O      ; {@NOPINOO}           {MCM}
NORPINAL        =  9C + 14H +  2O      ; {@NORPINAL}          {MCM: norpinaldehyde}
NORPINENOL      =  9C + 14H +  2O      ; {@NORPINENOL}        {norpinenol}
C89CO2H         =  9C + 14H +  3O      ; {@C89CO2H}           {MCM}
NOPINDOOH       =  9C + 14H +  3O      ; {@NOPINDOOH}         {MCM}
RO6R3P          =  9C + 14H +  3O      ; {@RO6R3P}            {from ref3019}
C89CO3H         =  9C + 14H +  4O      ; {@C89CO3H}           {MCM}
PINIC           =  9C + 14H +  4O      ; {@PINIC}             {MCM: pinic acid}
C811CO3H        =  9C + 14H +  5O      ; {@C811CO3H}          {MCM}
C96O2           =  9C + 15H +  3O      ; {@C96O2}             {MCM}
C97O2           =  9C + 15H +  4O      ; {@C97O2}             {MCM}
C98O2           =  9C + 15H +  5O      ; {@C98O2}             {MCM}
C96OOH          =  9C + 16H +  3O      ; {@C96OOH}            {MCM}
C97OOH          =  9C + 16H +  4O      ; {@C97OOH}            {MCM}
C98OOH          =  9C + 16H +  5O      ; {@C98OOH}            {MCM}
{9C (CHON)}
C89PAN          =  9C + 13H +  5O +  N ; {@C89PAN}            {MCM}
C9PAN2          =  9C + 13H +  6O +  N ; {@C9PAN2}            {MCM}
C811PAN         =  9C + 13H +  7O +  N ; {@C811PAN}           {MCM}
C96NO3          =  9C + 15H +  4O +  N ; {@C96NO3}            {MCM}
C98NO3          =  9C + 15H +  6O +  N ; {@C98NO3}            {MCM}
{C9 aromatics (lumped)}
LTMB            =  9C + 12H            ; {@LTMB}              {trimethylbenzenes}
{10C (CHO)}
C109CO          = 10C + 10H +  3O      ; {@C109CO}            {MCM}
PINALO2         = 10C + 13H +  4O      ; {@PINALO2}           {MCM}
PINALOOH        = 10C + 14H +  4O      ; {@PINALOOH}          {MCM}
C109O2          = 10C + 15H +  4O      ; {@C109O2}            {MCM}
C96CO3          = 10C + 15H +  4O      ; {@C96CO3}            {MCM}
C106O2          = 10C + 15H +  5O      ; {@C106O2}            {MCM}
APINENE         = 10C + 16H            ; {@APINENE}           {MCM: alpha pinene}
BPINENE         = 10C + 16H            ; {@BPINENE}           {MCM: beta pinene}
BMYRCENE        = 10C + 16H            ; {@BMYRCENE}           
BOCIMENE        = 10C + 16H            ; {@BOCIMENE}           
LIMONENE        = 10C + 16H            ; {@LIMONENE}           
OMTP            = 10C + 16H            ; {@OMTP}           
CARENE          = 10C + 16H            ; {@CARENE}            {carene}
SABINENE        = 10C + 16H            ; {@SABINENE}          {sabinene}
CAMPHENE        = 10C + 16H            ; {@CAMPHENE}          {camphene}
PINAL           = 10C + 16H +  2O      ; {@PINAL}             {MCM: pinonaldehyde}
PINENOL         = 10C + 16H +  2O      ; {@PINEOL}            {pinenol}
APINAOO         = 10C + 16H +  3O      ; {@APINAOO}           {stabilized APINOOA, not in MCM}
APINBOO         = 10C + 16H +  3O      ; {@APINBOO}           {MCM}
MENTHEN6ONE     = 10C + 16H +  3O      ; {@MENTHEN6ONE}       {8-OOH-menthen-6-one, Taraborrelli, pers. comm., not from MCM}
PINONIC         = 10C + 16H +  3O      ; {@PINONIC}           {MCM: pinonic acid}
C109OOH         = 10C + 16H +  4O      ; {@C109OOH}           {MCM}
PERPINONIC      = 10C + 16H +  4O      ; {@PERPINONIC}        {MCM}
C106OOH         = 10C + 16H +  5O      ; {@C106OOH}           {MCM}
BPINAO2         = 10C + 17H +  3O      ; {@BPINAO2}           {MCM}
OH2MENTHEN6ONE  = 10C + 17H +  4O      ; {@2OHMENTHEN6ONE}    {2-OH-8-OOH-menthen-6-one, Taraborrelli, pers. comm., not from MCM}
RO6R1O2         = 10C + 17H +  4O      ; {@RO6R1O2}           {cyclo-oxy peroxy radical from BPINENE, ref3019}
ROO6R1O2        = 10C + 17H +  5O      ; {@ROO6R1O2}          {cyclo-peroxy peroxy radical from BPINENE, ref3019}
RO6R3O2         = 10C + 17H +  5O      ; {@RO6R3O2}           {cyclo-oxy peroxy radical from BPINENE, ref3019}
OHMENTHEN6ONEO2 = 10C + 17H +  5O      ; {@OHMENTHEN6ONEO2}   {2-OH-8-OOH_menthen-6-peroxy radical, Taraborrelli, pers. comm., not from MCM}
BPINAOOH        = 10C + 18H +  3O      ; {@BPINAOOH}          {MCM}
RO6R3OOH        = 10C + 18H +  5O      ; {@RO6R3OOH}          {cyclo-oxy hydroperoxide from BPINENE, ref3019}
{10C (CHON)}
PINALNO3        = 10C + 13H +  5O +  N ; {@PINALNO3}          {MCM}
C10PAN2         = 10C + 15H +  6O +  N ; {@C10PAN2}           {MCM}
C106NO3         = 10C + 15H +  6O +  N ; {@C106NO3}           {MCM}
BPINANO3        = 10C + 17H +  4O +  N ; {@BPINANO3}          {MCM}
RO6R1NO3        = 10C + 17H +  5O +  N ; {@RO6R1NO3}          {nitrate from cyclo-oxy peroxy radical from BPINENE, ref3019}
RO6R3NO3        = 10C + 17H +  6O +  N ; {@RO6R3NO3}          {nitrate from cyclo-oxy peroxy radical from BPINENE, ref3019}
ROO6R1NO3       = 10C + 17H +  6O +  N ; {@ROO6R1NO3}         {nitrate from cyclo-peroxy peroxy radical from BPINENE, ref3019}
{10C (lumped)}
LAPINABO2       = 10C + 17H +  3O      ; {@LAPINABO2}         {APINAO2 and APINBO2 lumped (ratio 1:2)}
LAPINABOOH      = 10C + 18H +  3O      ; {@LAPINABOOH}        {APINAOOH and APINBOOH lumped (ratio 1:2)}
LNAPINABO2      = 10C + 16H +  5O +  N ; {@LNAPINABO2}        {.65 NAPINAO2 + .35 NAPINBO2}
LNBPINABO2      = 10C + 16H +  5O +  N ; {@LNBPINABO2}        {.8 NBPINAO2 + .2 NBPINBO2}
LAPINABNO3      = 10C + 17H +  4O +  N ; {@LAPINABNO3}        {APINANO3 and APINBNO3 lumped (ratio 1:2)}
LNAPINABOOH     = 10C + 17H +  5O +  N ; {@LNAPINABOOH}       {.65 NAPINAOOH + .35 NAPINBOOH}
LNBPINABOOH     = 10C + 17H +  5O +  N ; {@LNBPINABOOH}       {.8 NBPINAO2 + .2 NBPINBO2}
{C10 aromatics (lumped)}
LHAROM          = 11C + 14H            ; {@LHAROM}            {higher aromatics: model compound DIET35TOL(from MCM)}
{------------------------------------- F ------------------------------------}
LFLUORINE       = F                    ; {@LFLUORINE}         {lumped F species}
{------------------------------------- Cl -----------------------------------}

Cl              = Cl                   ; {@Cl}                {chlorine atom}
Cl2             = 2Cl                  ; {@Cl_2}              {chlorine}
ClO             = Cl + O               ; {@ClO}               {chlorine oxide}
HCl             = H + Cl               ; {@HCl}               {hydrochloric acid}
HOCl            = H + O + Cl           ; {@HOCl}              {hypochlorous acid}
Cl2O2           = 2Cl + 2O             ; {@Cl_2O_2}           {dichlorine dioxide}
OClO            = Cl + 2O              ; {@OClO}              {chlorine dioxide}
ClNO2           = Cl + 2O + N          ; {@ClNO_2}            {nitryl chloride}
ClNO3           = Cl + N + 3O          ; {@ClNO_3}            {chlorine nitrate}
CCl4            = C + 4Cl              ; {@CCl_4}             {tetrachloro methane}
CH3Cl           = C + 3H + Cl          ; {@CH_3Cl}            {chloromethane}
CH3CCl3         = 2C + 3H + 3Cl        ; {@CH_3CCl_3}         {1,1,1-trichloroethane = methyl chloroform = MCF}
CF2Cl2          = C + 2F + 2Cl         ; {@CF_2Cl_2}          {dichlorodifluoromethane = F12}
CFCl3           = C + F + 3Cl          ; {@CFCl_3}            {trichlorofluoromethane = F11}
LCHLORINE       = Cl                   ; {@LCHLORINE}         {lumped Cl species}

{------------------------------------- Br -----------------------------------}

Br              = Br                   ; {@Br}                {bromine atom}
Br2             = 2Br                  ; {@Br_2}              {bromine}
BrO             = Br + O               ; {@BrO}               {bromine oxide}
HBr             = H + Br               ; {@HBr}               {hydrobromic acid}
HOBr            = H + O + Br           ; {@HOBr}              {hypobromous acid}
BrNO2           = Br + N + 2O          ; {@BrNO_2}            {nitryl bromide}
BrNO3           = Br + N + 3O          ; {@BrNO_3}            {bromine nitrate}
BrCl            = Br + Cl              ; {@BrCl}              {bromine chloride}
CH3Br           = Br + C +3H           ; {@CH_3Br}            {bromomethane}
CF3Br           = Br + 3F + C          ; {@CF_3Br}            {Halon 1301}
CF2ClBr         = Br + 2F + Cl + C     ; {@CF_2ClBr}          {Halon 1211}
CHCl2Br         = C + H + 2Cl + Br     ; {@CHCl_2Br}          {}
CHClBr2         = C + H + Cl + 2Br     ; {@CHClBr_2}          {}
CH2ClBr         = C + 2H + Cl + Br     ; {@CH_2ClBr}          {}
CH2Br2          = C + 2H + 2Br         ; {@CH_2Br_2}          {}
CHBr3           = C + H + 3Br          ; {@CHBr_3}            {}
LBROMINE        = Br                   ; {@LBROMINE}          {lumped Br species}

{------------------------------------- I ------------------------------------}

I               = I                    ; {@I}                 {iodine atomic ground state}
I2              = 2I                   ; {@I_2}               {molecular iodine}
IO              = I + O                ; {@IO}                {iodine monoxide radical}
OIO             = I + 2O               ; {@OIO}               {}
I2O2            = 2O + 2I              ; {@I_2O_2}            {}
HI              = H + I                ; {@HI}                {hydrogen iodide}
HOI             = H + O + I            ; {@HOI}               {hypoiodous acid}
HIO3            = H + I + 3O           ; {@HIO_3}             {}
INO2            = I + N + 2O           ; {@INO_2}             {iodine nitrite}
INO3            = I + N + 3O           ; {@INO_3}             {iodine nitrate}
CH3I            = C + 3H + I           ; {@CH_3I}             {iodomethane}
CH2I2           = C + 2H + 2I          ; {@CH_2I_2}           {diiodomethane}
C3H7I           = 3C + 7H + I          ; {@CH_3CHICH_3}       {2-iodopropane}
ICl             = I + Cl               ; {@ICl}               {iodine chloride}
CH2ClI          = C + 2H + Cl + I      ; {@CH_2ClI}           {chloroiodomethane}
IBr             = I + Br               ; {@IBr}               {iodine bromide}
IPART           = 2I                   ; {@I(part)}           {iodine particles}

{------------------------------------- S ------------------------------------}

S               = S                    ; {@S}                 {sulfur atomic ground state}
SO              = S + O                ; {@SO}                {sulfur monoxide}
SO2             = S + 2O               ; {@SO_2}              {sulfur dioxide}
SO3             = S + 3O               ; {@SO_3}              {sulfur trioxide}
SH              = S + H                ; {@SH}                {}
H2SO4           = 2H + S + 4O          ; {@H_2SO_4}           {sulfuric acid}
CH3SO3H         = C + 4H + S + 3O      ; {@CH_3SO_3H}         {MSA: methane sulfonic acid}
DMS             = 2C + 6H + S          ; {@DMS}               {dimethyl sulfide}
DMSO            = 2C + 6H + S + O      ; {@DMSO}              {dimethyl sulfoxide: CH3SOCH3}
CH3SO2          = C + 3H + S + 2O      ; {@CH_3SO_2}          {}
CH3SO3          = C + 3H + S + 3O      ; {@CH_3SO_3}          {}
OCS             = C + S + O            ; {@OCS}               {}
LSULFUR         = S                    ; {@LSULFUR}           {lumped S species}

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

{--- mz_pj_20070209+}
{------------------------- Pseudo Aerosol -----------------------------------}
NO3m_cs         = N + 3O               ; {@NO_3^-\aq}         {}
Hp_cs           = H                    ; {@H^+\aq}            {}
RGM_cs          = Hg                   ; {@Hg\aq}             {from reactive gaseous Hg}
{--- mz_pj_20070209-}

{------------------------------- Dummies ------------------------------------}

Dummy           = IGNORE               ; {@Dummy}             {just a dummy}

{ mz_pj_20070621+}
{------------------------- O3 Budget Tracers (via eval2.3.rpl) --------------}
O3s             = 3O                   ; {@O_3(s)}            {strat. ozone}
LO3s            = IGNORE               ; {@LO_3(s)}           {lost strat. ozone}
{ mz_pj_20070621-}

{ mz_rs_20100227+}
{only for MIM1, not used in MIM2:}
LHOC3H6O2       = 3C + 7H + 3O         ; {@CH_3CH(O_2)CH_2OH} {hydroxyperoxyradical from propene+OH}
LHOC3H6OOH      = 3C + 8H + 3O         ; {@CH_3CH(OOH)CH_2OH} {C3H6OHOOH = hydroxyhydroperoxides from C3H6}
ISO2            = 5C + 9H + 3O         ; {@ISO2}              {isoprene (hydroxy) peroxy radicals}
ISON            = 5C +           N     ; {@ISON}              {organic nitrates from ISO2 and C5H8+NO3}
ISOOH           = 5C + 10H + 3O        ; {@ISOOH}             {isoprene (hydro) peroxides}
MVKO2           = 4C + 7H + 4O         ; {@MVKO2}             {MVK/MACR peroxy radicals}
MVKOOH          = 4C + 8H + 4O         ; {@MVKOOH}            {MVK hydroperoxides}
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
