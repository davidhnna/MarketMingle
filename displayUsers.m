function displayUsers(users)
    % DISPLAYUSERS - Displays all registered users in a clear format.

    % Check if the users array is empty
    if isempty(users)
        fprintf('No registered users found.\n');
        return;
    end

    % Display table header
    fprintf('\n%-20s %-25s %-15s %-30s\n', ...
        'Name', 'Email', 'Location', 'Preferences');
    fprintf(repmat('-', 1, 90)); % Divider
    fprintf('\n');

    % Loop through the users cell array and display each user
    for i = 1:size(users, 1)
        name = users{i, 1};
        email = users{i, 2};
        location = users{i, 3};
        preferences = users{i, 4};

        % Format preferences as text
        prefText = sprintf('Price: %d-%d, %s, %s', ...
            preferences.PriceRange(1), preferences.PriceRange(2), ...
            preferences.Category, preferences.Condition);

        % Display user info
        fprintf('%-20s %-25s %-15s %-30s\n', ...
            name, email, location, prefText);
    end
    fprintf('\n');
end
