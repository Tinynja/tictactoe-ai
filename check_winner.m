function winner = check_winner(state)
%CHECK_GAME_END Given a state, this function verifies if the TicTacToe
%game is over

winner = [];

for i = 1:3
	if all(state((i-1)*3+1:i*3) == state(i*3)) && state(i*3) ~= '-'
		winner = state(i*3);
	elseif all(state([i 3+i 6+i]) == state(i)) && state(i) ~= '-'
		winner = state(i);
	elseif i < 3 && all(state([1+2*(i-1) 5 9-2*(i-1)]) == state(5)) && state(5) ~= '-'
		winner = state(5);
	end
end

if isempty(winner)
	if any(state == '-')
		winner = 0;
	else
		winner = 't';
	end
end

end

