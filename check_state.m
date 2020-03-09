function check_state(index, policy, action_values, state)

keys_index = find(cellfun(@(x) strcmp(x,state), keys(index), 'UniformOutput', true), 1);

if isempty(keys_index)
	warning('State not found.');
else
	values_index = values(index);
	policy_index = values_index{keys_index};

	A_star = policy(policy_index);

	fprintf('''%s'': index=%d, A*=%d, action_values:\n', state, policy_index, A_star);
	disp(action_values{policy_index})
end

end