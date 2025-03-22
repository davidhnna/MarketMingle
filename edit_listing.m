% edit_listing.m - Edit or Remove Listings using Cell Arrays

function listings = edit_listing(users, listings)
    if isempty(users)
        fprintf('No registered users. Please register first.\n');
        return;
    end

    if isempty(listings)
        fprintf('No listings available. Create a listing first.\n');
        return;
    end

    userID = input('Enter your User ID: ');
    userIndex = find(cell2mat(users(:, 1)) == userID, 1);

    if isempty(userIndex)
        fprintf('User not found.\n');
        return;
    end

    % Display user's listings
    userListings = find(cell2mat(listings(:, 6)) == userID);
    if isempty(userListings)
        fprintf('You have no listings to edit or remove.\n');
        return;
    end

    fprintf('Your Listings:\n');
    for i = 1:length(userListings)
        idx = userListings(i);
        fprintf('%d. %s - $%.2f (%s)\n', idx, listings{idx, 2}, listings{idx, 3}, listings{idx, 4});
    end

    choice = input('Enter the number of the listing you want to edit or remove: ');

    if choice < 1 || choice > length(userListings)
        fprintf('Invalid selection.\n');
        return;
    end

    action = input('Enter 1 to Edit, 2 to Remove: ');
    if action == 1
        % Edit listing using cell arrays
        listings{choice, 2} = input('Enter new item name: ', 's');
        listings{choice, 3} = input('Enter new price: ');
        listings{choice, 4} = input('Enter new condition: ', 's');
        fprintf('Listing updated successfully!\n');
    elseif action == 2
        % Remove listing by setting to empty
        listings(choice, :) = [];
        fprintf('Listing removed successfully!\n');
    else
        fprintf('Invalid action.\n');
    end
end