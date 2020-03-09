function [index, action_values] = add_state(state, index, action_values)

% Checks if this state has already been visited before
% Otherwise adds the state to the index and to action_values

if ~isKey(index, state)

	index(state) = size(action_values,2)+2;
	action_values{index(state)} = zeros(sum(state=='-'), 3);
	
	all_actions = 1:9;
	action_values{index(state)}(:,1) = all_actions(state == '-');

end

end