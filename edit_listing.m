% edit_listing.m - Edit or Remove Listings

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
    user = find([users.ID] == userID, 1);

    if isempty(user)
        fprintf('User not found.\n');
        return;
    end

    % Display user's listings
    userListings = find([listings.SellerID] == userID);
    if isempty(userListings)
        fprintf('You have no listings to edit or remove.\n');
        return;
    end

    fprintf('Your Listings:\n');
    for i = 1:length(userListings)
        idx = userListings(i);
        fprintf('%d. %s - $%.2f (%s)\n', idx, listings(idx).ItemName, listings(idx).Price, listings(idx).Condition);
    end

    choice = input('Enter the number of the listing you want to edit or remove: ');

    if choice < 1 || choice > length(userListings)
        fprintf('Invalid selection.\n');
        return;
    end

    action = input('Enter 1 to Edit, 2 to Remove: ');
    if action == 1
        % Edit listing
        listings(choice).ItemName = input('Enter new item name: ', 's');
        listings(choice).Price = input('Enter new price: ');
        listings(choice).Condition = input('Enter new condition: ', 's');
        fprintf('Listing updated successfully!\n');
    elseif action == 2
        % Remove listing
        listings(choice) = [];
        fprintf('Listing removed successfully!\n');
    else
        fprintf('Invalid action.\n');
    end
end