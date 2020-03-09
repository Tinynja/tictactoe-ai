function [index, policy, action_values] = update_agent(episode, gamma, index, policy, action_values)

G = 0;
for i = size(episode,2)-1:-1:1
	G = gamma*G + episode{3,i};
	
	if all(cellfun(@(x) ~strcmp(x,episode{1,i}), episode(1,1:i-1), 'UniformOutput', true))
		% Create state if it doesn't exist
		[index, action_values] = add_state(episode{1,i}, index, action_values);

		% Reads the present values in order to lighten the code
		action_index = find(action_values{index(episode{1,i})}(:,1) == episode{2,i});
		action_value = action_values{index(episode{1,i})}(action_index,2);
		visits = action_values{index(episode{1,i})}(action_index,3);

		% Recalculate the mean value of the action and update the number of
		% visits
		action_values{index(episode{1,i})}(action_index,2) = (action_value*visits+G)/(visits+1);
		action_values{index(episode{1,i})}(action_index,3) = visits+1;

		% Update the policy by taking the max(action_value)
		action_index = find(action_values{index(episode{1,i})}(:,2) == max(action_values{index(episode{1,i})}(:,2)), 1);
		policy(index(episode{1,i})) = action_values{index(episode{1,i})}(action_index,1);
	end

end

end