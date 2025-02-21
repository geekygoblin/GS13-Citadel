#define DRAIN_MODIFIER 0.0125
#define CREDIT_CONVERSION_EFFICIENCY 0.0000025


/obj/machinery/power/energy_harvester
	desc = "A Device which upon connection to a node, will harvest the energy and send it to engineerless stations in return for credits, derived from a syndicate powersink model. The instructions say to never use more than 4 harvesters at a time."
	name = "Energy Harvesting Module"
	density = FALSE
	use_power = NO_POWER_USE
	// anchored = FALSE
	icon = 'GainStation13/icons/obj/adipoelectric_transformer.dmi'
	icon_state = "state_off"
	circuit = /obj/item/circuitboard/machine/energy_harvester
	

	var/maximum_net_drain_percentage = 0.05
	var/set_power_drain = 0.05
	var/credit_conversion_rate = 0.00002
	var/power_avaliable = 0
	// var/obj/structure/cable/attached

/obj/machinery/power/energy_harvester/Initialize(mapload)
	. = ..()
	RefreshParts()
	if(anchored)
		connect_to_network()

/obj/machinery/power/energy_harvester/RefreshParts()
	var/capacitor_rating = 0
	var/manipulator_rating = 0

	for(var/obj/item/stock_parts/capacitor/capacitor in component_parts)
		capacitor_rating += capacitor.rating
	maximum_net_drain_percentage = capacitor_rating * DRAIN_MODIFIER

	for(var/obj/item/stock_parts/manipulator/manipulator in component_parts)
		manipulator_rating += manipulator.rating
	credit_conversion_rate = manipulator_rating * CREDIT_CONVERSION_EFFICIENCY

/obj/machinery/power/energy_harvester/process()
	if(!is_operational())
		return

	if(!powernet)
		return

	power_avaliable = avail()
	if(power_avaliable <= 0)
		return

	var/power_drain = power_avaliable * set_power_drain
	add_load(power_drain)
	var/credits_earned = credit_conversion_rate * power_drain

	var/datum/bank_account/engineering_budget = SSeconomy.get_dep_account(ACCOUNT_ENG)
	if(engineering_budget)
		engineering_budget.adjust_money(credits_earned / 2)

	var/datum/bank_account/cargo_budget = SSeconomy.get_dep_account(ACCOUNT_CAR)
	if(cargo_budget)
		cargo_budget.adjust_money(credits_earned / 2)
	


/obj/machinery/power/energy_harvester/default_unfasten_wrench(mob/user, obj/item/I, time = 20)
	. = ..()
	if(. == SUCCESSFUL_UNFASTEN)
		if(anchored)
			connect_to_network()

/obj/machinery/power/energy_harvester/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	default_deconstruction_screwdriver(user, "state_open", "state_off", I)
	return TRUE

/obj/item/circuitboard/machine/energy_harvester
	name = "Energy Harvester (Machine Board)"
	build_path = /obj/machinery/power/energy_harvester
	req_components = list(
		/obj/item/stock_parts/capacitor = 4,
		/obj/item/stock_parts/manipulator = 2)


#undef DRAIN_MODIFIER
#undef CREDIT_CONVERSION_EFFICIENCY
