local melee_challenge = RegisterMod("Beat 'Em Up", 1)
local item = Isaac.GetItemIdByName("Spear Of Destiny")
local game = Game()

debugText = "This does not work"

local Challenges = {
	CHALLENGE_MELEE = Isaac.GetChallengeIdByName("Beat 'Em Up")
}

local stats = {
    DAMAGE = -1.75,
    LUCK = 0.5
}

function melee_challenge:hasSpear(player)
	local player = Isaac.GetPlayer(0)

	if player:HasCollectible(item) == true then
		debugText = "This works"
	end
end


function melee_challenge:useSpear(player)
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(item) == true then
		EntityTear:Scale(EntityRef(player), 120, 1.0)
	end
end

function stats:onCache(player, cacheFlag)
	if game.Challenge == Challenges.CHALLENGE_MELEE then 
		player = Isaac.GetPlayer(0)
		--if player:GetName() == "stats" then
		    if cacheFlag == CacheFlag.CACHE_DAMAGE then
		        player.Damage = player.Damage + stats.DAMAGE
		    end
		    if cacheFlag == CacheFlag.CACHE_LUCK then
		        player.Luck = player.Luck + stats.LUCK
		    end
    end
end

function melee_challenge:debugText()
    Isaac.RenderText(debugText, 100, 100, 255, 0, 0, 255)
end

melee_challenge:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, stats.onCache)
melee_challenge:AddCallback(ModCallbacks.MC_POST_UPDATE, melee_challenge.hasSpear, EntityType.ENTITY_PLAYER);
melee_challenge:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, melee_challenge.useSpear);
melee_challenge:AddCallback(ModCallbacks.MC_POST_RENDER, melee_challenge.debugText);