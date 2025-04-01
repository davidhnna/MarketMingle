function users = preferences(users, userIndex)
    % Display current preferences
    fprintf('\nCurrent Preferences for %s:\n', users{userIndex, 1});
    preferences = users{userIndex, 4};  % Assume preferences are stored in column 4
    fprintf('Price Range: $%.2f - $%.2f\n', preferences.PriceRange(1), preferences.PriceRange(2));
    fprintf('Preferred Category: %s\n', preferences.Category);
    fprintf('Preferred Condition: %s\n', preferences.Condition);
    
    % Ask the user if they want to update their preferences
    update = input('\nWould you like to update your preferences? (y/n): ', 's');
    if lower(update) == 'y'
        % Get new preferences from the user
        fprintf('\nEnter new preferences:\n');
    
        minPrice = input('Enter new min price: ');
        maxPrice = input('Enter new max price: ');
        category = input('Enter preferred category: ', 's');
        condition = input('Enter preferred condition: ', 's');
    
        % Store new preferences
        users{userIndex, 4} = struct('PriceRange', [minPrice, maxPrice], ...
                                     'Category', category, ...
                                     'Condition', condition);
    
        fprintf('Your preferences have been updated.\n');
    else
        fprintf('No changes were made to your preferences.\n');
    end
end
