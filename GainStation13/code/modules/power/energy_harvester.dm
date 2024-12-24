
/obj/machinery/power/energy_harvester
	desc = "A Device which upon connection to a node, will harvest the energy and send it to engineerless stations in return for credits, derived from a syndicate powersink model. The instructions say to never use more than 4 harvesters at a time."
	name = "Energy Harvesting Module"
	density = FALSE
	use_power = NO_POWER_USE
	anchored = FALSE
	circuit = /obj/item/circuitboard/machine/energy_harvester

	var/maximum_net_drain_percentage = 0.05
	var/credit_conversion_rate = 0.00002

/obj/machinery/power/rad_collector/anchored
	anchored = TRUE

/obj/machinery/power/energy_harvester/Initialize(mapload)
	. = ..()
	RefreshParts()
	if(anchored)
		connect_to_network()

/obj/machinery/power/emitter/RefreshParts()
	var/drain_modifier = 0.0125
	var/credit_conversion_efficiency = 0.0000025
	var/capacitor_rating = 0
	var/manipulator_rating = 0

	for(var/obj/item/stock_parts/capacitor/capacitor in component_parts)
		capacitor_rating += capacitor.rating
	maximum_net_drain_percentage = capacitor_rating * drain_modifier

	for(var/obj/item/stock_parts/manipulator/manipulator in component_parts)
		manipulator_rating += manipulator.rating
	credit_conversion_rate = credit_conversion_efficiency * manipulator_rating

/obj/item/circuitboard/machine/energy_harvester
	name = "Energy Harvester (Machine Board)"
	build_path = /obj/machinery/adipoelectric_transformer
	req_components = list(
		/obj/item/stock_parts/capacitor = 4,
		/obj/item/stock_parts/manipulator = 2)
