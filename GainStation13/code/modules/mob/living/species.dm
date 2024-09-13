/datum/species/proc/handle_fatness_trait(mob/living/carbon/human/H, trait, trait_lose, trait_gain, fatness_lose, fatness_gain, chat_lose, chat_gain)
	if(H.fatness < fatness_lose)
		if (chat_lose)
			to_chat(H, chat_lose)
		if (trait)
			REMOVE_TRAIT(H, trait, OBESITY)
		if (trait_lose)
			ADD_TRAIT(H, trait_lose, OBESITY)
		update_body_size(H, -1)
	else if(H.fatness >= fatness_gain)
		if (chat_gain)
			to_chat(H, chat_gain)
		if (trait)
			REMOVE_TRAIT(H, trait, OBESITY)
		if (trait_gain)
			ADD_TRAIT(H, trait_gain, OBESITY)
		update_body_size(H, 1)

/datum/species/proc/handle_helplessness(mob/living/carbon/human/fatty)
	var/datum/preferences/preferences = fatty?.client?.prefs
	if(!istype(preferences))
		return FALSE

	if(preferences.helplessness_no_movement)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_no_movement)
				to_chat(fatty, "<span class='warning'>You have become too fat to move anymore.</span>")
				ADD_TRAIT(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_no_movement)
			to_chat(fatty, "<span class='notice'>You have become thin enough to regain some of your mobility.</span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_clumsy)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_clumsy)
				to_chat(fatty, "<span class='warning'>Your newfound weight has made it hard to manipulate objects.</span>")
				ADD_TRAIT(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_clumsy)
			to_chat(fatty, "<span class='notice'>You feel like you have lost enough weight to recover your dexterity.</span>")
			REMOVE_TRAIT(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_nearsighted)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NEARSIGHT, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_nearsighted)
				to_chat(fatty, "<span class='warning'>Your fat makes it difficult to see the world around you. </span>")
				fatty.become_nearsighted(HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_nearsighted)
			to_chat(fatty, "<span class='notice'>You are thin enough to see your enviornment again. </span>")
			fatty.cure_nearsighted(HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NEARSIGHT, HELPLESSNESS_TRAIT))
			fatty.cure_nearsighted(HELPLESSNESS_TRAIT)


	if(preferences.helplessness_hidden_face)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_hidden_face)
				to_chat(fatty, "<span class='warning'>You have gotten fat enough that your face is now unrecognizable. </span>")
				ADD_TRAIT(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_hidden_face)
			to_chat(fatty, "<span class='notice'>You have lost enough weight to allow people to now recognize your face.</span>")
			REMOVE_TRAIT(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_mute)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_mute)
				to_chat(fatty, "<span class='warning'>Your fat makes it impossible for you to speak.</span>")
				ADD_TRAIT(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_mute)
			to_chat(fatty, "<span class='notice'>You are thin enough now to be able to speak again. </span>")
			REMOVE_TRAIT(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_immobile_arms)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_immobile_arms)
				to_chat(fatty, "<span class='warning'>Your arms are now engulfed in fat, making it impossible to move your arms. </span>")
				ADD_TRAIT(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT)
				ADD_TRAIT(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
				fatty.update_disabled_bodyparts()

		else if(fatty.fatness < preferences.helplessness_immobile_arms)
			to_chat(fatty, "<span class='notice'>You are able to move your arms again. </span>")
			REMOVE_TRAIT(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT)
			REMOVE_TRAIT(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
			fatty.update_disabled_bodyparts()

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT)
			REMOVE_TRAIT(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
			fatty.update_disabled_bodyparts()

	if(preferences.helplessness_clothing_jumpsuit)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_clothing_jumpsuit)
				ADD_TRAIT(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT)

				var/obj/item/clothing/under/jumpsuit = fatty.w_uniform
				if(istype(jumpsuit) && !istype(jumpsuit, /obj/item/clothing/under/color/grey/modular))
					to_chat(fatty, "<span class='warning'>[jumpsuit] can no longer contain your weight!</span>")
					fatty.dropItemToGround(jumpsuit)

		else if(fatty.fatness < preferences.helplessness_clothing_jumpsuit)
			to_chat(fatty, "<span class='notice'>You feel thin enough to put on jumpsuits now. </span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_clothing_misc)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_clothing_misc)
				ADD_TRAIT(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT)

				var/obj/item/clothing/suit/worn_suit = fatty.wear_suit
				if(istype(worn_suit))
					to_chat(fatty, "<span class='warning'>[worn_suit] can no longer contain your weight!</span>")
					fatty.dropItemToGround(worn_suit)

				var/obj/item/clothing/gloves/worn_gloves = fatty.gloves
				if(istype(worn_gloves))
					to_chat(fatty, "<span class='warning'>[worn_gloves] can no longer contain your weight!</span>")
					fatty.dropItemToGround(worn_gloves)

				var/obj/item/clothing/shoes/worn_shoes = fatty.shoes
				if(istype(worn_shoes))
					to_chat(fatty, "<span class='warning'>[worn_shoes] can no longer contain your weight!</span>")
					fatty.dropItemToGround(worn_shoes)

		else if(fatty.fatness < preferences.helplessness_clothing_misc)
			to_chat(fatty, "<span class='notice'>You feel thin enough to put on suits, shoes, and gloves now. </span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_clothing_back)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_clothing_back)
				ADD_TRAIT(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT)
				var/obj/item/back_item = fatty.back
				if(istype(back_item))
					to_chat(fatty, "<span class='warning'>Your weight makes it impossible for you to carry [back_item].</span>")
					fatty.dropItemToGround(back_item)

		else if(fatty.fatness < preferences.helplessness_clothing_back)
			to_chat(fatty, "<span class='notice'>You feel thin enough to hold items on your back now. </span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_no_buckle)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_no_buckle)
				to_chat(fatty, "<span class='warning'>You feel like you've gotten too big to fit on anything.</span>")
				ADD_TRAIT(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_no_buckle)
			to_chat(fatty, "<span class='notice'>You feel thin enough to sit on things again. </span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT)


/datum/species/proc/handle_fatness(mob/living/carbon/human/H)
	handle_helplessness(H)
	if(HAS_TRAIT(H, TRAIT_BLOB))
		handle_fatness_trait(
			H,
			TRAIT_BLOB,
			TRAIT_IMMOBILE,
			null,
			FATNESS_LEVEL_BLOB,
			INFINITY,
			"<span class='notice'>You feel like you've regained some mobility!</span>",
			null)
		return
	if(HAS_TRAIT(H, TRAIT_IMMOBILE))
		handle_fatness_trait(
			H,
			TRAIT_IMMOBILE,
			TRAIT_BARELYMOBILE,
			TRAIT_BLOB,
			FATNESS_LEVEL_IMMOBILE,
			FATNESS_LEVEL_BLOB,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you've become a mountain of fat!</span>")
		return
	if(HAS_TRAIT(H, TRAIT_BARELYMOBILE))
		handle_fatness_trait(
			H,
			TRAIT_BARELYMOBILE,
			TRAIT_EXTREMELYOBESE,
			TRAIT_IMMOBILE,
			FATNESS_LEVEL_BARELYMOBILE,
			FATNESS_LEVEL_IMMOBILE,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel belly smush against the floor!</span>")
		return
	if(HAS_TRAIT(H, TRAIT_EXTREMELYOBESE))
		handle_fatness_trait(
			H,
			TRAIT_EXTREMELYOBESE,
			TRAIT_MORBIDLYOBESE,
			TRAIT_BARELYMOBILE,
			FATNESS_LEVEL_EXTREMELY_OBESE,
			FATNESS_LEVEL_BARELYMOBILE,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you can barely move!</span>")
		return
	if(HAS_TRAIT(H, TRAIT_MORBIDLYOBESE))
		handle_fatness_trait(
			H,
			TRAIT_MORBIDLYOBESE,
			TRAIT_OBESE,
			TRAIT_EXTREMELYOBESE,
			FATNESS_LEVEL_MORBIDLY_OBESE,
			FATNESS_LEVEL_EXTREMELY_OBESE,
			"<span class='notice'>You feel a bit less fat!</span>",
			"<span class='danger'>You feel your belly rest heavily on your lap!</span>")
		return
	if(HAS_TRAIT(H, TRAIT_OBESE))
		handle_fatness_trait(
			H,
			TRAIT_OBESE,
			TRAIT_VERYFAT,
			TRAIT_MORBIDLYOBESE,
			FATNESS_LEVEL_OBESE,
			FATNESS_LEVEL_MORBIDLY_OBESE,
			"<span class='notice'>You feel like you've lost weight!</span>",
			"<span class='danger'>Your thighs begin to rub against each other.</span>")
		return
	if(HAS_TRAIT(H, TRAIT_VERYFAT))
		handle_fatness_trait(
			H,
			TRAIT_VERYFAT,
			TRAIT_FATTER,
			TRAIT_OBESE,
			FATNESS_LEVEL_VERYFAT,
			FATNESS_LEVEL_OBESE,
			"<span class='notice'>You feel like you've lost weight!</span>",
			"<span class='danger'>You feel like you're starting to get really heavy.</span>")
		return
	if(HAS_TRAIT(H, TRAIT_FATTER))
		handle_fatness_trait(
			H,
			TRAIT_FATTER,
			TRAIT_FAT,
			TRAIT_VERYFAT,
			FATNESS_LEVEL_FATTER,
			FATNESS_LEVEL_VERYFAT,
			"<span class='notice'>You feel like you've lost weight!</span>",
			"<span class='danger'>Your clothes creak quietly!</span>")
		return
	if(HAS_TRAIT(H, TRAIT_FAT))
		handle_fatness_trait(
			H,
			TRAIT_FAT,
			null,
			TRAIT_FATTER,
			FATNESS_LEVEL_FAT,
			FATNESS_LEVEL_FATTER,
			"<span class='notice'>You feel fit again!</span>",
			"<span class='danger'>You feel even plumper!</span>")
	else
		handle_fatness_trait(
			H,
			null,
			null,
			TRAIT_FAT,
			0,
			FATNESS_LEVEL_FAT,
			null,
			"<span class='danger'>You suddenly feel blubbery!</span>")

/datum/species/proc/handle_digestion(mob/living/carbon/human/H)
	if(HAS_TRAIT(src, TRAIT_NOHUNGER))
		return //hunger is for BABIES

	handle_fatness(H) // GS13

	// nutrition decrease and satiety
	if (H.nutrition > 0 && H.stat != DEAD && !HAS_TRAIT(H, TRAIT_NOHUNGER))
		// THEY HUNGER
		var/hunger_rate = HUNGER_FACTOR
		var/datum/component/mood/mood = H.GetComponent(/datum/component/mood)
		if(mood && mood.sanity > SANITY_DISTURBED)
			hunger_rate *= max(0.5, 1 - 0.002 * mood.sanity) //0.85 to 0.75

		// Whether we cap off our satiety or move it towards 0
		if(H.satiety > MAX_SATIETY)
			H.satiety = MAX_SATIETY
		else if(H.satiety > 0)
			H.satiety--
		else if(H.satiety < -MAX_SATIETY)
			H.satiety = -MAX_SATIETY
		else if(H.satiety < 0)
			H.satiety++
			if(prob(round(-H.satiety/40)))
				H.Jitter(5)
			hunger_rate = 3 * HUNGER_FACTOR
		hunger_rate *= H.physiology.hunger_mod
		H.nutrition = max(0, H.nutrition - hunger_rate)


	if (H.nutrition > NUTRITION_LEVEL_FULL)
		// fatConversionRate is functionally useless. It seems under normal curcumstances, each tick only processes, at most, 1 nutrition anyway. reducing the value has no effect.
		var/fatConversionRate = 100 //GS13 what percentage of the excess nutrition should go to fat (total nutrition to transfer can't be under 1)
		var/nutritionThatBecomesFat = max((H.nutrition - NUTRITION_LEVEL_FULL)*(fatConversionRate / 100),1)
		H.nutrition -= nutritionThatBecomesFat
		H.adjust_fatness(nutritionThatBecomesFat, FATTENING_TYPE_FOOD)
	if(H.fullness > FULLNESS_LEVEL_EMPTY)//GS13 stomach-emptying routine
		var/ticksToEmptyStomach = 20 // GS13 how many ticks it takes to decrease the fullness by 1
		if(HAS_TRAIT(H, TRAIT_VORACIOUS))
			ticksToEmptyStomach = ticksToEmptyStomach * 0.5
		H.fullness -= 1/ticksToEmptyStomach
	if (H.fullness > FULLNESS_LEVEL_BLOATED) //GS13 overeating depends on fullness now
		if(H.overeatduration < 5000) //capped so people don't take forever to unfat
			H.overeatduration++
	else
		if(H.overeatduration > 1)
			H.overeatduration -= 1 //doubled the unfat rate -- GS13 Nah, put it back

	//metabolism change
	if(H.nutrition > NUTRITION_LEVEL_FULL +100)
		H.metabolism_efficiency = 1
	else if(H.nutrition > NUTRITION_LEVEL_FED && H.satiety > 80)
		if(H.metabolism_efficiency != 1.25 && !HAS_TRAIT(H, TRAIT_NOHUNGER))
			to_chat(H, "<span class='notice'>You feel vigorous.</span>")
			H.metabolism_efficiency = 1.25
	else if(H.nutrition < NUTRITION_LEVEL_STARVING + 50)
		if(H.metabolism_efficiency != 0.8)
			to_chat(H, "<span class='notice'>You feel sluggish.</span>")
		H.metabolism_efficiency = 0.8
	else
		if(H.metabolism_efficiency == 1.25)
			to_chat(H, "<span class='notice'>You no longer feel vigorous.</span>")
		H.metabolism_efficiency = 1

	switch(H.nutrition)
		if(NUTRITION_LEVEL_HUNGRY to NUTRITION_LEVEL_FULL)
			H.clear_alert("nutrition")
		if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_HUNGRY)
			H.throw_alert("nutrition", /obj/screen/alert/hungry)
		if(0 to NUTRITION_LEVEL_STARVING)
			H.throw_alert("nutrition", /obj/screen/alert/starving)

	switch(H.fullness)
		if(0 to FULLNESS_LEVEL_BLOATED)
			H.clear_alert("fullness")
		if(FULLNESS_LEVEL_BLOATED to FULLNESS_LEVEL_BEEG)
			H.throw_alert("fullness", /obj/screen/alert/bloated)
		if(FULLNESS_LEVEL_BEEG to FULLNESS_LEVEL_NOMOREPLZ)
			H.throw_alert("fullness", /obj/screen/alert/stuffed)
		if(FULLNESS_LEVEL_NOMOREPLZ to INFINITY)
			H.throw_alert("fullness", /obj/screen/alert/beegbelly)


	switch(H.fatness)
		if(FATNESS_LEVEL_BLOB to INFINITY)
			H.throw_alert("fatness", /obj/screen/alert/blob)

		if(FATNESS_LEVEL_IMMOBILE to FATNESS_LEVEL_BLOB)
			H.throw_alert("fatness", /obj/screen/alert/immobile)

		if(FATNESS_LEVEL_BARELYMOBILE to FATNESS_LEVEL_IMMOBILE)
			H.throw_alert("fatness", /obj/screen/alert/barelymobile)

		if(FATNESS_LEVEL_EXTREMELY_OBESE to FATNESS_LEVEL_BARELYMOBILE)
			H.throw_alert("fatness", /obj/screen/alert/extremelyobese)

		if(FATNESS_LEVEL_MORBIDLY_OBESE to FATNESS_LEVEL_EXTREMELY_OBESE)
			H.throw_alert("fatness", /obj/screen/alert/morbidlyobese)

		if(FATNESS_LEVEL_OBESE to FATNESS_LEVEL_MORBIDLY_OBESE)
			H.throw_alert("fatness", /obj/screen/alert/obese)

		if(FATNESS_LEVEL_VERYFAT to FATNESS_LEVEL_OBESE)
			H.throw_alert("fatness", /obj/screen/alert/veryfat)

		if(FATNESS_LEVEL_FATTER to FATNESS_LEVEL_VERYFAT)
			H.throw_alert("fatness", /obj/screen/alert/fatter)

		if(FATNESS_LEVEL_FAT to FATNESS_LEVEL_FATTER)
			H.throw_alert("fatness", /obj/screen/alert/fat)

		if(0 to FATNESS_LEVEL_FAT)
			H.clear_alert("fatness")
