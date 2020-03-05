function action = generate_action(index, policy, state)

action_set_norm = sum(state == '-');

prob = zeros(2, action_set_norm+1);

i = 1;
for j = 1:length(state)
	if state(j) == '-'
		i = i+1;
		if isKey(index, state)
			if j == policy(index(state))
				prob(:,i) = [j; prob(2,i-1)+1-policy(1)+policy(1)/action_set_norm];
			else
				prob(:,i) = [j; prob(2,i-1)+policy(1)/action_set_norm];
			end
		else
			prob(:,i) = [j; prob(2,i-1)+1/action_set_norm];
		end
	end
end

action = prob(1, sum(rand() >= prob(2,:))+1);

end