*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*define ac_est and ac_sub
ac_est(ac) = no;
ac_est(ac) = yes$(ord(ac) <= (m_yeardiff_forestry(t)/5));

ac_sub(ac) = no;
ac_sub(ac) = yes$(ord(ac) > (m_yeardiff_forestry(t)/5));

*Reduction of ac_est is not possible.
v32_hvarea_forestry.fx(j,ac_est) = 0;
v32_land_reduction.fx(j,type32,ac_est) = 0;

** Start ndc **
* Limit demand for prescribed NPI/NDC afforestation in `p32_aff_pol` if not enough suitable area (`p32_aff_pot`) for afforestation is available.
   p32_aff_pot(t,j) = (vm_land.l(j,"crop") - vm_land.lo(j,"crop")) + (vm_land.l(j,"past") - vm_land.lo(j,"past"));
*correct ndc forest stock based on p32_aff_pot
  if((ord(t) > 1),
      p32_aff_pol(t,j)$(p32_aff_pol(t,j) - p32_aff_pol(t-1,j) > p32_aff_pot(t,j)) = p32_aff_pol(t-1,j) + p32_aff_pot(t,j);
    );
*calc ndc afforestation per time step based on forest stock changes
  p32_aff_pol_timestep("y1995",j) = 0;
  p32_aff_pol_timestep(t,j)$(ord(t)>1) = p32_aff_pol(t,j) - p32_aff_pol(t-1,j);

if(m_year(t) <= sm_fix_SSP2,
 p32_max_aff_area = Inf;
else
 p32_max_aff_area = s32_max_aff_area;
);
** END ndc **

*' @code

*' Afforestation switch:
*' 0 = Use natveg carbon densities for afforestation,
*' 1 = Use plantation carbon densities for afforestation.
if(s32_aff_plantation = 0,
 p32_carbon_density_ac(t,j,"aff",ac,ag_pools) = pm_carbon_density_ac(t,j,ac,ag_pools);
elseif s32_aff_plantation = 1,
 p32_carbon_density_ac(t,j,"aff",ac,ag_pools) = pm_carbon_density_ac_forestry(t,j,ac,ag_pools);
);
*' Timber plantations switch:
*' 0 = Use natveg carbon densities for timber plantations,
*' 1 = Use plantation carbon densities for timber plantations.
if(s32_timber_plantation = 0,
 p32_carbon_density_ac(t,j,"plant",ac,ag_pools) = pm_carbon_density_ac(t,j,ac,ag_pools);
elseif s32_timber_plantation = 1,
 p32_carbon_density_ac(t,j,"plant",ac,ag_pools) = pm_carbon_density_ac_forestry(t,j,ac,ag_pools);
);
*' NDC carbon densities are natveg carbon densities.
p32_carbon_density_ac(t,j,"ndc",ac,ag_pools) = pm_carbon_density_ac(t,j,ac,ag_pools);

*' CDR from afforestation for each age-class, depending on planning horizon.
p32_cdr_ac(t,j,ac)$(ord(ac) > 1 AND (ord(ac)-1) <= s32_planing_horizon/5)
= p32_carbon_density_ac(t,j,"aff",ac,"vegc") - p32_carbon_density_ac(t,j,"aff",ac-1,"vegc");

*' Regrowth of natural vegetation (natural succession) is modelled by shifting
*' age-classes according to time step length. For first year of simulation, the
*' shift is just 1. Division by 5 happends because the age-classes exist in 5 year steps
s32_shift = m_yeardiff_forestry(t)/5;
*' @stop

