function [episode_1, episode_2] = generate_episode(index_p1, policy_p1, index_p2, policy_p2, state_0, first_round)
%GENERATE_EPISODE Generates a TicTacToe episode based on the given policy

state = state_0;
turn = first_round;

episode_1 = cell(3,1);
episode_2 = cell(3,1);

i = 0;
j = 0;
result = 0;
while ~result
	if turn == 1
		i = i+1;
		if i ~= 1; episode_1{3,i-1} = 0; end
		episode_1{1,i} = state;
		episode_1{2,i} = generate_action(index_p1, policy_p1, episode_1{1,i});
		state(episode_1{2,i}) = 'x';
	elseif turn == 2
		j = j+1;
		if j ~= 1; episode_2{3,j-1} = 0; end
		episode_2{1,j} = state;
		episode_2{2,j} = generate_action(index_p2, policy_p2, episode_2{1,j});
		state(episode_2{2,j}) = 'o';
	end
	result = check_winner(state);
	turn = ~(turn-1) + 1;
end

if result == 't'
	episode_1{3,end} = 0;
	episode_2{3,end} = 0;
else
	if turn == 1 %Meaning Player 2 is the last one who played
		episode_1{3,end} = -1;
		episode_2{3,end} = 1;
	elseif turn == 2 %Meaning Player 1 is the last one who played
		episode_1{3,end} = 1;
		episode_2{3,end} = -1;
	end
end

episode_1{1,end+1} = state;
episode_2{1,end+1} = state;




% while ~
% 	i = i+1;
% 	
% 	episode{1,i} = state;
% 	episode{2,i} = generate_action(index_p1, policy_p1, episode{1,i});
% 	state(episode{2,i}) = 'x';
% 	
% 	win_state = check_winner(state);
% 	if win_state == 'x'
% 		episode{3,i} = 1;
% 		break
% 	else
% 		episode{3,i} = 0;
% 		if win_state == 't'
% 			break
% 		end
% 	end
% 	
% 	state(generate_action(index_p2, policy_p2, state)) = 'o';
% 	
% 	win_state = check_winner(state);
% 	if win_state == 'o'
% 		episode{3,i} = -1;
% 		break
% 	else
% 		episode{3,i} = 0;
% 		if win_state == 't'
% 			break
% 		end
% 	end
% end
% 
% episode{1,end+1} = state;

end

