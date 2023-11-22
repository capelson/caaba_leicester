{-----------------------------------------------------------------------------}
{------------------------------ aerosol mode: ## -----------------------------}
{-----------------------------------------------------------------------------}

{------------------------------- neutral species -----------------------------}

{------------------------------------- O -------------------------------------}

O2_a##         = 2O                   ; {@O_2}          {oxygen}
O3_a##         = 3O                   ; {@O_3}          {ozone}
HO3_a##        =  H +  3O             ; {@HO_3}           {}
HO4_a##        =  H +  4O             ; {@HO_4}           {}

{------------------------------------- H -------------------------------------}

OH_a##         =  H +  O              ; {@OH}           {hydroxyl radical}
HO2_a##        =  H + 2O              ; {@HO_2}         {perhydroxyl radical}
H2O_a##        = 2H +  O              ; {@H_2O}         {water}
H2O2_a##       = 2H + 2O              ; {@H_2O_2}       {hydrogen peroxide}

{------------------------------------- N -------------------------------------}

NH3_a##        = 3H      +  N         ; {@NH_3}         {ammonia}
NO_a##         =       O +  N         ; {@NO}           {nitric oxide}
NO2_a##        =      2O +  N         ; {@NO_2}         {nitrogen dioxide}
NO3_a##        =      3O +  N         ; {@NO_3}         {nitrogen trioxide}
N2O5_a##       =      5O + 2N         ; {@N_2O_5}       {dinitrogen pentoxide}
HONO_a##       =  H + 2O +  N         ; {@HONO}         {nitrous acid}
HNO3_a##       =  H + 3O +  N         ; {@HNO_3}        {nitric acid}
HNO4_a##       =  H + 4O +  N         ; {@HNO_4}        {pernitric acid}

{------------------------------------- C -------------------------------------}

{1C}
CO_a##         =   C       +   O      ; {@CO}           {carbon monoxide}
CH3OH_a##      =   C +  4H +   O      ; {@CH_3OH}       {methanol}
HCOOH_a##      =   C +  2H +  2O      ; {@HCOOH}        {formic acid}
HCHO_a##       =   C +  2H +   O      ; {@HCHO}         {methanal (formaldehyde)}
CH3O2_a##      =   C +  3H +  2O      ; {@CH_3OO}       {methylperoxy radical}
CH3OOH_a##     =   C +  4H +  2O      ; {@CH_3OOH}      {MCM: methyl hydroperoxide}
CO2_a##        =   C       +  2O      ; {@CO_2}         {carbon dioxide}
HOCH2OH_a##    =   C +  4H +  2O      ; {@HOCH_2OH}     {methane diol}
HOCH2OOH_a##   =   C +  4H +  3O      ; {@HOCH_2OOH}    {hydroxy methyl hydroperoxide}
CH3ONO2_a##    =   C +  3H +  3O + N  ; {@CH_3ONO_2}    {methylnitrate}
CH3NO3_a##     =   C +  3H +  3O + N  ; {@CH_3ONO_2}    {methylnitrate}
CHOOOH_a##     =   C +  2H +  3O      ; {@CHOOOH}       {performic acid}
HOCH2O2_a##    =   C +  3H +  3O      ; {@HOCH_2O_2}    {}
CHOHOHO2_a##   =   C +  3H +  4O      ; {@HCOHOHO_2}    {}
HCO3_a##       =   C +   H +  3O      ; {@HCO_3}        {}

{2C}
CH3CO2H_a##       =  2C +  4H +  2O       ; {@CH_3COOH}           {acetic acid}
PAN_a##           =  2C +  3H +  5O +  N  ; {@PAN}                {peroxyacetylnitrate}
CH3CHO_a##        =  2C +  4H +   O       ; {@CH_3CHO}            {acetaldehyde}
MG2_a##           =  2C +  6H +  3O       ; {@MG2}                {methane diol dimer}
HMF_a##           =  2C +  4H +  3O       ; {@HMF}                {methane diol dimer ester}
C2H5OH_a##        =  2C +  6H +   O       ; {@CH_3CH_2OH}         {ethanol}
HOCH2CH2O2_a##    =  2C +  5H +  3O       ; {@CH_2OHCH_2OO}       {MCM}
HYETHO2H_a##      =  2C +  6H +  3O       ; {@HYETHO2H}           {MCM: HOCH2CH2OOH}
ETHGLY_a##        =  2C +  6H +  2O       ; {@ETHGLY}             {MCM: HOCH2CH2OH}
CH3CO3_a##        =  2C +  3H +  3O       ; {@CH_3COOO}           {MCM: acetyldioxidanyl}
CH3CHOHOH_a##     =  2C +  6H +  2O       ; {@CH_3CHOHOH}         {}
CH3COHOHO2_a##    =  2C +  5H +  4O       ; {@CH_3COHOHOO}        {}
CH3CHOHO2_a##     =  2C +  6H +  3O       ; {@CH3CHOHO2}          {}
HOCH2CHO_a##      =  2C +  4H +  2O       ; {@CH_2OHCHO}          {glycolaldehyde}
HOCH2CO3_a##      =  2C +  3H +  4O       ; {@CH_2OHCO3}          {MCM}
CHOHO2CHO_a##     =  2C +  3H +  4O       ; {@CHOHOOCHO}          {}
CHOHO2CHOHOH_a##  =  2C +  5H +  5O       ; {@CHOHOOCHOHOH}       {}
HOCH2COHOHO2_a##  =  2C +  5H +  5O       ; {@CH_2OHCOHOHO_2}     {}
HOCH2CHOHOH_a##   =  2C +  6H +  3O       ; {@CH_2OHCHOHOH}       {}
GLYOX_a##         =  2C +  2H +  2O       ; {@GLYOX}              {MCM: CHOCHO = glyoxal}
CHOCHOHOH_a##     =  2C +  4H +  3O       ; {@CHOCHOHOH}          {}
CHOHOHCHOHOH_a##  =  2C +  6H +  4O       ; {@CHOHOHCHOHOH}       {}
CHOCO3_a##        =  2C +   H +  4O       ; {@CHOCO_3}            {}
CHOCOHOHO2_a##    =  2C +  3H +  5O       ; {@CHOCOHOHO_2}        {}
CHOHOHCOHOHO2_a## =  2C +  5H +  6O       ; {@CHOHOHCOHOHO_2}     {}
CHOHOHCOOH_a##    =  2C +  4H +  4O       ; {@CHOOHOHCOOH}        {}
CH3CO3H_a##       =  2C +  4H +  3O       ; {@CH_3C(O)OOH}        {MCM: peroxy acetic acid}
HOCH2CO3H_a##     =  2C +  4H +  4O       ; {@HOCH_2CO_3H}        {MCM}
CH2OOCOOH_a##     =  2C +  3H +  4O       ; {@CH_2OOCOOH}         {}
C2H5OOH_a##       =  2C +  6H +  2O       ; {@C2H5OOH}            {ethyl hydroperoxide, in gas.spc: C2H5OOH}
C2H5O2_a##        =  2C +  5H +  2O       ; {@C2H5OO}             {ethylperoxyl radical}
HOOCH2CO2H_a##    =  2C +  4H +  4O       ; {@HOOCH2CO2H}         {}
HOCH2CO2H_a##     =  2C +  4H +  3O       ; {@HOCH_2CO_2H}        {glycolic acid}
CHOHOOCOOH_a##    =  2C +  3H +  5O       ; {@CHOHOOCOOH}         {}
HOOCCOOH_a##      =  2C +  2H +  4O       ; {@HOOCCOOH}           {oxalic acid}
CHOOHOOCOOH_a##   =  2C +  3H +  6O       ; {@CHOOHOOCOOH}        {}
HCOCO2H_a##       =  2C +  2H +  3O       ; {@CHOCOOH}            {MCM: glyoxylic acid}
COOHCO3_a##       =  2C +   H +  5O       ; {@COOHCO_3}           {}
COOHCOHOHO2_a##   =  2C +  3H +  6O       ; {@COOHCOHOHO_2}       {}
HOOCH2CHO_a##     =  2C +  4H +  3O       ; {@CH_2OOHCHO}         {}
HOOCH2CHOHOH_a##  =  2C +  6H +  4O       ; {@HOOCH_2CHOHOH}      {}
CH2CHOH_a##       =  2C +  4H +   O       ; {@CH_2CHOH}           {vinyl alcohol}
C2H5NO3_a##       =  2C +  5H +  3O +  N  ; {@C_2H_5ONO_2}        {MCM: ethyl nitrate}
CH3CN_a##         =  2C +  3H       +  N  ; {@CH_3CN}             {acetonitrile}

CH2CO_a##         =  2C +  2H +   O       ; {@CH2CO}              {ketene}
CH3CHOHOOH_a##    =  2C +  6H +  3O       ; {@CH3CHOHOOH}         {}
HCOCO3H_a##       =  2C +  2H +  4O       ; {@HCOCO_3H}           {MCM}
HOOCH2CO3H_a##    =  2C +  4H +  5O       ; {@HOOCH2CO3H}         {}
ETHOHNO3_a##      =  2C +  5H +  4O +  N  ; {@ETHOHNO3}           {MCM: HOCH2CH2ONO2}
PHAN_a##          =  2C +  3H +  6O +  N  ; {@PHAN}               {MCM: HOCH2C(O)OONO2}

{3C}
CH3COCH3_a##       =  3C +  6H +   O      ; {@CH_3COCH_3}         {acetone}
MG3_a##            =  3C +  8H +  4O      ; {@MG3}                {methane diol trimer}
HM2F_a##           =  3C +  6H +  4O      ; {@HM2F}               {methane diol trimer ester}
MGLYOX_a##         =  3C +  4H +  2O      ; {@CH_3C(O)CHO}        {methylglyoxal}
CH3COCHOHOH_a##    =  3C +  6H +  3O      ; {@CH_3COCHOHOH}       {hmglyox}
CH3COCO2H_a##      =  3C +  4H +  3O      ; {@CH_3COCOOH}         {pyruvic acid}
CH3COCH2O2_a##     =  3C +  5H +  3O      ; {@CH_3COCH_2O_2}      {peroxy radical from acetone}
ACETOL_a##         =  3C +  6H +  2O      ; {@CH_3COCH_2OH}       {hydroxy acetone}
CH3COCHOHO2_a##    =  3C +  5H +  4O      ; {@CH_3COCHOHO_2}      {}
IPROPOL_a##        =  3C +  8H +   O      ; {@IPROPOL}            {MCM: isopropanol}
HYPERACET_a##      =  3C +  6H +  3O      ; {@CH_3COCH_2O_2H}     {MCM: hydroperoxide from CH3COCH2O2}
IC3H7OOH_a##       =  3C +  8H +  2O      ; {@iC_3H_7OOH}         {isopropyl hydro peroxaide}
IC3H7O2_a##        =  3C +  7H +  2O      ; {@iC_3H_7O_2}         {isopropylperoxy radical}

ALCOCH2OOH_a##    =  3C +  4H +  4O       ; {@HCOCOCH_2OOH}       {MCM}
C33CO_a##         =  3C +  2H +  3O       ; {@HCOCOCHO}           {MCM}
CH3CHCO_a##       =  3C +  4H +   O       ; {@CH3CHCO}            {CH3CHCO}
CH3COCO3H_a##     =  3C +  4H +  4O       ; {@CH_3COCO_3H}        {MCM}
HCOCH2CHO_a##     =  3C +  4H +  3O       ; {@HCOCH2CHO}          {MCM}
HCOCH2CO2H_a##    =  3C +  4H +  4O       ; {@HCOCH2CO2H}         {MCM}
HCOCH2CO3H_a##    =  3C +  4H +  5O       ; {@HCOCH2CO3H}         {MCM}
HCOCOCH2OOH_a##   =  3C +  4H +  4O       ; {@HCOCOCH_2OOH}       {}
HOC2H4CO2H_a##    =  3C +  6H +  3O       ; {@HOC2H4CO2H}         {MCM: 3-hydroxypropanoic acid}
HOC2H4CO3H_a##    =  3C +  6H +  4O       ; {@HOC2H4CO3H}         {MCM}
HOCH2COCH2OOH_a## =  3C +  6H +  4O       ; {@HOCH2COCH2OOH}      {}
HOCH2COCHO_a##    =  3C +  4H +  3O       ; {@HOCH2COCHO}         {MCM: hydroxypyruvaldehyde}
HYPROPO2H_a##     =  3C +  8H +  3O       ; {@HYPROPO2H}          {MCM: CH3CH(OOH)CH2OH}
C32OH13CO_a##     =  3C +  4H +  3O       ; {@C32OH13CO}          {MCM: hydroxymalonaldehyde}
C3DIALOOH_a##     =  3C +  4H +  4O       ; {@C3DIALOOH}          {MCM}
HCOCOHCO3H_a##    =  3C +  4H +  5O       ; {@HCOCOHCO3H}         {MCM}
METACETHO_a##     =  3C +  4H +  3O       ; {@METACETHO}          {MCM: acetic formic anhydride}
C3PAN1_a##        =  3C +  5H +  6O +  N  ; {@C_3PAN1}            {MCM}
C3PAN2_a##        =  3C +  3H +  6O +  N  ; {@C_3PAN2}            {MCM}
CH3COCH2O2NO2_a## =  3C +  5H +  5O +  N  ; {@CH_3COCH_2OONO_2}   {CH3-C(O)-CH2-OONO2}
NOA_a##           =  3C +  5H +  4O +  N  ; {@NOA}                {MCM: CH3-CO-CH2ONO2 = nitro-oxy-acetone}
PR2O2HNO3_a##     =  3C +  7H +  5O +  N  ; {@PR2O2HNO3}          {MCM: CH3-CH(OOH)-CH2ONO2}
PROPOLNO3_a##     =  3C +  7H +  4O +  N  ; {@PROPOLNO3}          {MCM: HOCH2-CH(CH3)ONO2)}
HCOCOHPAN_a##     =  3C +  3H +  7O +  N  ; {@HCOCOHPAN}          {MCM}

{4C}
GOLIG1_a##         =  4C +  6H +  5O      ; {@GOLIG1}             {}
GOLIG2_a##         =  4C +  8H +  6O      ; {@GOLIG2}             {}
GOLIG3_a##         =  4C + 10H +  7O      ; {@GOLIG3}             {}
HGO1_a##           =  4C +  5H +  5O      ; {@GOLIGO1}            {}
HGO2_a##           =  4C +  7H +  6O      ; {@GOLIGO2}            {}
HGO3_a##           =  4C +  9H +  7O      ; {@GOLIGO3}            {}
MACR_a##           =  4C +  6H +   O      ; {@MACR}               {MCM: CH2=C(CH3)CHO = methacrolein}
CH2OHCO2CH3CHO_a## =  4C +  7H +  4O      ; {@CH_2OHCO_2CH_3CHO}  {from MACR_a## + OH}
MVK_a##            =  4C +  6H +   O      ; {@MVK}                {MCM: CH3-CO-CH=CH2 = methyl vinyl ketone}
CH3COCHO2CH2OH_a## =  4C +  7H +  4O      ; {@CH_3COCHO_2CH_2OH}  {from MVK_a## + OH}
CH3COCOCH2OH_a##   =  4C +  6H +  3O      ; {@CH_2COCOCH_2OH}     {from self reaction of CH3COCHO2CH2OH_a##}
CH2OHCHOHCOCH3_a## =  4C +  8H +  3O      ; {@CH_2OHCHOOHCOCH_3}  {from self reaction of CH3COCHO2CH2OH_a##}

BIACETO2_a##      =  4C +  5H +  4O       ; {@CH_3COCOCH_2O_2}    {MCM}
BIACETOH_a##      =  4C +  6H +  3O       ; {@BIACETOH}           {MCM: CH3-CO-CO-CH2OH}
BIACETOOH_a##     =  4C +  6H +  4O       ; {@CH_3COCOCH_2OOH}    {MCM}
BUT2OLO_a##       =  4C +  8H +  3O       ; {@BUT2OLO}            {MCM}
BUT2OLOOH_a##     =  4C + 10H +  3O       ; {@BUT2OLOOH}          {MCM}
C312COCO3H_a##    =  4C +  4H +  5O       ; {@C312COCO3H}         {MCM}
C413COOOH_a##     =  4C +  6H +  4O       ; {@C413COOOH}          {MCM}
C44OOH_a##        =  4C +  6H +  5O       ; {@C44OOH}             {MCM}
C4CODIAL_a##      =  4C +  4H +  3O       ; {@C4CODIAL}           {MCM}
CH3COCHCO_a##     =  4C +  4H +  2O       ; {@CH_3COCHCO}         {}
CH3COCOCO2H_a##   =  4C +  4H +  4O       ; {@CH3COCOCO2H}        {}
CH3COOHCHCHO_a##  =  4C +  6H +  3O       ; {@CH_3COOHCHCHO}      {}
CHOC3COO2_a##     =  4C +  5H +  4O       ; {@CHOC3COO2}          {MCM}
CO23C3CHO_a##     =  4C +  4H +  3O       ; {@CH_3COCOCHO}        {MCM}
CO2C3CHO_a##      =  4C +  6H +  2O       ; {@CO2C3CHO}           {MCM: CH3COCH2CHO}
CO2H3CHO_a##      =  4C +  5H +  3O       ; {@CO2H3CHO}           {MCM: CH3-CO-CH(OH)-CHO}
CO2H3CO2H_a##     =  4C +  6H +  5O       ; {@CO2H3CO2H}          {}
CO2H3CO3H_a##     =  4C +  6H +  5O       ; {@CO2H3CO3H}          {MCM: CH3-CO-CH(OH)-C(O)OOH}
HCOCCH3CHOOH_a##  =  4C +  6H +  3O       ; {@HCOCCH_3CHOOH}      {}
HCOCCH3CO_a##     =  4C +  4H +  2O       ; {@HCOCCH_3CO}         {}
HMAC_a##          =  4C +  6H +  2O       ; {@HMAC}               {MCM: HCOC(CH3)CHOH}
HO12CO3C4_a##     =  4C +  8H +  3O       ; {@HO12CO3C4}          {MCM: CH3-CO-CH(OH)-CH2OH}
HVMK_a##          =  4C +  6H +  2O       ; {@HVMK}               {MCM: CH3COCHCHOH = hydroxy vinyl methyl ketone}
IBUTALOH_a##      =  4C +  8H +  2O       ; {@IBUTALOH}           {MCM}
IBUTDIAL_a##      =  4C +  6H +  2O       ; {@IBUTDIAL}           {MCM: HCOC(CH3)CHO}
IBUTOLBOOH_a##    =  4C + 10H +  3O       ; {@IBUTOLBOOH}         {}
IPRHOCO2H_a##     =  4C +  8H +  3O       ; {@IPRHOCO2H}          {MCM}
IPRHOCO3H_a##     =  4C +  8H +  4O       ; {@IPRHOCO3H}          {MCM}
MACO2H_a##        =  4C +  6H +  2O       ; {@MACO2H}             {MCM: CH2=C(CH3)COOH = methacrylic acid}
MACO3H_a##        =  4C +  6H +  3O       ; {@MACO3H}             {MCM: CH2=C(CH3)C(O)OOH}
MACROH_a##        =  4C +  8H +  3O       ; {@MACROH}             {MCM: HOCH2C(OH)(CH3)CHO}
MACROOH_a##       =  4C +  8H +  4O       ; {@MACROOH}            {MCM: HOCH2C(OOH)(CH3)CHO}
BZFUCO_a##        =  4C +  4H +  4O       ; {@BZFUCO}             {MCM}
BZFUOOH_a##       =  4C +  6H +  5O       ; {@BZFUOOH}            {MCM}
CO14O3CHO_a##     =  4C +  4H +  4O       ; {@CO14O3CHO}          {MCM}
CO14O3CO2H_a##    =  4C +  4H +  5O       ; {@CO14O3CO2H}         {MCM}
CO2C4DIAL_a##     =  4C +  2H +  4O       ; {@CO2C4DIAL}          {MCM: 2,3-dioxosuccinaldehyde}
EPXC4DIAL_a##     =  4C +  4H +  3O       ; {@EPXC4DIAL}          {MCM}
EPXDLCO2H_a##     =  4C +  4H +  4O       ; {@EPXDLCO2H}          {MCM}
EPXDLCO3H_a##     =  4C +  4H +  5O       ; {@EPXDLCO3H}          {MCM}
HOCOC4DIAL_a##    =  4C +  4H +  4O       ; {@HOCOC4DIAL}         {MCM: 2-hydroxy-3-oxosuccinaldehyde}
MALANHYOOH_a##    =  4C +  4H +  6O       ; {@MALANHYOOH}         {MCM}
MALDALCO2H_a##    =  4C +  4H +  3O       ; {@MALDALCO2H}         {MCM: 4-oxo-2-butenoic acid}
MALDALCO3H_a##    =  4C +  4H +  4O       ; {@MALDALCO3H}         {MCM}
MALDIAL_a##       =  4C +  4H +  2O       ; {@MALDIAL}            {MCM: 2-butenedial}
MALDIALOOH_a##    =  4C +  6H +  5O       ; {@MALDIALOOH}         {MCM}
MALNHYOHCO_a##    =  4C +  2H +  5O       ; {@MALNHYOHCO}         {MCM}
MECOACEOOH_a##    =  4C +  6H +  5O       ; {@MECOACEOOH}         {MCM}
C312COPAN_a##     =  4C +  3H +  7O +  N  ; {@C312COPAN}          {MCM}
C4PAN5_a##        =  4C +  7H +  6O +  N  ; {@C4PAN5}             {MCM}
MVKNO3_a##        =  4C +  7H +  5O +  N  ; {@MVKNO3}             {MCM}
NBZFUOOH_a##      =  4C +  5H +  7O +  N  ; {@NBZFUOOH}           {MCM}
NC4DCO2H_a##      =  4C +  3H +  5O +  N  ; {@NC4DCO2H}           {MCM}
LBUT1ENOOH_a##    =  4C + 10H +  3O       ; {@LBUT1ENOOH}         {HO3C4OOH + NBUTOLAOOH}
LHMVKABOOH_a##    =  4C +  8H +  4O       ; {@LHMVKABOOH}         {HOCH2-CH(OOH)-CO-CH3 + CH2(OOH)-CH(OH)-CO-CH3}
LMEKOOH_a##       =  4C +  8H +  3O       ; {@LMEKOOH}            {CH3-CO-CH2-CH2-OOH + CH3-CO-CH(OOH)-CH3}

{5C}
C5H8_a##           =  5C +  8H            ; {@C5H8}               {MCM: isoprene}

C1ODC2O2C4OOH_a##  =  5C +  9H +  5O      ; {@C1ODC2O2C4OOH}      {}
C1ODC2OOHC4OD_a##  =  5C +  8H +  4O      ; {@C1ODC2OOHC4OD}      {}
C1ODC3O2C4OOH_a##  =  5C +  9H +  5O      ; {@C1ODC3O2C4OOH}      {}
C1OOHC2OOHC4OD_a## =  5C + 10H +  5O      ; {@C1OOHC2OOHC4OD}     {}
C4MDIAL_a##        =  5C +  6H +  2O      ; {@C4MDIAL}            {MCM: 2-methyl-butenedial}
C511OOH_a##        =  5C +  8H +  4O      ; {@C511OOH}            {MCM}
C512OOH_a##        =  5C +  8H +  4O      ; {@C512OOH}            {MCM}
C513CO_a##         =  5C +  6H +  4O      ; {@C513CO}             {MCM}
C513OOH_a##        =  5C +  8H +  5O      ; {@C513OOH}            {MCM}
C514OOH_a##        =  5C +  8H +  4O      ; {@C514OOH}            {MCM}
C59OOH_a##         =  5C + 10H +  5O      ; {@C59OOH}             {MCM: HOCH2-CO-C(CH3)(OOH)-CH2OH}
CHOC3COOOH_a##     =  5C +  6H +  4O      ; {@CHOC3COOOH}         {MCM}
CO13C4CHO_a##      =  5C +  6H +  3O      ; {@CO13C4CHO}          {MCM}
CO23C4CHO_a##      =  5C +  6H +  3O      ; {@CO23C4CHO}          {MCM}
CO23C4CO3H_a##     =  5C +  6H +  5O      ; {@CO23C4CO3H}         {MCM}
DB1OOH_a##         =  5C + 10H +  4O      ; {@DB1OOH}             {}
DB2OOH_a##         =  5C + 10H +  5O      ; {@DB2OOH}             {}
ISOPAOH_a##        =  5C + 10H +  2O      ; {@ISOPAOH}            {MCM: HOCH2-C(CH3)=CH-CH2OH}
ISOPBOH_a##        =  5C + 10H +  2O      ; {@ISOPBOH}            {MCM: HOCH2-C(CH3)(OH)-CH=CH2}
ISOPBOOH_a##       =  5C + 10H +  3O      ; {@ISOPBOOH}           {MCM: HOCH2-C(CH3)(OOH)-CH=CH2}
ISOPDOH_a##        =  5C + 10H +  2O      ; {@ISOPDOH}            {MCM: CH2=C(CH3)CH(OH)-CH2OH}
ISOPDOOH_a##       =  5C + 10H +  3O      ; {@ISOPDOOH}           {MCM: CH2=C(CH3)CH(OOH)-CH2OH}
MBO_a##            =  5C + 10H +   O      ; {@MBO}                {MCM: 2-methyl-3-buten-2-ol}
MBOACO_a##         =  5C + 10H +  3O      ; {@MBOACO}             {MCM}
MBOCOCO_a##        =  5C +  8H +  3O      ; {@MBOCOCO}            {MCM}
ME3FURAN_a##       =  5C +  6H +   O      ; {@3METHYLFURAN}       {3-methyl-furan}
ACCOMECHO_a##      =  5C +  6H +  4O      ; {@ACCOMECHO}          {MCM}
ACCOMECO3H_a##     =  5C +  6H +  6O      ; {@ACCOMECO3H}         {MCM}
C24O3CCO2H_a##     =  5C +  6H +  5O      ; {@C24O3CCO2H}         {MCM}
C4CO2DBCO3_a##     =  5C +  3H +  5O      ; {@C4CO2DBCO3}         {MCM}
C4CO2DCO3H_a##     =  5C +  4H +  5O      ; {@C4CO2DCO3H}         {MCM}
C5134CO2OH_a##     =  5C +  6H +  4O      ; {@C5134CO2OH}         {MCM: 2-hydroxy-3,4-dioxopentanal}
C54CO_a##          =  5C +  4H +  4O      ; {@C54CO}              {MCM: 2,3,4-trioxopentanal}
C5CO14OH_a##       =  5C +  6H +  3O      ; {@C5CO14OH}           {MCM: 4-oxo-2-pentenoic acid}
C5CO14OOH_a##      =  5C +  6H +  4O      ; {@C5CO14OOH}          {MCM}
C5DIALCO_a##       =  5C +  4H +  3O      ; {@C5DIALCO}           {MCM}
C5DIALOOH_a##      =  5C +  6H +  4O      ; {@C5DIALOOH}          {MCM}
C5DICARB_a##       =  5C +  6H +  2O      ; {@C5DICARB}           {MCM: 4-oxo-2-pentenal}
C5DICAROOH_a##     =  5C +  8H +  5O      ; {@C5DICAROOH}         {MCM}
MC3ODBCO2H_a##     =  5C +  6H +  3O      ; {@MC3ODBCO2H}         {MCM}
MMALNHYOOH_a##     =  5C +  6H +  6O      ; {@MMALNHYOOH}         {MCM}
TLFUOOH_a##        =  5C +  8H +  5O      ; {@TLFUOOH}            {MCM}
C4MCONO3OH_a##     =  5C +  9H +  5O +  N ; {@C4MCONO3OH}         {MCM}
C514NO3_a##        =  5C +  7H +  5O +  N ; {@C514NO3}            {MCM}
C5PAN9_a##         =  5C +  5H +  7O +  N ; {@C5PAN9}             {MCM}
CHOC3COPAN_a##     =  5C +  5H +  5O +  N ; {@CHOC3COPAN}         {MCM}
DB1NO3_a##         =  5C +  9H +  6O +  N ; {@DB1NO3}             {}
ISOPBNO3_a##       =  5C +  9H +  4O +  N ; {@ISOPBNO3}           {MCM: HOCH2-C(CH3)(ONO2)-CH=CH2}
ISOPDNO3_a##       =  5C +  9H +  4O +  N ; {@ISOPDNO3}           {MCM: CH2=C(CH3)CH(ONO2)-CH2OH}
NC4OHCO3H_a##      =  5C +  9H +  6O +  N ; {@NC4OHCO3H}          {MCM}
NC4OHCPAN_a##      =  5C +  8H +  8O + 2N ; {@NC4OHCPAN}          {MCM}
NISOPOOH_a##       =  5C +  9H +  5O +  N ; {@NISOPOOH}           {MCM: O2NOCH2-C(CH3)=CH-CH2OOH}
NMBOBCO_a##        =  5C +  9H +  5O +  N ; {@NMBOBCO}            {MCM}
C4CO2DBPAN_a##     =  5C +  3H +  7O +  N ; {@C4CO2DBPAN}         {MCM}
NC4MDCO2H_a##      =  5C +  5H +  5O +  N ; {@NC4MDCO2H N}        {MCM}
NTLFUOOH_a##       =  5C +  7H +  6O +  N ; {@NTLFUOOH}           {MCM}
LC578OOH_a##       =  5C + 10H +  5O      ; {@LC578OOH}           {HOCH2-CH(OH)C(CH3)(OOH)-CHO + HOCH2-C(CH3)(OOH)-CH(OH)-CHO}
LHC4ACCHO_a##      =  5C +  8H +  2O      ; {@LHC4ACCHO}          {HOCH2-C(CH3)=CH-CHO + HOCH2-CH=C(CH3)-CHO}
LHC4ACCO2H_a##     =  5C +  8H +  3O      ; {@LHC4ACCO2H}         {HOCH2-C(CH3)=CH-C(O)OH + HOCH2-CH=C(CH3)-C(O)OH}
LHC4ACCO3H_a##     =  5C +  8H +  4O      ; {@LHC4ACCO3H}         {HOCH2-C(CH3)=CH-C(O)OOH + HOCH2-CH=C(CH3)-C(O)OOH}
LIEPOX_a##         =  5C + 10H +  3O      ; {@LIEPOX}             {epoxydiol}
LISOPACOOH_a##     =  5C + 10H +  3O      ; {@LISOPACOOH}         {HOCH2-C(CH3)=CH-CH2OOH + HOCH2-CH=C(CH3)-CH2OOH}
LMBOABOOH_a##      =  5C + 12H +  4O      ; {@LMBOABOOH}          {}
LZCO3HC23DBCOD_a## =  5C +  6H +  4O      ; {@LZCO3HC23DBCOD}     {C5PACALD1 + C5PACALD2}
LC5PAN1719_a##     =  5C +  7H +  6O +  N ; {@LC5PAN1719}         {HOCH2-C(CH3)=CH-C(O)OONO2 + HOCH2-CH=C(CH3)C(O)OONO2}
LISOPACNO3_a##     =  5C +  9H +  4O +  N ; {@LISOPACNO3}         {HOCH2-C(CH3)=CH-CH2ONO2 + HOCH2-CH=C(CH3)-CH2ONO2}
LMBOABNO3_a##      =  5C + 11H +  5O +  N ; {@LMBOABNO3}          {}
LNMBOABOOH_a##     =  5C + 10H +  6O +  N ; {@LNMBOABOOH}         {}

{6C}
MGLYOXDA_a##       =  6C + 10H +  5O      ; {@CH_3COCHOHOCHOHCOCH_3}   {Dimer of MGLYOX and diol}
MGLYOXDB_a##       =  6C + 12H +  6O      ; {@CH_3COCHOHOCOHC_3CHOHOH} {Dimer of self reaction MGLYOX diol}
MGLYFA_a##         =  6C +  8H +  5O      ; {@CH_3COCOHOCOHCOCH_3}     {from MGLYOXDA + OH}
MGLYFB_a##         =  6C + 10H +  6O      ; {@CH_3COCOHOCOHC_3COHOH}   {form MGLYOXDB + OH}

C614CO_a##         =  6C +  8H +  4O      ; {@C614CO}             {MCM}
C614OOH_a##        =  6C + 10H +  5O      ; {@C614OOH}            {MCM}
CO235C5CHO_a##     =  6C +  6H +  4O      ; {@CO235C5CHO}         {MCM}
CO235C6OOH_a##     =  6C +  8H +  5O      ; {@CO235C6OOH}         {MCM}
BZBIPEROOH_a##     =  6C +  8H +  5O      ; {@BZBIPEROOH}         {MCM}
BZEMUCCO_a##       =  6C +  6H +  5O      ; {@BZEMUCCO}           {MCM}
BZEMUCCO2H_a##     =  6C +  6H +  4O      ; {@BZEMUCCO2H}         {MCM}
BZEMUCCO3H_a##     =  6C +  6H +  5O      ; {@BZEMUCCO3H}         {MCM}
BZEMUCOOH_a##      =  6C +  8H +  6O      ; {@BZEMUCOOH}          {MCM}
BZEPOXMUC_a##      =  6C +  6H +  3O      ; {@BZEPOXMUC}          {MCM}
BZOBIPEROH_a##     =  6C +  6H +  4O      ; {@BZOBIPEROH}         {MCM}
C5CO2DCO3H_a##     =  6C +  6H +  5O      ; {@C5CO2DCO3H}         {MCM}
C5COOHCO3H_a##     =  6C +  6H +  6O      ; {@C5COOHCO3H}         {MCM}
C6125CO_a##        =  6C +  6H +  3O      ; {@C6125CO}            {MCM: 2,5-dioxo-3-hexenal}
C615CO2OOH_a##     =  6C +  8H +  4O      ; {@C615CO2OOH}         {MCM}
C6CO4DB_a##        =  6C +  4H +  4O      ; {@C6CO4DB}            {MCM}
C6H5O_a##          =  6C +  5H +   O      ; {@C6H5O}              {MCM: phenyloxidanyl}
C6H5OOH_a##        =  6C +  6H +  2O      ; {@C6H5OOH}            {MCM: phenyl hydroperoxide}
CATEC1O_a##        =  6C +  5H +  2O      ; {@CATEC1O}            {MCM: 2-λ1-oxidanylphenol}
CATEC1OOH_a##      =  6C +  6H +  3O      ; {@CATEC1OOH}          {MCM}
CATECHOL_a##       =  6C +  4H +  2O      ; {@CATECHOL}           {MCM: 1,2-dihydroxybenzene}
PBZQCO_a##         =  6C +  4H +  4O      ; {@PBZQCO}             {MCM}
PBZQOOH_a##        =  6C +  6H +  5O      ; {@PBZQOOH}            {MCM}
PHENOL_a##         =  6C +  6H +   O      ; {@PHENOL}             {MCM}
PHENOOH_a##        =  6C +  8H +  6O      ; {@PHENOOH}            {MCM}
HOC6H4NO2_a##      =  6C +  5H +  3O +  N ; {@HOC6H4NO2}          {MCM: 2-nitrophenol}
C614NO3_a##        =  6C +  9H +  6O +  N ; {@C614NO3}            {MCM}
BZBIPERNO3_a##     =  6C +  7H +  6O +  N ; {@BZBIPERNO3}         {MCM}
BZEMUCNO3_a##      =  6C +  7H +  7O +  N ; {@BZEMUCNO3}          {MCM}
C5CO2DBPAN_a##     =  6C +  5H +  7O +  N ; {@C5CO2DBPAN}         {MCM}
C5CO2OHPAN_a##     =  6C +  5H +  8O +  N ; {@C5CO2OHPAN}         {MCM}
DNPHEN_a##         =  6C +  4H +  5O + 2N ; {@DNPHEN}             {MCM: 2,4-dinitrophenol}
DNPHENOOH_a##      =  6C +  6H + 10O + 2N ; {@DNPHENOOH}          {MCM}
NBZQOOH_a##        =  6C +  5H +  7O +  N ; {@NBZQOOH}            {MCM}
NCATECHOL_a##      =  6C +  5H +  4O +  N ; {@NCATECHOL}          {MCM}
NCATECOOH_a##      =  6C +  7H +  9O +  N ; {@NCATECOOH}          {MCM}
NDNPHENOOH_a##     =  6C +  5H + 12O + 3N ; {@NDNPHENOOH}         {MCM}
NNCATECOOH_a##     =  6C +  6H + 11O + 2N ; {@NNCATECOOH}         {MCM}
NPHENOOH_a##       =  6C +  7H +  8O +  N ; {@NPHENOOH}           {MCM}

{7C}
C235C6CO3H_a##     =  7C +  8H +  6O      ; {@C235C6CO3H}         {MCM}
C716OOH_a##        =  7C + 10H +  5O      ; {@C716OOH}            {MCM}
C721OOH_a##        =  7C + 12H +  4O      ; {@C721OOH}            {MCM}
C722OOH_a##        =  7C + 12H +  5O      ; {@C722OOH}            {MCM}
CO235C6CHO_a##     =  7C +  8H +  4O      ; {@CO235C6CHO}         {MCM}
C6COOHCO3H_a##     =  7C +  8H +  6O      ; {@C6COOHCO3H}         {MCM}
C6H5CH2OOH_a##     =  7C +  8H +  2O      ; {@C6H5CH2OOH}         {MCM: benzyl hydroperoxide}
C6H5CO3H_a##       =  7C +  6H +  3O      ; {@C6H5CO3H}           {MCM: perbenzoic acid}
C7CO4DB_a##        =  7C +  6H +  4O      ; {@C7CO4DB}            {MCM}
CRESOL_a##         =  7C +  8H +   O      ; {@CRESOL}             {MCM: 2-methylphenol}
CRESOOH_a##        =  7C + 10H +  6O      ; {@CRESOOH}            {MCM}
MCATEC1O_a##       =  7C +  7H +  2O      ; {@MCATEC1O}           {MCM}
MCATEC1OOH_a##     =  7C +  8H +  3O      ; {@MCATEC1OOH}         {MCM}
MCATECHOL_a##      =  7C +  8H +  2O      ; {@MCATECHOL}          {MCM: 3-methylcatechol}
OXYL1OOH_a##       =  7C +  8H +  2O      ; {@OXYL1OOH}           {MCM}
PHCOOH_a##         =  7C +  6H +  2O      ; {@PHCOOH}             {MCM: benzoic acid}
TLBIPEROOH_a##     =  7C + 10H +  5O      ; {@TLBIPEROOH}         {MCM}
TLEMUCCO_a##       =  7C +  8H +  5O      ; {@TLEMUCCO}           {MCM}
TLEMUCCO2H_a##     =  7C +  8H +  4O      ; {@TLEMUCCO2H}         {MCM}
TLEMUCCO3H_a##     =  7C +  8H +  5O      ; {@TLEMUCCO3H}         {MCM}
TLEMUCOOH_a##      =  7C + 10H +  6O      ; {@TLEMUCOOH}          {MCM}
TLOBIPEROH_a##     =  7C +  8H +  4O      ; {@TLOBIPEROH}         {MCM}
TOL1O_a##          =  7C +  7H +   O      ; {@TOL1O}              {MCM: (2-methylphenyl)oxidanyl}
C7PAN3_a##         =  7C +  7H +  8O +  N ; {@C7PAN3}             {MCM}
C6CO2OHPAN_a##     =  7C +  7H +  8O +  N ; {@C6CO2OHPAN}         {MCM}
DNCRES_a##         =  7C +  6H +  5O + 2N ; {@DNCRES}             {MCM: 2-methyl-4,6-dinitrophenol}
DNCRESOOH_a##      =  7C +  8H + 10O + 2N ; {@DNCRESOOH}          {MCM}
MNCATECH_a##       =  7C +  7H +  4O +  N ; {@MNCATECH}           {MCM: 3-methyl-6-nitro-1,2-benzenediol}
MNCATECOOH_a##     =  7C +  9H +  9O +  N ; {@MNCATECOOH}         {MCM}
MNNCATCOOH_a##     =  7C +  8H + 11O + 2N ; {@MNNCATCOOH}         {MCM}
NCRESOOH_a##       =  7C +  9H +  8O +  N ; {@NCRESOOH}           {MCM}
NDNCRESOOH_a##     =  7C +  7H + 12O + 3N ; {@NDNCRESOOH}         {MCM}
TLEMUCNO3_a##      =  7C +  9H +  7O +  N ; {@TLEMUCNO3}          {MCM}

{8C}
C721CHO_a##        =  8C + 12H +  3O      ; {@C721CHO}            {MCM}
C721CO3H_a##       =  8C + 12H +  5O      ; {@C721CO3H}           {MCM}
C810OOH_a##        =  8C + 14H +  4O      ; {@C810OOH}            {MCM}
C812OOH_a##        =  8C + 14H +  5O      ; {@C812OOH}            {MCM}
C813OOH_a##        =  8C + 14H +  5O      ; {@C813OOH}            {MCM}
C85OOH_a##         =  8C + 14H +  3O      ; {@C85OOH}             {MCM}
C86OOH_a##         =  8C + 14H +  4O      ; {@C86OOH}             {MCM}
C89OOH_a##         =  8C + 14H +  3O      ; {@C89OOH}             {MCM}
C8BC_a##           =  8C + 14H            ; {@C8BC}               {MCM}
C8BCCO_a##         =  8C + 12H +  O       ; {@C8BCCO}             {MCM}
C8BCOOH_a##        =  8C + 12H +  2O      ; {@C8BCOOH}            {MCM}
NORPINIC_a##       =  8C + 12H +  4O      ; {@NORPINIC}           {MCM}
STYRENOOH_a##      =  8C + 10H +  3O      ; {@STYRENOOH}          {MCM}
C721PAN_a##        =  8C + 11H +  7O +  N ; {@C721PAN}            {MCM}
C810NO3_a##        =  8C + 14H +  5O +  N ; {@C810NO3}            {MCM}
C89NO3_a##         =  8C + 13H +  4O +  N ; {@C89NO3}             {MCM}
C8BCNO3_a##        =  8C + 11H +  3O +  N ; {@C8BCNO3}            {MCM}

{9C}
C811CO3H_a##       =  9C + 14H +  5O      ; {@C811CO3H}           {MCM}
C85CO3H_a##        =  9C + 12H +  4O      ; {@C85CO3H}            {MCM}
C89CO2H_a##        =  9C + 14H +  3O      ; {@C89CO2H}            {MCM}
C89CO3H_a##        =  9C + 14H +  4O      ; {@C89CO3H}            {MCM}
C96OOH_a##         =  9C + 16H +  3O      ; {@C96OOH}             {MCM}
C97OOH_a##         =  9C + 16H +  4O      ; {@C97OOH}             {MCM}
C98OOH_a##         =  9C + 16H +  5O      ; {@C98OOH}             {MCM}
NOPINDCO_a##       =  9C + 12H +  2O      ; {@NOPINDCO}           {MCM}
NOPINDOOH_a##      =  9C + 14H +  3O      ; {@NOPINDOOH}          {MCM}
NOPINONE_a##       =  9C + 14H +   O      ; {@NOPINONE}           {MCM}
NOPINOO_a##        =  9C + 14H +  2O      ; {@NOPINOO}            {MCM}
NORPINAL_a##       =  9C + 14H +  2O      ; {@NORPINAL}           {MCM: norpinaldehyde}
NORPINENOL_a##     =  9C + 14H +  2O      ; {@NORPINENOL}         {}
PINIC_a##          =  9C + 14H +  4O      ; {@PINIC}              {MCM: pinic acid}
C811PAN_a##        =  9C + 13H +  7O +  N ; {@C811PAN}            {MCM}
C89PAN_a##         =  9C + 13H +  5O +  N ; {@C89PAN}             {MCM}
C96NO3_a##         =  9C + 15H +  4O +  N ; {@C96NO3}             {MCM}
C9PAN2_a##         =  9C + 13H +  6O +  N ; {@C9PAN2}             {MCM}

{10C}
BPINAOOH_a##       = 10C + 18H +  3O      ; {@BPINAOOH}           {MCM}
C106OOH_a##        = 10C + 16H +  5O      ; {@C106OOH}            {MCM}
C109CO_a##         = 10C + 10H +  3O      ; {@C109CO}             {MCM}
C109OOH_a##        = 10C + 16H +  4O      ; {@C109OOH}            {MCM}
MENTHEN6ONE_a##    = 10C + 16H +  3O      ; {@MENTHEN6ONE}        {8-OOH-menthen-6-one, Taraborrelli, pers. comm.}
OH2MENTHEN6ONE_a## = 10C + 17H +  4O      ; {@2OHMENTHEN6ONE}     {2-OH-8-OOH-menthen-6-one, Taraborrelli, pers. comm.}
PERPINONIC_a##     = 10C + 16H +  4O      ; {@PERPINONIC}         {MCM}
PINAL_a##          = 10C + 16H +  2O      ; {@PINAL}              {MCM: pinonaldehyde}
PINALOOH_a##       = 10C + 14H +  4O      ; {@PINALOOH}           {MCM}
PINENOL_a##        = 10C + 16H +  2O      ; {@PINEOL}             {}
PINONIC_a##        = 10C + 16H +  3O      ; {@PINONIC}            {MCM: pinonic acid}
BPINANO3_a##       = 10C + 17H +  4O +  N ; {@BPINANO3}           {MCM}
C106NO3_a##        = 10C + 15H +  6O +  N ; {@C106NO3}            {MCM}
C10PAN2_a##        = 10C + 15H +  6O +  N ; {@C10PAN2}            {MCM}
PINALNO3_a##       = 10C + 13H +  5O +  N ; {@PINALNO3}           {MCM}
RO6R1NO3_a##       = 10C + 17H +  5O +  N ; {@RO6R1NO3}           {nitrate from cyclo-oxy peroxy radical from BPINENE, ref3019}
ROO6R1NO3_a##      = 10C + 17H +  6O +  N ; {@ROO6R1NO3}          {nitrate from cyclo-peroxy peroxy radical from BPINENE, ref3019}
LAPINABNO3_a##     = 10C + 17H +  4O +  N ; {@LAPINABNO3}         {APINANO3 + APINBNO3 lumped (ratio 1:2)}
LAPINABOOH_a##     = 10C + 18H +  3O      ; {@LAPINABOOH}         {APINAOOH + APINBOOH lumped (ratio 1:2)}
LNAPINABOOH_a##    = 10C + 17H +  5O +  N ; {@LNAPINABOOH}        {.65 NAPINAOOH + .35 NAPINBOOH}
LNBPINABOOH_a##    = 10C + 17H +  5O +  N ; {@LNBPINABOOH}        {.8 NBPINAO2 + .2 NBPINBO2}

{------------------------------------- Cl ------------------------------------}

Cl_a##         = Cl                   ; {@Cl}           {chlorine atom}
Cl2_a##        = 2Cl                  ; {@Cl_2}         {molecular chlorine}
HCl_a##        = H + Cl               ; {@HCl}          {hydrogen chloride}
HOCl_a##       = H + O + Cl           ; {@HOCl}         {hypochlorous acid}
ClNO_a##       =     O + Cl + N       ; {@ClNO}         {nitrosyl chloride}
ClNO2_a##      =    2O + Cl + N       ; {@ClNO_2}       {nitryl chloride}

{------------------------------------- Br ------------------------------------}

Br_a##         = Br                   ; {@Br}           {bromine atom}
Br2_a##        = 2Br                  ; {@Br_2}         {molecular bromine}
HBr_a##        = H + Br               ; {@HBr}          {hydrogen bromide}
HOBr_a##       = H + O + Br           ; {@HOBr}         {hypobromous acid}
BrCl_a##       = Br + Cl              ; {@BrCl}         {bromine chloride}

{------------------------------------- I -------------------------------------}

I2_a##         = 2I                   ; {@I_2}          {molecular iodine}
IO_a##         = I + O                ; {@IO}           {iodine monoxide radical}
HOI_a##        = H + O + I            ; {@HOI}          {hypoiodous acid}
ICl_a##        = I + Cl               ; {@ICl}          {iodine chloride}
IBr_a##        = I + Br               ; {@IBr}          {iodine bromide}

{------------------------------------- S -------------------------------------}

SO2_a##        = S + 2O               ; {@SO_2}         {sulfur dioxide}
H2SO4_a##      = 2H + S + 4O          ; {@H_2SO_4}      {sulfuric acid}
DMS_a##        = 2C + 6H + S          ; {@DMS}          {dimethyl sulfide: CH3SCH3}
DMSO_a##       = 2C + 6H + S + O      ; {@DMSO}         {dimethyl sulfoxide: CH3SOCH3}

{------------------------------------- Hg ------------------------------------}

Hg_a##         = Hg                   ; {@Hg}           {mercury}
HgO_a##        = Hg + O               ; {@HgO}          {}
HgOHOH_a##     = Hg + 2O + 2H         ; {@Hg(OH)_2}     {}
HgOHCl_a##     = Hg + O + H + Cl      ; {@Hg(OH)Cl}     {}
HgCl2_a##      = Hg + 2Cl             ; {@HgCl_2}       {}
HgBr2_a##      = Hg + 2Br             ; {@HgBr_2}       {}
HgSO3_a##      = Hg + S + 3O          ; {@HgSO_3}       {}
ClHgBr_a##     = Hg + Cl + Br         ; {@ClHgBr}       {}
BrHgOBr_a##    = Hg + O + 2Br         ; {@BrHgOBr}      {}
ClHgOBr_a##    = Hg + O + Cl + Br     ; {@ClHgOBr}      {}

{------------------------------------Fe---------------------------------------}

FeOH3_a##      = Fe + 3O + 3H         ; {@FeOH3}        {}
FeCl3_a##      = Fe + 3Cl             ; {@FeCl3}        {}
FeF3_a##       = Fe + 3F              ; {@FeF3}         {}

{----------------------------------- ions ------------------------------------}

{------------------------------------- O -------------------------------------}

O2m_a##        = 2O            + Min  ; {@O_2^-}        {}
OHm_a##        = H +  O        + Min  ; {@OH^-}         {}
HO2m_a##       = H + 2O        + Min  ; {@HO2^-}        {}
O2mm_a##       = 2O            + 2Min ; {@O2^<2->}      {}
O3m_a##        = 3O            + Min  ; {@O_3^-}        {}

{------------------------------------- H -------------------------------------}

Hp_a##         =  H             + Pls ; {@H^+}          {}

{------------------------------------- N -------------------------------------}

NH4p_a##       = N + 4H         + Pls ; {@NH_4^+}       {ammonium}
NO2m_a##       =      2O +  N   + Min ; {@NO_2^-}       {nitrite}
NO2p_a##       =      2O +  N   + Pls ; {@NO_2^+}       {nitronium ion}
NO3m_a##       =      3O +  N   + Min ; {@NO_3^-}       {nitrate}
NO4m_a##       =      4O +  N   + Min ; {@NO_4^-}       {peroxy nitrate}

{------------------------------------- C -------------------------------------}

{1C}
CO3m_a##       = C     + 3O     + Min ; {@CO_3^-}       {}
HCOOm_a##      = C + H + 2O     + Min ; {@HCOO^-}       {formate}
HCO3m_a##      = C + H + 3O     + Min ; {@HCO_3^-}      {hydrogen carbonate}

{2C}
CH3COOm_a##       = 2C + 3H + 2O + Min  ; {@CH_3COO^-}     {acetate}
CH3CO3m_a##       = 2C + 3H + 3O + Min  ; {@CH_3COOO^-}    {}
HOCH2CO3m_a##     = 2C + 3H + 2O + Min  ; {@CH_2OHCO_2O^-} {}
CH2OOCO2m_a##     = 2C + 2H + 4O + Min  ; {@CH_2OOCO_2^-}  {}
CH2OOHCO2m_a##    = 2C + 3H + 4O + Min  ; {@CH_2OOHCO_2^-} {}
HOCH2CO2m_a##     = 2C + 3H + 3O + Min  ; {@CH_2OHCO_2^-}  {}
CHOHOOCO2m_a##    = 2C + 2H + 5O + Min  ; {@CHOHOOCOO_2^-} {}
CHOCO2m_a##       = 2C +  H + 3O + Min  ; {@CHOCOO^-}      {}
HOOCCO2m_a##      = 2C +  H + 4O + Min  ; {@HOOCCOO^-}     {}
C2O4m_a##         = 2C +      4O + Min  ; {@C_2O_4^-}      {oxalate radical}
CHOOHOOCO2m_a##   = 2C + 2H + 6O + Min  ; {@CHOOHOOCO_2^-} {}
CHOHOHCO2m_a##    = 2C + 3H + 4O + Min  ; {@CHOHOHCO_2^-}  {}
CO2CO2mm_a##      = 2C +      4O + 2Min ; {@C_2O_4^<2->}   {oxalate}
CO2CO3m_a##       = 2C +      5O + Min  ; {@CO_2^-CO_3}    {}
CO2COHOHO2m_a##   = 2C + 2H + 6O + Min  ; {@CO2^-COHOHO_2} {}

{3C}
CH3COCO2m_a##     = 3C + 3H + 3O + Min  ; {@CH_3COCO2^-}   {}

{------------------------------------- Cl ------------------------------------}

Clm_a##        = Cl             + Min ; {@Cl^-}         {chloride}
Cl2m_a##       = 2Cl            + Min ; {@Cl_2^-}       {}
ClOm_a##       = Cl + O         + Min ; {@ClO^-}        {}
ClOHm_a##      = H + O + Cl     + Min ; {@ClOH^-}       {}

{------------------------------------- Br ------------------------------------}

Brm_a##        = Br             + Min ; {@Br^-}         {bromide}
Br2m_a##       = 2Br            + Min ; {@Br_2^-}       {}
BrOm_a##       = Br + O         + Min ; {@BrO^-}        {}
BrOHm_a##      = H + O + Br     + Min ; {@BrOH^-}       {}
BrCl2m_a##     = Br + 2Cl       + Min ; {@BrCl_2^-}     {}
Br2Clm_a##     = 2Br + Cl       + Min ; {@Br_2Cl^-}     {}

{------------------------------------- I -------------------------------------}

Im_a##         = I              + Min ; {@I^-}          {iodide}
IO2m_a##       = I + 2O         + Min ; {@IO_2^-}       {}
IO3m_a##       = I + 3O         + Min ; {@IO_3^-}       {iodate}
ICl2m_a##      = I + 2Cl        + Min ; {@ICl_2^-}      {}
IBr2m_a##      = I + 2Br        + Min ; {@IBr_2^-}      {}

{------------------------------------- S -------------------------------------}

SO3m_a##       = S + 3O          + Min ; {@SO_3^-}       {}
SO3mm_a##      = S + 3O         + 2Min ; {@SO_3^<2->}    {sulfite}
SO4m_a##       = S + 4O          + Min ; {@SO_4^-}       {}
SO4mm_a##      = S + 4O         + 2Min ; {@SO_4^<2->}    {sulfate}
SO5m_a##       = S + 5O          + Min ; {@SO_5^-}       {}
HSO3m_a##      = H + S + 3O      + Min ; {@HSO_3^-}      {hydrogen sulfite}
HSO4m_a##      = H + S + 4O      + Min ; {@HSO_4^-}      {hydrogen sulfate}
HSO5m_a##      = H + S + 5O      + Min ; {@HSO_5^-}      {}
CH3SO3m_a##    = C + 3H + S + 3O + Min ; {@CH_3SO_3^-}   {MSA anion}
CH2OHSO3m_a##  = C + 3H + S + 4O + Min ; {@CH_2OHSO_3^-} {}

{------------------------------------Hg---------------------------------------}

Hgp_a##        = Hg                +  Pls ; {@Hg^+}              {}
Hgpp_a##       = Hg                + 2Pls ; {@Hg^<2+>}           {}
HgOHp_a##      = Hg + O + H        +  Pls ; {@HgOH^+}            {}
HgClp_a##      = Hg + Cl           +  Pls ; {@HgCl^+}            {}
HgBrp_a##      = Hg + Br           +  Pls ; {@HgBr^+}            {}
HgSO32mm_a##   = Hg + 2S + 6O      + 2Min ; {@Hg(SO_3)_2^<2->}   {}

{------------------------------------Fe---------------------------------------}

Fepp_a##        = Fe             + 2Pls ; {@Fe^<2+>}         {Fe(II)}
FeOpp_a##       = Fe + O         + 2Pls ; {@FeO^<2+>}        {Fe(II)}
FeOHp_a##       = Fe + O + H     + Pls  ; {@FeOH^+}          {Fe(II)}
FeOH2p_a##      = Fe + 2O + 2H   + Pls  ; {@Fe(OH)_2^+}      {Fe(II)}
FeClp_a##       = Fe + Cl        + Pls  ; {@FeCl^+}          {Fe(II)}
Feppp_a##       = Fe             + 3Pls ; {@Fe^<3+>}         {Fe(III)}
FeHOpp_a##      = Fe + O + H     + 2Pls ; {@FeHO^<2+>}       {Fe(III)}
FeHO2pp_a##     = Fe + 2O + H    + 2Pls ; {@FeHO_2^<2+>}     {Fe(III)}
FeOHpp_a##      = Fe + O + H     + 2Pls ; {@FeOH^<2+>}       {Fe(III)}
FeOH4m_a##      = Fe + 4O + 4H   + Min  ; {@Fe(OH)_4^-}      {Fe(III)}
FeOHHO2p_a##    = Fe + 3O + 2H   + Pls  ; {@Fe(OH)(HO_2)^+}  {Fe(III)}
FeClpp_a##      = Fe + Cl        + 2Pls ; {@FeCl^<2+>}       {Fe(III)}
FeCl2p_a##      = Fe + 2Cl       + Pls  ; {@FeCl_2^+}        {Fe(III)}
FeBrpp_a##      = Fe + Br        + 2Pls ; {@FeBr^<2+>}       {Fe(III)}
FeBr2p_a##      = Fe + 2Br       + Pls  ; {@FeBr_2^+}        {Fe(III)}
FeFpp_a##       = Fe + F         + 2Pls ; {@FeF^<2+>}        {Fe(III)}
FeF2p_a##       = Fe + 2F        + 2Pls ; {@FeF_2^+}         {Fe(III)}
FeSO3p_a##      = Fe + 3O + S    + Pls  ; {@FeSO_3^+}        {Fe(III)}
FeSO4p_a##      = Fe + 4O + S    + Pls  ; {@FeSO_4^+}        {Fe(III)}
FeSO42m_a##     = Fe + 8O + 2S   + Min  ; {@Fe(SO_4)_2^-}    {Fe(III)}
FeOH2Fepppp_a## = 2 Fe + O + H   + 4Pls ; {@Fe(OH)_2Fe^<4+>} {Fe(III)}

{-----------------------------------------------------------------------------}
{------------------------------------ dummies --------------------------------}
{-----------------------------------------------------------------------------}

D1O_a##        = IGNORE              ; {@D_1O}         {}
Nap_a##        = IGNORE              ; {@Na^+}         {dummy cation}
