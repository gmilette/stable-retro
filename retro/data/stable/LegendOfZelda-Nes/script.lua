-- enemy locations
prev1_x = 0
prev2_x = 0
prev3_x = 0

starting_killed = -1
current_killed = -1
prev_damage = -1

current_map_loc = -1
frame_limit = 4000
frame_quarter = frame_limit / 4

-- todo: clip of most of the top except the hearts display
-- also can clip bottom and left and right because that doesn't change in a level
-- Box(0, 255, (84, 84, 4), uint8)


function zelda_done()
--    return false
    if data.gameMode ~= 5 then
        return true
    end
--    print("data ", pairs(data))
--    for k,v in pairs(data) do
--    	print("key: ", k, " = ", v)
--    end	
--    print("something ", data.mapLoc)
    if data.mapLoc > 0 and data.mapLoc ~= current_map_loc then
    	return true
    end
    
--    if data.mapLoc ~= 114 then
--    	return true
--    end
    
    if (current_killed - starting_killed == 3) then
    	return true
    end
    
    if scenario.frame >= frame_limit then
        return true
    end
    
    return false
end


function zelda_reward()

if (starting_killed == -1) then
 starting_killed = data.killed
 current_killed = data.killed
 current_map_loc = data.mapLoc
end

if (prev_damage == -1) then
 prev_damage = data.damage 
end

--print ("frame", scenario.frame)
-- print ("starting", starting_killed, "current ", current_killed, "data ", data.killed)
if (current_killed ~= data.killed) then
 current_killed = data.killed

return 1
 --[[
 return 1
 if (scenario.frame < 500) then
   return 1
 elseif (scenario.frame < (frame_quarter * 2)) then
   return 0.8
 elseif (scenario.frame < (frame_quarter * 3)) then
   return 0.7
 else
   return 0.6
 end
 --]]

end

if (prev_damage ~= data.damage) then
 prev_damage = data.damage
 return -0.02
end

-- damage -1
-- alive 
-- after 60 sec, score is 60
prev_damage = data.damage
current_killed = data.killed

-- positive reward for attacking near enemy
-- reward for staying alive
    return 0.00001
end
