*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description Copy of fbask_jan16, but with regression calibrated to regional labor costs.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/70_livestock/fbask_regcost_feb22/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/70_livestock/fbask_regcost_feb22/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/70_livestock/fbask_regcost_feb22/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/70_livestock/fbask_regcost_feb22/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/70_livestock/fbask_regcost_feb22/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/70_livestock/fbask_regcost_feb22/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/70_livestock/fbask_regcost_feb22/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
