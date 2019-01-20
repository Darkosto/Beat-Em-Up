local melee_challenge = RegisterMod("Beat 'Em Up", 1)
local game = Game()

local Challenges = {
	CHALLENGE_MELEE = Isaac.GetChallengeIdByName("Beat 'Em Up")
}

local stats = {
    DAMAGE = -1.75,
    LUCK = 0.5
}

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

melee_challenge:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, stats.onCache)