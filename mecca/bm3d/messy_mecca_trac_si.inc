! -*- f90 -*- created automatically by xmecca, DO NOT EDIT!
CALL new_tracer(status, setname, 'LCARBON',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  refspec              = 'C', &
  medium               = AIR, &
  idx                  = idt_LCARBON)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LCARBON, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LCARBON, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LCARBON, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CO2H3CO2H',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CO2H3CO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CO2H3CO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2H3CO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2H3CO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2H3CO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2H3CO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NBZFUONE',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NBZFUONE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NBZFUONE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZFUONE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZFUONE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZFUONE, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZFUONE, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NC4MDCO2H',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NC4MDCO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NC4MDCO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4MDCO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4MDCO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4MDCO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4MDCO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PBZQO2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PBZQO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PBZQO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PBZQO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PBZQO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PBZQO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PBZQO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C8BC',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C8BC)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C8BC, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C8BC, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C8BC, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C8BC, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C8BC, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3SO3H',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3SO3H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3SO3H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3SO3H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3SO3H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3SO3H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3SO3H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'H2SO4',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_H2SO4)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_H2SO4, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H2SO4, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H2SO4, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H2SO4, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H2SO4, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C1ODC2O2C4OOH',  modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C1ODC2O2C4OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C1ODC2O2C4OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C1ODC2O2C4OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C1ODC2O2C4OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C1ODC2O2C4OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C1ODC2O2C4OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NH3',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NH3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NH3, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH3, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH3, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH3, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH3, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C2H6',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C2H6)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C2H6, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H6, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H6, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H6, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'IC4H10',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_IC4H10)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_IC4H10, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IC4H10, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IC4H10, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IC4H10, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IC4H10, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NC4H10',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NC4H10)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NC4H10, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4H10, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4H10, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4H10, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4H10, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CPDKETENE',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CPDKETENE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CPDKETENE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CPDKETENE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CPDKETENE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CPDKETENE, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CPDKETENE, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3SO3',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3SO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3SO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3SO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3SO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3SO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C3H8',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C3H8)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C3H8, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3H8, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3H8, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3H8, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ACCOMEPAN',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ACCOMEPAN)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ACCOMEPAN, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACCOMEPAN, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACCOMEPAN, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACCOMEPAN, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACCOMEPAN, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NOPINDOOH',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NOPINDOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NOPINDOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINDOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINDOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINDOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINDOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C109OOH',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C109OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C109OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C109OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C109OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C109OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C109OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C109CO',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C109CO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C109CO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C109CO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C109CO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C109CO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C109CO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3Cl',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3Cl)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3Cl, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3Cl, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3Cl, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3Cl, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3Cl, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NCO',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NCO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NCO, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCO, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCO, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCO, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C1OOHC3O2C4OD',  modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C1OOHC3O2C4OD)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C1OOHC3O2C4OD, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C1OOHC3O2C4OD, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C1OOHC3O2C4OD, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C1OOHC3O2C4OD, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ROO6R1O2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ROO6R1O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ROO6R1O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ROO6R1O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ROO6R1O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ROO6R1O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'H2OH2O',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_H2OH2O)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_H2OH2O, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H2OH2O, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H2OH2O, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H2OH2O, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOC2H4CO2H',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOC2H4CO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOC2H4CO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOC2H4CO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOC2H4CO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOC2H4CO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOC2H4CO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOCH2COCH2OOH',  modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOCH2COCH2OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOCH2COCH2OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2COCH2OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2COCH2OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2COCH2OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2COCH2OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'N2O',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_N2O)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_N2O, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_N2O, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_N2O, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_N2O, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CO14O3CO2H',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CO14O3CO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CO14O3CO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO14O3CO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO14O3CO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO14O3CO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO14O3CO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MALNHYOHCO',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MALNHYOHCO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MALNHYOHCO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALNHYOHCO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALNHYOHCO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALNHYOHCO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALNHYOHCO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C512O2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C512O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C512O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C512O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C512O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C512O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C24O3CCO2H',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C24O3CCO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C24O3CCO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C24O3CCO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C24O3CCO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C24O3CCO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C24O3CCO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C5DIALCO',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C5DIALCO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C5DIALCO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DIALCO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DIALCO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DIALCO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DIALCO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'DNPHEN',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_DNPHEN)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_DNPHEN, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DNPHEN, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DNPHEN, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DNPHEN, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DNPHEN, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MCPDKETENE',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MCPDKETENE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MCPDKETENE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCPDKETENE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCPDKETENE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCPDKETENE, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCPDKETENE, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'TOLUENE',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_TOLUENE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_TOLUENE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TOLUENE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TOLUENE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TOLUENE, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TOLUENE, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'DNCRES',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_DNCRES)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_DNCRES, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DNCRES, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DNCRES, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DNCRES, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DNCRES, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C810OOH',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C810OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C810OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C810OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C810OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C810OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C810OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NSTYRENOOH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NSTYRENOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NSTYRENOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NSTYRENOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NSTYRENOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NSTYRENOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NSTYRENOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C98OOH',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C98OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C98OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C98OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C98OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C98OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C98OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C106OOH',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C106OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C106OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C106OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C106OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C106OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C106OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ETHGLY',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ETHGLY)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ETHGLY, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ETHGLY, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ETHGLY, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ETHGLY, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ETHGLY, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NC3H7O2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NC3H7O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NC3H7O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC3H7O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC3H7O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC3H7O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LISOPAB',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LISOPAB)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LISOPAB, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPAB, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPAB, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPAB, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LISOPCD',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LISOPCD)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LISOPCD, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPCD, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPCD, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPCD, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LME3FURANO2',    modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LME3FURANO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LME3FURANO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LME3FURANO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LME3FURANO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LME3FURANO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BZOBIPEROH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BZOBIPEROH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BZOBIPEROH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZOBIPEROH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZOBIPEROH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZOBIPEROH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZOBIPEROH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'TLOBIPEROH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_TLOBIPEROH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_TLOBIPEROH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLOBIPEROH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLOBIPEROH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLOBIPEROH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLOBIPEROH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PROPENOL',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PROPENOL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PROPENOL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PROPENOL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PROPENOL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PROPENOL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PROPENOL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NISOPOOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NISOPOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NISOPOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NISOPOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NISOPOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NISOPOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NISOPOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LIEPOX',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LIEPOX)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LIEPOX, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LIEPOX, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LIEPOX, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LIEPOX, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LIEPOX, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C6H5OOH',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C6H5OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C6H5OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CATEC1OOH',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CATEC1OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CATEC1OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATEC1OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATEC1OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATEC1OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATEC1OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C6H5CH2OOH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C6H5CH2OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C6H5CH2OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5CH2OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5CH2OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5CH2OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5CH2OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MCATEC1OOH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MCATEC1OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MCATEC1OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATEC1OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATEC1OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATEC1OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATEC1OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'OXYL1OOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_OXYL1OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_OXYL1OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_OXYL1OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_OXYL1OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_OXYL1OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_OXYL1OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C812OOH',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C812OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C812OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C812OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C812OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C812OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C812OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C85OOH',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C85OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C85OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C85OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C85OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C85OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C85OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C89OOH',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C89OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C89OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C89OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C89OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C89OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C89OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C97OOH',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C97OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C97OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C97OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C97OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C97OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C97OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C98O2',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C98O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C98O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C98O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C98O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C98O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CN',             modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CN)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CN, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CN, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CN, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CN, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PINALOOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PINALOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PINALOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PINALOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PINALOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PINALOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PINALOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C106O2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C106O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C106O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C106O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C106O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C106O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NH2OH',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NH2OH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NH2OH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH2OH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH2OH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH2OH, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH2OH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C312COCO3',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C312COCO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C312COCO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C312COCO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C312COCO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C312COCO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CO23C4CO3',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CO23C4CO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CO23C4CO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO23C4CO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO23C4CO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO23C4CO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BIACETO2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BIACETO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BIACETO2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BIACETO2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BIACETO2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BIACETO2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BIACETO2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C2H5OH',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C2H5OH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C2H5OH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5OH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5OH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5OH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5OH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PHCOOH',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PHCOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PHCOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHCOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHCOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHCOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHCOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C810O2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C810O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C810O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C810O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C810O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C810O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'N2O5',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_N2O5)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_N2O5, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_N2O5, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_N2O5, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_N2O5, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_N2O5, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PR2O2HNO3',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PR2O2HNO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PR2O2HNO3, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PR2O2HNO3, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PR2O2HNO3, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PR2O2HNO3, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PR2O2HNO3, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CHOC3COO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CHOC3COO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CHOC3COO2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CHOC3COO2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CHOC3COO2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CHOC3COO2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CHOC3COO2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MACO3H',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MACO3H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MACO3H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACO3H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACO3H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACO3H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACO3H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MALANHYOOH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MALANHYOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MALANHYOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALANHYOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALANHYOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALANHYOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALANHYOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NH2O',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NH2O)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NH2O, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH2O, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH2O, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH2O, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH2O, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C511OOH',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C511OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C511OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C511OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C511OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C511OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C511OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C59OOH',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C59OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C59OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C59OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C59OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C59OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C59OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NTLFUOOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NTLFUOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NTLFUOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NTLFUOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NTLFUOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NTLFUOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NTLFUOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MCATECHOL',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MCATECHOL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MCATECHOL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATECHOL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATECHOL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATECHOL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATECHOL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NPTLQOOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NPTLQOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NPTLQOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPTLQOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPTLQOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPTLQOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPTLQOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C811O2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C811O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C811O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C811O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C811O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C811O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3CO3H',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3CO3H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3CO3H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CO3H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CO3H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CO3H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CO3H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C86OOH',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C86OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C86OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C86OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C86OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C86OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C86OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C96OOH',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C96OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C96OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C96OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C96OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C96OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C96OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOCH2CH2O',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOCH2CH2O)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOCH2CH2O, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CH2O, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CH2O, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LNAPINABOOH',    modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LNAPINABOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LNAPINABOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNAPINABOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNAPINABOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNAPINABOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNAPINABOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C1ODC2OOHC4OD',  modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C1ODC2OOHC4OD)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C1ODC2OOHC4OD, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C1ODC2OOHC4OD, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C1ODC2OOHC4OD, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C1ODC2OOHC4OD, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C1ODC2OOHC4OD, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'IC3H7OOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_IC3H7OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_IC3H7OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IC3H7OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IC3H7OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IC3H7OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IC3H7OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C3PAN1',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C3PAN1)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C3PAN1, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3PAN1, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3PAN1, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3PAN1, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3PAN1, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C3PAN2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C3PAN2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C3PAN2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3PAN2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3PAN2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3PAN2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3PAN2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'IBUTOLBOOH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_IBUTOLBOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_IBUTOLBOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IBUTOLBOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IBUTOLBOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IBUTOLBOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IBUTOLBOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MACO2H',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MACO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MACO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'EPXDLPAN',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_EPXDLPAN)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_EPXDLPAN, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EPXDLPAN, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EPXDLPAN, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EPXDLPAN, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EPXDLPAN, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MALDIALPAN',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MALDIALPAN)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MALDIALPAN, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDIALPAN, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDIALPAN, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDIALPAN, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDIALPAN, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NBZFUOOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NBZFUOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NBZFUOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZFUOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZFUOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZFUOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZFUOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'DB1O',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_DB1O)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_DB1O, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DB1O, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DB1O, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DB1O, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C5DIALOOH',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C5DIALOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C5DIALOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DIALOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DIALOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DIALOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DIALOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C5COO2NO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C5COO2NO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C5COO2NO2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5COO2NO2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5COO2NO2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5COO2NO2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5COO2NO2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BENZENE',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BENZENE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BENZENE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BENZENE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BENZENE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BENZENE, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BENZENE, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BZBIPEROOH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BZBIPEROOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BZBIPEROOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZBIPEROOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZBIPEROOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZBIPEROOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZBIPEROOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C2H5OOH',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C2H5OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C2H5OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PBZQONE',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PBZQONE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PBZQONE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PBZQONE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PBZQONE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PBZQONE, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PBZQONE, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NNCATECOOH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NNCATECOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NNCATECOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NNCATECOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NNCATECOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NNCATECOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NNCATECOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NPHENOOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NPHENOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NPHENOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHENOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHENOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHENOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHENOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C6CO2OHPAN',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C6CO2OHPAN)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C6CO2OHPAN, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6CO2OHPAN, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6CO2OHPAN, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6CO2OHPAN, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6CO2OHPAN, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C811CO3',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C811CO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C811CO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C811CO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C811CO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C811CO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BPINAOOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BPINAOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BPINAOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BPINAOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BPINAOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BPINAOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BPINAOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HCOCO3H',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HCOCO3H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HCOCO3H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCO3H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCO3H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCO3H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCO3H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HNO4',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HNO4)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HNO4, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HNO4, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HNO4, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HNO4, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HNO4, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C10PAN2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C10PAN2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C10PAN2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C10PAN2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C10PAN2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C10PAN2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C10PAN2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LNBPINABOOH',    modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LNBPINABOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LNBPINABOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNBPINABOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNBPINABOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNBPINABOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNBPINABOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'DMSO',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_DMSO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_DMSO, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DMSO, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DMSO, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DMSO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DMSO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BIACETOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BIACETOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BIACETOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BIACETOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BIACETOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BIACETOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BIACETOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CHOC3COCO3',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CHOC3COCO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CHOC3COCO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CHOC3COCO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CHOC3COCO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CHOC3COCO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LISOPEFO',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LISOPEFO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LISOPEFO, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPEFO, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPEFO, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NCATECHOL',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NCATECHOL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NCATECHOL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCATECHOL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCATECHOL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCATECHOL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCATECHOL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C813O2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C813O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C813O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C813O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C813O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C813O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'EBENZ',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_EBENZ)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_EBENZ, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EBENZ, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EBENZ, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EBENZ, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EBENZ, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LXYL',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LXYL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LXYL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LXYL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LXYL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LXYL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LXYL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C97O2',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C97O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C97O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C97O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C97O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C97O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LTMB',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LTMB)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LTMB, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LTMB, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LTMB, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LTMB, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LTMB, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C2H2',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C2H2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C2H2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PINALO2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PINALO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PINALO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PINALO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PINALO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PINALO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LHAROM',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LHAROM)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LHAROM, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LHAROM, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LHAROM, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LHAROM, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LHAROM, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CRESOL',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CRESOL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CRESOL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CRESOL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CRESOL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CRESOL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CRESOL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HCOCCH3CO',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HCOCCH3CO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HCOCCH3CO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCCH3CO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCCH3CO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCCH3CO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCCH3CO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'TC4H9OOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_TC4H9OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_TC4H9OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TC4H9OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TC4H9OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TC4H9OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TC4H9OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MALANHY',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MALANHY)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MALANHY, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALANHY, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALANHY, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALANHY, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALANHY, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LBUT1ENOOH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LBUT1ENOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LBUT1ENOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LBUT1ENOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LBUT1ENOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LBUT1ENOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LBUT1ENOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C5134CO2OH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C5134CO2OH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C5134CO2OH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5134CO2OH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5134CO2OH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5134CO2OH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5134CO2OH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HCOCOCH2OOH',    modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HCOCOCH2OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HCOCOCH2OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCOCH2OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCOCH2OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCOCH2OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCOCH2OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ISOPBNO3',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ISOPBNO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ISOPBNO3, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPBNO3, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPBNO3, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPBNO3, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPBNO3, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LNISOOH',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LNISOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LNISOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNISOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNISOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNISOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNISOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NDNPHENOOH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NDNPHENOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NDNPHENOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NDNPHENOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NDNPHENOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NDNPHENOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NDNPHENOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HYPROPO2H',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HYPROPO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HYPROPO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYPROPO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYPROPO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYPROPO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYPROPO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CRESOOH',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CRESOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CRESOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CRESOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CRESOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CRESOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CRESOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3CO2H',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3CO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3CO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'IC3H7O2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_IC3H7O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_IC3H7O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IC3H7O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IC3H7O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IC3H7O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MNCATECH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MNCATECH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MNCATECH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MNCATECH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MNCATECH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MNCATECH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MNCATECH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C89PAN',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C89PAN)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C89PAN, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C89PAN, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C89PAN, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C89PAN, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C89PAN, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOCHCHO',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOCHCHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOCHCHO, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCHCHO, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCHCHO, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCHCHO, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOOCH2CO2H',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOOCH2CO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOOCH2CO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOOCH2CO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOOCH2CO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOOCH2CO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOOCH2CO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NCCH2O2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NCCH2O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NCCH2O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCCH2O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCCH2O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCCH2O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'EZCH3CO2CHCHO',  modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_EZCH3CO2CHCHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_EZCH3CO2CHCHO, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EZCH3CO2CHCHO, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EZCH3CO2CHCHO, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EZCH3CO2CHCHO, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C6CO4DB',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C6CO4DB)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C6CO4DB, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6CO4DB, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6CO4DB, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6CO4DB, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6CO4DB, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NPHEN1O2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NPHEN1O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NPHEN1O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHEN1O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHEN1O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHEN1O2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHEN1O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C7CO4DB',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C7CO4DB)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C7CO4DB, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C7CO4DB, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C7CO4DB, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C7CO4DB, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C7CO4DB, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NCRES1O2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NCRES1O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NCRES1O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRES1O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRES1O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRES1O2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRES1O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NO3CH2CO3',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NO3CH2CO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NO3CH2CO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO3CH2CO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO3CH2CO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO3CH2CO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3SO2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3SO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3SO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3SO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3SO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3SO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HYETHO2H',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HYETHO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HYETHO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYETHO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYETHO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYETHO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYETHO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MPAN',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MPAN)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MPAN, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MPAN, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MPAN, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MPAN, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MPAN, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NC4DCO2H',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NC4DCO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NC4DCO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4DCO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4DCO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4DCO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4DCO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LC4H9OOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LC4H9OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LC4H9OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LC4H9OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LC4H9OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LC4H9OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LC4H9OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LMEKO2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LMEKO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LMEKO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LMEKO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LMEKO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LMEKO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C2H5O2NO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C2H5O2NO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C2H5O2NO2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5O2NO2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5O2NO2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5O2NO2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5O2NO2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ETHOHNO3',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ETHOHNO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ETHOHNO3, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ETHOHNO3, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ETHOHNO3, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ETHOHNO3, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ETHOHNO3, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'DB2OOH',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_DB2OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_DB2OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DB2OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DB2OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DB2OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DB2OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOCH2COCHO',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOCH2COCHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOCH2COCHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2COCHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2COCHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2COCHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2COCHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PPN',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PPN)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PPN, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PPN, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PPN, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PPN, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PPN, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3COCHO2CHO',   modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3COCHO2CHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3COCHO2CHO, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCHO2CHO, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCHO2CHO, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCHO2CHO, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NCRESOOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NCRESOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NCRESOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRESOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRESOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRESOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRESOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOCH2CO3H',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOCH2CO3H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOCH2CO3H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CO3H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CO3H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CO3H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CO3H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3O2NO2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3O2NO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3O2NO2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3O2NO2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3O2NO2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3O2NO2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3O2NO2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BrNO3',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BrNO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BrNO3, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BrNO3, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BrNO3, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BrNO3, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BrNO3, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'TC4H9O2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_TC4H9O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_TC4H9O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TC4H9O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TC4H9O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TC4H9O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C511O2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C511O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C511O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C511O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C511O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C511O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3CN',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3CN)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3CN, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CN, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CN, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CN, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CN, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C513O2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C513O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C513O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C513O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C513O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C513O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3COCH2O2NO2',  modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3COCH2O2NO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3COCH2O2NO2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCH2O2NO2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCH2O2NO2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCH2O2NO2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCH2O2NO2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CO2H3CO3H',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CO2H3CO3H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CO2H3CO3H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2H3CO3H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2H3CO3H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2H3CO3H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ISOPDNO3',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ISOPDNO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ISOPDNO3, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPDNO3, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPDNO3, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPDNO3, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPDNO3, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BZEMUCCO3',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BZEMUCCO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BZEMUCCO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZEMUCCO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZEMUCCO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZEMUCCO3, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZEMUCCO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C6H5CH2O2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C6H5CH2O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C6H5CH2O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5CH2O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5CH2O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5CH2O2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5CH2O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HO12CO3C4',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HO12CO3C4)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HO12CO3C4, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HO12CO3C4, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HO12CO3C4, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HO12CO3C4, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HO12CO3C4, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PTLQONE',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PTLQONE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PTLQONE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PTLQONE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PTLQONE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PTLQONE, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PTLQONE, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NHOH',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NHOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NHOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NHOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NHOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NHOH, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NHOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3CHCO',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3CHCO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3CHCO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHCO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHCO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHCO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHCO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH2CHOH',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH2CHOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH2CHOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH2CHOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH2CHOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH2CHOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH2CHOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LNAPINABO2',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LNAPINABO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LNAPINABO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNAPINABO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNAPINABO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNAPINABO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HBr',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HBr)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HBr, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HBr, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HBr, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HBr, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HBr, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOBr',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOBr)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOBr, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOBr, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOBr, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOBr, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOBr, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH2OOA',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH2OOA)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH2OOA, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH2OOA, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH2OOA, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH2OOA, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOCH2CO2H',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOCH2CO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOCH2CO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MACRO',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MACRO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MACRO, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACRO, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACRO, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACRO, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3NO3',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3NO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3NO3, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3NO3, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3NO3, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3NO3, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3NO3, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C85O2',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C85O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C85O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C85O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C85O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C85O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C89O2',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C89O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C89O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C89O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C89O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C89O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C85CO3',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C85CO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C85CO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C85CO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C85CO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C85CO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PAN',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PAN)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PAN, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PAN, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PAN, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PAN, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PAN, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PHAN',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PHAN)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PHAN, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHAN, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHAN, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHAN, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHAN, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MACRNO3',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MACRNO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MACRNO3, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACRNO3, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACRNO3, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACRNO3, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACRNO3, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NISOPO2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NISOPO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NISOPO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NISOPO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NISOPO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NISOPO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LHC4ACCHO',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LHC4ACCHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LHC4ACCHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LHC4ACCHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LHC4ACCHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LHC4ACCHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LHC4ACCHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'TOL1O',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_TOL1O)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_TOL1O, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TOL1O, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TOL1O, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TOL1O, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TOL1O, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C812O2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C812O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C812O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C812O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C812O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C812O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'STYRENE',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_STYRENE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_STYRENE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_STYRENE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_STYRENE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_STYRENE, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_STYRENE, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PHENOL',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PHENOL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PHENOL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHENOL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHENOL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHENOL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHENOL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CATECHOL',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CATECHOL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CATECHOL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATECHOL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATECHOL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATECHOL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATECHOL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C6H5O',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C6H5O)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C6H5O, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5O, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5O, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5O, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5O, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NOPINONE',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NOPINONE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NOPINONE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINONE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINONE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINONE, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINONE, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'TLFUO2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_TLFUO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_TLFUO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLFUO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLFUO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLFUO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLFUO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NTLFUO2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NTLFUO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NTLFUO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NTLFUO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NTLFUO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NTLFUO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NTLFUO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HYPERACET',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HYPERACET)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HYPERACET, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYPERACET, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYPERACET, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYPERACET, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYPERACET, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NPHEN1O',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NPHEN1O)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NPHEN1O, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHEN1O, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHEN1O, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHEN1O, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHEN1O, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HVMK',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HVMK)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HVMK, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HVMK, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HVMK, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HVMK, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HVMK, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NBZFUO2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NBZFUO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NBZFUO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZFUO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZFUO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZFUO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZFUO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'TLBIPEROOH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_TLBIPEROOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_TLBIPEROOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLBIPEROOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLBIPEROOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLBIPEROOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLBIPEROOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'TLEMUCCO3',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_TLEMUCCO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_TLEMUCCO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLEMUCCO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLEMUCCO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLEMUCCO3, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLEMUCCO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BZFUO2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BZFUO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BZFUO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZFUO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZFUO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZFUO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZFUO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MNNCATECO2',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MNNCATECO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MNNCATECO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MNNCATECO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MNNCATECO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MNNCATECO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MNNCATECO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NCRES1O',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NCRES1O)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NCRES1O, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRES1O, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRES1O, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRES1O, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRES1O, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MACO2',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MACO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MACO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PRONO3BO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PRONO3BO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PRONO3BO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PRONO3BO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PRONO3BO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PRONO3BO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C96O2',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C96O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C96O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C96O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C96O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C96O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BPINENE',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BPINENE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BPINENE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BPINENE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BPINENE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BPINENE, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BPINENE, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CAMPHENE',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CAMPHENE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CAMPHENE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CAMPHENE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CAMPHENE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CAMPHENE, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CAMPHENE, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'SABINENE',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_SABINENE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_SABINENE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_SABINENE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_SABINENE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_SABINENE, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_SABINENE, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BPINAO2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BPINAO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BPINAO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BPINAO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BPINAO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BPINAO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HCOCOHCO3',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HCOCOHCO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HCOCOHCO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCOHCO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCOHCO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCOHCO3, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCOHCO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'IBUTDIAL',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_IBUTDIAL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_IBUTDIAL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IBUTDIAL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IBUTDIAL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IBUTDIAL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IBUTDIAL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C5DIALO2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C5DIALO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C5DIALO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DIALO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DIALO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DIALO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DIALO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'Cl',             modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_Cl)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_Cl, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_Cl, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_Cl, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_Cl, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'H2',             modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_H2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_H2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HCOC5',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HCOC5)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HCOC5, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOC5, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOC5, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOC5, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOC5, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C615CO2O2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C615CO2O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C615CO2O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C615CO2O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C615CO2O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C615CO2O2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C615CO2O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3CHOHOOH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3CHOHOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3CHOHOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHOHOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHOHOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHOHOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHOHOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NBZQO2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NBZQO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NBZQO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZQO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZQO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZQO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NBZQO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NPHENO2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NPHENO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NPHENO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHENO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHENO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHENO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPHENO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C6H5CO3',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C6H5CO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C6H5CO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5CO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5CO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5CO3, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5CO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOCH2OOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOCH2OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOCH2OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'IBUTOLBO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_IBUTOLBO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_IBUTOLBO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IBUTOLBO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IBUTOLBO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_IBUTOLBO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HCOCH2CHO',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HCOCH2CHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HCOCH2CHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCH2CHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCH2CHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCH2CHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCH2CHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NSTYRENO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NSTYRENO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NSTYRENO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NSTYRENO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NSTYRENO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NSTYRENO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NSTYRENO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HCN',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HCN)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HCN, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCN, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCN, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCN, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCN, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LNBPINABO2',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LNBPINABO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LNBPINABO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNBPINABO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNBPINABO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNBPINABO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LHMVKABOOH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LHMVKABOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LHMVKABOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LHMVKABOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LHMVKABOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LHMVKABOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LHMVKABOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CO14O3CHO',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CO14O3CHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CO14O3CHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO14O3CHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO14O3CHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO14O3CHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO14O3CHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HONO',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HONO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HONO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HONO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HONO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HONO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HONO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HNO',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HNO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HNO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HNO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HNO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HNO, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HNO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NH2',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NH2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NH2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NH2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CO13C4CHO',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CO13C4CHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CO13C4CHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO13C4CHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO13C4CHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO13C4CHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO13C4CHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LDISOPACO2',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LDISOPACO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LDISOPACO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LDISOPACO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LDISOPACO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CRESO2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CRESO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CRESO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CRESO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CRESO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CRESO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CRESO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PTLQO2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PTLQO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PTLQO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PTLQO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PTLQO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PTLQO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PTLQO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ACCOMECO3',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ACCOMECO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ACCOMECO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACCOMECO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACCOMECO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACCOMECO3, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACCOMECO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3OOH',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NCRESO2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NCRESO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NCRESO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRESO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRESO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRESO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCRESO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NPTLQO2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NPTLQO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NPTLQO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPTLQO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPTLQO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPTLQO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NPTLQO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C6CO2OHCO3',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C6CO2OHCO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C6CO2OHCO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6CO2OHCO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6CO2OHCO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6CO2OHCO3, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6CO2OHCO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C33CO',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C33CO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C33CO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C33CO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C33CO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C33CO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C33CO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PINAL',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PINAL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PINAL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PINAL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PINAL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PINAL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PINAL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C96CO3',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C96CO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C96CO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C96CO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C96CO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C96CO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MEPROPENE',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MEPROPENE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MEPROPENE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MEPROPENE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MEPROPENE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MEPROPENE, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MEPROPENE, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LC4H9O2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LC4H9O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LC4H9O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LC4H9O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LC4H9O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LC4H9O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MEK',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MEK)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MEK, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MEK, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MEK, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MEK, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MEK, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BUT1ENE',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BUT1ENE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BUT1ENE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BUT1ENE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BUT1ENE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BUT1ENE, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BUT1ENE, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LNISO3',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LNISO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LNISO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNISO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LNISO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HYPROPO2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HYPROPO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HYPROPO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYPROPO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYPROPO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HYPROPO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3COCH3',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3COCH3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3COCH3, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCH3, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCH3, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCH3, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCH3, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOC2H4CO3',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOC2H4CO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOC2H4CO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOC2H4CO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOC2H4CO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOC2H4CO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3COCHCO',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3COCHCO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3COCHCO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCHCO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCHCO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCHCO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCHCO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BZBIPERO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BZBIPERO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BZBIPERO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZBIPERO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZBIPERO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZBIPERO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZBIPERO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MVKNO3',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MVKNO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MVKNO3, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MVKNO3, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MVKNO3, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MVKNO3, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MVKNO3, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C5CO14OH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C5CO14OH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C5CO14OH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5CO14OH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5CO14OH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5CO14OH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5CO14OH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ALCOCH2OOH',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ALCOCH2OOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ALCOCH2OOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ALCOCH2OOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ALCOCH2OOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ALCOCH2OOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ALCOCH2OOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NORPINAL',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NORPINAL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NORPINAL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NORPINAL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NORPINAL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NORPINAL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NORPINAL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LBUT1ENO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LBUT1ENO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LBUT1ENO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LBUT1ENO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LBUT1ENO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LBUT1ENO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NNCATECO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NNCATECO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NNCATECO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NNCATECO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NNCATECO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NNCATECO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NNCATECO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MALDALCO2H',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MALDALCO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MALDALCO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDALCO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDALCO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDALCO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDALCO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MCATEC1O2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MCATEC1O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MCATEC1O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATEC1O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATEC1O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATEC1O2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATEC1O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'OXYL1O2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_OXYL1O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_OXYL1O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_OXYL1O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_OXYL1O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_OXYL1O2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_OXYL1O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C59O2',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C59O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C59O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C59O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C59O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C59O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MACROOH',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MACROOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MACROOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACROOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACROOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACROOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACROOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CO23C3CHO',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CO23C3CHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CO23C3CHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO23C3CHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO23C3CHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO23C3CHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO23C3CHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NCATECO2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NCATECO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NCATECO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCATECO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCATECO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCATECO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NCATECO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C3DIALO2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C3DIALO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C3DIALO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3DIALO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3DIALO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3DIALO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3DIALO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CATEC1O2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CATEC1O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CATEC1O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATEC1O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATEC1O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATEC1O2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATEC1O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LISOPACO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LISOPACO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LISOPACO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPACO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPACO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'DMS',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_DMS)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_DMS, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DMS, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DMS, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DMS, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'SO2',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_SO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_SO2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_SO2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_SO2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_SO2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_SO2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BZEPOXMUC',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BZEPOXMUC)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BZEPOXMUC, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZEPOXMUC, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZEPOXMUC, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZEPOXMUC, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZEPOXMUC, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH2CO',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH2CO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH2CO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH2CO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH2CO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH2CO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH2CO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LISOPACNO3O2',   modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LISOPACNO3O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LISOPACNO3O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPACNO3O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPACNO3O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPACNO3O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOCH2CO',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOCH2CO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOCH2CO, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CO, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CO, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CO, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BENZAL',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BENZAL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BENZAL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BENZAL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BENZAL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BENZAL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BENZAL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C6H5O2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C6H5O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C6H5O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5O2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C6H5O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NOA',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NOA)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NOA, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOA, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOA, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOA, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOA, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NO3CH2CHO',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NO3CH2CHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NO3CH2CHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO3CH2CHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO3CH2CHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO3CH2CHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO3CH2CHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ACCOMECHO',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ACCOMECHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ACCOMECHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACCOMECHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACCOMECHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACCOMECHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACCOMECHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'TLEPOXMUC',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_TLEPOXMUC)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_TLEPOXMUC, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLEPOXMUC, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLEPOXMUC, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLEPOXMUC, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLEPOXMUC, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'EPXDLCO3',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_EPXDLCO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_EPXDLCO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EPXDLCO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EPXDLCO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EPXDLCO3, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EPXDLCO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BUT2OLO2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BUT2OLO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BUT2OLO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BUT2OLO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BUT2OLO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BUT2OLO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CATEC1O',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CATEC1O)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CATEC1O, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATEC1O, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATEC1O, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATEC1O, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CATEC1O, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NDNCRESO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NDNCRESO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NDNCRESO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NDNCRESO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NDNCRESO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NDNCRESO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NDNCRESO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MECOACETO2',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MECOACETO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MECOACETO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MECOACETO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MECOACETO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MECOACETO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MECOACETO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HCOCH2CO3',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HCOCH2CO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HCOCH2CO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCH2CO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCH2CO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCH2CO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'TLEMUCO2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_TLEMUCO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_TLEMUCO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLEMUCO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLEMUCO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLEMUCO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLEMUCO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'EPXC4DIAL',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_EPXC4DIAL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_EPXC4DIAL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EPXC4DIAL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EPXC4DIAL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EPXC4DIAL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_EPXC4DIAL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HCOCO',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HCOCO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HCOCO, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCO, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCO, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCO, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'PHENO2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_PHENO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_PHENO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHENO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHENO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHENO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_PHENO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'TLBIPERO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_TLBIPERO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_TLBIPERO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLBIPERO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLBIPERO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLBIPERO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLBIPERO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'H2O2',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_H2O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_H2O2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H2O2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H2O2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H2O2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H2O2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CO2C3CHO',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CO2C3CHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CO2C3CHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2C3CHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2C3CHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2C3CHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2C3CHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3OH',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3OH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3OH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3OH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3OH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3OH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3OH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LISOPEFO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LISOPEFO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LISOPEFO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPEFO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPEFO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NOPINDO2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NOPINDO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NOPINDO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINDO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINDO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINDO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CO2H3CO3',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CO2H3CO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CO2H3CO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2H3CO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2H3CO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2H3CO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C2H5O2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C2H5O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C2H5O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NDNPHENO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NDNPHENO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NDNPHENO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NDNPHENO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NDNPHENO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NDNPHENO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NDNPHENO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C2H5CO3',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C2H5CO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C2H5CO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5CO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5CO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5CO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'TOL1OHNO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_TOL1OHNO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_TOL1OHNO2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TOL1OHNO2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TOL1OHNO2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TOL1OHNO2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TOL1OHNO2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BZFUONE',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BZFUONE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BZFUONE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZFUONE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZFUONE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZFUONE, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BZFUONE, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MCATEC1O',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MCATEC1O)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MCATEC1O, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATEC1O, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATEC1O, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATEC1O, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MCATEC1O, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOOCH2CO3',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOOCH2CO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOOCH2CO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOOCH2CO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOOCH2CO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOOCH2CO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C2H4',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C2H4)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C2H4, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H4, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H4, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H4, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MALANHYO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MALANHYO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MALANHYO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALANHYO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALANHYO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALANHYO2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALANHYO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MALDIALCO3',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MALDIALCO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MALDIALCO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDIALCO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDIALCO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDIALCO3, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDIALCO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CBUT2ENE',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CBUT2ENE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CBUT2ENE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CBUT2ENE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CBUT2ENE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CBUT2ENE, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CBUT2ENE, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'TBUT2ENE',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_TBUT2ENE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_TBUT2ENE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TBUT2ENE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TBUT2ENE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TBUT2ENE, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TBUT2ENE, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3CHOHO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3CHOHO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3CHOHO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHOHO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHOHO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHOHO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH4',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH4)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH4, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH4, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH4, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH4, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HCOCO2H',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HCOCO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HCOCO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOCH2O2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOCH2O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOCH2O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2O2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2O2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOOCH2CHO',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOOCH2CHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOOCH2CHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOOCH2CHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOOCH2CHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOOCH2CHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOOCH2CHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C86O2',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C86O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C86O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C86O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C86O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C86O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'TLFUONE',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_TLFUONE)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_TLFUONE, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLFUONE, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLFUONE, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLFUONE, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_TLFUONE, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C2H5CHO',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C2H5CHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C2H5CHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5CHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5CHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5CHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C2H5CHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOC6H4NO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOC6H4NO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOC6H4NO2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOC6H4NO2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOC6H4NO2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOC6H4NO2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOC6H4NO2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ClO',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ClO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ClO, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ClO, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ClO, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ClO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C5CO14O2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C5CO14O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C5CO14O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5CO14O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5CO14O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5CO14O2, I_drydep            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5CO14O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MALDIAL',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MALDIAL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MALDIAL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDIAL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDIAL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDIAL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MALDIAL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MACO3',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MACO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MACO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'H',              modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_H, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MACRO2',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MACRO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MACRO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACRO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACRO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACRO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3COCO2H',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3COCO2H)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3COCO2H, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCO2H, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCO2H, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCO2H, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCO2H, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CHOCOCH2O2',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CHOCOCH2O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CHOCOCH2O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CHOCOCH2O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CHOCOCH2O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CHOCOCH2O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HCOCO3',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HCOCO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HCOCO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ISOPDO2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ISOPDO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ISOPDO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPDO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPDO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C5H8',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C5H8)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C5H8, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5H8, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5H8, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5H8, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5H8, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NC4CHO',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NC4CHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NC4CHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4CHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4CHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4CHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NC4CHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C3H6',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C3H6)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C3H6, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3H6, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3H6, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C3H6, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ISOPBDNO3O2',    modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ISOPBDNO3O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ISOPBDNO3O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPBDNO3O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPBDNO3O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPBDNO3O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3CO3',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3CO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3CO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C5DICARB',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C5DICARB)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C5DICARB, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DICARB, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DICARB, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DICARB, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C5DICARB, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NOPINOO',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NOPINOO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NOPINOO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINOO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINOO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINOO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NOPINOO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LHMVKABO2',      modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LHMVKABO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LHMVKABO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LHMVKABO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LHMVKABO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CO2H3CHO',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CO2H3CHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CO2H3CHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2H3CHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2H3CHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2H3CHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2H3CHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MACR',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MACR)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MACR, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACR, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACR, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACR, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MACR, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'DB2O2',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_DB2O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_DB2O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DB2O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DB2O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_DB2O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HNO3',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HNO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HNO3, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HNO3, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HNO3, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HNO3, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HNO3, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HMAC',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HMAC)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HMAC, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HMAC, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HMAC, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HMAC, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HMAC, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ACETOL',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ACETOL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ACETOL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACETOL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACETOL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACETOL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ACETOL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C4MDIAL',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C4MDIAL)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C4MDIAL, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C4MDIAL, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C4MDIAL, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C4MDIAL, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C4MDIAL, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MGLYOX',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MGLYOX)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MGLYOX, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MGLYOX, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MGLYOX, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MGLYOX, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MGLYOX, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ISOPBO2',        modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ISOPBO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ISOPBO2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPBO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPBO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPBO2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'GLYOX',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_GLYOX)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_GLYOX, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_GLYOX, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_GLYOX, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_GLYOX, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_GLYOX, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LISOPACNO3',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LISOPACNO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LISOPACNO3, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPACNO3, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPACNO3, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPACNO3, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LISOPACNO3, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOCH2CO3',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOCH2CO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOCH2CO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ISOPDOOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ISOPDOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ISOPDOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPDOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPDOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPDOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPDOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOCH2CH2O2',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOCH2CH2O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOCH2CH2O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CH2O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CH2O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'ISOPBOOH',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_ISOPBOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_ISOPBOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPBOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPBOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPBOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_ISOPBOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'MVK',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_MVK)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_MVK, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MVK, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MVK, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MVK, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_MVK, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3COCH2O2',     modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3COCH2O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3COCH2O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCH2O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCH2O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3COCH2O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'LZCODC23DBCOOH', modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_LZCODC23DBCOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_LZCODC23DBCOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LZCODC23DBCOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LZCODC23DBCOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LZCODC23DBCOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_LZCODC23DBCOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HCOCH2O2',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HCOCH2O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HCOCH2O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCH2O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCH2O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOCH2O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3CHO',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3CHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3CHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HOCH2CHO',       modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HOCH2CHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HOCH2CHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HOCH2CHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3CO',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3CO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3CO, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CO, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CO, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3CO, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'C89CO3',         modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_C89CO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_C89CO3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C89CO3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C89CO3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_C89CO3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HCOOH',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HCOOH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HCOOH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOOH, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOOH, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOOH, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCOOH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'O1D',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  refspec              = 'O', &
  medium               = AIR, &
  idx                  = idt_O1D)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_O1D, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_O1D, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_O1D, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_O1D, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'BrO',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_BrO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_BrO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BrO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BrO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_BrO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3O',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3O)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3O, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3O, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3O, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3O, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'Br',             modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_Br)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_Br, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_Br, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_Br, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_Br, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH2OO',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH2OO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH2OO, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH2OO, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH2OO, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH2OO, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NO3',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NO3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NO3, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO3, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO3, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO3, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO3, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NO',             modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CO',             modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'NO2',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_NO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_NO2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_NO2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3O2',          modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3O2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3O2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'O3P',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  refspec              = 'O', &
  medium               = AIR, &
  idx                  = idt_O3P)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_O3P, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_O3P, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_O3P, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_O3P, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'O3',             modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_O3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_O3, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_O3, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_O3, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_O3, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_O3, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HCHO',           modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HCHO)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HCHO, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCHO, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCHO, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCHO, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HCHO, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CH3',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CH3)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CH3, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CH3, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'OH',             modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_OH)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_OH, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_OH, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_OH, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_OH, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'HO2',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_HO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_HO2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HO2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HO2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HO2, I_drydep            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_HO2, I_scav              , ON)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'O2',             modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_O2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_O2, R_vini              , 0.21_dp)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_O2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_O2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_O2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_O2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'N2',             modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_N2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_N2, R_vini              , 0.78_dp)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_N2, I_advect            , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_N2, I_convect           , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_N2, I_vdiff             , OFF)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_N2, I_scav              , OFF)
CALL tracer_halt(substr, status)
CALL new_tracer(status, setname, 'CO2',            modstr, &
  quantity             = AMOUNTFRACTION, &
  unit                 = 'mol/mol', &
  medium               = AIR, &
  idx                  = idt_CO2)
CALL tracer_halt(substr,status)
CALL set_tracer(status, setname, idt_CO2, R_vini              , 3.5E-04_dp)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2, I_advect            , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2, I_convect           , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2, I_vdiff             , ON)
CALL tracer_halt(substr, status)
CALL set_tracer(status, setname, idt_CO2, I_scav              , ON)
CALL tracer_halt(substr, status)