*' Shifting of age-calsses in land.
*` @code
if((ord(t)=1),
p32_land(t,j,type32,ac)$(ord(ac) > s32_shift) = p32_land_start_ac(j,type32,ac-s32_shift);
p32_land(t,j,type32,"acx") = p32_land(t,j,type32,"acx") + sum(ac$(ord(ac) > card(ac)-s32_shift), p32_land_start_ac(j,type32,ac));
else
* Example: ac10 in t = ac5 (ac10-1) in t-1 for a 5 yr time step (s32_shift = 1)
p32_land(t,j,type32,ac)$(ord(ac) > s32_shift) = p32_land(t-1,j,type32,ac-s32_shift);
* Account for cases at the end of the age class set (s32_shift > 1) which are not shifted by the above calculation
p32_land(t,j,type32,"acx") = p32_land(t,j,type32,"acx") + sum(ac$(ord(ac) > card(ac)-s32_shift), p32_land(t-1,j,type32,ac));
);
* set ac_est to zero
p32_land(t,j,type32,ac_est) = 0;
*' @stop

** Calculate v32_land.l
v32_land.l(j,type32,ac) = p32_land(t,j,type32,ac);
pc32_land(j,type32,ac) = v32_land.l(j,type32,ac);
p32_land_before(t,j,type32,ac) = p32_land(t,j,type32,ac);
vm_land.l(j,"forestry") = sum((type32,ac), v32_land.l(j,type32,ac));
pcm_land(j,"forestry") = sum((type32,ac), v32_land.l(j,type32,ac));

** reset all bounds
v32_land.lo(j,type32,ac) = 0;
v32_land.up(j,type32,ac) = Inf;

if(s32_hvarea = 0,
*** zero. Fixed timber plantations. No harvest. No establisment.
  v32_hvarea_forestry.fx(j,ac_sub) = 0;
  v32_land.fx(j,"plant",ac) = pc32_land(j,"plant",ac);
  s32_establishment_static = 1;
  s32_establishment_dynamic = 0;
elseif s32_hvarea = 1,
*** exogenous. All timber plantations are harvested at rotation age and are re-established such that the total plantation area remains constant.
  v32_land.fx(j,"plant",ac)$(ac.off < p32_rotation_cellular_harvesting(t,j)) = pc32_land(j,"plant",ac);
  v32_land.fx(j,"plant",ac)$(ac.off >= p32_rotation_cellular_harvesting(t,j)) = 0;
  v32_hvarea_forestry.fx(j,ac_sub) = pc32_land(j,"plant",ac_sub) - v32_land.l(j,"plant",ac_sub);
*  $(ac.off >= p32_rotation_cellular_harvesting(t,j)) = pc32_land(j,"plant",ac);
  s32_establishment_static = 1;
  s32_establishment_dynamic = 0;

** Timber plantations can be harvested at rotation age (the economically
** optimal point in time harvesting usually natural forests would be preferred over harvest
** from timber plantations, mainly because the growing stock at rotation age (e.g. 50 years)
** in timber plantations is smaller compared to the growing stock of old-growth primary and
** secondary forest (> 100 years).

elseif s32_hvarea = 2,
*** endogenous. All plantations are harvested at rotation age. Plantation establishment is endogenous.
** Fix timber plantations until the end of the rotation. "ac.off" identical to "ord(ac)-1".
** The offset is needed because the first element of ac is ac0, which is not included in p32_rotation_cellular_harvesting.
  v32_land.fx(j,"plant",ac)$(ac.off < p32_rotation_cellular_harvesting(t,j)) = pc32_land(j,"plant",ac);
** After the rotation period, plantations are free for harvesting
  v32_land.up(j,"plant",ac)$(ac.off >= p32_rotation_cellular_harvesting(t,j)) = pc32_land(j,"plant",ac);
  s32_establishment_static = 0;
  s32_establishment_dynamic = 1;
);
** overwrite bounds for ac_est
v32_land.lo(j,"plant",ac_est) = 0;
v32_land.up(j,"plant",ac_est) = Inf;


** fix ndc afforestation forever, all age-classes are fixed except ac_est
v32_land.fx(j,"ndc",ac_sub) = pc32_land(j,"ndc",ac_sub);
v32_land.lo(j,"ndc",ac_est) = 0;
v32_land.up(j,"ndc",ac_est) = Inf;

** fix c price induced afforestation based on s32_planing_horizon, fixed only until end of s32_planing_horizon, ac_est is free
v32_land.fx(j,"aff",ac)$(ac.off <= s32_planing_horizon/5) = pc32_land(j,"aff",ac);
v32_land.up(j,"aff",ac)$(ac.off > s32_planing_horizon/5) = pc32_land(j,"aff",ac);
v32_land.lo(j,"aff",ac_est) = 0;
v32_land.up(j,"aff",ac_est) = Inf;
v32_land.l(j,"aff",ac_est) = 0;

** Certain areas (e.g. the boreal zone) are excluded from endogenous afforestation.
** DON'T USE TYPE32 SET HERE
if(m_year(t) <= sm_fix_SSP2,
	v32_land.fx(j,"aff",ac_est) = 0;
else
	v32_land.lo(j,"aff",ac_est) = 0;
	v32_land.up(j,"aff",ac_est) = f32_aff_mask(j) * sum(land, pcm_land(j,land));
);
*' No afforestation is allowed if carbon density <= 20 tc/ha
v32_land.fx(j,"aff",ac_est)$(fm_carbon_density(t,j,"forestry","vegc") <= 20) = 0;

m_boundfix(v32_land,(j,type32,ac_sub),up,10e-5);

** Calculate future yield based on rotation length
pc32_yield_forestry_future(j) = sum(ac$(ord(ac) = p32_rotation_cellular_estb(t,j)-1), pm_timber_yield(t,j,ac,"forestry"));

** Display
p32_updated_gs_reg(t,i) = 1;
p32_updated_gs_reg(t,i)$(sum((cell(i,j),ac_sub),p32_land(t,j,"plant",ac_sub))>0) = (sum((cell(i,j),ac_sub),(pm_timber_yield(t,j,ac_sub,"forestry") / sm_wood_density) * p32_land(t,j,"plant",ac_sub))/ sum((cell(i,j),ac_sub),p32_land(t,j,"plant",ac_sub)));

*** EOF presolve.gms ***
