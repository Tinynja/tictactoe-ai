fprintf('You are playing as O''s.\n')
policy_1(1) = 0;
debug = 1;

while true

board = '---------';

in = 'junk';
while ~any(strcmp(in, ["y" "n" "" "exit"]))
	in = lower(input('Would you like to start (Y/n/exit)? ', 's'));
end

if strcmp(in, 'exit')
	break
elseif strcmp(in, 'n')
	board(generate_action(index_1, policy_1, board)) = 'x';
end

while 1
	moves = zeros(1, sum(board == '-'));
	j = 0;
	for i = 1:length(board)
		j = j+1;
		if board(i) == '-'
			moves(j) = i;
		end
	end
	moves = string(moves);
	
	in = 'junk';
	while ~any(strcmp(in, moves))
		fprintf('\n');
		print_board(board);
		in = lower(input('What''s your next move? ', 's'));
	end
	in = str2double(in);
	board(in) = 'o';
	
	win_state = check_winner(board);
	if win_state == 'o'
		fprintf('Congratulations, you won!\n');
		break
	else
		if win_state == 't'
			fprintf('It''s a tie!\n');
			break
		end
	end
	
	if debug; check_state(index_1,policy_1,action_values,board); end
	board(generate_action(index_1, policy_1, board)) = 'x';
	win_state = check_winner(board);
	if win_state == 'x'
			fprintf('Whoops, you lost!\n');
		break
	else
		if win_state == 't'
			fprintf('It''s a tie!\n');
			break
		end
	end
end

end