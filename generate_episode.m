function episode = generate_episode(policy_p1, policy_p2, state_0, first_round)
%GENERATE_EPISODE Generates a TicTacToe episode based on the given policy
%   

state = state_0;

if first_round == 'o'
	state(generate_action(policy_p2, state)) = 'o';
end

episode = cell(3,1);

i = 0;
while 1
	i = i+1;
	
	episode{1,i} = state;
	episode{2,i} = generate_action(policy_p1, episode{1,i});
	state(episode{2,i}) = 'x';
	
	win_state = check_winner(state);
	if win_state == 'x'
		episode{3,i} = 1;
		break
	else
		episode{3,i} = 0;
		if win_state == 't'
			break
		end
	end
	
	state(generate_action(policy_p2, state)) = 'o';
	
	win_state = check_winner(state);
	if win_state == 'o'
		episode{3,i} = -1;
		break
	else
		episode{3,i} = 0;
		if win_state == 't'
			break
		end
	end
end

episode{1,end+1} = state;

end

