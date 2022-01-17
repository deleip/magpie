*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization is based on sticky_feb18, but uses regional factor requirements
*' instead of global values. Furthermore, historic values for factor requirements are used up 
*' until 2010, and kept constant afterwards. The aim of this realization is to better match 
*' historic data on labor costs.

*' @limitations 


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/38_factor_costs/sticky_feb18/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/38_factor_costs/sticky_feb18/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/38_factor_costs/sticky_feb18/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/38_factor_costs/sticky_feb18/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/38_factor_costs/sticky_feb18/scaling.gms"
$Ifi "%phase%" == "presolve" $include "./modules/38_factor_costs/sticky_feb18/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/38_factor_costs/sticky_feb18/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
