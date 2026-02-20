RLMedium = {}

modDirectory = g_currentModDirectory
modSettingsDirectory = g_currentModSettingsDirectory


local files = {
	"scripts/animals/events/AnimalRidingEvent.lua",
	"scripts/animals/husbandry/cluster/AnimalClusterHusbandry.lua",
	"scripts/animals/husbandry/placeables/PlaceableHusbandryAnimals.lua",
	"scripts/animals/husbandry/HusbandrySystem.lua",
	"scripts/gui/VisualAnimalsDialog.lua",
	"scripts/handTools/specializations/HandToolHorseBrush.lua",
	"scripts/player/PlayerHUDUpdater.lua",
	"scripts/player/PlayerInputComponent.lua",
	"scripts/FSBaseMission.lua"
}


function RLMedium.loadMap()

	local conflictingMods = {
		"FS25_RealisticLivestock",
		"FS25_RealisticLivestockRM",
		"FS25_MoreVisualAnimals",
		"FS25_EnhancedLivestock",
	}

	local hasConflict = false
	for _, modName in ipairs(conflictingMods) do
		if g_modIsLoaded[modName] then
			hasConflict = true
			break
		end
	end

	if not hasConflict then

		for _, file in pairs(files) do source(modDirectory .. file) end

		local xmlFile = XMLFile.loadIfExists("visualAnimalsCap", modSettingsDirectory .. "visualAnimals.xml")

		if xmlFile ~= nil then

			MVA_AnimalClusterHusbandry.MAX_HUSBANDRIES = xmlFile:getInt("settings#limit", 50)

			xmlFile:delete()

		end

	end

end

addModEventListener(RLMedium)