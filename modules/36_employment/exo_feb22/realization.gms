*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization calculates agricultural employment based
*' on it's relation to labor costs. It therefore depends on the labor costs
*' calculated in the modules [38_factor_costs] and [70_livestock], but does 
*' not affect resulting total costs or production patterns.

*' @limitations Labor availability is not seen as a limiting factor for
*' agricultural production, the number of people employed is solely based
*' on labor costs which scale with the amount of production. Furthermore, 
*' hourly labor costs are projected into the future following current trends,
*' while factor requirements for crops (i.e. labor + capital costs per production 
*' unit) are kept constant. This means, that any increase in wages is assumed to 
*' be matched by a corresponding increase in labor productivity. 


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/36_employment/exo_feb22/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/36_employment/exo_feb22/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/36_employment/exo_feb22/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/36_employment/exo_feb22/equations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/36_employment/exo_feb22/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/36_employment/exo_feb22/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
