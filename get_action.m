function action = get_action(policy, state, epsilon)

action_set_norm = sum(state == '-');

prob = zeros(2, action_set_norm+1);

i = 1;
for j = 1:length(state)
	if state(j) == '-'
		i = i+1;
		if j == policy(state)
			prob(:,i) = [j; 1-epsilon+epsilon/action_set_norm+prob(2,i-1)];
		else
			prob(:,i) = [j; epsilon/action_set_norm+prob(2,i-1)];
		end
	end
end

action = prob(1, sum(rand() > prob(2,:))+1);

end